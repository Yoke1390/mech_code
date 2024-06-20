#include <iostream>
#include <opencv2/opencv.hpp>

int main() {
  cv::VideoCapture cap(0 + cv::CAP_V4L2); // Open the default camera
  if (!cap.isOpened()) {
    std::cerr << "Cannot open the camera" << std::endl;
    return -1;
  }

  // Disable autofocus and set auto exposure initially
  cap.set(cv::CAP_PROP_AUTO_EXPOSURE, 1);
  cap.set(cv::CAP_PROP_AUTOFOCUS, 0);
  cap.set(cv::CAP_PROP_EXPOSURE, 10);
  cap.set(cv::CAP_PROP_FOCUS, 1000);

  int focus = 400;     // Starting focus value
  int exposure = 1006; // Starting exposure value, depends on the camera's range

  cv::Mat frame;
  while (true) {
    cap >> frame; // capture a frame
    if (frame.empty())
      break;

    cv::imshow("Frame", frame);

    int key = cv::waitKey(10); // Wait for a key press with a small delay
    if (key == 'q')
      break; // Exit loop

    switch (key) {
    case 'w': // Increase focus
      focus += 50;
      if (focus > 1024)
        focus = 255;
      cap.set(cv::CAP_PROP_FOCUS, focus);
      break;
    case 's': // Decrease focus
      focus -= 50;
      if (focus < 1)
        focus = 1;
      cap.set(cv::CAP_PROP_FOCUS, focus);
      break;
    case 'e': // Increase exposure
      exposure += 50;
      cap.set(cv::CAP_PROP_EXPOSURE, exposure);
      break;
    case 'd': // Decrease exposure
      exposure -= 50;
      cap.set(cv::CAP_PROP_EXPOSURE, exposure);
      break;
    }
    std::cout << "Focus: " << focus << ", Exposure: " << exposure << std::endl;
  }

  return 0;
}
