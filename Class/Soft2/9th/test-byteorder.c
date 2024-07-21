// test-byteorder.c
#include <stdio.h>

void print_byte_uint(unsigned int s) {
  int i;
  unsigned char *p;
  p = (unsigned char *)&s;
  for (i = 0; i < sizeof(unsigned int); i++) {
    printf("%02x", *p);
    p++;
  }
  printf("\n");
}

void print_byte_ushort(unsigned short s) {
  int i;
  unsigned char *p;
  p = (unsigned char *)&s;
  for (i = 0; i < sizeof(unsigned short); i++) {
    printf("%02x", *p);
    p++;
  }
  printf("\n");
}

void print_byte_ulong(unsigned long s) {
  int i;
  unsigned char *p;
  p = (unsigned char *)&s;
  for (i = 0; i < sizeof(unsigned long); i++) {
    printf("%02x", *p);
    p++;
  }
  printf("\n");
}

int main(int argc, char *argv[]) {
  unsigned int u1; // 32bit, 4byte
  u1 = 0x1234abcd;
  printf("u1 = %x : ", u1);
  print_byte_uint(u1);

  unsigned short u2; // 16bit, 2byte
  u2 = 0x1234;
  printf("u2 = %x : ", u2);
  print_byte_ushort(u2);

  unsigned long u3; // 64bit, 8byte
  u3 = 0x1234abcd5678ef01;
  printf("u3 = %lx : ", u3);
  print_byte_ulong(u3);
}
