// Generated by ReScript, PLEASE EDIT WITH CARE
'use strict';

var Fs = require("fs");
var Process = require("process");
var Belt_Int = require("rescript/lib/js/belt_Int.js");
var Belt_Array = require("rescript/lib/js/belt_Array.js");
var Caml_array = require("rescript/lib/js/caml_array.js");
var CamlinternalLazy = require("rescript/lib/js/camlinternalLazy.js");

var readInput = {
  LAZY_DONE: false,
  VAL: (function () {
      return Fs.readFileSync(Caml_array.get(Process.argv, 2), "utf8").trim().split("\n");
    })
};

var input = CamlinternalLazy.force(readInput);

var numBits = Caml_array.get(input, 1).length;

function encode(binaryString) {
  return Array.from(binaryString).map(function (c) {
              var n = Belt_Int.fromString(c);
              if (n !== undefined) {
                return n;
              } else {
                return -1;
              }
            });
}

var encodedInput = CamlinternalLazy.force(readInput).map(encode);

function sumVectors(encodedInput) {
  return encodedInput.reduce((function (el, acc) {
                return el.map(function (el, i) {
                            return el + Caml_array.get(acc, i) | 0;
                          });
              }), Belt_Array.make(numBits, 0));
}

function binaryToInt(encodedBinary) {
  return encodedBinary.reverse().reduce((function (acc, el, i) {
                return acc + Math.imul(el, Math.pow(2.0, i) | 0) | 0;
              }), 0);
}

function isMostCommon(i, numInputs) {
  if (i / numInputs >= 0.5) {
    return 1;
  } else {
    return 0;
  }
}

function isLeastCommon(i, numInputs) {
  if (i / numInputs >= 0.5) {
    return 0;
  } else {
    return 1;
  }
}

function getGamma(summed, numInputs) {
  return summed.map(function (el) {
              return isMostCommon(el, numInputs);
            });
}

function getEpsilon(summed, numInputs) {
  return summed.map(function (el) {
              return isLeastCommon(el, numInputs);
            });
}

function partOne(param) {
  console.log("Day 03 - Part 1\n================");
  var summed = sumVectors(encodedInput);
  var gamma = getGamma(summed, encodedInput.length);
  var epsilon = getEpsilon(summed, encodedInput.length);
  var result = Math.imul(binaryToInt(gamma), binaryToInt(epsilon));
  console.log(result);
  console.log("================\n");
  
}

function partTwo(param) {
  console.log("Day 03 - Part 1\n================");
  var o2 = encodedInput;
  var co2 = encodedInput;
  for(var i = 0; i < numBits; ++i){
    if (o2.length > 1) {
      var summed = sumVectors(o2);
      var gamma = getGamma(summed, o2.length);
      o2 = o2.filter((function(i,gamma){
          return function (e) {
            return Caml_array.get(e, i) === Caml_array.get(gamma, i);
          }
          }(i,gamma)));
    }
    if (co2.length > 1) {
      var summed$1 = sumVectors(co2);
      var epsilon = getEpsilon(summed$1, co2.length);
      co2 = co2.filter((function(i,epsilon){
          return function (e) {
            return Caml_array.get(e, i) === Caml_array.get(epsilon, i);
          }
          }(i,epsilon)));
    }
    
  }
  var result = Math.imul(binaryToInt(Caml_array.get(o2, 0)), binaryToInt(Caml_array.get(co2, 0)));
  console.log(result);
  console.log("================\n");
  
}

partOne(undefined);

partTwo(undefined);

exports.readInput = readInput;
exports.input = input;
exports.numBits = numBits;
exports.encode = encode;
exports.encodedInput = encodedInput;
exports.sumVectors = sumVectors;
exports.binaryToInt = binaryToInt;
exports.isMostCommon = isMostCommon;
exports.isLeastCommon = isLeastCommon;
exports.getGamma = getGamma;
exports.getEpsilon = getEpsilon;
exports.partOne = partOne;
exports.partTwo = partTwo;
/* input Not a pure module */
