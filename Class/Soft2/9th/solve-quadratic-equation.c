#include <math.h>
#include <stdio.h>

void print_roots_float(float a, float b, float c) {
  printf("Solve with float\n");
  float d = b * b - 4 * a * c;
  if (d < 0) {
    printf("No real roots\n");
  } else if (d == 0) {
    printf("One real root: %.16f\n", -b / (2 * a));
  } else {
    float x1 = (-b + sqrtf(d)) / (2 * a);
    float x2 = (-b - sqrtf(d)) / (2 * a);
    printf("Two real roots: %.16f and %.16f\n", x1, x2);
  }
}

void print_roots_double(double a, double b, double c) {
  printf("Solve with double\n");
  double d = b * b - 4 * a * c;
  if (d < 0) {
    printf("No real roots\n");
  } else if (d == 0) {
    printf("One real root: %.16f\n", -b / (2 * a));
  } else {
    double x1 = (-b + sqrt(d)) / (2 * a);
    double x2 = (-b - sqrt(d)) / (2 * a);
    printf("Two real roots: %.16f and %.16f\n", x1, x2);
  }
}

int main() {
  float a = 1, b = 2, c = -2;
  print_roots_float(a, b, c);
  print_roots_double(a, b, c);
  return 0;
}
