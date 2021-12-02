// Generated by ReScript, PLEASE EDIT WITH CARE
'use strict';

var Fs = require("fs");
var Belt_Int = require("rescript/lib/js/belt_Int.js");
var Caml_obj = require("rescript/lib/js/caml_obj.js");
var Caml_array = require("rescript/lib/js/caml_array.js");
var CamlinternalLazy = require("rescript/lib/js/camlinternalLazy.js");

var readInput = {
  LAZY_DONE: false,
  VAL: (function () {
      return Fs.readFileSync("data/01/input.txt", "utf8").split("\n");
    })
};

var arr = CamlinternalLazy.force(readInput).map(Belt_Int.fromString);

function increasing(acc, val, i) {
  var len = arr.length - 1 | 0;
  if (i !== len && Caml_obj.caml_lessthan(val, Caml_array.get(arr, i + 1 | 0))) {
    return acc + 1 | 0;
  } else {
    return acc;
  }
}

console.log(arr.reduce(increasing, 0));

exports.readInput = readInput;
exports.arr = arr;
exports.increasing = increasing;
/* arr Not a pure module */
