#include <stdio.h>
#define LEN 1000

int main() {
  double a[LEN], b[LEN];
  double iprod = 0.0;
  int i;

  for (i = 0; i < LEN; i++)
    a[i] = b[i] = 1.0 * i;

#pragma omp parallel for
  for (i = 0; i < LEN; i++) {
#pragma omp critical
    iprod += (a[i] * b[i]);
  }

  printf("inner product = %lf\n", iprod);

  return 0;
}
