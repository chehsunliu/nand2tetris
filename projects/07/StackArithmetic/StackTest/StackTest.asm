// push constant 17
@17
D=A
@SP
A=M
M=D
@SP
M=M+1

// push constant 17
@17
D=A
@SP
A=M
M=D
@SP
M=M+1

// eq
@SP    // A = 0
A=M    // A = M[0] = 258
A=A-1  // A = 258 - 1 = 257
D=M    // D = M[257] = 17
A=A-1  // A = 257 - 1 = 256
D=D-M  // D = 17 - M[256] = 17 - 17 = 0
@_LABEL.0
D;JEQ  // if D == 0, jump to LABEL0

@SP    // A = 0
A=M    // A = M[0] = 258
A=A-1  // A = 258 - 1 = 257
A=A-1  // A = 257 - 1 = 256
M=0    // M[256] = false
@_LABEL.1
0;JMP

(_LABEL.0)
@SP    // A = 0
A=M    // A = M[0] = 258
A=A-1  // A = 258 - 1 = 257
A=A-1  // A = 257 - 1 = 256
M=-1   // M[256] = true

(_LABEL.1)
@SP    // A = 0
M=M-1  // M[0] = 258 - 1 = 257

// push constant 17
@17
D=A
@SP
A=M
M=D
@SP
M=M+1

// push constant 16
@16
D=A
@SP
A=M
M=D
@SP
M=M+1

// eq
@SP    // A = 0
A=M    // A = M[0] = 258
A=A-1  // A = 258 - 1 = 257
D=M    // D = M[257] = 17
A=A-1  // A = 257 - 1 = 256
D=D-M  // D = 17 - M[256] = 17 - 17 = 0
@_LABEL.2
D;JEQ  // if D == 0, jump to LABEL0

@SP    // A = 0
A=M    // A = M[0] = 258
A=A-1  // A = 258 - 1 = 257
A=A-1  // A = 257 - 1 = 256
M=0    // M[256] = false
@_LABEL.3
0;JMP

(_LABEL.2)
@SP    // A = 0
A=M    // A = M[0] = 258
A=A-1  // A = 258 - 1 = 257
A=A-1  // A = 257 - 1 = 256
M=-1   // M[256] = true

(_LABEL.3)
@SP    // A = 0
M=M-1  // M[0] = 258 - 1 = 257

// push constant 16
@16
D=A
@SP
A=M
M=D
@SP
M=M+1

// push constant 17
@17
D=A
@SP
A=M
M=D
@SP
M=M+1

// eq
@SP    // A = 0
A=M    // A = M[0] = 258
A=A-1  // A = 258 - 1 = 257
D=M    // D = M[257] = 17
A=A-1  // A = 257 - 1 = 256
D=D-M  // D = 17 - M[256] = 17 - 17 = 0
@_LABEL.4
D;JEQ  // if D == 0, jump to LABEL0

@SP    // A = 0
A=M    // A = M[0] = 258
A=A-1  // A = 258 - 1 = 257
A=A-1  // A = 257 - 1 = 256
M=0    // M[256] = false
@_LABEL.5
0;JMP

(_LABEL.4)
@SP    // A = 0
A=M    // A = M[0] = 258
A=A-1  // A = 258 - 1 = 257
A=A-1  // A = 257 - 1 = 256
M=-1   // M[256] = true

(_LABEL.5)
@SP    // A = 0
M=M-1  // M[0] = 258 - 1 = 257

// push constant 892
@892
D=A
@SP
A=M
M=D
@SP
M=M+1

// push constant 891
@891
D=A
@SP
A=M
M=D
@SP
M=M+1

// lt
@SP    // A = 0
A=M    // A = M[0] = 258
A=A-1  // A = 258 - 1 = 257
D=M    // D = M[257] = y
A=A-1  // A = 257 - 1 = 256
D=D-M  // D = y - x
@_LABEL.7
D;JGT  // if y - x > 0

@SP    // A = 0
A=M    // A = M[0] = 258
A=A-1  // A = 258 - 1 = 257
A=A-1  // A = 257 - 1 = 256
M=0    // M[256] = false
@_LABEL.6
0;JMP

(_LABEL.7)
@SP    // A = 0
A=M    // A = M[0] = 258
A=A-1  // A = 258 - 1 = 257
A=A-1  // A = 257 - 1 = 256
M=-1   // M[256] = true

(_LABEL.6)
@SP
M=M-1

// push constant 891
@891
D=A
@SP
A=M
M=D
@SP
M=M+1

// push constant 892
@892
D=A
@SP
A=M
M=D
@SP
M=M+1

// lt
@SP    // A = 0
A=M    // A = M[0] = 258
A=A-1  // A = 258 - 1 = 257
D=M    // D = M[257] = y
A=A-1  // A = 257 - 1 = 256
D=D-M  // D = y - x
@_LABEL.9
D;JGT  // if y - x > 0

@SP    // A = 0
A=M    // A = M[0] = 258
A=A-1  // A = 258 - 1 = 257
A=A-1  // A = 257 - 1 = 256
M=0    // M[256] = false
@_LABEL.8
0;JMP

(_LABEL.9)
@SP    // A = 0
A=M    // A = M[0] = 258
A=A-1  // A = 258 - 1 = 257
A=A-1  // A = 257 - 1 = 256
M=-1   // M[256] = true

(_LABEL.8)
@SP
M=M-1

// push constant 891
@891
D=A
@SP
A=M
M=D
@SP
M=M+1

// push constant 891
@891
D=A
@SP
A=M
M=D
@SP
M=M+1

