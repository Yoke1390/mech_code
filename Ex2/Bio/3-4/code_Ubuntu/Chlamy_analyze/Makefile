all: Chlamy_analyze

Chlamy_analyze: Chlamy_analyze.cpp
	 g++ -o Chlamy_analyze Chlamy_analyze.cpp $$(pkg-config opencv4 --cflags) $$(pkg-config opencv4 --libs)

