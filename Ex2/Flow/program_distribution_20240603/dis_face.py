from PIL import Image
import os
import sys
import csv
import math
import argparse
import numpy as np
import matplotlib.pyplot as plt

if len(sys.argv) != 6:
	print('dis_face.py [target.bmp] [template.bmp] [result.bmp] [x@max] [y@max]')
	quit()

print('reading data : ' + sys.argv[1])
A_DATA = Image.open(sys.argv[1]).transpose(Image.FLIP_TOP_BOTTOM)
print('reading data : ' + sys.argv[2])
B_DATA = Image.open(sys.argv[2]).transpose(Image.FLIP_TOP_BOTTOM)	
print('reading data : ' + sys.argv[3])
C_DATA = np.array(Image.open(sys.argv[3]).transpose(Image.FLIP_TOP_BOTTOM)	)
print('face center x: ' + sys.argv[4])
print('face center y: ' + sys.argv[5])
D_DATA = C_DATA/128-1.0


fig = plt.figure(figsize=(9, 5),tight_layout=True,dpi=120,facecolor="w")
plt.rcParams['axes.labelsize'] = 14 #ラベル全体のフォントサイズ
plt.rcParams['font.size'] = 12 #全体のフォントサイズ

ax1 = fig.add_subplot(131)
ax1.xaxis.set_ticks_position('both')
ax1.yaxis.set_ticks_position('both')
ax1.set_xlabel(r"Position, $x$ [pixel]", fontsize=14)
ax1.set_ylabel(r"Position, $y$ [pixel]", fontsize=14)
pp=plt.imshow(A_DATA, origin='lower', cmap=plt.cm.gray)
plt.clim(0,256)
plt.colorbar(pp, ax=ax1, orientation='horizontal', ticks=np.linspace(0, 256, 5, endpoint=True))\
	.set_label(r"Gray Scale [arb. unit]",size=14)
plt.xticks(np.arange(0, 800+1e-9, 400))
plt.yticks(np.arange(0, 800+1e-9, 400))


ax2 = fig.add_subplot(132)
ax2.xaxis.set_ticks_position('both')
ax2.yaxis.set_ticks_position('both')
ax2.set_xlabel(r"Position, $x$ [pixel]", fontsize=14)
ax2.set_ylabel(r"Position, $y$ [pixel]", fontsize=14)
pp=plt.imshow(B_DATA, origin='lower', cmap=plt.cm.gray)
plt.clim(0,256)
plt.colorbar(pp, ax=ax2, orientation='horizontal', ticks=np.linspace(0, 256, 5, endpoint=True))\
	.set_label(r"Gray Scale [arb. unit]",size=14)
plt.xticks(np.arange(0, 72+1e-9, 24))
plt.yticks(np.arange(0, 96+1e-9, 24))


ax3 = fig.add_subplot(133)
ax3.xaxis.set_ticks_position('both')
ax3.yaxis.set_ticks_position('both')
ax3.set_xlabel(r"Position, $x$ [pixel]", fontsize=14)
ax3.set_ylabel(r"Position, $y$ [pixel]", fontsize=14)
plt.imshow(A_DATA, origin='lower', cmap=plt.cm.gray)
pp=plt.imshow(D_DATA, alpha=0.8, origin='lower', cmap=plt.cm.coolwarm)
plt.clim(-1,1)
plt.colorbar(pp, ax=ax3, orientation='horizontal', ticks=np.linspace(-1, 1, 5, endpoint=True))\
	.set_label(r"$c$ [-]",size=14)
plt.xticks(np.arange(0, 800+1e-9, 400))
plt.yticks(np.arange(0, 800+1e-9, 400))

x,y,width,height = int(sys.argv[4])-36,int(sys.argv[5])-48,72,96
rect = plt.Rectangle((x,y), width, height, edgecolor="green", facecolor='None')
plt.gca().add_patch(rect)



# plt.show()
fig.savefig(os.path.splitext(sys.argv[1])[0]+".png", facecolor=fig.get_facecolor(), edgecolor=fig.get_edgecolor())

im = Image.open(os.path.splitext(sys.argv[1])[0]+".png")
im.crop((0,im.size[1]*7/50,im.size[0],im.size[1]*47/50)).save(os.path.splitext(sys.argv[1])[0]+".png")