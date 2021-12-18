OUT = project5.zip
SIM = ../../tools/HardwareSimulator.sh
HDL_FILES = $(wildcard *.hdl)
TST_FILES = $(wildcard *.tst)

.PHONY: all
all: $(OUT)

$(OUT): $(HDL_FILES)
	zip -r $@ $^

.PHONY: test
test: $(TST_FILES)
	@for tst_file in $^; do \
		echo "> $$tst_file" ; \
		$(SIM) $$tst_file ; \
	done

.PHONY: clean
clean:
	rm -rf $(OUT)
