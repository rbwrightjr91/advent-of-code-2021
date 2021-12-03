/* * Shared functions
 */
let readInput = lazy {
  Js.String2.split(Js.String2.trim(Node.Fs.readFileAsUtf8Sync(Node.Process.argv[2])), "\n")
}

// create array of tuples
// ie [["forward", 5], ["up", 3]]
let parseCommands = () => {
  Js.Array2.map(Lazy.force(readInput), e => {
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
}

/* * Part 1
 */
let partOne = () => {
  Js.log("Day 02 - Part 1\n================")

  let arr = parseCommands()

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

  Js.log("================\n")
}

/* * Part 2
 */
let partTwo = () => {
  Js.log("Day 02 - Part 2\n================")

  let arr = parseCommands()

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

  Js.log("================\n")
}

partOne()
partTwo()
