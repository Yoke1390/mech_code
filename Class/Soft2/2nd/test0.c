/* test0.c */
#include <stdio.h>
/*
* 引数：整数 i, j
* 返値：i と j の積となる整数
* 機能：引き数の積を計算し返す関数
*/
int test(int i, int j) {
return (i * j);
}
int main(int argc, char *argv) {
int i, j; /* 入力となる整数 i,j */
int k;
/* i と j の積 */
i = 3;
j = 2;
/* i と j を掛けて k に代入する */
k = test(i,j);
/* k の値が 5 より大きければ">5"と表示し，
そうでなければ"<=5"を表示する */
if (k > 5) printf(">5\n");
else printf("<=5\n");
/* if 文の後には曖昧性をさけるため中括弧{を入れるべきである．
ここでは後述の演習のため{を使っていない */
return 0;
}
