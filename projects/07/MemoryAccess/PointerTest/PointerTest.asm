// push constant 3030
@3030
D=A
@SP
A=M
M=D
@SP
M=M+1

// pop pointer 0


// push constant 3040
@3040
D=A
@SP
A=M
M=D
@SP
M=M+1

// pop pointer 1


// push constant 32
@32
D=A
@SP
A=M
M=D
@SP
M=M+1

// pop this 2


// push constant 46
@46
D=A
@SP
A=M
M=D
@SP
M=M+1

// pop that 6


// push pointer 0


// push pointer 1


// add
@SP    // A = SP = 0
A=M    // A = M[0] = 258
A=A-1  // A = 258 - 1 = 257
D=M    // D = M[257] = 8
A=A-1  // A = 257 - 1 = 256
M=D+M  // M[256] = 8 + M[256] = 8 + 7 = 15
@SP
M=M-1

// push this 2


// sub
@SP    // A = SP = 0
A=M    // A = M[0] = 258
A=A-1  // A = 258 - 1 = 257
D=M    // D = M[257] (y)
A=A-1  // A = 257 - 1 = 256
M=M-D  // M[256] = x - y
@SP
M=M-1

// push that 6


// add
@SP    // A = SP = 0
A=M    // A = M[0] = 258
A=A-1  // A = 258 - 1 = 257
D=M    // D = M[257] = 8
A=A-1  // A = 257 - 1 = 256
M=D+M  // M[256] = 8 + M[256] = 8 + 7 = 15
@SP
M=M-1

