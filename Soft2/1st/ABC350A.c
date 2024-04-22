/*
AtCoder Beginner Contest 350 A - Past ABCs

問題文

長さ
6 の文字列 S が与えられます。S の先頭 3 文字は ABC であり、末尾

3 文字は数字であることが保証されます。

Sが、このコンテスト開始以前に AtCoder上で開催され終了したコンテストの略称であるかどうか判定してください。

ただし、文字列
T が「このコンテスト開始以前に AtCoder上で開催され終了したコンテストの略称」であるとは、以下の

348 個の文字列のうちいずれかに等しいことと定めます。

ABC001, ABC002,
…, ABC314, ABC315, ABC317, ABC318,

…, ABC348, ABC349

特に ABC316 が含まれないことに注意してください。
制約

S は先頭 3 文字が ABC、末尾 3 文字が数字である長さ 6 の文字列
*/
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

char* substr(const char* source, size_t start, size_t len, char* destination){
  strncpy(destination, source + start, len);
  destination[len] = '\0';
  return destination;
}

int main(int argc, char *argv[]){
  printf("%s\n", argv[1]);
  char *source = argv[1];
  char abc[4], number_str[4];
  substr(source, 0, 3, abc);
  substr(source, 3, 3, number_str);
  int number = atoi(number_str);
  printf("abc: %s, number_str: %s, number: %d\n", abc, number_str, number);

  // printf("comprae:%d\n", strcmp(abc, "ABC"));

  if (strcmp(abc, "ABC") != 0){
    printf("ABC Does not match\n");
    printf("No\n");
    return 0;
  }
  if (number < 1 || number > 349 || number == 316){
    printf("number Does not match\n");
    printf("No\n");
    return 0;
  }
  printf("Yes\n");
}
