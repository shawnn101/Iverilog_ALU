module top_module (
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

// Testbench

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

