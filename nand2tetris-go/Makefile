BUILD_DIR = build
HOST_EXE = $(BUILD_DIR)/nand2tetris.exe
CROSS_EXE = $(BUILD_DIR)/nand2tetris-linux.exe
SRCS = $(shell find . -name '*.go')

PROJECT_7 = $(BUILD_DIR)/project7.zip

%.exe:
	@echo "Compile $@..."
	@go build -o $@ ./cmd/main.go

.PHONY: all
all: $(HOST_EXE) $(CROSS_EXE) $(PROJECT_7)

$(CROSS_EXE): export CGO_ENABLED = 1
$(CROSS_EXE): export GOOS = linux
$(CROSS_EXE): export GOARCH = amd64

$(HOST_EXE): $(SRCS)
$(CROSS_EXE): $(SRCS)

.PHONY: clean
clean:
	rm -rf build

$(PROJECT_7): $(CROSS_EXE) wrapper/VMTranslator.py wrapper/lang.txt
	zip -j $@ $^
