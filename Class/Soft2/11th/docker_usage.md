```
docker ps -a
docker start ros
docker exec -it ros /bin/bash
```

このコマンドを実行した後、ブラウザでhttp://127.0.0.1:6080 にアクセスする

ホスト側のファイルをコンテナにコピーするには以下のようにする
```
docker cp <source_path> ros:<dest_path>
```

## 終了したあと再接続するには
公式には、ログアウトしてから終了することで再度接続できるようになると書いてあるがうまくいかないことも。
その場合は、以下のコマンドを実行する
```
docker start ros
docker exec -it ros /bin/bash

vncserver -list
vncserver -kill :1 # 1はvncserver -listで左に表示される番号
vncserver :1 -geometry 1280x800 -depth 24
```
こうしてから、ブラウザでhttp://127.0.0.1:6080 にアクセスする

## 参考
MacでROS noeticをつかう！
https://qiita.com/hukurou1234/items/2240e243a3214f1b847c
