client_platform = x86_64-unknown-linux-musl
exe = nand2tetris-rust
srcs = $(shell find ./src -name '*.rs')

host_exe = ./target/debug/$(exe)
client_exe = ./target/$(client_platform)/release/$(exe)

project7_zip = ./target/project7.zip 

# -------------------- Build -------------------- 

.PHONY: build
build: $(host_exe) $(client_exe)

$(host_exe): $(srcs)
	@cargo build

$(client_exe): $(srcs)
	@cargo build --target=$(client_platform) --release

# -------------------- Test -------------------- 

.PHONY: test7
test7: $(host_exe)
	@./extra/test7.sh

# -------------------- Publish -------------------- 

.PHONY: project7
project7: $(project7_zip)

$(project7_zip): $(client_exe) ./extra/VMTranslator.py ./extra/lang.txt
	@zip -j $@ $^

# -------------------- Misc -------------------- 

.PHONY: fmt
fmt:
	@cargo fmt

.PHONY: clean
clean:
	@cargo clean
