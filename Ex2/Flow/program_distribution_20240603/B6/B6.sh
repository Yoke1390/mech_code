#!/bin/bash

mkdir -p out

# Initialize variables
DEGREE=""
N1=""
N2=""
GRID=""
SEE_WINDOW=""
INT_WINDOW=""

# Function to display usage
usage() {
    echo "Usage: $0 -degree DEGREE -n1 N1 -n2 N2 -grid GRID -see SEE_WINDOW -int INT_WINDOW"
    exit 1
}

# Parse command-line options
while [[ $# -gt 0 ]]; do
    key="$1"

    case $key in
        -degree)
            DEGREE="$2"
            shift # past argument
            shift # past value
            ;;
        -n1)
            N1="$2"
            shift # past argument
            shift # past value
            ;;
        -n2)
            N2="$2"
            shift # past argument
            shift # past value
            ;;
        -grid)
            GRID="$2"
            shift # past argument
            shift # past value
            ;;
        -see)
            SEE_WINDOW="$2"
            shift # past argument
            shift # past value
            ;;
        -int)
            INT_WINDOW="$2"
            shift # past argument
            shift # past value
            ;;
        *)    # unknown option
            echo "Invalid option: $1" 1>&2
            usage
            ;;
    esac
done
shift $((OPTIND -1))

# Check if all mandatory parameters are provided
if [ -z "$DEGREE" ] || [ -z "$N1" ] || [ -z "$N2" ] || [ -z "$GRID" ] || [ -z "$SEE_WINDOW" ] || [ -z "$INT_WINDOW" ]; then
    echo "DEGREE: "$DEGREE
    echo "N1: "$N1
    echo "N2: "$N2
    echo "GRID: "$GRID
    echo "SEE_WINDOW: "$SEE_WINDOW
    echo "INT_WINDOW: "$INT_WINDOW
    usage
fi

####################
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
####################
python kadai_B5_tqdm.py -i1 $FILE1 -i2 $FILE2 -o $OUT -x $GRID -y $GRID -s $SEE_WINDOW -n $INT_WINDOW
python dis_vec2.py  $OUT $SHAPE
