// Push { segment: "constant", index: 111 }
@111
D=A
@SP
A=M
M=D
@SP
M=M+1

// Push { segment: "constant", index: 333 }
@333
D=A
@SP
A=M
M=D
@SP
M=M+1

// Push { segment: "constant", index: 888 }
@888
D=A
@SP
A=M
M=D
@SP
M=M+1

// Pop { segment: "static", index: 8 }
@SP
M=M-1
A=M
D=M
@StaticTest.8
M=D

// Pop { segment: "static", index: 3 }
@SP
M=M-1
A=M
D=M
@StaticTest.3
M=D

// Pop { segment: "static", index: 1 }
@SP
M=M-1
A=M
D=M
@StaticTest.1
M=D

// Push { segment: "static", index: 3 }
@StaticTest.3
D=M
@SP
A=M
M=D
@SP
M=M+1

// Push { segment: "static", index: 1 }
@StaticTest.1
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

// Push { segment: "static", index: 8 }
@StaticTest.8
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

