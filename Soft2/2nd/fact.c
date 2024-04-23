#include <stdio.h> 
#include <stdlib.h> 

// 階乗を再帰的に求める関数
int fact (int x) { 
  if (x > 0) { 

    #ifdef DEBUG 
      printf("x = %d\n", x); 
    #endif 

    // 入力と、入力から1を引いた数の階乗をかけた数を出力とする。
    // n! = n * (n-1)!
    return ( x * fact (x - 1) );
  } 
  else { 

    #ifdef DEBUG 
      printf("x = %d, return 1\n", x); 
    #endif 

    // 0! = 1
    return 1; 
  } 
}

int main (int argc, char *argv[]) { 
  int x, ret; 
  x = atoi(argv[1]); 
  ret = fact(x); 
  printf("ret = %d\n", ret); 
}
