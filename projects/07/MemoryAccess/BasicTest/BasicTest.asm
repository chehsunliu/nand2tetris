// Push { segment: "constant", index: 10 }
@10
D=A
@SP
A=M
M=D
@SP
M=M+1

// Pop { segment: "local", index: 0 }
@0
D=A
@LCL
D=D+M
@SP
A=M
M=D
@SP
M=M-1
A=M
D=M
A=A+1
A=M
M=D

// Push { segment: "constant", index: 21 }
@21
D=A
@SP
A=M
M=D
@SP
M=M+1

// Push { segment: "constant", index: 22 }
@22
D=A
@SP
A=M
M=D
@SP
M=M+1

// Pop { segment: "argument", index: 2 }
@2
D=A
@ARG
D=D+M
@SP
A=M
M=D
@SP
M=M-1
A=M
D=M
A=A+1
A=M
M=D

// Pop { segment: "argument", index: 1 }
@1
D=A
@ARG
D=D+M
@SP
A=M
M=D
@SP
M=M-1
A=M
D=M
A=A+1
A=M
M=D

// Push { segment: "constant", index: 36 }
@36
D=A
@SP
A=M
M=D
@SP
M=M+1

// Pop { segment: "this", index: 6 }
@6
D=A
@THIS
D=D+M
@SP
A=M
M=D
@SP
M=M-1
A=M
D=M
A=A+1
A=M
M=D

// Push { segment: "constant", index: 42 }
@42
D=A
@SP
A=M
M=D
@SP
M=M+1

// Push { segment: "constant", index: 45 }
@45
D=A
@SP
A=M
M=D
@SP
M=M+1

// Pop { segment: "that", index: 5 }
@5
D=A
@THAT
D=D+M
@SP
A=M
M=D
@SP
M=M-1
A=M
D=M
A=A+1
A=M
M=D

// Pop { segment: "that", index: 2 }
@2
D=A
@THAT
D=D+M
@SP
A=M
M=D
@SP
M=M-1
A=M
D=M
A=A+1
A=M
M=D

// Push { segment: "constant", index: 510 }
@510
D=A
@SP
A=M
M=D
@SP
M=M+1

// Pop { segment: "temp", index: 6 }
@11
D=A
@SP
A=M
M=D
@SP
M=M-1
A=M
D=M
A=A+1
A=M
M=D

// Push { segment: "local", index: 0 }
@0
D=A
@LCL
A=D+M
D=M
@SP
A=M
M=D
@SP
M=M+1

// Push { segment: "that", index: 5 }
@5
D=A
@THAT
A=D+M
D=M
@SP
A=M
M=D
@SP
M=M+1

// Add
@SP
A=M
A=A-1
D=M
A=A-1
M=D+M
@SP
M=M-1

// Push { segment: "argument", index: 1 }
@1
D=A
@ARG
A=D+M
D=M
@SP
A=M
M=D
@SP
M=M+1

// Sub
@SP
A=M
A=A-1
D=M
A=A-1
M=M-D
@SP
M=M-1

// Push { segment: "this", index: 6 }
@6
D=A
@THIS
A=D+M
D=M
@SP
A=M
M=D
@SP
M=M+1

// Push { segment: "this", index: 6 }
@6
D=A
@THIS
A=D+M
D=M
@SP
A=M
M=D
@SP
M=M+1

// Add
@SP
A=M
A=A-1
D=M
A=A-1
M=D+M
@SP
M=M-1

// Sub
@SP
A=M
A=A-1
D=M
A=A-1
M=M-D
@SP
M=M-1

// Push { segment: "temp", index: 6 }
@R11
D=M
@SP
A=M
M=D
@SP
M=M+1

// Add
@SP
A=M
A=A-1
D=M
A=A-1
M=D+M
@SP
M=M-1

