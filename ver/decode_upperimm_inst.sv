`ifndef FILE_INCL
    `include "processor_defines.sv"
`endif

module decode_upperimm_inst(
    input logic [31:0] instruction_code,
    output logic [4:0] rd,
    output logic [31:0] imm,
    output logic [4:0] alu_control
);
// always@(*) begin
//     rd = instruction_code[11:7];
//     imm[31:12] = instruction_code[31:12];
//     if(instruction_code[6:0] == 7'b0110111) begin
//         alu_control = `LUI;
//     end
//     else if(instruction_code[6:0] == 7'b0010111) begin
//         alu_control = `AUIPC;
//     end
// end
logic [6:0] opcode ;
always_comb begin 
    rd = instruction_code[11:7];
    imm[31:12] = instruction_code[31:12];
    opcode=instruction_code[6:0];

    for(int i = 11; i>= 0; i = i-1)
    begin
        imm[i] = 1'b0;

    end
    case(opcode)
    7'd55 : alu_control =`LUI;
    7'd23 : alu_control =`AUIPC;
    
    default : alu_control = `ALU_NOP;
    endcase
    
end


`ifndef SUBMODULE_DISABLE_WAVES
   initial
     begin
        $dumpfile("./sim_build/decode_upperimm_inst.vcd");
        $dumpvars(0, decode_upperimm_inst);
     end
 `endif
endmodule
