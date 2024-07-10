
`ifndef FILE_INCL
    `include "processor_defines.sv"
`endif

module decode_reg_inst(
    input logic [31:7] instruction_code, //starting bits not needed bcz we know its r type
    output logic [4:0] rs1,
    output logic [4:0] rs2,
    output logic [4:0] rd,
    output logic [4:0] alu_control
);
logic [2:0]func3;
logic [6:0] func7;


always@(*) begin
    rs1 = instruction_code[19:15];
    rs2 = instruction_code[24:20];
    rd = instruction_code[11:7];
    func3 = instruction_code[14:12];
    func7 = instruction_code[31:25];
    case(func3)
    3'b0 : if(func7 == 'b0) 
                alu_control = `ADD ;
            else
            alu_control = `SUB ;     
           
    3'b001 :alu_control = `SLL;

    3'b010 : alu_control = `SLT;
    3'b011 : alu_control = `SLTU ;
    3'b100 :alu_control = `XOR ;
    3'b101 : if(func7 == 'b0)
                alu_control = `SRL;
             else 
                alu_control = `SRA ;

    3'b110 :alu_control = `OR;
    3'b111 :alu_control = `AND;
        
    endcase
end

`ifndef SUBMODULE_DISABLE_WAVES
   initial
     begin
        $dumpfile("./sim_build/decode_reg_inst.vcd");
        $dumpvars(0, decode_reg_inst);
     end
 `endif

endmodule
