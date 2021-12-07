/* * Shared functions
 */
let readInput = lazy {
  Js.String2.split(Js.String2.trim(Node.Fs.readFileAsUtf8Sync(Node.Process.argv[2])), "\n")
}

type point = {x: int, y: int}

type line = {
  begin: point,
  end: point,
}

let stringToInt = s => {
  switch s->Belt.Int.fromString {
  | Some(n) => n
  | None => {
      "Something went wrong"->Js.Console.error
      -1
    }
  }
}

let parseLine = pointString => {
  let beginString = pointString->Js.String2.split(" -> ")->Js.Array2.unsafe_get(0)
  let endString = pointString->Js.String2.split(" -> ")->Js.Array2.unsafe_get(1)

  {
    begin: {
      x: (beginString->Js.String2.split(","))[0]->stringToInt,
      y: (beginString->Js.String2.split(","))[1]->stringToInt,
    },
    end: {
      x: (endString->Js.String2.split(","))[0]->stringToInt,
      y: (endString->Js.String2.split(","))[1]->stringToInt,
    },
  }
}

let drawHznLine = (hashMap, l) => {
  let y = l.begin.y
  let sorted = [l.begin.x, l.end.x]->Js.Array2.sortInPlace
  for i in sorted[0] to sorted[1] {
    switch hashMap->Belt.HashMap.String.get(j`x:$i,y:$y`) {
    | Some(n) => hashMap->Belt.HashMap.String.set(j`x:$i,y:$y`, n + 1)
    | None => hashMap->Belt.HashMap.String.set(j`x:$i,y:$y`, 1)
    }
  }
}

let drawVrtLine = (hashMap, l) => {
  let x = l.begin.x
  let sorted = [l.begin.y, l.end.y]->Js.Array2.sortInPlace
  for i in sorted[0] to sorted[1] {
    switch hashMap->Belt.HashMap.String.get(j`x:$x,y:$i`) {
    | Some(n) => hashMap->Belt.HashMap.String.set(j`x:$x,y:$i`, n + 1)
    | None => hashMap->Belt.HashMap.String.set(j`x:$x,y:$i`, 1)
    }
  }
}

/* * Part 1
 */
let partOne = () => {
  Js.log("Day 05 - Part 1\n================")

  "Completed in: "->Js.Console.timeStart

  let h = Belt.HashMap.String.make(~hintSize=10)

  Lazy.force(readInput)
  ->Belt.Array.reduce(([]: array<line>), (acc, el) => {
    acc->Js.Array2.push(el->parseLine)->ignore
    acc
  })
  ->Js.Array2.filter(el => el.begin.x == el.end.x || el.begin.y == el.end.y)
  ->Belt.List.fromArray
  ->Belt.List.forEach(line => {
    if line.begin.x == line.end.x {
      h->drawVrtLine(line)
    }
    if line.begin.y == line.end.y {
      h->drawHznLine(line)
    }
  })

  h->Belt.HashMap.String.valuesToArray->Js.Array2.filter(e => e > 1)->Belt.Array.size->Js.log

  "Completed in: "->Js.Console.timeEnd

  Js.log("================\n")
}

/* * Part 2
 */
let partTwo = () => {
  Js.log("Day 05 - Part 2\n================")

  Js.log("================\n")
}

partOne()
partTwo()
