#include <omp.h>
#include <stdio.h>
#include <sys/resource.h>
#include <sys/time.h>
#include <time.h>

#define SIZE 500

double gettimeofday_sec() {
  struct timeval tv;
  gettimeofday(&tv, NULL);
  return tv.tv_sec + tv.tv_usec * 1e-6;
}

void printMatrix(long matrix[SIZE][SIZE], char name) {
  printf("Matrix %c:\n", name);
  for (int i = 0; i < SIZE; i++) {
    for (int j = 0; j < SIZE; j++) {
      printf("%12ld ", matrix[i][j]);
    }
    printf("\n");
  }
  printf("\n");
}

int main() {
  double t1, t2;

  long A[SIZE][SIZE], B[SIZE][SIZE], C[SIZE][SIZE];

  int i, j, k;
  for (i = 0; i < SIZE; i++) {
    for (j = 0; j < SIZE; j++) {
      A[i][j] = i * SIZE + j;
      B[i][j] = j * SIZE + i;
    }
  }

  // printMatrix(A, 'A');
  // printMatrix(B, 'B');

  double sum;

  t1 = gettimeofday_sec();

#pragma omp parallel for reduction(+ : sum) private(i, j, k)
  for (i = 0; i < SIZE; i++) {
    for (j = 0; j < SIZE; j++) {
      sum = 0;
      for (k = 0; k < SIZE; k++) {
        sum += A[i][k] * B[k][j];
      }
      C[i][j] = sum;
    }
  }

  t2 = gettimeofday_sec();
  printf("time=%lf [sec]\n", (double)(t2 - t1));

  // printMatrix(C, 'C');

  return 0;
}
