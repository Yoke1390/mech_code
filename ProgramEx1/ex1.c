#include<stdio.h>
#include <stdlib.h>
int main(int argc, char* argv[])
{
  if (argc != 3 + 1)
  {
    printf("Input Error: 3 arguments required.");
    return 1;
  }

  int volume = 1;
  int i;
  for(i=1; i<argc; i++)
  {
    int length = atoi(argv[i]);
    // printf("%d\n", length);
    volume *= length;
  }
  printf("%d\n", volume);
  return 0;
}
