`timescale 1ns / 1ps


module Perceptron_tb;
    reg clk;
    reg reset;
    reg [7:0] input1;
    reg [7:0] input2;
    reg [7:0] weight1;
    reg [7:0] weight2;
    reg [7:0] bias;
    wire [15:0] output_neuron;

    Perceptron uut (
        .clk(clk),
        .reset(reset),
        .input1(input1),
        .input2(input2),
        .weight1(weight1),
        .weight2(weight2),
        .bias(bias),
        .output_neuron(output_neuron)
    );

    initial begin
        clk = 0;
        forever #5 clk = ~clk; // Clock generation
    end

    initial begin
        // Initialize Inputs
        reset = 1;
        input1 = 8'd0;
        input2 = 8'd0;
        weight1 = 8'd0;
        weight2 = 8'd0;
        bias = 8'd0;

        // Wait for global reset
        #10;
        reset = 0;

        // Test Case 1: Expected output_neuron = 1
        #10;
        input1 = 8'd10;
        input2 = 8'd20;
        weight1 = 8'd2;
        weight2 = 8'd3;
        bias = 8'd0;

        // Test Case 2: Expected output_neuron = 1
        #20;
        input1 = 8'd15;
        input2 = 8'd25;
        weight1 = 8'd4;
        weight2 = 8'd5;
        bias = 8'd0;

        // Test Case 3: Expected output_neuron = 1
        #30;
        input1 = 8'd30;
        input2 = 8'd40;
        weight1 = 8'd6;
        weight2 = 8'd7;
        bias = 8'd0;

        // Test Case 4: Expected output_neuron = 0
        #40;
        input1 = 8'd5;
        input2 = 8'd3;
        weight1 = 8'd2; // Note: Negative values are represented differently in Verilog
        weight2 = 8'd4; // Example weights represented as negative
        bias = 8'd10;   // Example bias represented as negative

        // End simulation
        #50;
        $finish;
    end
endmodule

