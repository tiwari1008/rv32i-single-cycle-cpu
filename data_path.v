`timescale 1ns / 1ps

  module data_path(
  input clk ,
  input rst , 
  input[5:0] alu_control ,
  input mem_to_reg ,
  input mem_write,
  input alu_src,
  input reg_write ,
  input lui_operation,
  input jump ,
  input beq_control,
  input bneq_control,
  input bgeq_control,
  input blt_control ,
  
  output [31:0] instruction_out
     );
     //internal wires 
     
     wire[31:0] pc_current ;
     wire[31:0] pc_next ; 
     wire[31:0] pc_plus_4;
     wire[31:0] imm_val;
     wire[31:0] read_data1;
     wire[31:0] read_data2;
     wire[31:0] alu_src_b;
     wire[31:0] alu_result ;
     wire[31:0] mem_read_data;
     wire[31:0] write_back_data;
     wire zero_flag ;

wire[31:0] instruction_wire;

assign instruction_out = instruction_wire ;

assign pc_plus_4= pc_current+4;

instrc_fetch_unit PC_unit(
.clk(clk) ,
.rst(rst) ,
.next_pc(pc_next) ,
.pc(pc_current) 
);

  instrc_memory IM(
  .pc(pc_current) ,
  .instruction_out(instruction_wire) 
  ) ;
  
  register_file RF(
  .clk(clk) ,
  .rst(rst) ,
  .reg_write(reg_write) ,
  .read_reg_num1(instruction_wire[19:15]),
    .read_reg_num2(instruction_wire[24:20]),
    .write_reg_num(instruction_wire[11:7]) ,
    .write_data(write_back_data) ,
    .read_data1(read_data1) ,
        .read_data2(read_data2) 
        );

    imm_gen IMGEN(
    .instruction(instruction_wire) ,
    .imm_val(imm_val) 
    );
    
    assign alu_src_b = (alu_src)?imm_val: read_data2;
    
    alu ALU_UNIT (
     .src1(read_data1) ,
    .src2(alu_src_b) ,
    .alu_control(alu_control),
    .shamt(instruction_wire[24:20]),
    .result(alu_result),
    .zero(zero_flag) 
        ) ;
    
    data_memory DM(
    .clk(clk) ,
    .rst(rst) ,
    .addr(alu_result) ,
    .write_data(read_data2),
    .memory_write(mem_write),
    .mem_read(mem_to_reg) ,
    .read_data(mem_read_data)
    );
    
    //////////write _back_mux 
    
    assign write_back_data= (mem_to_reg)?mem_read_data: (jump)?pc_plus_4:(lui_operation)?imm_val:alu_result;
    
    wire take_branch = (beq_control && alu_result[0]) ||

(bneq_control && alu_result[0]) ||

(bgeq_control && alu_result[0]) ||

(blt_control && alu_result[0]);

assign pc_next = (take_branch || jump) ? (pc_current + imm_val) : pc_plus_4;
     
endmodule
