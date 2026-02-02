module stopwatch_top (
    input  wire clk,
    input  wire rst_n,     
    input  wire start,
    input  wire stop,
    input  wire reset,
    output wire [7:0] minutes,
    output wire [5:0] seconds,
    output wire [1:0] status // 00=IDLE, 01=RUNNING, 10=PAUSED
);

    wire count_enable;
    wire sec_rollover;
    wire clear_counters;   

    // LOGIC: If FSM is IDLE (00), force counters to Clear
    assign clear_counters = (status == 2'b00);

    // 1. FSM Instance
    control_fsm u_control_fsm (
        .clk(clk),
        .rst_n(rst_n),
        .start(start),
        .stop(stop),
        .reset(reset),
        .count_enable(count_enable),
        .state(status)
    );

    // 2. Seconds Counter Instance
    // IMPORTANT: connecting the .clear() port here avoids the mismatch error
    seconds_counter u_seconds_counter (
        .clk(clk),
        .rst_n(rst_n),
        .clear(clear_counters),   
        .enable(count_enable),
        .seconds(seconds),
        .rollover(sec_rollover)
    );

    // 3. Minutes Counter Instance
    minutes_counter u_minutes_counter (
        .clk(clk),
        .rst_n(rst_n),
        .clear(clear_counters),   
        .enable(sec_rollover),
        .minutes(minutes)
    );

endmodule
