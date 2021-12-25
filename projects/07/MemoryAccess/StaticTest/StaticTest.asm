// push constant 111
@111
D=A
@SP
A=M
M=D
@SP
M=M+1

// push constant 333
@333
D=A
@SP
A=M
M=D
@SP
M=M+1

// push constant 888
@888
D=A
@SP
A=M
M=D
@SP
M=M+1

// pop static 8
@SP
M=M-1  // SP--
A=M
D=M    // D = M[M[SP]]
@StaticTest.8
M=D

// pop static 3
@SP
M=M-1  // SP--
A=M
D=M    // D = M[M[SP]]
@StaticTest.3
M=D

// pop static 1
@SP
M=M-1  // SP--
A=M
D=M    // D = M[M[SP]]
@StaticTest.1
M=D

// push static 3
@StaticTest.3
D=M
@SP
A=M
M=D
@SP
M=M+1

// push static 1
@StaticTest.1
D=M
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

// push static 8
@StaticTest.8
D=M
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

