#include <cmath>
#include <iostream>
#include <numeric>
#include <opencv2/opencv.hpp>
#include <vector>

// Known distance (um) of the channel width
const double k_dis = 200;

// Global variables for storing points and distances
std::vector<cv::Point> all_points;
std::vector<double> distances;
double scale = 0;
bool isRecording = false;    // Flag to check if recording is on
cv::VideoWriter videoWriter; // VideoWriter object

// Initial settings for flipping and rotating
int flipMode =
    0; // Flip mode (-1 for both axes, 0 for vertical, 1 for horizontal)
int rotationFlag =
    cv::ROTATE_90_CLOCKWISE; // Rotation flag (ROTATE_90_CLOCKWISE, ROTATE_180,
                             // ROTATE_90_COUNTERCLOCKWISE)

// Mouse callback function
void click_and_measure(int event, int x, int y, int flags, void *userdata) {
  if (event == cv::EVENT_LBUTTONDOWN) {
    all_points.push_back(cv::Point(x, y)); // Store click point

    // Recalculate distances and scale if enough points
    if (all_points.size() % 2 == 0) {
      double dx = all_points.back().x - all_points[all_points.size() - 2].x;
      double dy = all_points.back().y - all_points[all_points.size() - 2].y;
      double pixel_distance = std::sqrt(dx * dx + dy * dy);
      distances.push_back(pixel_distance);
      std::cout << "Pixel distance #" << distances.size() << ": "
                << pixel_distance << " pixels\n";

      if (distances.size() >= 3) { // Collect enough pairs to calculate scale
        double mean_distance =
            std::accumulate(distances.begin(), distances.end(), 0.0) /
            distances.size();
        double variance =
            std::accumulate(distances.begin(), distances.end(), 0.0,
                            [mean_distance](double sum, double value) {
                              return sum + (value - mean_distance) *
                                               (value - mean_distance);
                            }) /
            distances.size();

        double std_dev = std::sqrt(variance);
        std::cout << "Mean distance: " << mean_distance << " pixels\n";
        std::cout << "Standard deviation: " << std_dev << " pixels\n";
        scale = k_dis / mean_distance;
        std::cout << "Scale: " << scale << " um/pixel\n";
        all_points.clear(); // Clear points to restart measurement
        distances.clear();
      }
    }
  }
}

int main() {
  cv::VideoCapture cap(2 + cv::CAP_V4L2); // Open the camera with V4L2
  cap.set(cv::CAP_PROP_AUTO_EXPOSURE, 1);
  cap.set(cv::CAP_PROP_AUTOFOCUS, 0);
  cap.set(cv::CAP_PROP_EXPOSURE, 400);
  cap.set(cv::CAP_PROP_FOCUS, 350);

  if (!cap.isOpened()) {
    std::cerr << "Error: Cannot open the camera" << std::endl;
    return -1;
  }

  std::string filename = "output.avi";
  int fcc = cv::VideoWriter::fourcc('M', 'J', 'P', 'G');
  videoWriter.open(filename, fcc, 30.0, cv::Size(1200, 800), true);
  if (!videoWriter.isOpened()) {
    std::cerr << "Failed to open video for output." << std::endl;
    return -1;
  }

  cv::namedWindow("image", cv::WINDOW_NORMAL); // Create a resizable window
  cv::Mat frame, resizedFrame;
  cv::setMouseCallback("image", click_and_measure,
                       nullptr); // Set mouse callback

  while (true) {
    cap >> frame; // Capture frame-by-frame
    if (frame.empty())
      break;

    // Resize frame
    cv::resize(frame, resizedFrame, cv::Size(1200, 800)); // Resize to 1200x800
    // Apply flip and rotation settings
    cv::flip(resizedFrame, resizedFrame, flipMode);
    // cv::rotate(resizedFrame, resizedFrame, rotationFlag);

    // Draw all points and scale bar
    for (const auto &point : all_points) {
      cv::circle(resizedFrame, point, 5, cv::Scalar(0, 255, 0), -1);
    }
    if (scale != 0) {
      int bar_length_pixels = static_cast<int>(400 / scale);
      int y = resizedFrame.rows - 50;
      cv::line(resizedFrame, cv::Point(50, y),
               cv::Point(50 + bar_length_pixels, y), cv::Scalar(255, 0, 0), 2);
      cv::putText(resizedFrame, "400 um", cv::Point(50, y - 10),
                  cv::FONT_HERSHEY_SIMPLEX, 0.75, cv::Scalar(255, 0, 0), 2);
    }

    if (isRecording) {
      videoWriter.write(resizedFrame); // Write the frame to the video file
    }

    cv::imshow("image", resizedFrame); // Display the frame

    char key = cv::waitKey(1);
    if (key == 'q')
      break;               // Quit on 'q'
    else if (key == 'r') { // Toggle recording on 'r'
      isRecording = !isRecording;
      std::cout << "Recording toggled:" << (isRecording ? "ON" : "OFF")
                << std::endl;
    }
  }

  videoWriter.release(); // Close the VideoWriter
  cap.release();         // Clean up
  cv::destroyAllWindows();
  return 0;
}
