package cmd

import (
	"log"
	"os"

	"github.com/spf13/cobra"
)

func newRootCmd() *cobra.Command {
	cmd := &cobra.Command{
		Use:   os.Args[0],
		Short: "Command collection of the nand2tetris course",
	}

	cmd.AddCommand(newVmTranslatorCmd())

	return cmd
}

func Execute() {
	if err := newRootCmd().Execute(); err != nil {
		log.Fatal(err)
	}
}
