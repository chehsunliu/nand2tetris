package assemble

import (
	"bufio"
	"io"
	"regexp"
	"strings"
)

type Assembler struct {
	instruction *Instruction
	symbolTable *SymbolTable
}

func readAssembly(r io.Reader) (*Instruction, error) {
	scanner := bufio.NewScanner(r)

	var head, prev *Instruction

	for scanner.Scan() {
		line := strings.TrimSpace(scanner.Text())
		if len(line) == 0 || strings.HasPrefix(line, "//") {
			continue
		}

		line = strings.TrimSpace(strings.SplitN(line, "//", 2)[0])
		instruction := NewInstruction(line)

		if head == nil {
			head = instruction
		}

		if prev != nil {
			prev.Next = instruction
		}

		prev = instruction
	}

	return head, nil
}

func readLabels(instruction *Instruction, table *SymbolTable) *Instruction {
	if instruction == nil {
		return nil
	}

	dummy := NewInstruction("")
	dummy.Next = instruction
	current := instruction
	prev := dummy

	lineNumber := 0
	pattern := regexp.MustCompile(`^\((.+)\)$`)

	for current != nil {
		matches := pattern.FindStringSubmatch(current.Raw)
		if len(matches) > 0 {
			label := matches[1]
			table.Add(label, lineNumber)
			prev.Next = current.Next
		} else {
			lineNumber++
			prev = current
		}

		current = current.Next
	}

	return dummy.Next
}

func NewAssembler(r io.Reader) (*Assembler, error) {
	instruction, err := readAssembly(r)
	if err != nil {
		return nil, err
	}

	symbolTable := NewSymbolTable()
	instruction = readLabels(instruction, symbolTable)

	g := &Assembler{instruction, symbolTable}
	return g, nil
}

func (g *Assembler) HasNext() bool {
	return g.instruction != nil
}

func (g *Assembler) Generate() string {
	inst := g.instruction.Translate(g.symbolTable)
	g.instruction = g.instruction.Next
	return inst
}
