set out_vector out_vector
python kadai_B5.py -i1 ./original01_000001.bmp -i2 ./original01_000002.bmp -o ${out_vector}.csv -x 40 -y 40 -s 5 -n 5
python dis_vec.py  ${out_vector}.csv
