#include<stdio.h>
#include <stdlib.h>
int main(int argc, char* argv[])
{
  int sample_num = argc - 1;
  double mean = 0.0;
  double var = 0.0;

  int i;
  for(i=1; i<argc; i++)
  {
    double data = atof(argv[i]);
    mean += data / sample_num;
    var += data * data / sample_num;
  }
  var -= mean * mean;
  printf("%lf\n", mean);
  printf("%lf\n", var);
  return 0;
}
