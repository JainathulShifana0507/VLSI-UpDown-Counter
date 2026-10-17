
`timescale 1ns/1ps

module tb_sync_up_counter;

    reg clk;
    reg reset;
    wire [3:0] count;

    reg [3:0] expected_count;
    integer errors;
    integer i;

    sync_up_counter uut (
        .clk(clk),
        .reset(reset),
        .count(count)
    );

    always #5 clk = ~clk;

    task check_count;
        input [3:0] expected;
        begin
            if (count !== expected) begin
                $display("FAIL: expected %b, got %b",
                         expected, count);
                errors = errors + 1;
            end else begin
                $display("PASS: count = %b (%0d)",
                         count, count);
            end
        end
    endtask

    initial begin
        $dumpfile("counter.vcd");
        $dumpvars(0, tb_sync_up_counter);

        clk = 0;
        reset = 1;
        expected_count = 0;
        errors = 0;

        // Test synchronous reset
        @(posedge clk);
        #1;
        check_count(4'b0000);

        // Release reset at the falling edge
        @(negedge clk);
        reset = 0;

        // Verify all 16 states, including rollover
        for (i = 0; i < 16; i = i + 1) begin
            @(posedge clk);
            #1;

            expected_count = expected_count + 1'b1;
            check_count(expected_count);
        end

        // Assert reset and check it at the next rising edge
        @(negedge clk);
        reset = 1;

        @(posedge clk);
        #1;
        expected_count = 0;
        check_count(expected_count);

        // Final report
        if (errors == 0)
            $display("ALL CHECKS PASSED");
        else
            $display("TEST FAILED: %0d error(s)", errors);

        $finish;
    end

endmodule
