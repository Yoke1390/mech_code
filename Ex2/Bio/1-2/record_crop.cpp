#include <iostream>
#include <opencv2/opencv.hpp>
#include <sstream>

// Global variables
bool isRecording = false;    // Flag to check if recording is on
cv::VideoWriter videoWriter; // VideoWriter object
int recordingCount = 0;      // Counter for the number of recordings

// Resolution setting (adjusted to 90% of 1600x1200)
cv::Size reso(static_cast<int>(1600 * 0.9), static_cast<int>(1200 * 0.9));

// Initial settings for flipping and rotating
int flipMode =
    0; // Flip mode (-1 for both axes, 0 for vertical, 1 for horizontal)
int rotationFlag = cv::ROTATE_180; // Rotation flag (ROTATE_90_CLOCKWISE,
                                   // ROTATE_180, ROTATE_90_COUNTERCLOCKWISE)

// Focus control
int focus = 350;    // Initial focus setting
int focusStep = 50; // Step change for focus adjustments

void startRecording() {
  std::ostringstream oss;
  oss << "output_" << recordingCount << ".avi";
  std::string filename = oss.str();
  int fcc = cv::VideoWriter::fourcc('M', 'J', 'P', 'G');
  videoWriter.open(filename, fcc, 30.0, reso, true);
  if (!videoWriter.isOpened()) {
    std::cerr << "Failed to open video for output." << std::endl;
  } else {
    std::cout << "Started recording to " << filename << std::endl;
    isRecording = true;
  }
}

void stopRecording() {
  if (isRecording) {
    videoWriter.release();
    std::cout << "Stopped recording" << std::endl;
    isRecording = false;
    recordingCount++;
  }
}

int main(int argc, char **argv) {
  cv::VideoCapture cap(2 + cv::CAP_V4L2); // Open the camera with V4L2
  if (!cap.isOpened()) {
    std::cerr << "Error: Cannot open the camera" << std::endl;
    return -1;
  }

  // Set camera properties
  cap.set(cv::CAP_PROP_AUTO_EXPOSURE, 1);
  cap.set(cv::CAP_PROP_AUTOFOCUS, 0); // Turn off auto focus
  cap.set(cv::CAP_PROP_FOCUS, focus);
  cap.set(cv::CAP_PROP_EXPOSURE, 100);

  cv::namedWindow("image", cv::WINDOW_NORMAL);
  cv::Mat frame, croppedFrame, processedFrame;

  while (true) {
    cap >> frame;
    if (frame.empty()) {
      std::cerr << "Error: Empty frame" << std::endl;
      break;
    }

    // Crop and resize the frame
    cv::Rect cropRect((frame.cols - frame.cols / 2) / 2,
                      (frame.rows - frame.rows / 2) / 2, frame.cols / 2,
                      frame.rows / 2);
    croppedFrame = frame(cropRect);
    cv::resize(croppedFrame, processedFrame, reso);

    // Apply flip and rotation settings
    cv::flip(processedFrame, processedFrame, flipMode);
    // cv::rotate(processedFrame, processedFrame, rotationFlag);

    if (isRecording) {
      videoWriter.write(processedFrame); // Ensure the frame size matches the
                                         // VideoWriter's configuration
    }

    cv::imshow("image", processedFrame);

    char key = cv::waitKey(1);
    if (key == 'q') {
      break; // Quit on 'q'
    } else if (key == 'r') {
      if (isRecording) {
        stopRecording();
      } else {
        startRecording();
      }
    } else if (key == 'w') {
      focus += focusStep;
      cap.set(cv::CAP_PROP_FOCUS, focus);
      std::cout << "Focus increased to: " << focus << std::endl;
    } else if (key == 's') {
      focus -= focusStep;
      cap.set(cv::CAP_PROP_FOCUS, focus);
      std::cout << "Focus decreased to: " << focus << std::endl;
    }
  }

  if (isRecording) {
    stopRecording();
  }

  // Release resources
  cap.release();
  cv::destroyAllWindows();
  return 0;
}
