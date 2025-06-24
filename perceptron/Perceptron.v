`timescale 1ns / 1ps

module Perceptron (
    input clk,
    input reset,
    input  [7:0] input1,
    input [7:0] input2,
    input  [7:0] weight1,
    input  [7:0] weight2,
    input [7:0] bias,
    output reg [15:0] output_neuron
);
    wire [15:0] product1, product2;
   
    reg  [15:0] sum;
    
 
        
    // Approximate Multiplier Instances
    ApproxMultiplier mult1 (
        .A(input1),
        .B(weight1),
        .result(product1)
    );

    ApproxMultiplier mult2 (
        .A(input2),
        .B(weight2),
        .result(product2)
    );

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            sum <= 16'd0;
            output_neuron <= 16'd0;
        end else begin
            sum <= product1 + product2 + bias;
            output_neuron <= log_sigmoid(sum);
        end
    end

    // Log Sigmoid Function Approximation
    function [15:0] log_sigmoid;
        input [15:0] x;
        begin
            // Simplified sigmoid approximation
            log_sigmoid = (x > 0) ? 16'd1 : 16'd0;
        end
    endfunction
endmodule


module ApproxMultiplier (
    input  [7:0] A,
    input  [7:0] B,
    output wire [15:0] result
);

    wire [3:0] AL_BL [0:3];
    wire [3:0] AH_BH [0:3];
	wire [3:0] AH_BL [0:3];
	wire [3:0] AL_BH [0:3];
    wire [7:0] result1;
    wire [7:0] result2;
    wire [7:0] result3;
    wire [7:0] result4;
   
              
    assign  AL_BL[0] =  A[3:0] & {4{B[0]}};
    assign  AL_BL[1] = A[3:0] & {4{B[1]}};
    assign  AL_BL[2] = A[3:0] & {4{B[2]}};
    assign  AL_BL[3] = A[3:0] & {4{B[3]}};

    assign  AH_BH[0] = A[7:4] & {4{B[4]}};
    assign  AH_BH[1] = A[7:4] & {4{B[5]}};
    assign  AH_BH[2] = A[7:4] & {4{B[6]}};
    assign  AH_BH[3] = A[7:4] & {4{B[7]}};

    assign  AL_BH[0] =  {A[3:0] & {4{B[4]}}};
    assign  AL_BH[1] = {A[3:0] & {4{B[5]}}};
    assign  AL_BH[2] = {A[3:0] & {4{B[6]}}};
    assign  AL_BH[3] = {A[3:0] & {4{B[7]}}};

    assign  AH_BL[0] =  {A[7:4] & {4{B[0]}}};
    assign  AH_BL[1] = {A[7:4] & {4{B[1]}}};
    assign  AH_BL[2] = {A[7:4] & {4{B[2]}}};
    assign  AH_BL[3] = {A[7:4] & {4{B[3]}}};
     
    assign result1[0] = AL_BL[0][0];
	assign result1[1] = AL_BL[1][0] | AL_BL[0][1];
	assign result1[2] = AL_BL[2][0] | AL_BL[1][1] | AL_BL[0][2] ;
	assign result1[3] = AL_BL[3][0] | AL_BL[2][1] | AL_BL[1][2] | AL_BL[0][3];
	assign result1[4] = AL_BL[3][1] | AL_BL[2][2] | AL_BL[1][3] ;
	assign result1[5] = AL_BL[2][3] ^ AL_BL[3][2] ^ (AL_BL[1][3] | AL_BL[3][1] & AL_BL[2][2]); 
    assign result1[6] =(AL_BL[3][3] & (~(AL_BL[2][2]))) | ((~(AL_BL[3][3]) & (AL_BL[2][2])) & (AL_BL[1][3] | AL_BL[3][1]));
    assign result1[7] = AL_BL[3][3] & AL_BL[2][2];    
 
    assign result2[7:0] = AH_BL[0][3:0] + {AH_BL[1][3:0] , 1'b0} + {AH_BL[2][3:0], 2'b0} + {AH_BL[3][3:0], 3'b0};
    assign result3[7:0] = AL_BH[0][3:0] + {AL_BH[1][3:0] , 1'b0} + {AL_BH[2][3:0], 2'b0} + {AL_BH[3][3:0], 3'b0};        
    assign result4[7:0] = AH_BH[0][3:0] + {AH_BH[1][3:0] , 1'b0} + {AH_BH[2][3:0], 2'b0} + {AH_BH[3][3:0], 3'b0};  
    assign result = { {result4[7:0] , 1'b0} + result3[7:3] + result2[7:3] , result1[6] | result2[2] | result3[2] , result1[5] | result2[1] | result3[1] , result1[4] | result2[0] | result3[0] , result1[3:0]};
    

endmodule
