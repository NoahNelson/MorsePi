WIRPATH = ~/wiringPi/wiringPi/

OBJS = softTone.o softPwm.o piHiPri.o wiringPi.o

WIROBJS = $(addprefix $(WIRPATH), $(OBJS))

HEADER = $(addprefix $(WIRPATH), wiringPi.h)

LIBS = -lpthread

swiftblink: $(WIROBJS) test.o
	swiftc test.o $(WIROBJS) -o test $(LIBS)
test.o: test.swift
	swiftc -c test.swift -import-objc-header $(HEADER)
morsewrite: $(WIROBJS) morsewrite.o
	swiftc morsewrite.o $(WIROBJS) -o morsewrite $(LIBS)
morseread: $(WIROBJS) morseread.o
	swiftc morseread.o $(WIROBJS) -o morseread $(LIBS)
morsewrite.o: morsewrite.swift
	swiftc -c morsewrite.swift -import-objc-header $(HEADER)
morseread.o: morseread.swift
	swiftc -c morseread.swift -import-objc-header $(HEADER)
