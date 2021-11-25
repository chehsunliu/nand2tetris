OUT = project1.zip
HDL_FILES = $(wildcard *.hdl)

.PHONY: all
all: $(OUT)

$(OUT): $(HDL_FILES)
	zip -r $@ $^

.PHONY: clean
clean:
	rm -rf $(OUT)
