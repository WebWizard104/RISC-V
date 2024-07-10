`ifndef FILE_INCL
    `include "processor_defines.sv"
`endif

module branch(
    input logic i_clk,
    input logic i_rst,
    input logic [31:0] pc,
    input logic [31:0] imm,
    input logic [31:0] rs1_val,
    input logic [31:0] rs2_val,
    input logic [2:0] branch_control,


    output logic pc_update_control,
    output logic [31:0] pc_update_val,
    output logic ignore_curr_inst
);
always_comb begin 
   // if(branch_control != `BR_NOP) begin
    //     case(branch_control)

    //     `BEQ : begin
    //         if(rs1_val == rs2_val) begin
    //             pc_update_control = 1'b1;
    //             pc_update_val = pc + imm;
    //         end
    //         else begin
    //             pc_update_val = 'b0;
    //             pc_update_control = 'b0;
    //         end
    //     end 

    //     `BNE : begin
    //         if(rs1_val != rs2_val ) begin

    //             pc_update_control = 1'b1;
    //             pc_update_val = pc + imm;

    //         end
    //         else begin
    //             pc_update_val = 'b0;
    //             pc_update_control = 'b0;
    //         end
    //     end


    //     `BLT : begin

            // if(rs1_val < rs2_val) begin
            //     pc_update_control = 1'b1;
            //     pc_update_val = pc + imm;

            // end
            // else begin
            //     pc_update_val = 'b0;
            //     pc_update_control = 'b0;
            // end
            
    //     end


    //     `BGE : begin
    //         if(rs1_val >= rs2_val ) begin

    //             pc_update_control = 1'b1;
    //             pc_update_val = pc + imm;

    //         end
    //         else begin
    //             pc_update_val = 'b0;
    //             pc_update_control = 'b0;
    //         end
    //     end


    //     `BLTU : begin
    //         if({1'b0,rs1_val} < {1'b0,rs2_val} ) begin

    //             pc_update_control = 1'b1;
    //             pc_update_val = pc + imm;

    //         end
    //         else begin
    //             pc_update_val = 'b0;
    //             pc_update_control = 'b0;
    //         end
    //     end

    //     `BGEU : begin
    //         if({1'b0,rs1_val} >= {1'b0,rs2_val} ) begin

    //             pc_update_control = 1'b1;
    //             pc_update_val = pc + imm;

    //         end
    //         else begin
    //             pc_update_val = 'b0;
    //             pc_update_control = 'b0;
    //         end
    //     end
    //     default : begin
    //         pc_update_control = 'b0;
    //         pc_update_val = 'b0;
    //     end
    //     endcase

    // end
    // else begin
        // ignore_curr_inst = 'b0;
        // pc_update_val = 'b0;
        // pc_update_control = 'b0;
    // end
    if(branch_control != 3'd0) begin

        if(branch_control == 3'd1) begin
            if(rs1_val == rs2_val) begin
                pc_update_control = 1'b1;
                pc_update_val = pc + imm;
            end
            else begin
                pc_update_val = 'b0;
                pc_update_control = 'b0;
            end

        end

        else if(branch_control == 3'd2) begin
             if(rs1_val != rs2_val ) begin

                pc_update_control = 1'b1;
                pc_update_val = pc + imm;

            end
            else begin
                pc_update_val = 'b0;
                pc_update_control = 'b0;
            end

        end

        else if(branch_control == 3'd3) begin
            if(rs1_val < rs2_val) begin
                pc_update_control = 1'b1;
                pc_update_val = pc + imm;

            end
            else begin
                pc_update_val = 'b0;
                pc_update_control = 'b0;
            end

        end

        else if(branch_control == 3'd4) begin 
            if(rs1_val >= rs2_val ) begin

                pc_update_control = 1'b1;
                pc_update_val = pc + imm;

            end
            else begin
                pc_update_val = 'b0;
                pc_update_control = 'b0;
            end
        end

            else if(branch_control == 3'd5) begin
            if({1'b0,rs1_val} < {1'b0,rs2_val} ) begin

                pc_update_control = 1'b1;
                pc_update_val = pc + imm;

            end
            else begin
                pc_update_val = 'b0; 
                pc_update_control = 'b0;
            end
            end
            else if(branch_control == 3'd6) begin
            if({1'b0,rs1_val} >= {1'b0,rs2_val} ) begin

                pc_update_control = 1'b1;
                pc_update_val = pc + imm;

            end
            else begin
                pc_update_val = 'b0;
                pc_update_control = 'b0;
            end

            end
            else begin
                 pc_update_control = 'b0;
                 pc_update_val = 'b0;
            end
        
    end
    else begin
        ignore_curr_inst = 'b0;
        pc_update_val = 'b0;
        pc_update_control = 'b0;
    end
    
end

always@(posedge i_clk or negedge i_rst) begin
    if(~i_rst) begin
        ignore_curr_inst <= 'b0;
    end
    else begin
        ignore_curr_inst <= pc_update_control;
    end
end

`ifndef SUBMODULE_DISABLE_WAVES
   initial
     begin
        $dumpfile("./sim_build/branch.vcd");
        $dumpvars(0, branch);
     end
 `endif
endmodule
