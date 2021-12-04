OUT = project3.zip
HDL_FILES = $(shell find . -type f -name '*.hdl')
TST_FILES = $(HDL_FILES:%.hdl=%.tst)
SIM = ../../tools/HardwareSimulator.sh

.PHONY: all
all: $(OUT) test

$(OUT): test
$(OUT): $(HDL_FILES)
	zip -j -r $@ $^

.PHONY: test
test: $(TST_FILES)
	@for tst_file in $^; do \
		echo "> $$tst_file" ; \
		$(SIM) $$tst_file ; \
	done

.PHONY: clean
clean:
	rm -rf $(OUT)
