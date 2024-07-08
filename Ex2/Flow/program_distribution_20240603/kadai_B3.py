from PIL import Image
import os
import sys
import csv
import math
import time
import argparse
import numpy as np
import matplotlib.pyplot as plt


def calc_crc(A_DATA, B_DATA, A_wid, A_hei):
	tmp3 = 0.0
	return tmp3

def get_args():
	parser = argparse.ArgumentParser( \
		prog='kadai_B3.py', \
		formatter_class=argparse.ArgumentDefaultsHelpFormatter)

	parser.add_argument('-i1', 
		help='target bmp image (***.bmp; extension is needed)', \
		action='store', default=None)
	parser.add_argument('-i2', 
		help='template bmp image (***.bmp; extension is needed)', \
		action='store', default=None)
	
	if  parser.parse_args().i1 == None or \
		parser.parse_args().i2 == None :	
			parser.print_help()
			quit()
	
	args = parser.parse_args()
	return(args)

if __name__ == "__main__":
	
	t1 = time.perf_counter()
	args = get_args()
	infilename1 = args.i1
	infilename2 = args.i2
	print('target bmp image   : ' + args.i1)
	print('template bmp image : ' + args.i2)
	
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
	print("Processing time : " + '{:.3f}'.format(t2-t1) + "s")
	print("Done")