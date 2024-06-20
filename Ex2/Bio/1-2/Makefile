all: record_crop cam_c scalebar

record_crop: record_crop.cpp
	 g++ -o record_crop record_crop.cpp $$(pkg-config opencv4 --cflags) $$(pkg-config opencv4 --libs)

cam_c: cam_c.cpp
	 g++ -o cam_c cam_c.cpp $$(pkg-config opencv4 --cflags) $$(pkg-config opencv4 --libs)

scalebar: scalebar.cpp
	 g++ -o scalebar scalebar.cpp $$(pkg-config opencv4 --cflags) $$(pkg-config opencv4 --libs)
