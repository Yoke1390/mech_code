// We need the following files for this sample.
// config file: opencv_face_detector.pbtxt
//// https://github.com/opencv/opencv/blob/4.2.0/samples/dnn/face_detector/opencv_face_detector.pbtxt
// model file: opencv_face_detector_uint8.pb
//// We can generate this file by the following files.
//// https://github.com/opencv/opencv/blob/4.2.0/samples/dnn/face_detector/download_weights.py
//// https://github.com/opencv/opencv/blob/4.2.0/samples/dnn/face_detector/weights.meta4

#include <iostream>
#include <opencv2/core/core.hpp>
#include <opencv2/imgproc/imgproc.hpp>
#include <opencv2/objdetect/objdetect.hpp>
#include <opencv2/highgui/highgui.hpp>
#include <opencv2/dnn/dnn.hpp>

int main (int argc, char **argv)
{
  cv::Mat src_img;
  const char *model_file = "opencv_face_detector_uint8.pb";
  const char *config_file = "opencv_face_detector.pbtxt";

  static cv::Scalar colors[] = {
    {0, 0, 255}, {0, 128, 255}, {0, 255, 255}, {0, 255, 0},
    {255, 128, 0}, {255, 255, 0}, {255, 0, 0}, {255, 0, 255}
  };

  // (1)画像を読み込む
  if (argc >= 2)
    src_img = cv::imread(argv[1], cv::IMREAD_COLOR);
  if (!src_img.data)
    return -1;
  int frameHeight = src_img.rows;
  int frameWidth = src_img.cols;

  // (2)DNNモジュールを使用して，TensorFlowのモデルファイルを読み込む
  cv::dnn::Net model = cv::dnn::readNetFromTensorflow(model_file, config_file);

  // (3)画像から4次元配列を作成しネットワークに入力する
  cv::Mat blob = cv::dnn::blobFromImage(src_img, 1.0, cv::Size(1000, 1000), cv::Scalar(104, 117, 123), true, false);
  model.setInput(blob);

  // (4)ニューラルネットワークの推論の実行.物体（顔）検出.結果をdetectionsに格納する
  cv::Mat detections = model.forward();

  // (5)検出された全ての顔位置に，四角を描画する
  cv::Mat detectionMat(detections.size[2], detections.size[3], CV_32F, detections.ptr<float>());
  for(int i = 0; i < detectionMat.rows; i++){
      float confidence = detectionMat.at<float>(i, 2);

      if(confidence > 0.6){
          int x1 = static_cast<int>(detectionMat.at<float>(i, 3) * frameWidth);
          int y1 = static_cast<int>(detectionMat.at<float>(i, 4) * frameHeight);
          int x2 = static_cast<int>(detectionMat.at<float>(i, 5) * frameWidth);
          int y2 = static_cast<int>(detectionMat.at<float>(i, 6) * frameHeight);

          std::cout << i << ": (" << x1 << ", " << y1 << ") " << x2 - x1 << "x" <<  y2 - y1 << std::endl;
          cv::rectangle(src_img, cv::Point(x1, y1), cv::Point(x2, y2), cv::Scalar(0, 255, 0),
                        cv::getFontScaleFromHeight(cv::FONT_HERSHEY_COMPLEX, frameHeight / 150), 8);
      }
  }

  // (6)画像を表示，キーが押されたときに終了
  cv::namedWindow ("Face Detection", cv::WINDOW_AUTOSIZE);
  cv::imshow ("Face Detection", src_img);
  cv::waitKey (0);

  cv::destroyWindow ("Face Detection");

  return 0;
}
