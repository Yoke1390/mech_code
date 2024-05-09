#MAKEFILE

CC	= gcc
RM	= rm -f

CFLAGS	= -Wall	
LDFLAGS	= -lglut -lGLU -lGL -lm

#TARGET	= sample-hello
#OBJS	= sample-hello.o

TARGET	= sample-teapot
OBJS	= sample-teapot.o

.c.o:
	${CC} -c ${CFLAGS} $<

TARGET: ${OBJS}
	${CC} -o ${TARGET} ${OBJS} ${LDFLAGS}

clean:
	${RM} ${TARGET} *.o *~
