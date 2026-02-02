module seconds_counter (
    input  wire clk,
    input  wire rst_n,
    input  wire clear,        
    input  wire enable,
    output reg  [5:0] seconds,
    output wire rollover
);

assign rollover = (enable && seconds == 6'd59);

always @(posedge clk or negedge rst_n) begin
    if (!rst_n)
        seconds <= 6'd0;
    else if (clear)           
        seconds <= 6'd0;      
    else if (enable) begin
        if (seconds == 6'd59)
            seconds <= 6'd0;
        else
            seconds <= seconds + 6'd1;
    end
end
endmodule
