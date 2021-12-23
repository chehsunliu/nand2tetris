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
@SP    // A = 0
A=M    // A = M[0] = 258
A=A-1  // A = 258 - 1 = 257
A=A-1  // A = 257 - 1 = 256
@_LABEL.0
D;JEQ  // if D == 0, jump to LABEL0
M=0    // M[256] = false
@_LABEL.1
0;JMP
(_LABEL.0)
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
@SP    // A = 0
A=M    // A = M[0] = 258
A=A-1  // A = 258 - 1 = 257
A=A-1  // A = 257 - 1 = 256
@_LABEL.2
D;JEQ  // if D == 0, jump to LABEL0
M=0    // M[256] = false
@_LABEL.3
0;JMP
(_LABEL.2)
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
@SP    // A = 0
A=M    // A = M[0] = 258
A=A-1  // A = 258 - 1 = 257
A=A-1  // A = 257 - 1 = 256
@_LABEL.4
D;JEQ  // if D == 0, jump to LABEL0
M=0    // M[256] = false
@_LABEL.5
0;JMP
(_LABEL.4)
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
@SP    // A = SP = 0
D=M    // D = M[0] = 258
M=D-1  // M[0] = 258 - 1 = 257
// push constant 112
@112
D=A
@SP
A=M
M=D
@SP
M=M+1
// sub

// neg

// and

// push constant 82
@82
D=A
@SP
A=M
M=D
@SP
M=M+1
// or

// not

