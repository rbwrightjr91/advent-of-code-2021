/* * Shared functions
 */
let readInput = lazy {
  Js.String2.split(Js.String2.trim(Node.Fs.readFileAsUtf8Sync(Node.Process.argv[2])), "\n")
}

/* * Part 1
 */
let partOne = () => {
  Js.log("Day 01 - Part 1\n================")

  let arr = Js.Array2.map(Lazy.force(readInput), e => Belt.Int.fromString(e))

  let increasing = (acc, val, i) => {
    let lastIndex = Js.Array.length(arr) - 1

    if i !== lastIndex && val < arr[i + 1] {
      acc + 1
    } else {
      acc
    }
  }

  Js.log(Js.Array2.reducei(arr, increasing, 0))
  Js.log("================\n")
}

/* * Part 2
 */
let partTwo = () => {
  Js.log("Day 01 - Part 2\n================")

  let arr = Js.Array2.map(Lazy.force(readInput), e =>
    switch Belt.Int.fromString(e) {
    | None => -1
    | Some(n) => n
    }
  )

  let arr2 = Js.Array2.reducei(
    arr,
    (acc, _, i) => {
      let lastIndex = Js.Array.length(arr) - 1

      if i <= lastIndex - 2 {
        let j = arr[i] + arr[i + 1] + arr[i + 2]
        Js.Array2.concat(acc, [j])
      } else {
        acc
      }
    },
    [],
  )

  let increasing = (acc, val, i) => {
    let lastIndex = Js.Array.length(arr2) - 1

    if i !== lastIndex && val < arr2[i + 1] {
      acc + 1
    } else {
      acc
    }
  }

  Js.log(Js.Array2.reducei(arr2, increasing, 0))
  Js.log("================\n")
}

partOne()
partTwo()
