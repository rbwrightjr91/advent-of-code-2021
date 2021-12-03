/* * Shared functions
 */
let readInput = lazy {
  Js.String2.split(Js.String2.trim(Node.Fs.readFileAsUtf8Sync(Node.Process.argv[2])), "\n")
}

let input = Lazy.force(readInput)
// let inputSize = Js.Array2.length(input)
let numBits = Js.String2.length(input[1])

// given string representation of binary number, convert to array of integers
// ie "10101" => [1, 0, 1, 0, 1]
let encode = binaryString => {
  Js.Array2.map(Js.Array2.from(Js.String2.castToArrayLike(binaryString)), c => {
    switch Belt.Int.fromString(c) {
    | None => -1
    | Some(n) => n
    }
  })
}

let encodedInput = Js.Array2.map(input, el => encode(el))

let sumVectors = encodedInput => {
  let vectorAdd = (element, arr, i) => element + arr[i]

  // sum arrays element-wise
  // ie [1, 0, 1] + [1, 1, 0] = [2, 1, 1]
  Js.Array2.reduce(
    encodedInput,
    (el, acc) => {
      Js.Array2.mapi(el, (el, i) => vectorAdd(el, acc, i))
    },
    Belt.Array.make(numBits, 0),
  )
}

let binaryToInt = encodedBinary => {
  Js.Array2.reducei(
    Js.Array2.reverseInPlace(encodedBinary),
    (acc, el, i) => {
      acc + el * Belt.Float.toInt(2.0 ** Js.Int.toFloat(i))
    },
    0,
  )
}

let isMostCommon = (i, numInputs) => Js.Int.toFloat(i) /. Js.Int.toFloat(numInputs) >= 0.5 ? 1 : 0
let isLeastCommon = (i, numInputs) => Js.Int.toFloat(i) /. Js.Int.toFloat(numInputs) >= 0.5 ? 0 : 1

let getGamma = (summed, numInputs) => Js.Array2.map(summed, el => isMostCommon(el, numInputs))
let getEpsilon = (summed, numInputs) => Js.Array2.map(summed, el => isLeastCommon(el, numInputs))

/* * Part 1
 */
let partOne = encodedInput => {
  Js.log("Day 3 - Part 1\n===============")

  let summed = sumVectors(encodedInput)

  let gamma = getGamma(summed, Js.Array2.length(encodedInput))
  let epsilon = getEpsilon(summed, Js.Array2.length(encodedInput))

  let result = binaryToInt(gamma) * binaryToInt(epsilon)

  Js.log(result)
}

/* * Part 2
 */
let partTwo = encodedInput => {
  Js.log("\n\nDay 3 - Part 2\n===============")

  let o2 = ref(encodedInput)
  let co2 = ref(encodedInput)

  for i in 0 to numBits - 1 {
    if Js.Array2.length(o2.contents) > 1 {
      let summed = sumVectors(o2.contents)

      let gamma = getGamma(summed, Js.Array2.length(o2.contents))

      o2.contents = Js.Array2.filter(o2.contents, e => e[i] == gamma[i])
    }

    if Js.Array2.length(co2.contents) > 1 {
      let summed = sumVectors(co2.contents)

      let epsilon = getEpsilon(summed, Js.Array2.length(co2.contents))

      co2.contents = Js.Array2.filter(co2.contents, e => e[i] == epsilon[i])
    }
  }

  let result = binaryToInt(o2.contents[0]) * binaryToInt(co2.contents[0])

  Js.log(result)
}

partOne(encodedInput)
partTwo(encodedInput)
