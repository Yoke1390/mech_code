from PIL import Image
import os
import sys
import csv
import math
import argparse
import numpy as np
import matplotlib.pyplot as plt


if len(sys.argv) != 2:
    print('dis_vec.py [input csv file name]')
    quit()

print('reading data : ' + sys.argv[1])
with open(sys.argv[1]) as ff:
    # inlist = csv.reader(ff)
    inlist = [row for row in csv.reader(ff)]

# print(inlist)
# print(inlist[2][2])

xnum = int(inlist[1][1])
ynum = int(inlist[1][2])
print('number of xdata : ' + str(xnum))
print('number of ydata : ' + str(ynum))

xpos = [[0 for ii in range(xnum)] for jj in range(ynum)]
ypos = [[0 for ii in range(xnum)] for jj in range(ynum)]
xvec = [[0 for ii in range(xnum)] for jj in range(ynum)]
yvec = [[0 for ii in range(xnum)] for jj in range(ynum)]
mvec = [[0 for ii in range(xnum)] for jj in range(ynum)]

for jj in range(ynum):
    for ii in range(xnum):
        xpos[jj][ii] = float(inlist[jj * (xnum + 1) + ii + 3][0]) - 0.5
        ypos[jj][ii] = float(inlist[jj * (xnum + 1) + ii + 3][1]) - 0.5
        if 'nan' in inlist[jj * (xnum + 1) + ii + 3][3]:
            xvec[jj][ii] = 1.0e-9
        else:
            xvec[jj][ii] = float(inlist[jj * (xnum + 1) + ii + 3][3])
        if 'nan' in inlist[jj * (xnum + 1) + ii + 3][4]:
            yvec[jj][ii] = 1.0e-9
        else:
            yvec[jj][ii] = float(inlist[jj * (xnum + 1) + ii + 3][4])
        mvec[jj][ii] = np.sqrt(
            xvec[jj][ii] * xvec[jj][ii]
            + yvec[jj][ii] * yvec[jj][ii])


fig = plt.figure(figsize=(5, 4), tight_layout=True, dpi=120, facecolor="w")
plt.rcParams['axes.labelsize'] = 14
plt.rcParams['font.size'] = 12

ax = fig.add_subplot(111)

img_wid = 256
img_hei = 256

plt.xticks(np.arange(0, img_wid + 1e-9, 64))
plt.yticks(np.arange(0, img_hei + 1e-9, 64))
ax.set_xlim(0, img_wid)
ax.set_ylim(0, img_hei)
ax.minorticks_on()
ax.set_aspect('equal', 'box')
ax.xaxis.set_ticks_position('both')
ax.yaxis.set_ticks_position('both')
ax.tick_params(which="both", direction='in')

ax.set_xlabel(r"Position, $x$ [pixel]", fontsize=14)
ax.set_ylabel(r"Position, $y$ [pixel]", fontsize=14)
ax.set_xticklabels(ax.get_xticklabels(), fontsize=12)
ax.set_yticklabels(ax.get_yticklabels(), fontsize=12)


pp = plt.imshow(mvec, extent=[0, img_wid, 0, img_hei], origin='lower', cmap=plt.cm.rainbow)
plt.clim(0, 16)
plt.colorbar(pp, ax=ax, ticks=np.linspace(0, 16, 5, endpoint=True))\
    .set_label(r"Displacement, $|\mathbf{u}|$ [pixel/frame]", size=14)

plt.quiver(xpos, ypos, xvec, yvec, color='black', angles='xy', scale_units='xy', scale=0.7)

plt.show()
fig.savefig(os.path.splitext(sys.argv[1])[0] + ".png", facecolor=fig.get_facecolor(), edgecolor=fig.get_edgecolor())
