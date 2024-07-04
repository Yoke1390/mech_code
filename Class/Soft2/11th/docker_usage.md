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

## 参考
MacでROS noeticをつかう！
https://qiita.com/hukurou1234/items/2240e243a3214f1b847c
