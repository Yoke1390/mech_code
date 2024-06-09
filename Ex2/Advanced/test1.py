import os
import cv2

# 画像の読み込み
path = 'image.jpg'
if not os.path.exists(path):
    raise FileNotFoundError('No such file: {}'.format(path))
    exit()
image = cv2.imread(path)

# グレースケール変換
gray = cv2.cvtColor(image, cv2.COLOR_BGR2GRAY)

# ぼかし
blurred = cv2.GaussianBlur(gray, (5, 5), 0)

# エッジ検出
edges = cv2.Canny(blurred, 50, 150)

# 輪郭検出
contours, hierarchy = cv2.findContours(edges, cv2.RETR_EXTERNAL, cv2.CHAIN_APPROX_SIMPLE)

# チョキの形をした輪郭のフィルタリング
choki_contours = []
for contour in contours:
    # 輪郭の面積を計算
    area = cv2.contourArea(contour)
    # 輪郭の周囲長を計算
    perimeter = cv2.arcLength(contour, True)
    # チョキの形の特徴に基づいたフィルタリング
    if area > 100 and perimeter > 100:
        # 近似
        approx = cv2.approxPolyDP(contour, 0.01 * perimeter, True)
        # 頂点の数が3〜5個で、周囲長と面積の比率が特定の範囲内
        if len(approx) >= 3 and len(approx) <= 5 and area / perimeter**2 > 0.01:
            choki_contours.append(contour)

# チョキの形をした輪郭の描画
for contour in contours:
    cv2.drawContours(image, [contour], -1, (0, 255, 0), 3)

# 画像の表示
cv2.imshow('Choki Detection', image)
cv2.waitKey(0)
cv2.destroyAllWindows()
