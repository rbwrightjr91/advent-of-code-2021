let readInput = lazy({
    Js.String.split("\n", Node.Fs.readFileAsUtf8Sync("data/01/input.txt"))
})

let arr = Js.Array2.map(Lazy.force(readInput), e => Belt.Int.fromString(e))

let increasing = (acc, val, i) => {
    let len = Js.Array.length(arr) - 1
    
    if i !== len && val < arr[i + 1]{
        acc + 1
    } else {
        acc
    }
}

Js.log(Js.Array2.reducei(arr, increasing, 0))