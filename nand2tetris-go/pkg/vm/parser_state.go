package vm

import "strconv"

type ParserState struct {
	count int
}

func (s *ParserState) GetLabel() string {
	label := "_LABEL." + strconv.Itoa(s.count)
	s.count++
	return label
}
