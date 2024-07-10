`ifndef FILE_INCL
    `include "processor_defines.sv"
`endif

module decode_imm_inst(
    input logic [31:7] instruction_code,

    output logic [4:0] rs1,
    output logic [4:0] rd,
    output logic [11:0] imm,
    output logic [4:0] alu_control
);
logic [2:0] func3;
//logic [6:0] opcode;


always@(*) begin
    rd = instruction_code[11:7];
    rs1 = instruction_code[19:15];
    func3 = instruction_code[14:12];
    imm = instruction_code[31:20];

    
        // case(func3) 
        // 3'b000  : 
        // 3'b001 : begin
        // if(imm[11:5] == 'b0) 
        //  alu_control = `SLLI;
        // end

        // 3'b010 :alu_control = `SLTI;
        //3'b011 :alu_control = `SLTIU;
        //3'b100 :alu_control = `XORI;
       // 3'b101 : begin  if(imm[11:5] == 'b0)
       //             alu_control = `SRLI;
//
       //         else if(imm[11:5] == 7'b0100000)
       //          alu_control = `SRAI;
       // end

        // 3'b110 :alu_control = `ORI;
        // 3'b111 :alu_control = `ANDI;

        // default:alu_control = `ALU_NOP;
               // endcase


        if(func3 == 'b0) begin
            alu_control = `ADDI;
        end
        else if(func3 == 3'b001) begin
            if(imm[11:5] == 'b0) begin
                alu_control = `SLLI;
            end
            else
            alu_control = `ALU_NOP; 
        end
        else if(func3 == 3'b010) begin
            alu_control = `SLTI;
        end
        else if(func3 ==  3'b011) begin
            alu_control = `SLTIU;
        end
        else if(func3 == 3'b100) begin
            alu_control = `XORI;
        end
        else if(func3 == 3'b101) begin
            if(imm[11:5] == 'b0) begin
                alu_control = `SRLI;
            end
            else if(imm[11:5] == 7'b0100000) begin
                alu_control = `SRAI; 
            end
            else begin
                alu_control = `ALU_NOP ;
            end   
        end
        else if(func3 == 3'b110) begin
            alu_control = `ORI;
        end 
        else if(func3 == 3'b111) begin
            alu_control = `ANDI ;
        end
        else begin
            alu_control = `ALU_NOP;
        end

 


    


end

`ifndef SUBMODULE_DISABLE_WAVES
   initial
     begin
        $dumpfile("./sim_build/decode_imm_inst.vcd");
        $dumpvars(0, decode_imm_inst);
     end
 `endif

endmodule
