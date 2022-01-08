// Push { segment: "constant", index: 3030 }
@3030
D=A
@SP
A=M
M=D
@SP
M=M+1

// Pop { segment: "pointer", index: 0 }
@SP
M=M-1
A=M
D=M
@THIS
M=D

// Push { segment: "constant", index: 3040 }
@3040
D=A
@SP
A=M
M=D
@SP
M=M+1

// Pop { segment: "pointer", index: 1 }
@SP
M=M-1
A=M
D=M
@THAT
M=D

// Push { segment: "constant", index: 32 }
@32
D=A
@SP
A=M
M=D
@SP
M=M+1

// Pop { segment: "this", index: 2 }
@2
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

// Push { segment: "constant", index: 46 }
@46
D=A
@SP
A=M
M=D
@SP
M=M+1

// Pop { segment: "that", index: 6 }
@6
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

// Push { segment: "pointer", index: 0 }
@THIS
D=M
@SP
A=M
M=D
@SP
M=M+1

// Push { segment: "pointer", index: 1 }
@THAT
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

// Push { segment: "this", index: 2 }
@2
D=A
@THIS
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

// Push { segment: "that", index: 6 }
@6
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

