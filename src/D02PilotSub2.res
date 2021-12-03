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
        let (depth, position, aim) = acc
        (depth, position, aim - distance)
      }
    | Some("down") => {
        let (depth, position, aim) = acc
        (depth, position, aim + distance)
      }
    | Some("forward") => {
        let (depth, position, aim) = acc
        (depth + aim * distance, position + distance, aim)
      }
    | _ => {
        Js.log("Invalid")
        acc
      }
    }
  },
  (0, 0, 0), // tuple of (depth, horizontal position, aim)
)

let (depth, position, _) = tuple

Js.log(depth * position)
