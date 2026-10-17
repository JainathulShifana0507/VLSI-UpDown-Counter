
`timescale 1ns/1ps

module tb_sync_up_down_counter;

    reg clk;
    reg reset;
    reg up_down;
    wire [3:0] count;

    integer errors;
    integer i;

    sync_up_down_counter uut (
        .clk(clk),
        .reset(reset),
        .up_down(up_down),
        .count(count)
    );

    // Generate a clock with a 10 ns period
    always #5 clk = ~clk;

    // Compare actual count with expected count
    task check_count;
        input [3:0] expected;
        begin
            if (count !== expected) begin
                $display("FAIL: expected %0d, got %0d",
                         expected, count);
                errors = errors + 1;
            end else begin
                $display("PASS: count = %0d", count);
            end
        end
    endtask

    initial begin
        $dumpfile("up_down_counter.vcd");
        $dumpvars(0, tb_sync_up_down_counter);

        clk = 0;
        reset = 1;
        up_down = 1;
        errors = 0;

        // Test 1: Synchronous reset
        @(posedge clk);
        #1;
        check_count(4'd0);

        // Test 2: Count upward through all 16 states
        @(negedge clk);
        reset = 0;
        up_down = 1;

        for (i = 1; i <= 16; i = i + 1) begin
            @(posedge clk);
            #1;
            check_count(i % 16);
        end

        // Test 3: Reset before the downward sequence
        @(negedge clk);
        reset = 1;

        @(posedge clk);
        #1;
        check_count(4'd0);

        // Test 4: Count upward from 0 to 5
        @(negedge clk);
        reset = 0;
        up_down = 1;

        repeat (5) begin
            @(posedge clk);
            #1;
        end
        check_count(4'd5);

        // Test 5: Count downward from 5 to 0
        @(negedge clk);
        up_down = 0;

        for (i = 4; i >= 0; i = i - 1) begin
            @(posedge clk);
            #1;
            check_count(i);
        end

        // Test 6: Downward rollover from 0 to 15
        @(negedge clk);
        @(posedge clk);
        #1;
        check_count(4'd15);

        // Test 7: Upward rollover from 15 to 0
        @(negedge clk);
        up_down = 1;

        @(posedge clk);
        #1;
        check_count(4'd0);
        
        // Test 8: Verify synchronous reset between clock edges
@(negedge clk);
reset = 0;
up_down = 1;

@(posedge clk);
#1;
check_count(4'd1);

// Assert reset between rising edges
#1;
reset = 1;
#1;
check_count(4'd1);  // Count should still be 1

// At the next rising edge, reset should take effect
@(posedge clk);
#1;
check_count(4'd0);

@(negedge clk);
reset = 0; 

        // Final test report
        if (errors == 0)
            $display("ALL CHECKS PASSED");
        else
            $display("TEST FAILED: %0d errors", errors);

        $finish;
    end

endmodule
