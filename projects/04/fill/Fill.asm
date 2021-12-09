// This file is part of www.nand2tetris.org
// and the book "The Elements of Computing Systems"
// by Nisan and Schocken, MIT Press.
// File name: projects/04/Fill.asm

// Runs an infinite loop that listens to the keyboard input.
// When a key is pressed (any key), the program blackens the screen,
// i.e. writes "black" in every pixel;
// the screen should remain fully black as long as the key is pressed. 
// When no key is pressed, the program clears the screen, i.e. writes
// "white" in every pixel;
// the screen should remain fully clear as long as no key is pressed.

// Put your code here.

(INPUT_CHECK)
  @KBD
  D=M
  @CHOOSE_WHITE_COLOR
  D;JEQ
  @CHOOSE_BLACK_COLOR
  0;JMP

(CHOOSE_WHITE_COLOR)
  @color
  M=0
  @DRAW_INIT
  0;JMP

(CHOOSE_BLACK_COLOR)
  @color
  M=-1
  @DRAW_INIT
  0;JMP

(DRAW_INIT)
  @8191
  D=A
  @offset
  M=D

(DRAW_CHECK_OFFSET)
  @offset
  D=M
  @INPUT_CHECK
  D;JLT

(DRAW_START)
  @SCREEN
  D=A
  @offset
  D=D+M
  @address
  M=D
  @color
  D=M
  @address
  A=M
  M=D

(DRAW_MINUS)
  @offset
  M=M-1
  @DRAW_CHECK_OFFSET
  0;JMP
