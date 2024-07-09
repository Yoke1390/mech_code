from PIL import Image
import os
import sys
import csv
import math
import time
import argparse
from tqdm import tqdm
import numpy as np
import matplotlib.pyplot as plt


def calc_vec(A_DATA, B_DATA, xgridsize, ygridsize,
             int_window, sea_window, wid_num, hei_num,
             A_wid, A_hei, B_wid, B_hei,
             xposition, yposition, xdisplacement, ydisplacement):

    init = int(((A_DATA.size[0] - 1) % xgridsize) / 2 + 1)
    for ii in range(wid_num):
        xposition[ii] = init + ii * xgridsize
    init = int(((A_DATA.size[1] - 1) % ygridsize) / 2 + 1)
    for jj in range(hei_num):
        yposition[jj] = init + jj * ygridsize


    for jj in tqdm(range(hei_num)):
        for ii in tqdm(range(wid_num), leave=False):
            xp1 = int(xposition[ii])
            yp1 = int(yposition[jj])
            x_best = xp1
            y_best = yp1
            cc_max = 0.0
            cc = -1.0
            for yp2 in range(yp1 - sea_window, yp1 + sea_window + 1):
                for xp2 in range(xp1 - sea_window, xp1 + sea_window + 1):
                    ave1 = 0.0
                    ave2 = 0.0
                    tmp1 = 0.0
                    tmp2 = 0.0
                    tmp3 = 0.0
                    num = 0
                    for y in range(yp1 - int_window, yp1 + int_window + 1):
                        for x in range(xp1 - int_window, xp1 + int_window + 1):
                            if x >= 0 and x < A_wid and y >= 0 and y < A_hei:
                                pixelA = A_DATA.getpixel((x, y))
                                ave1 += pixelA
                                num += 1
                    ave1 /= num

                    for y in range(yp2 - int_window, yp2 + int_window + 1):
                        for x in range(xp2 - int_window, xp2 + int_window + 1):
                            if x >= 0 and x < B_wid and y >= 0 and y < B_hei:
                                pixelB = B_DATA.getpixel((x, y))
                                ave2 += pixelB
                    ave2 /= num

                    for y in range(max(yp1, yp2) - int_window, min(yp1, yp2) + int_window + 1):
                        for x in range(max(xp1, xp2) - int_window, min(xp1, xp2) + int_window + 1):
                            if (x >= 0 and x < A_wid and y >= 0 and y < A_hei) and (x >= 0 and x < B_wid and y >= 0 and y < B_hei):
                                pixelA = A_DATA.getpixel((x, y))
                                pixelB = B_DATA.getpixel((x, y))
                                tmp1 += (pixelA - ave1) ** 2
                                tmp2 += (pixelB - ave2) ** 2
                                tmp3 += (pixelA - ave1) * (pixelB - ave2)

                    if math.sqrt(tmp1 * tmp2) == 0:
                        cc = -1.0
                    else:
                        cc = tmp3 / math.sqrt(tmp1 * tmp2)

                    if cc_max < cc:
                        cc_max = cc
                        x_best = xp2
                        y_best = yp2

            xdisplacement[jj][ii] = x_best - xp1
            ydisplacement[jj][ii] = y_best - yp1


def calcoutparam(A_DATA, xgridsize, ygridsize):
    wid_num = int((A_DATA.size[0] - 1) / xgridsize + 1)
    hei_num = int((A_DATA.size[1] - 1) / ygridsize + 1)
    return wid_num, hei_num


def summarize(xgridsize, ygridsize, int_window, sea_window, wid_num, hei_num,
              xposition, yposition, xdisplacement, ydisplacement, csvform):
    line = [""]

    line = ["# data format", "5"]
    csvform.append(line)

    line = ["#", wid_num, hei_num, wid_num * hei_num, xgridsize, ygridsize, xposition[0], yposition[0]]
    csvform.append(line)
    line = ["#  xx", "   yy", " zz", "   uu", "   vv", " ww"]
    csvform.append(line)

    for j in range(int(hei_num)):
        for i in range(int(wid_num)):
            line = [format(xposition[i], '5'), format(yposition[j], '5'), "  0",
                    format(xdisplacement[j][i], '5'), format(ydisplacement[j][i], '5'), "  0"]
            csvform.append(line)
        line = []
        csvform.append(line)


