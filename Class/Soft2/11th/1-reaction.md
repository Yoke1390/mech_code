MacでDockerを使用してガンダムを動かすことができた。
tiryoh/ros-desktop-vnc:noeticのdocker fileを使用した。
```
docker run -p 6080:80 --name ros --shm-size=512m tiryoh/ros-desktop-vnc:noetic
```
このコマンドを実行した後、ブラウザでhttp://127.0.0.1:6080 にアクセスして、vncを用いてGUIのデスクトップにアクセスする方式。
一度コンテナを終了するとVNCに接続できなくなる不具合があったが、コンテナを再度起動した後にvncserverを再起動すれば再び接続することができた。
