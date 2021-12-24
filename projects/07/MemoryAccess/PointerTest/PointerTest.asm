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
@2  // A = i
D=A        // D = i
@THIS
D=D+M      // D = i + M[LCL]
@SP        // A = SP
A=M        // A = M[SP]
M=D        // M[M[SP]] = i + M[LCL]
@SP
M=M-1      // M[SP] = M[SP] - 1
A=M        // A = M[SP]
D=M        // D = M[M[SP]]
A=A+1      // A = M[SP] + 1
A=M
M=D

// push constant 46
@46
D=A
@SP
A=M
M=D
@SP
M=M+1

// pop that 6
@6  // A = i
D=A        // D = i
@THAT
D=D+M      // D = i + M[LCL]
@SP        // A = SP
A=M        // A = M[SP]
M=D        // M[M[SP]] = i + M[LCL]
@SP
M=M-1      // M[SP] = M[SP] - 1
A=M        // A = M[SP]
D=M        // D = M[M[SP]]
A=A+1      // A = M[SP] + 1
A=M
M=D

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
@2
D=A        // D = I
@THIS
A=D+M      // A = I + M[LCL]
D=M        // D = M[I+M[LCL]]
@SP
A=M
M=D        // M[M[SP]] = D
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

// push that 6
@6
D=A        // D = I
@THAT
A=D+M      // A = I + M[LCL]
D=M        // D = M[I+M[LCL]]
@SP
A=M
M=D        // M[M[SP]] = D
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

