my_sqrt = function() {
  let count = 0;
  return (x) => {
    count ++;
    console.log("Call: my_sqrt(" + x + ")");
    console.log("count: " + count);
    return x ** 0.5;
  }
}();

console.log( my_sqrt(9) );
console.log( my_sqrt(16) );
