// push constant 10
@10
D=A
@SP
A=M
M=D
@SP
M=M+1

// pop local 0
@0  // A = i
D=A        // D = i
@LCL
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

// push constant 21
@21
D=A
@SP
A=M
M=D
@SP
M=M+1

// push constant 22
@22
D=A
@SP
A=M
M=D
@SP
M=M+1

// pop argument 2
@2  // A = i
D=A        // D = i
@ARG
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

// pop argument 1
@1  // A = i
D=A        // D = i
@ARG
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

// push constant 36
@36
D=A
@SP
A=M
M=D
@SP
M=M+1

// pop this 6
@6  // A = i
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

// push constant 42
@42
D=A
@SP
A=M
M=D
@SP
M=M+1

// push constant 45
@45
D=A
@SP
A=M
M=D
@SP
M=M+1

// pop that 5
@5  // A = i
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

// pop that 2
@2  // A = i
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

// push constant 510
@510
D=A
@SP
A=M
M=D
@SP
M=M+1

// pop temp 6
@6
D=A
@5
D=D+A  // D = I + 5
@SP
A=M
M=D    // M[M[SP]] = 5 + I

@SP
M=M-1  // SP--
A=M    // A = M[SP]
D=M    // D = M[M[SP]]
A=A+1  // A = M[SP] + 1
A=M
M=D

// push local 0
@0
D=A        // D = I
@LCL
A=D+M      // A = I + M[LCL]
D=M        // D = M[I+M[LCL]]
@SP
A=M
M=D        // M[M[SP]] = D
@SP
M=M+1

// push that 5
@5
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

// push argument 1
@1
D=A        // D = I
@ARG
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

// push this 6
@6
D=A        // D = I
@THIS
A=D+M      // A = I + M[LCL]
D=M        // D = M[I+M[LCL]]
@SP
A=M
M=D        // M[M[SP]] = D
@SP
M=M+1

// push this 6
@6
D=A        // D = I
@THIS
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

// sub
@SP    // A = SP = 0
A=M    // A = M[0] = 258
A=A-1  // A = 258 - 1 = 257
D=M    // D = M[257] (y)
A=A-1  // A = 257 - 1 = 256
M=M-D  // M[256] = x - y
@SP
M=M-1

// push temp 6
@6
D=A        // D = I
@5
A=D+A      // A = I + M[LCL]
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

