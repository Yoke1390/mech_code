/***********************************************
sample-clr.c
OpenGL 画面をクリアするプログラム

        Author:k-taro@cyber.rcast.u-tokyo.ac.jp
        Author:kuni@cyber.t.u-tokyo.ac.jp

************************************************/

#include <GL/glut.h>

// 描画関数
void display(void) {
  // 画面をクリアする
  glClear(GL_COLOR_BUFFER_BIT);
  // コマンドバッファをフラッシュする
  glFlush();
}

// 初期化
void init(void) {
  // 画面をクリアする色を指定する(R,G,B,A)
  glClearColor(0.0, 1.0, 0.0, 1.0);
}

int main(int argc, char *argv[]) {
  // glutライブラリを初期化する
  glutInit(&argc, argv);
  // ウィンドウの開く位置を指定する
  glutInitWindowSize(500, 500);
  glutInitWindowPosition(100, 100);
  // ディスプレイモードを設定する
  glutInitDisplayMode(GLUT_RGBA);
  // 名前をつけてウィンドウを開く
  glutCreateWindow(argv[0]);

  // 描画関数の登録
  glutDisplayFunc(display);

  init();
  // ループ
  glutMainLoop();
  return 0;
}
