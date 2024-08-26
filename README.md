# Iverilog_ALU
The ALU is a fundamental component in CPUs that performs arithmetic and logical operations. Specifically, a 4-bit ALU in Verilog can perform various operations such as addition, subtraction, AND, OR, XOR, and NOT on 4-bit binary numbers. <be>

## Components
Input Operands: Two 4-bit input operands (A and B). <br>
Control/Arithmetic Signals: A control signal (3 bits) that determines which operation the ALU will perform. <br>
Output: A 4-bit output that reflects the result of the selected operation. <br>
Status Flags: Flags such as Zero, Carry, Overflow, and Negative indicate the status of the result.

## Supported Operations

-000: Addition (A + B) <br>
-001: Subtraction (A - B) <br>
-010: AND (A & B) <br>
-011: OR (A | B) <br>
-100: XOR (A ^ B) <br>
-101: NOT (A) <br>
-110: Left Shift (A << 1) <br>
-111: Right Shift (A >> 1) <be>

# Verilog ALU

```verilog
module top_moudule (
    input [3:0] A, B,
    input [2:0] ALU_Sel,
    output reg [3:0] ALU_Out,
    output reg CarryOut
);
    always @(*)
    begin
        case(ALU_Sel)
            3'b000: {CarryOut, ALU_Out} = A + B;    // Addition
            3'b001: {CarryOut, ALU_Out} = A - B;    // Subtraction
            3'b010: ALU_Out = A & B;                // AND
            3'b011: ALU_Out = A | B;                // OR
            3'b100: ALU_Out = A ^ B;                // XOR
            3'b101: ALU_Out = ~A;                   // NOT
            3'b110: ALU_Out = A << 1;               // Left Shift
            3'b111: ALU_Out = A >> 1;               // Right Shift
            default: ALU_Out = 4'b0000;
        endcase
    end
endmodule
```

# Testbench

```verilog
module ALU_tb;

    // Inputs
    reg [3:0] A;
    reg [3:0] B;
    reg [2:0] ALU_Sel;

    // Outputs
    wire [3:0] ALU_Out;
    wire CarryOut;

    // Instantiate the ALU module
    top_module uut (
        .A(A),
        .B(B),
        .ALU_Sel(ALU_Sel),
        .ALU_Out(ALU_Out),
        .CarryOut(CarryOut)
    );

    // Test procedure
    initial begin
        // Monitor the signals
        $monitor("A = %b, B = %b, ALU_Sel = %b, ALU_Out = %b, CarryOut = %b", A, B, ALU_Sel, ALU_Out, CarryOut);

        // Test Case 1: Addition (A + B)
        A = 4'b0011; B = 4'b0101; ALU_Sel = 3'b000;
        #10;  // Wait for 10 time units

        // Test Case 2: Subtraction (A - B)
        A = 4'b1010; B = 4'b0011; ALU_Sel = 3'b001;
        #10;

        // Test Case 3: AND (A & B)
        A = 4'b1100; B = 4'b1010; ALU_Sel = 3'b010;
        #10;

        // Test Case 4: OR (A | B)
        A = 4'b1100; B = 4'b1010; ALU_Sel = 3'b011;
        #10;

        // Test Case 5: XOR (A ^ B)
        A = 4'b1100; B = 4'b1010; ALU_Sel = 3'b100;
        #10;

        // Test Case 6: NOT (~A)
        A = 4'b1100; ALU_Sel = 3'b101;
        #10;

        // Test Case 7: Left Shift (A << 1)
        A = 4'b0011; ALU_Sel = 3'b110;
        #10;

        // Test Case 8: Right Shift (A >> 1)
        A = 4'b1001; ALU_Sel = 3'b111;
        #10;

        // End of test cases
        $finish;
    end
endmodule
```

# IVerilog IDE
Note: This program was created and ran from this website - https://hdlbits.01xz.net/wiki/Iverilog








