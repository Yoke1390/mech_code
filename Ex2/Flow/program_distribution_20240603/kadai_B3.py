from PIL import Image
import os
import sys
import csv
import time
import argparse
import numpy as np
import matplotlib.pyplot as plt


def calc_crc(A_DATA, B_DATA, A_wid, A_hei):
    a_average = 0.0
    b_average = 0.0
    for x in range(A_wid):
        for y in range(A_hei):
            a_average += A_DATA.getpixel((x, y))
            b_average += B_DATA.getpixel((x, y))
    a_average /= (A_wid * A_hei)
    b_average /= (A_wid * A_hei)

    tmp1 = 0.0
    tmp2 = 0.0
    tmp3 = 0.0
    for x in range(A_wid):
        for y in range(A_hei):
            tmp1 += (A_DATA.getpixel((x, y)) - a_average) ** 2
            tmp2 += (B_DATA.getpixel((x, y)) - b_average) ** 2
            tmp3 += (A_DATA.getpixel((x, y)) - a_average) * (B_DATA.getpixel((x, y)) - b_average)

    tmp1 /= (A_wid * A_hei)
    tmp1 = np.sqrt(tmp1)

    tmp2 /= (A_wid * A_hei)
    tmp2 = np.sqrt(tmp2)

    tmp3 /= (A_wid * A_hei)

    return tmp3 / (tmp1 * tmp2)


def get_args():
    parser = argparse.ArgumentParser(
        prog='kadai_B3.py',
        formatter_class=argparse.ArgumentDefaultsHelpFormatter)

    parser.add_argument('-i1',
                        help='target bmp image (***.bmp; extension is needed)',
                        action='store', default=None)
    parser.add_argument('-i2',
                        help='template bmp image (***.bmp; extension is needed)',
                        action='store', default=None)

    if parser.parse_args().i1 == None or \
            parser.parse_args().i2 == None:
        parser.print_help()
        quit()

    args = parser.parse_args()
    return (args)


def process(infilename1, infilename2):
    t1 = time.perf_counter()
    print('target bmp image   : ' + infilename1)
    print('template bmp image : ' + infilename2)

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

    print("Calc. Crosscorrelation Start")
    cc = calc_crc(A_DATA, B_DATA, A_wid, A_hei)
    print("Calc. Crosscorrelation End")

    print("Crosscorrelation is " + str(cc))

    t2 = time.perf_counter()
    print("Processing time : " + '{:.3f}'.format(t2 - t1) + "s")
    print("Done")
    return cc


if __name__ == "__main__":
    image_list = [
        "rekidai-index-089-koizumi.bmp",
        "rekidai-index-090-abe.bmp",
        "rekidai-index-091-fukuda.bmp",
        "rekidai-index-092-aso.bmp",
        "rekidai-index-093-hatoyama.bmp",
        "rekidai-index-094-kan.bmp",
        "rekidai-index-095-noda.bmp",
        "rekidai-index-096-abe.bmp",
        "rekidai-index-099-suga.bmp",
        "rekidai-index-100-kishida.bmp",
    ]

    result = []
    for num1 in range(len(image_list)):
        result.append([])
        for num2 in range(len(image_list)):
            crc = process(image_list[num1], image_list[num2])
            result[-1].append(crc)
    print(result)

    result_path = "B3.csv"
    os.remove(result_path) if os.path.exists(result_path) else None

    with open(result_path, 'a') as f:
        writer = csv.writer(f)
        writer.writerows(result)
