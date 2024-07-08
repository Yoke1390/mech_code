from PIL import Image
import os
import sys
import csv
import math
import time
import argparse
import numpy as np
import matplotlib.pyplot as plt


def mk_array(A_DATA, B_DATA, wid, hei):
    for jj in range(hei):
        for ii in range(wid):
            if B_DATA.getpixel((ii, jj)) > A_DATA.getpixel((ii, jj)):
                B_DATA.putpixel((ii, jj), A_DATA.getpixel((ii, jj)))


def bg_remove(A_DATA, B_DATA, wid, hei):
    for jj in range(hei):
        for ii in range(wid):
            A_DATA.putpixel((ii, jj), A_DATA.getpixel((ii, jj)) - B_DATA.getpixel((ii, jj)))


def get_args():
    parser = argparse.ArgumentParser(
        prog='bgr.py',
        formatter_class=argparse.ArgumentDefaultsHelpFormatter)

    parser.add_argument('-i',
                        help='rootname of bmp image (***.bmp; extension is needed)',
                        action='store', default=None)
    parser.add_argument('-s',
                        help='start number of bmp image',
                        action='store', type=int, default=1)
    parser.add_argument('-n',
                        help='total number of bmp image',
                        action='store', type=int, default=11)

    if parser.parse_args().i == None:
        parser.print_help()
        quit()

    args = parser.parse_args()
    return (args)


if __name__ == "__main__":

    t1 = time.perf_counter()
    args = get_args()
    rootname = args.i
    start = args.s
    num = args.n
    print('rootname of bmp  : ' + args.i)
    print('start num of bmp : ' + str(args.s))
    print('total num of bmp : ' + str(args.n))

    infilename1 = rootname + '{:06d}'.format(start) + '.bmp'
    print('Reading : ' + infilename1)
    A_DATA = Image.open(infilename1).transpose(Image.FLIP_TOP_BOTTOM)

    print('----- ----- ----- ----- ----- -----')
    print('width  of image : ' + str(A_DATA.size[0]))
    print('height of image : ' + str(A_DATA.size[1]))
    print('----- ----- ----- ----- ----- -----')

    wid = A_DATA.size[0]
    hei = A_DATA.size[1]

    B_DATA = Image.new("L", (wid, hei), 255)

    for kk in range(num):
        infilename1 = rootname + '{:06d}'.format(int(start + kk)) + '.bmp'
        print('Reading : ' + infilename1)
        A_DATA = Image.open(infilename1).transpose(Image.FLIP_TOP_BOTTOM)
        mk_array(A_DATA, B_DATA, wid, hei)
    for kk in range(num):
        infilename1 = rootname + '{:06d}'.format(int(start + kk)) + '.bmp'
        print('Reading : ' + infilename1)
        A_DATA = Image.open(infilename1).transpose(Image.FLIP_TOP_BOTTOM)
        bg_remove(A_DATA, B_DATA, wid, hei)
        outfilename = 'bgr_' + infilename1
        print("Writing : " + outfilename)
        A_DATA.transpose(Image.FLIP_TOP_BOTTOM).save(outfilename)

    outfilename = 'bg_' + rootname + '.bmp'
    print("Writing : " + outfilename)
    B_DATA.transpose(Image.FLIP_TOP_BOTTOM).save(outfilename)

    t2 = time.perf_counter()
    print("Processing time : " + '{:.3f}'.format(t2 - t1) + "s")
    print("Done")
