#include <stdio.h>
#include <stdlib.h>

int main(void){
  int x, y;

  //=====kokokara========

  srand(0);
  int source, i;
  for (i = 0; i < 100; i++) {
    source = rand() % 64;
    x = source % 8;
    y = source / 8;
    printf("x=%d, y=%d\n", x, y);
  }

  //=====kokomade========

}
