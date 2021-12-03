/* * Shared functions
 */
let readInput = lazy {
  Js.String2.split(Js.String2.trim(Node.Fs.readFileAsUtf8Sync(Node.Process.argv[2])), "\n")
}

/* * Part 1
 */
let partOne = () => {
  Js.log("Day 00 - Part 1\n================")

  Js.log("================\n")
}

/* * Part 2
 */
let partTwo = () => {
  Js.log("Day 00 - Part 2\n================")

  Js.log("================\n")
}

partOne()
partTwo()
