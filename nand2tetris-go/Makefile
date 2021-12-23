BUILD_DIR = build
HOST_EXE = $(BUILD_DIR)/nand2tetris.exe
CROSS_EXE = $(BUILD_DIR)/nand2tetris-linux.exe
SRCS = $(shell find . -name '*.go')

PROJECT_7 = $(BUILD_DIR)/project7.zip

%.exe:
	@echo "Compile $@..."
	@go build -o $@

.PHONY: build
build: $(HOST_EXE)

.PHONY: publish
publish: $(PROJECT_7)

$(CROSS_EXE): export CGO_ENABLED = 0
$(CROSS_EXE): export GOOS = linux
$(CROSS_EXE): export GOARCH = amd64

$(HOST_EXE): $(SRCS)
$(CROSS_EXE): $(SRCS)

.PHONY: clean
clean:
	rm -rf build

.PHONY: fmt
fmt: $(SRCS)
	go fmt ./...

$(PROJECT_7): $(CROSS_EXE) wrapper/VMTranslator.py wrapper/lang.txt
	zip -j $@ $^
