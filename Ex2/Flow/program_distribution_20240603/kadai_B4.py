from PIL import Image
import os
import sys
import csv
import math
import time
import argparse
import numpy as np
import matplotlib.pyplot as plt


def calc_matching(A_DATA, B_DATA, C_DATA, A_wid, A_hei, B_wid, B_hei, skip):
	cc = 0.0
	xpos = 0
	ypos = 0
	cmax = -1.0
	HB_wid = int((B_wid-1)/2)
	HB_hei = int((B_hei-1)/2)
	for jj in range(int(skip/2),A_hei,skip):
		for ii in range(int(skip/2),A_wid,skip):
			print( "  (" + str(ii) + "," + str(jj) + ")/(" + str(A_wid) + "," + str(A_hei) + ")")
			
			C_DATA.putpixel((int((ii-int(skip/2))/skip),int((jj-int(skip/2))/skip)), int((cc+1.0)/2.0*255))
			
	return xpos, ypos, cmax
	

def get_args():
	parser = argparse.ArgumentParser( \
		prog='kadai_B4.py', \
		formatter_class=argparse.ArgumentDefaultsHelpFormatter)

	parser.add_argument('-i1', 
		help='target bmp image (***.bmp; extension is needed)', \
		action='store', default=None)
	parser.add_argument('-i2', 
		help='template bmp image (***.bmp; extension is needed)', \
		action='store', default=None)
	parser.add_argument('-o', 
		help='output bmp file (***.bmp; extension is needed)', \
		action='store', default='find.bmp')
	parser.add_argument('-n', 
		help='grid interval for calculation', \
		action='store', default=100)
	
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
	outfilename = args.o
	skip = int(args.n)
	print('target bmp image   : ' + args.i1)
	print('template bmp image : ' + args.i2)
	print('output csv         : ' + args.o)
	print('grid interval      : ' + str(args.n))
	
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
	
	C_DATA = Image.new("L", (int(A_wid/skip), int(A_hei/skip)))

	print("Template Matching Start")
	xpos, ypos, cmax= calc_matching(A_DATA, B_DATA, C_DATA, A_wid, A_hei, B_wid, B_hei, skip)
	print("Template Matching End")
	
	print("max crc = " + str(cmax))
	print("@ x pos = " + str(xpos))
	print("@ y pos = " + str(ypos))

	print("Writing : " + outfilename)
	C_DATA = C_DATA.resize((A_wid, A_hei), resample=0)
	C_DATA.transpose(Image.FLIP_TOP_BOTTOM).save(outfilename)
	
	t2 = time.perf_counter()
	print("Processing time : " + '{:.3f}'.format(t2-t1) + "s")
	print("Done")