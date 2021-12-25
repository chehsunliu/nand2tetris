package vm

import (
	"fmt"
	"strconv"
)

type ParserState struct {
	count    int
	filename string
}

func (s *ParserState) GetLabel() string {
	label := "_LABEL." + strconv.Itoa(s.count)
	s.count++
	return label
}

func (s *ParserState) GetStaticSymbol(i int) string {
	return fmt.Sprintf("%s.%d", s.filename, i)
}
