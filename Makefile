# Makefile for my morse coder project for Raspberry Pi

WIRPATH = ~/wiringPi/wiringPi/
# Path to wriringPi files, since we need to compile against these

OBJS = softTone.o softPwm.o piHiPri.o wiringPi.o
# Make sure these are built, or add targets for them to this Makefile

WIROBJS = $(addprefix $(WIRPATH), $(OBJS))

HEADER = $(addprefix $(WIRPATH), wiringPi.h)

LIBS = -lpthread

all: morsewrite morseread

morsewrite: $(WIROBJS) morsewrite.o
	swiftc morsewrite.o $(WIROBJS) -o morsewrite $(LIBS)
morseread: $(WIROBJS) morseread.o
	swiftc morseread.o $(WIROBJS) -o morseread $(LIBS)
morsewrite.o: morsewrite.swift
	swiftc -c morsewrite.swift -import-objc-header $(HEADER)
morseread.o: morseread.swift
	swiftc -c morseread.swift -import-objc-header $(HEADER)
