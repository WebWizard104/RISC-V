`ifndef FILE_INCL
    `include "processor_defines.sv"
`endif

module store(
    input logic i_clk,
    input logic i_rst,
    input logic [31:0] rs1_val,
    input logic [31:0] rs2_val,
    input logic [31:0] imm,
    input logic [2:0] store_control,


    output logic stall_pc,
    output logic ignore_curr_inst,
    output logic mem_rw_mode,
    output logic [31:0] mem_addr,
    output logic [31:0] mem_write_data,
    output logic [3:0] mem_byte_en
);
always@(*) begin
    if(store_control != `STR_NOP) begin
        stall_pc = 'b1;
        mem_rw_mode = 'b0;
        mem_addr = rs1_val + imm;
        mem_write_data = rs2_val;
        if(store_control == `SW)begin
          //  mem_write_data = rs2_val;
            mem_byte_en = 4'b1111;
            

        end
        else if(store_control == `SH)begin
           if(mem_addr[1] == 1'b0) begin
           // mem_write_data[15:0] = rs2_val[15:0];
            mem_byte_en = 4'b0011;
           end
           else if(mem_addr[1] == 1'b1) begin
          //  mem_write_data[31:16] = rs2_val[31:16];
            mem_byte_en = 4'b1100;
           end


        end
        else if(store_control == `SB)begin
            if(mem_addr[1:0] == 2'b0) begin
            //    mem_write_data[7:0] = rs2_val[7:0];
                mem_byte_en = 4'b0001;
            end
            else if(mem_addr[1:0] == 2'b01) begin
            //    mem_write_data[15:8] = rs2_val[15:8];
                mem_byte_en = 4'b0010;
            end
            else if(mem_addr[1:0] == 2'b10) begin
            //    mem_write_data[24:16] = rs2_val[24:16];
                mem_byte_en = 4'b0100;
            end
            else if(mem_addr[1:0] == 2'b11) begin
             //   mem_write_data[31:24] = rs2_val[31:24];
                mem_byte_en = 4'b1000;
            end
        end

    end

    else begin
        stall_pc = 'b0;
        //ignore_curr_inst = 'b0;
        mem_rw_mode = 'b1;
        mem_addr = 'b0;
        mem_write_data = 'b0;
        mem_byte_en = 'b0;


    end
end


always@(posedge i_clk or negedge i_rst) begin
        if(~i_rst) begin
        ignore_curr_inst <= 'b0;
    end

    else begin
    ignore_curr_inst <= stall_pc;
    end


end
`ifndef SUBMODULE_DISABLE_WAVES
   initial
     begin
        $dumpfile("./sim_build/store.vcd");
        $dumpvars(0, store);
     end
 `endif

endmodule
