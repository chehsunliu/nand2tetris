package assemble

import (
	"fmt"
	"regexp"
	"strconv"
	"strings"
)

var instructionPattern = regexp.MustCompile(`^([A-Z0-9]+=)?([^;]+)?(;[A-Z]+)?$`)
var (
	jumpMapping = map[string]string{
		"JGT": "001",
		"JEQ": "010",
		"JGE": "011",
		"JLT": "100",
		"JNE": "101",
		"JLE": "110",
		"JMP": "111",
	}
	destMapping = map[string]string{
		"M":   "001",
		"D":   "010",
		"MD":  "011",
		"A":   "100",
		"AM":  "101",
		"AD":  "110",
		"AMD": "111",
	}
	compMapping = map[string]string{
		"0":   "0101010",
		"1":   "0111111",
		"-1":  "0111010",
		"D":   "0001100",
		"A":   "0110000",
		"M":   "1110000",
		"!D":  "0001101",
		"!A":  "0110001",
		"!M":  "1110001",
		"-D":  "0001111",
		"-A":  "0110011",
		"-M":  "1110011",
		"D+1": "0011111",
		"A+1": "0110111",
		"M+1": "1110111",
		"D-1": "0001110",
		"A-1": "0110010",
		"M-1": "1110010",
		"D+A": "0000010",
		"D+M": "1000010",
		"D-A": "0010011",
		"D-M": "1010011",
		"A-D": "0000111",
		"M-D": "1000111",
		"D&A": "0000000",
		"D&M": "1000000",
		"D|A": "0010101",
		"D|M": "1010101",
	}
)

type Instruction struct {
	Raw  string
	Next *Instruction
}

func NewInstruction(raw string) *Instruction {
	return &Instruction{Raw: raw}
}

func (inst *Instruction) translateA(symbolTable *SymbolTable) string {
	symbol := inst.Raw[1:]

	addr, err := strconv.Atoi(symbol)
	if err != nil {
		addr = symbolTable.GetOrAdd(symbol)
	}

	s := strconv.FormatInt(int64(addr), 2)
	return fmt.Sprintf("%016s", s)
}

func (inst *Instruction) translateDest(s string) string {
	if len(s) == 0 {
		return "000"
	}

	out, ok := destMapping[s[:len(s)-1]]
	if !ok {
		panic("Unexpected dest: " + s)
	}
	return out
}

func (inst *Instruction) translateComp(s string) string {
	out, ok := compMapping[s]
	if !ok {
		panic("Unexpected comp: " + s)
	}
	return out
}

func (inst *Instruction) translateJump(s string) string {
	if len(s) == 0 {
		return "000"
	}

	out, ok := jumpMapping[s[1:]]
	if !ok {
		panic("Unexpected jump: " + s)
	}
	return out
}

func (inst *Instruction) Translate(symbolTable *SymbolTable) string {
	if strings.HasPrefix(inst.Raw, "@") {
		return inst.translateA(symbolTable)
	}

	groups := instructionPattern.FindStringSubmatch(inst.Raw)
	return "111" + inst.translateComp(groups[2]) + inst.translateDest(groups[1]) + inst.translateJump(groups[3])
}
