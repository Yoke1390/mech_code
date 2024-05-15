#!/usr/bin/env python3

# We need the following files for this sample.
# config file: opencv_face_detector.pbtxt
## https://github.com/opencv/opencv/blob/4.2.0/samples/dnn/face_detector/opencv_face_detector.pbtxt
# model file: opencv_face_detector_uint8.pb
## We can generate this file by the following files.
## https://github.com/opencv/opencv/blob/4.2.0/samples/dnn/face_detector/download_weights.py
## https://github.com/opencv/opencv/blob/4.2.0/samples/dnn/face_detector/weights.meta4

import cv2
import sys

colors = [(0, 0, 255), (0, 128, 255),
          (0, 255, 255), (9, 255, 0),
          (255, 128, 0), (255, 255, 0),
          (255, 0, 0), (255, 0, 255)]

src_img = cv2.imread(sys.argv[1])

model_file = "opencv_face_detector_uint8.pb"
config_file = "opencv_face_detector.pbtxt"
frameHeight = src_img.shape[0]
frameWidth = src_img.shape[1]
model = cv2.dnn.readNetFromTensorflow(model_file, config_file)
blob = cv2.dnn.blobFromImage(src_img, 1.0, (1000, 1000), [104, 117, 123], True, False)
model.setInput(blob)
detections = model.forward()

for i in range(detections.shape[2]):
        confidence = detections[0, 0, i, 2]
        if confidence > 0.6:
            x1 = int(detections[0, 0, i, 3] * frameWidth)
            y1 = int(detections[0, 0, i, 4] * frameHeight)
            x2 = int(detections[0, 0, i, 5] * frameWidth)
            y2 = int(detections[0, 0, i, 6] * frameHeight)

            print("{} ({},{}) {}x{}".format(i, x1,y1, x2-x1, y2-y1))
            cv2.rectangle(src_img, (x1, y1), (x2, y2), (0, 255, 0), int(round(frameHeight/150)), 8)

cv2.imshow("Face Detection", src_img)
cv2.waitKey(0)
cv2.destroyAllWindows()

