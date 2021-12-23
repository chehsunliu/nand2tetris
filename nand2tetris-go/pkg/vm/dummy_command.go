package vm

type DummyCommand struct {
	raw string
}

func (n *DummyCommand) Raw() string {
	return n.raw
}

func (n *DummyCommand) Translate() string {
	return ""
}
