package vm

import (
	"bytes"
	"html/template"
)

func fillTemplate(text string, data interface{}) string {
	t, err := template.New("vm-translator").Parse(text)
	if err != nil {
		panic(err)
	}

	buf := &bytes.Buffer{}
	if err := t.Execute(buf, data); err != nil {
		panic(err)
	}

	return buf.String()
}
