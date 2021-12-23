package cmd

import (
	"github.com/spf13/cobra"

	"github.com/chehsunliu/nand2tetris/nand2tetris-go/pkg/vm"
)

func newVmTranslatorCmd() *cobra.Command {
	var options vm.Options

	cmd := &cobra.Command{
		Use:   "vm-translator",
		Short: "Translate VM code into Hack assembly",
		RunE: func(cmd *cobra.Command, args []string) error {
			return vm.Translate(&options)
		},
	}

	cmd.Flags().StringVar(&options.InputPath, "input-path", "", "Filepath of VM code")
	if err := cmd.MarkFlagRequired("input-path"); err != nil {
		panic(err)
	}

	return cmd
}
