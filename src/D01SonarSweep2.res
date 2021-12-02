let readInput = lazy({
    Js.String.split("\n", Node.Fs.readFileAsUtf8Sync("data/01/02-input.txt"))
})

let arr = Js.Array2.map(Lazy.force(readInput), e => 
    switch Belt.Int.fromString(e) {
        | None => -1
        | Some(n) => n 
    }
)

let arr2 = Js.Array2.reducei(arr, (acc, _, i) => {
    let lastIndex = Js.Array.length(arr) - 1

    if i <= lastIndex - 2 {
        let j = arr[i] + arr[i+1] + arr[i+2]
        Js.Array2.concat(acc, [j])
    } else {
        acc
    }

}, [])

let increasing = (acc, val, i) => {
    let lastIndex = Js.Array.length(arr2) - 1
    
    if i !== lastIndex && val < arr2[i + 1]{
        acc + 1
    } else {
        acc
    }
}

Js.log(Js.Array2.reducei(arr2, increasing, 0))