def writematrix(outfilename, xgridsize, ygridsize,
                int_window, sea_window, wid_num, hei_num,
                xposition, yposition, xdisplacement, ydisplacement):

    csvform = []
    summarize(xgridsize, ygridsize, int_window, sea_window, wid_num, hei_num,
              xposition, yposition, xdisplacement, ydisplacement, csvform)
    writecsv = csv.writer(open(outfilename, 'w', newline=''), lineterminator=",\n")
    writecsv.writerows(csvform)


def get_args():
    parser = argparse.ArgumentParser(
        prog='kadai_B5.py',
        formatter_class=argparse.ArgumentDefaultsHelpFormatter)

    parser.add_argument('-i1',
                        help='1st bmp image (***.bmp; extension is needed)',
                        action='store', default=None)
    parser.add_argument('-i2',
                        help='2nd bmp image (***.bmp; extension is needed)',
                        action='store', default=None)
    parser.add_argument('-o',
                        help='output csv file (***.csv; extension is needed)',
                        action='store', default='test_B5.csv')
    parser.add_argument('-x',
                        help='grid interval in x direction ',
                        action='store', type=int, default=64)
    parser.add_argument('-y',
                        help='grid interval in y direction ',
                        action='store', type=int, default=64)
    parser.add_argument('-s',
                        help='half size of search window length',
                        action='store', type=int, default=11)
    parser.add_argument('-n',
                        help='half size of interrogation window lenght',
                        action='store', type=int, default=9)

    if parser.parse_args().i1 == None or \
            parser.parse_args().i2 == None:
        parser.print_help()
        quit()

    args = parser.parse_args()
    return (args)


if __name__ == "__main__":
    t1 = time.perf_counter()
    args = get_args()
    infilename1 = args.i1
    infilename2 = args.i2
    outfilename = args.o
    xgridsize = args.x
    ygridsize = args.y
    see_window = args.s
    int_window = args.n
    print('1st bmp image   : ' + args.i1)
    print('2nd bmp image   : ' + args.i2)
    print('output csv      : ' + args.o)
    print('grid interval x : ' + str(args.x))
    print('grid interval y : ' + str(args.y))
    print('search window   : ' + str(args.s))
    print('inter. window   : ' + str(args.n))

    A_DATA = Image.open(infilename1).transpose(Image.FLIP_TOP_BOTTOM)
    B_DATA = Image.open(infilename2).transpose(Image.FLIP_TOP_BOTTOM)

    A_wid = A_DATA.size[0]
    A_hei = A_DATA.size[1]
    B_wid = B_DATA.size[0]
    B_hei = B_DATA.size[1]
    print('----- ----- ----- ----- ----- -----')
    print('width  of target image   : ' + str(A_wid))
    print('height of target image   : ' + str(A_hei))
    print('width  of template image : ' + str(B_wid))
    print('height of template image : ' + str(B_hei))
    print('----- ----- ----- ----- ----- -----')

    wid_num, hei_num = calcoutparam(A_DATA, xgridsize, ygridsize)

    xposition = [0 for i in range(wid_num)]
    yposition = [0 for j in range(hei_num)]
    xdisplacement = [[0 for i in range(wid_num)] for j in range(hei_num)]
    ydisplacement = [[0 for i in range(wid_num)] for j in range(hei_num)]

    print("Direct Cross Correlation Start")
    calc_vec(A_DATA, B_DATA, xgridsize, ygridsize,
             int_window, see_window, wid_num, hei_num,
             A_wid, A_hei, B_wid, B_hei,
             xposition, yposition, xdisplacement, ydisplacement)
    print("Direct Cross Correlation End")

    print("Writing : " + outfilename)
    writematrix(outfilename, xgridsize, ygridsize,
                int_window, see_window, wid_num, hei_num,
                xposition, yposition, xdisplacement, ydisplacement)

    t2 = time.perf_counter()
    print("Processing time : " + '{:.3f}'.format(t2 - t1) + "s")
    print("Done")
