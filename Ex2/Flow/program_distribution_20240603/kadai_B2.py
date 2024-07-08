from PIL import Image
import os
import sys
import csv
import math
import time
import argparse
import numpy as np
import matplotlib.pyplot as plt


def calc_smooth(A_DATA, B_DATA, A_wid, A_hei, len):
    ave = 0.0


def get_args():
    parser = argparse.ArgumentParser(
        prog='kadai_B2.py',
        formatter_class=argparse.ArgumentDefaultsHelpFormatter)

    parser.add_argument('-i',
                        help='target bmp image (***.bmp; extension is needed)',
                        action='store', default=None)
    parser.add_argument('-o',
                        help='output bmp file (***.bmp; extension is needed)',
                        action='store', default='smooth.bmp')
    parser.add_argument('-n',
                        help='half length of smoothing window',
                        action='store', default=3)

    if parser.parse_args().i == None:
        parser.print_help()
        quit()

    args = parser.parse_args()
    return (args)


if __name__ == "__main__":

    t1 = time.perf_counter()
    args = get_args()
    infilename = args.i
    outfilename = args.o
    smooth_len = int(args.n)
    print('input bmp image  : ' + args.i)
    print('putput bmp image : ' + args.o)
    print('smoothing window : ' + str(args.n))

    A_DATA = Image.open(infilename).transpose(Image.FLIP_TOP_BOTTOM)

    A_wid = A_DATA.size[0]
    A_hei = A_DATA.size[1]
    print('----- ----- ----- ----- ----- -----')
    print('width  of input image : ' + str(A_wid))
    print('height of input image : ' + str(A_hei))
    print('----- ----- ----- ----- ----- -----')

    B_DATA = Image.new("L", (A_wid, A_hei))

    print("Smoothing Start")
    calc_smooth(A_DATA, B_DATA, A_wid, A_hei, smooth_len)
    print("Smoothing End")

    print("Writing : " + outfilename)
    B_DATA.transpose(Image.FLIP_TOP_BOTTOM).save(outfilename)

    t2 = time.perf_counter()
    print("Processing time : " + '{:.3f}'.format(t2 - t1) + "s")
    print("Done")