// lt
@SP    // A = 0
A=M    // A = M[0] = 258
A=A-1  // A = 258 - 1 = 257
D=M    // D = M[257] = y
A=A-1  // A = 257 - 1 = 256
D=D-M  // D = y - x
@_LABEL.11
D;JGT  // if y - x > 0

@SP    // A = 0
A=M    // A = M[0] = 258
A=A-1  // A = 258 - 1 = 257
A=A-1  // A = 257 - 1 = 256
M=0    // M[256] = false
@_LABEL.10
0;JMP

(_LABEL.11)
@SP    // A = 0
A=M    // A = M[0] = 258
A=A-1  // A = 258 - 1 = 257
A=A-1  // A = 257 - 1 = 256
M=-1   // M[256] = true

(_LABEL.10)
@SP
M=M-1

// push constant 32767
@32767
D=A
@SP
A=M
M=D
@SP
M=M+1

// push constant 32766
@32766
D=A
@SP
A=M
M=D
@SP
M=M+1

// gt
@SP    // A = 0
A=M    // A = M[0] = 258
A=A-1  // A = 258 - 1 = 257
D=M    // D = M[257] = y
A=A-1  // A = 257 - 1 = 256
D=D-M  // D = y - x
@_LABEL.13
D;JLT  // if y - x &lt; 0

@SP    // A = 0
A=M    // A = M[0] = 258
A=A-1  // A = 258 - 1 = 257
A=A-1  // A = 257 - 1 = 256
M=0    // M[256] = false
@_LABEL.12
0;JMP

(_LABEL.13)
@SP    // A = 0
A=M    // A = M[0] = 258
A=A-1  // A = 258 - 1 = 257
A=A-1  // A = 257 - 1 = 256
M=-1   // M[256] = true

(_LABEL.12)
@SP
M=M-1

// push constant 32766
@32766
D=A
@SP
A=M
M=D
@SP
M=M+1

// push constant 32767
@32767
D=A
@SP
A=M
M=D
@SP
M=M+1

// gt
@SP    // A = 0
A=M    // A = M[0] = 258
A=A-1  // A = 258 - 1 = 257
D=M    // D = M[257] = y
A=A-1  // A = 257 - 1 = 256
D=D-M  // D = y - x
@_LABEL.15
D;JLT  // if y - x &lt; 0

@SP    // A = 0
A=M    // A = M[0] = 258
A=A-1  // A = 258 - 1 = 257
A=A-1  // A = 257 - 1 = 256
M=0    // M[256] = false
@_LABEL.14
0;JMP

(_LABEL.15)
@SP    // A = 0
A=M    // A = M[0] = 258
A=A-1  // A = 258 - 1 = 257
A=A-1  // A = 257 - 1 = 256
M=-1   // M[256] = true

(_LABEL.14)
@SP
M=M-1

// push constant 32766
@32766
D=A
@SP
A=M
M=D
@SP
M=M+1

// push constant 32766
@32766
D=A
@SP
A=M
M=D
@SP
M=M+1

// gt
@SP    // A = 0
A=M    // A = M[0] = 258
A=A-1  // A = 258 - 1 = 257
D=M    // D = M[257] = y
A=A-1  // A = 257 - 1 = 256
D=D-M  // D = y - x
@_LABEL.17
D;JLT  // if y - x &lt; 0

@SP    // A = 0
A=M    // A = M[0] = 258
A=A-1  // A = 258 - 1 = 257
A=A-1  // A = 257 - 1 = 256
M=0    // M[256] = false
@_LABEL.16
0;JMP

(_LABEL.17)
@SP    // A = 0
A=M    // A = M[0] = 258
A=A-1  // A = 258 - 1 = 257
A=A-1  // A = 257 - 1 = 256
M=-1   // M[256] = true

(_LABEL.16)
@SP
M=M-1

// push constant 57
@57
D=A
@SP
A=M
M=D
@SP
M=M+1

// push constant 31
@31
D=A
@SP
A=M
M=D
@SP
M=M+1

// push constant 53
@53
D=A
@SP
A=M
M=D
@SP
M=M+1

// add
@SP    // A = SP = 0
A=M    // A = M[0] = 258
A=A-1  // A = 258 - 1 = 257
D=M    // D = M[257] = 8
A=A-1  // A = 257 - 1 = 256
M=D+M  // M[256] = 8 + M[256] = 8 + 7 = 15
@SP
M=M-1

// push constant 112
@112
D=A
@SP
A=M
M=D
@SP
M=M+1

// sub
@SP    // A = SP = 0
A=M    // A = M[0] = 258
A=A-1  // A = 258 - 1 = 257
D=M    // D = M[257] (y)
A=A-1  // A = 257 - 1 = 256
M=M-D  // M[256] = x - y
@SP
M=M-1

// neg
@SP    // A = SP = 0
A=M    // A = M[0] = addr_sp
A=A-1  // A = 258 - 1 = addr_y
M=-M   // M[addr_y] = -y

// and
@SP    // A = SP = 0
A=M    // A = M[0] = 258
A=A-1  // A = 258 - 1 = addr_y
D=M    // D = M[addr_y] = y
A=A-1  // A = 257 - 1 = addr_x
M=D&M  // M[addr_x] = y & x
@SP
M=M-1

// push constant 82
@82
D=A
@SP
A=M
M=D
@SP
M=M+1

// or
@SP    // A = SP = 0
A=M    // A = M[0] = 258
A=A-1  // A = 258 - 1 = addr_y
D=M    // D = M[addr_y] = y
A=A-1  // A = 257 - 1 = addr_x
M=D|M  // M[addr_x] = y | x
@SP
M=M-1

// not
@SP    // A = SP = 0
A=M    // A = M[0] = addr_sp
A=A-1  // A = 258 - 1 = addr_y
M=!M   // M[addr_y] = !y

