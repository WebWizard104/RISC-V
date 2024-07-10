
module regfile(
    input logic i_clk,
    input logic i_rst,
    input logic [4:0] rs1,
    input logic [4:0] rs2,
    input logic [4:0] rd,
    input logic rd_write_control,
    input logic [31:0] rd_write_val,
    output logic [31:0] rs1_val,
    output logic [31:0] rs2_val
);
logic [31:0]reg_memory[31:0];
always@(*) begin
        rs1_val = reg_memory[rs1][31:0];
        rs2_val = reg_memory[rs2][31:0];
end

always@(posedge i_clk or negedge i_rst) begin
    if(~i_rst) begin
        for(int i = 0 ; i <32 ; i=i+1) begin
            reg_memory[i] <= 0;
        end

    end
    else begin
        if((rd_write_control) & (rd > 0)) begin
            reg_memory[rd][31:0] <= rd_write_val;
        end

    end
end

endmodule
