TARGET = HackAssembler
SRCS = $(shell find . -type f -name '*.go')

.PHONY: all
all: $(TARGET)

$(TARGET): $(SRCS)
	go build -o $@ .

.PHONY: fmt
fmt: $(SRCS)
	gofmt -w $^

.PHONY: clean
clean:
	rm -rf $(TARGET)
