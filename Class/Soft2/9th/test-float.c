/* test-float.c */
#include <stdio.h>

void print_bit(float f, char name) {
  printf("%c = %-12f : ", name, f);
  int i;
  unsigned int *j = ((unsigned int *)&f);
  unsigned int s = *j;
  for (i = 0; i < 32; i++) {
    printf("%c", ((0x80000000) & s) ? '1' : '0');
    if ((i == 0) || (i == 8))
      printf(" ");
    s = s << 1;
  }
  printf("\n");
}

int main(int argc, char *argv[]) {
  float f; // 32bit, 4byte

  f = 2.5;
  print_bit(f, 'f');

  float a = 2.625;
  print_bit(a, 'a');
  float b = a + a + a;
  print_bit(b, 'b');
  if (b == 7.875f)
    printf("same\n");
  else
    printf("diff\n");

  float g = 0;
  for (int i = 0; i < 1000000; i++) {
    g = g + f;
  }
  print_bit(g, 'g');
}
