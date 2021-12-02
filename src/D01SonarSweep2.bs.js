// Generated by ReScript, PLEASE EDIT WITH CARE
'use strict';

var Fs = require("fs");
var Belt_Int = require("rescript/lib/js/belt_Int.js");
var Caml_array = require("rescript/lib/js/caml_array.js");
var CamlinternalLazy = require("rescript/lib/js/camlinternalLazy.js");

var readInput = {
  LAZY_DONE: false,
  VAL: (function () {
      return Fs.readFileSync("data/01/02-input.txt", "utf8").split("\n");
    })
};

var arr = CamlinternalLazy.force(readInput).map(function (e) {
      var n = Belt_Int.fromString(e);
      if (n !== undefined) {
        return n;
      } else {
        return -1;
      }
    });

var arr2 = arr.reduce((function (acc, param, i) {
        var lastIndex = arr.length - 1 | 0;
        if (i > (lastIndex - 2 | 0)) {
          return acc;
        }
        var j = (Caml_array.get(arr, i) + Caml_array.get(arr, i + 1 | 0) | 0) + Caml_array.get(arr, i + 2 | 0) | 0;
        return acc.concat([j]);
      }), []);

function increasing(acc, val, i) {
  var lastIndex = arr2.length - 1 | 0;
  if (i !== lastIndex && val < Caml_array.get(arr2, i + 1 | 0)) {
    return acc + 1 | 0;
  } else {
    return acc;
  }
}

console.log(arr2.reduce(increasing, 0));

exports.readInput = readInput;
exports.arr = arr;
exports.arr2 = arr2;
exports.increasing = increasing;
/* arr Not a pure module */
