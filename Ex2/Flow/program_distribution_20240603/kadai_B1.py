from PIL import Image
import os
import sys
import csv
import math
import time
import argparse
import numpy as np
import matplotlib.pyplot as plt


def calc_ave(A_DATA, A_wid, A_hei):
	
	ave = 0
	return ave
	
def get_args():
	parser = argparse.ArgumentParser( \
		prog='kadai_B2.py', \
		formatter_class=argparse.ArgumentDefaultsHelpFormatter)

	parser.add_argument('-i', 
		help='target bmp image (***.bmp; extension is needed)', \
		action='store', default=None)
	
	if  parser.parse_args().i == None :	
			parser.print_help()
			quit()
	
	args = parser.parse_args()
	return(args)

if __name__ == "__main__":
	
	t1 = time.perf_counter()
	args = get_args()
	infilename  = args.i
	print('input bmp image  : ' + args.i)
	
	A_DATA = Image.open(infilename).transpose(Image.FLIP_TOP_BOTTOM)
	
	A_wid = A_DATA.size[0]
	A_hei = A_DATA.size[1]
	print('----- ----- ----- ----- ----- -----')
	print('width  of input image : ' + str(A_wid))
	print('height of input image : ' + str(A_hei))
	print('----- ----- ----- ----- ----- -----')		

	B_DATA = Image.new("L", (A_wid, A_hei))
	
	print("Smoothing Start")
	ave = calc_ave(A_DATA, A_wid, A_hei)
	print("Smoothing End")
	
	print("Average : " + str(ave))
	
	t2 = time.perf_counter()
	print("Processing time : " + '{:.3f}'.format(t2-t1) + "s")
	print("Done")