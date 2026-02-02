module control_fsm (
    input  wire clk,
    input  wire rst_n,        
    input  wire start,
    input  wire stop,
    input  wire reset,        
    output reg  count_enable, 
    output reg  [1:0] state
);

    localparam IDLE    = 2'b00;
    localparam RUNNING = 2'b01;
    localparam PAUSED  = 2'b10;

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            state <= IDLE;
        end else if (reset) begin
            state <= IDLE;    
        end else begin
            case (state)
                IDLE: begin
                    if (start) state <= RUNNING;
                end

                RUNNING: begin
                    if (stop) state <= PAUSED;
                end

                PAUSED: begin
                    if (start) state <= RUNNING;
                end

                default: state <= IDLE;
            endcase
        end
    end

    // Combinational Output Logic
    always @(*) begin
        if (state == RUNNING)
            count_enable = 1'b1;
        else
            count_enable = 1'b0;
    end

endmodule
