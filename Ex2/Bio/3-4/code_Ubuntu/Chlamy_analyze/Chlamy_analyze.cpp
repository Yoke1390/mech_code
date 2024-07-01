#include <cstdio>
#include <fstream>
#include <iostream>
#include <opencv2/core/core.hpp>
#include <opencv2/highgui/highgui.hpp>
#include <opencv2/imgproc/imgproc.hpp>
#include <opencv2/video/tracking.hpp>
#include <sys/stat.h>
#include <unistd.h>
// using namespace std;

// 標準入力にファイル名を入れる
//  例：実行ファイルと同じディレクトリにある動画ファイル (20240101_Left.avi)
//  を処理したい場合
//  >> ./Chlamy_analyze 20240101_Left.avi
int main(int argc, char *argv[]) {
  // 1. 入力(video)元をmovファイルに設定する
  // 動画ファイルのパスの文字列を取得する
  std::string filepath = argv[1];
  // 動画ファイルを取り込むためのオブジェクトを宣言する
  cv::VideoCapture video;
  // 動画ファイルを開く
  video.open(filepath);
  if (video.isOpened() == false) {
    // 動画ファイルが開けなかったときは終了する
    return 0;
  }
  // 2. 出力(writer)先を設定する
  // 動画のファイル名と同じ名前をもつディレクトリを作成し、移動する
  std::string dirname = filepath.substr(
      0, filepath.size() - 4); // 拡張子を含まないファイル名を取得
  mkdir(dirname.c_str(), 0777); // ディレクトリ作成
  chdir(dirname.c_str());       // ディレクトリ移動

  // 画像処理したあとの動画ファイルを書き出すためのオブジェクトを宣言(演習ではオフ)
  // cv::VideoWriter writer;
  // std::string writer_name="Clone_" + dirname + ".mp4";
  // 書き出し先の動画ファイル (writer) のプロパティを読み込み元
  // (videoまたはカメラキャプチャ) からコピーする
  int width, height, fourcc; // 横幅、縦幅、フォーマットを定義
  double fps;                // フレームレートを定義
  // 読み込み元から、各値を取得
  width = (int)video.get(cv::CAP_PROP_FRAME_WIDTH);   // フレーム横幅
  height = (int)video.get(cv::CAP_PROP_FRAME_HEIGHT); // フレーム縦幅
  fps = video.get(cv::CAP_PROP_FPS);                  // フレームレート
  // fourcc = cv::VideoWriter::fourcc('m', 'p', '4', 'v'); //
  // ビデオフォーマットを指定(ISO MPEG-4 / .mp4)
  //  書き出し先の動画ファイル (writer) へ各値を設定する
  // writer.open(writer_name, fourcc, fps, cv::Size(width, height));

  // 3. 動体検知処理に使うオブジェクトなどを宣言する
  cv::Mat mat, image, frame, gray, gray32, avg32, delta32, thresh32,
      thresh; // 動体検知処理のためのオブジェクトを宣言
  std::vector<std::vector<cv::Point>>
      contours; // 抽出された輪郭情報の格納先を宣言

  // 4. 動体検知
  int count_frame = 0;
  char fname[30];
  while (1) {
    // 4-1. videoからimageへ1フレーム取り込む(CV_8UC3)
    video >> image;

    if (image.empty() == true)
      break; // 画像が読み込めなかったとき、無限ループを抜ける
    // 4-2. imageをグレースケールgrayに変換(CV_8U)
    cv::cvtColor(image, gray, cv::COLOR_BGR2GRAY);
    // さらにCV_8UからCV_32Fへ変換
    gray.convertTo(gray32, CV_32F, 1.0 / 255);

    // 4-3. 近い過去の重み付け平均avg(CV_32F)を求める
    // 4-3-1. 最初の1フレームはgray32をそのままavgに代入
    if (avg32.empty()) {
      avg32 = gray32.clone();
      continue;
    }
    // 4-3-2. avgを更新
    cv::accumulateWeighted(gray32, avg32, 0.6);

    // 4-4. 現在のgray32と直近過去image_avgとの差frame_Deltaを計算
    cv::absdiff(gray32, avg32, delta32);

    // 4-5. deltaに閾値処理を行い、threshを得る
    cv::threshold(delta32, thresh32, 0.018, 1, cv::THRESH_BINARY);
    // 引数：inputpict outputpict, threshold, maxValue, 2値化の方法

    // 4-6. threshから輪郭線を抽出
    // 4-6-1. thresh(CV_32F)をthresh(CV_8U)に変換
    thresh32.convertTo(thresh, CV_8U, 255);
    // 4-6-2. 輪郭線を抽出し、contoursに格納
    cv::findContours(thresh.clone(), contours, cv::RETR_EXTERNAL,
                     cv::CHAIN_APPROX_SIMPLE);
    // 引数：inputpict, 輪郭情報contours, CV_RETR_EXTERNAL
    // 最も外側の輪郭のみを抽出, CV_CHAIN_APPROX_NONE すべての輪郭点を完全に格納

    // 4-7. 輪郭線を元のカラーフレーム画像imageに(緑色で)描画する
    cv::drawContours(image, contours, -1, cv::Scalar(255, 0, 0), 3);
    // 引数：outputpict, contours, contourIdx=描かれる輪郭(負値の場合すべて),
    // color

    // 4-8. ウィンドウに動画を表示する
    cv::imshow("showing", image);      // 元画像+輪郭線
    cv::moveWindow("showing", 10, 10); // ウィンドウ移動
    //		cv::imshow("showing", thresh);	// 閾値画像
    //		cv::imshow("showing", delta32); 	// 差分画像
    //		cv::imshow("showing", avg32); 	// 直近の平均画像

    // 4-9. 画像 image を動画ファイルへ書き出す(演習ではオフ)
    // writer << image;

    // 4-10. 輪郭線の重心をテキストファイルに出力する
    // Point2fは(x座標,y座標)のように指定される
    count_frame++;
    sprintf(fname, "file_%d.txt", count_frame);
    std::ofstream outputfile(fname);
    for (const auto &contour : contours) {
      cv::Moments m = moments(contour);
      if (m.m00 != 0) { // 有効な座標情報のみを書き込み
        cv::Point2f center(m.m10 / m.m00, m.m01 / m.m00);
        outputfile << center.x << "," << center.y << std::endl;
      }
    }
    outputfile.close();

    if (cv::waitKey(1) == 'q')
      break; // qを押すと終了
  }
  return 0;
}
