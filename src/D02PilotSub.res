// read input
let readInput = lazy {
  Js.String.split("\n", Node.Fs.readFileAsUtf8Sync("data/02/01-input.txt"))
}

// Js.log(Lazy.force(readInput))

// create array of tuples
// ie [["forward", 5], ["up", 3]]
let arr = Js.Array2.map(Lazy.force(readInput), e => {
  // split original string on space
  let el = Js.String.split(" ", e)

  (
    el[0],
    switch Belt.Int.fromString(el[1]) {
    | None => -1
    | Some(n) => n
    },
  )
})

// Js.log(arr)

let tuple = Js.Array2.reduce(
  arr,
  (acc, command) => {
    let (direction, distance) = command

    switch Js.Option.some(direction) {
    | Some("up") => {
        let (depth, position) = acc
        (depth - distance, position)
      }
    | Some("down") => {
        let (depth, position) = acc
        (depth + distance, position)
      }
    | Some("forward") => {
        let (depth, position) = acc
        (depth, position + distance)
      }
    | _ => {
        Js.log("Invalid direction")
        acc
      }
    }
  },
  (0, 0), // tuple of (depth, horizontal position)
)

let (depth, position) = tuple

Js.log(depth * position)
