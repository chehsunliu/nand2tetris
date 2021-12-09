OUT = project4.zip
HDL_FILES = $(shell find . -type f -name '*.asm')

.PHONY: all
all: $(OUT)

$(OUT): $(HDL_FILES)
	zip -j -r $@ $^

