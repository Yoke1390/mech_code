function closure(){
  let sum_local = 0;
  
  return n => {
    sum_local += n;
    console.log(sum_local);
  }
}

a = closure();

console.log("a: closure");
a(5);
a(10);

sum_global = 0;

b = (n) => {
  sum_global += n;
  console.log(sum_global);
}

console.log("b: global variable");
b(5);
b(10);
