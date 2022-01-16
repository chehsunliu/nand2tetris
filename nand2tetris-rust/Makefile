client_platform = x86_64-unknown-linux-musl
exe = nand2tetris-rust
srcs = $(shell find ./src -name '*.rs')

host_exe = ./target/debug/$(exe)
client_exe = ./target/$(client_platform)/release/$(exe)

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

.PHONY: test8
test8: $(host_exe)
	@./extra/test8.sh

.PHONY: test10
test10: $(host_exe)
	@./extra/test10.sh

# -------------------- Publish -------------------- 

project7_zip = ./target/project7.zip 
project8_zip = ./target/project8.zip 
project10_zip = ./target/project10.zip 

project%.zip:
	@zip -j $@ $^

.PHONY: publish7
publish7: $(project7_zip)

.PHONY: publish8
publish8: $(project8_zip)

.PHONY: publish10
publish10: $(project10_zip)

$(project7_zip): $(client_exe) ./extra/VMTranslator.py ./extra/lang.txt
$(project8_zip): $(client_exe) ./extra/VMTranslator.py ./extra/lang.txt
$(project10_zip): $(client_exe) ./extra/JackAnalyzer.py ./extra/lang.txt

# -------------------- Misc -------------------- 

.PHONY: fmt
fmt:
	@cargo fmt

.PHONY: clean
clean:
	@cargo clean
