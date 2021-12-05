/* * Shared functions
 */
let readInput = lazy {
  Js.String2.split(Node.Fs.readFileAsUtf8Sync(Node.Process.argv[2]), "\n")
}

let parseDrawOrder = input => ref(Js.String2.split(input[0], ",")->Belt.Array.reverse)

let parseBoards = input => {
  let a = Belt.Array.reverse(input)
  let boards = []
  let board = ref([])

  while Belt.Array.size(a) != 0 {
    let el = switch Js.Array2.pop(a) {
    | Some(string) => string
    | None => "-1"
    }

    if el != "" {
      board.contents
      ->Js.Array2.push(Js.String2.split(el, " ")->Js.Array2.filter(e => e != ""))
      ->ignore
    } else {
      boards->Js.Array2.push(board.contents)->ignore
      board.contents = board.contents->Js.Array2.filter(e => false)
    }
  }

  ref(boards)
}

let markBoard = (board, number) => {
  board->Belt.Array.forEach(row =>
    if row->Js.Array2.includes(number) {
      row->Belt.Array.set(row->Js.Array2.findIndex(n => n == number), "-1")->ignore
    }
  )
}

let transpose = board => {
  let transposed = []

  for _ in 0 to board->Belt.Array.size - 1 {
    transposed->Js.Array2.push([])->ignore
  }

  for i in 0 to board->Belt.Array.size - 1 {
    for j in 0 to board->Belt.Array.size - 1 {
      transposed[j]->Js.Array2.push(board[i][j])->ignore
    }
  }

  transposed
}

let checkWinner = board => {
  let win = ref(false)

  board->Belt.Array.forEach(row => {
    if !win.contents {
      win.contents = row->Belt.Array.every(e => e == "-1")
    }
  })

  if !win.contents {
    let transposed = board->transpose

    transposed->Belt.Array.forEach(row => {
      if !win.contents {
        win.contents = row->Belt.Array.every(e => e == "-1")
      }
    })
  }

  win.contents
}

let playRound = (num, boards) => {
  let winner = ref(-1)

  boards->Belt.Array.forEachWithIndex((i, board) => {
    markBoard(board, num)
    if checkWinner(board) {
      winner.contents = i
    }
  })

  winner.contents
}

let parseResults = (board, numberString) => {
  switch Belt.Int.fromString(numberString) {
  | None => -1
  | Some(n) => n
  } *
  board
  ->Belt.Array.concatMany
  ->Js.Array2.filter(e => e != "-1")
  ->Belt.Array.reduce(0, (acc, el) =>
    acc +
    switch Belt.Int.fromString(el) {
    | None => -1
    | Some(n) => n
    }
  )
}

/* * Part 1
 */
let partOne = () => {
  Js.log("Day 04 - Part 1\n================")

  let input = ref(Lazy.force(readInput))

  let drawOrder = parseDrawOrder(input.contents->Belt.Array.slice(~offset=0, ~len=1))

  let boards = parseBoards(input.contents->Belt.Array.sliceToEnd(2))

  let winner = ref(-1)
  let lastDrawnNum = ref("-1")

  while winner.contents < 0 {
    lastDrawnNum.contents = switch drawOrder.contents->Js.Array2.pop {
    | Some(s) => s
    | None => "-1"
    }

    winner.contents = playRound(lastDrawnNum.contents, boards.contents)
  }

  let result = parseResults(boards.contents[winner.contents], lastDrawnNum.contents)

  Js.log(result)

  Js.log("================\n")
}

/* * Part 2
 */
let partTwo = () => {
  Js.log("Day 04 - Part 2\n================")

  let input = ref(Lazy.force(readInput))

  let drawOrder = parseDrawOrder(input.contents->Belt.Array.slice(~offset=0, ~len=1))

  let boards = parseBoards(input.contents->Belt.Array.sliceToEnd(2))

  let lastDrawnNum = ref("-1")

  while boards.contents->Belt.Array.size > 1 {
    lastDrawnNum.contents = switch drawOrder.contents->Js.Array2.pop {
    | Some(s) => s
    | None => "-1"
    }

    let winner = playRound(lastDrawnNum.contents, boards.contents)
    if winner >= 0 {
      boards.contents->Js.Array2.removeCountInPlace(~pos=winner, ~count=1)->ignore
    }
  }

  lastDrawnNum.contents = switch drawOrder.contents->Js.Array2.pop {
  | Some(s) => s
  | None => "-1"
  }

  playRound(lastDrawnNum.contents, boards.contents)->ignore

  Js.log(boards.contents[0]->parseResults(lastDrawnNum.contents))

  Js.log("================\n")
}

partOne()
partTwo()
