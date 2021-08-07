CC ?= gcc

#$(LD_LIBS) := -lpthread
OUTPUT_DIR := output
USER_SRCS := fileA.c fileB.c
#USER_OBJS := $(addsuffix .o, $(USER_SRCS))
USER_OBJS := $(patsubst %.c,%.o,$(wildcard $(USER_SRCS)))
#USER_OBJS_OUT := $(addprefix $(DIR_OBJS)/, $(USER_OBJS))
USER_OBJS_OUT := $(USER_OBJS)

CFLAGS := -ffunction-sections -fdata-sections

S_LIB_NAME := libdata.a
D_LIB_NAME := libdata.so

USER_PROGRAM_NAME := main

#header file
#CFLAGS = -I ./
#CFLAGS = -ffunction-sections -fdata-sections -Wl,--gc-sections
#para
LDFLAGS = -L./output/libs
CFLAGS = -fPIC
LIBS = -ldata

.PHONY: all clean

all: $(OUTPUT_DIR)/libs/$(S_LIB_NAME) \
	$(OUTPUT_DIR)/libs/$(D_LIB_NAME) \
	$(USER_PROGRAM_NAME)

$(OUTPUT_DIR)/libs/$(S_LIB_NAME): $(USER_OBJS_OUT)
	mkdir -p $(dir $@)
	$(AR) -rcs $@ $^
	echo "Build $@ is finished"

$(OUTPUT_DIR)/libs/$(D_LIB_NAME): $(USER_OBJS_OUT)
	mkdir -p $(dir $@)
	$(CC) -fPIC -shared -o $@ $^ $(LD_LIBS)
	echo "Build $@ is finished"
	
$(OUTPUT_DIR)/libs/%.o: %.c
	mkdir -p $(dir $@)
	$(CC) $(CFLAGS) -o $@ -c $<

#static
#$(USER_PROGRAM_NAME): main.c
#	$(CC) $^ -Wl,--gc-sections -static $(LDFLAGS) $(LIBS) -o $@
#dynamic
$(USER_PROGRAM_NAME): main.c
	$(CC) $^ $(CFLAGS) $(LDFLAGS) $(LIBS) -o $@
#all:
#	$(CC) main.c $(CFLAGS) $(LDFLAGS) $(LIBS) -o main

clean:
	rm *.o -rf
	rm *.a -rf
	rm -rf main
	rm output -rf


