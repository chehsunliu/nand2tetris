package assemble

import "strconv"

const (
	addrSp = iota
	addrLcl
	addrArg
	addrThis
	addrThat

	addrScreen = 0x4000
	addrKbd    = 0x6000
)

type SymbolTable struct {
	table   map[string]int
	addrVar int
}

func NewSymbolTable() *SymbolTable {
	table := make(map[string]int)

	table["SP"] = addrSp
	table["LCL"] = addrLcl
	table["ARG"] = addrArg
	table["THIS"] = addrThis
	table["THAT"] = addrThat
	table["SCREEN"] = addrScreen
	table["KBD"] = addrKbd

	for i := 0; i < 16; i++ {
		table["R"+strconv.Itoa(i)] = i
	}

	return &SymbolTable{table: table, addrVar: 16}
}

func (t *SymbolTable) Add(symbol string, address int) {
	t.table[symbol] = address
}

func (t *SymbolTable) GetOrAdd(symbol string) int {
	addr, ok := t.table[symbol]
	if !ok {
		addr = t.addrVar
		t.table[symbol] = addr
		t.addrVar++
	}

	return addr
}
