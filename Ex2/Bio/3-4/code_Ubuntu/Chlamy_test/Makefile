all: Chlamy_test

Chlamy_test: Chlamy_test.cpp
	 g++ -o Chlamy_test Chlamy_test.cpp $$(pkg-config opencv4 --cflags) $$(pkg-config opencv4 --libs)

