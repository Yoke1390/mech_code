mkdir -p out
DEGREE=$1
N1=$2
N2=$3
IMG_DIR=$(printf "background_erased/bgr_g13_%02ddeg" $DEGREE)
FILE1=$IMG_DIR/$(printf "bgr_g13_%02ddeg_%06d.bmp" $DEGREE $N1)
FILE2=$IMG_DIR/$(printf "bgr_g13_%02ddeg_%06d.bmp" $DEGREE $N2)
OUT=$(printf "out/out_vector_%02ddeg_%06d_%06d.csv" $DEGREE $N1 $N2)
SHAPE=$(printf "outlined/%02dshape.csv" $DEGREE)
echo "------------------------------------------"
echo "target1: "$FILE1
echo "target2: "$FILE2
echo "output: "$OUT
echo "shape: "$SHAPE
echo "------------------------------------------"
exit
python kadai_B5.py -i1 $FILE1 -i2 $FILE2 -o $OUT -x 35 -y 35 -s 15 -n 15
python dis_vec2.py  $OUT $SHAPE
