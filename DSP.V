module DSP(A,B,C,D,CARRYIN,M,P,CARRYOUT,CARRYOUTF,CLK,OPMODE,CEA,CEB,CECARRYIN,CEC,CED,CEM,CEOPMODE 
,CEP,RSTA,RSTB,RSTC,RSTCARRYIN,RSTD,RSTM,RSTP,RSTOPMODE,BCOUT,PCIN,BCIN,PCOUT);

input [17:0] A,B,D,BCIN;
input [47:0] C,PCIN;
input [7:0] OPMODE;
input CARRYIN,CLK,CEA,CEB,CECARRYIN,CEC,CED,CEM,CEOPMODE,CEP,RSTA,RSTB,RSTC,RSTCARRYIN,RSTD,RSTM,RSTP,RSTOPMODE;
output CARRYOUTF,CARRYOUT;
output [47:0] PCOUT,P;
output [17:0] BCOUT;
output [35:0] M;
/*............................parameter......................................*/
parameter A0REG=0;
parameter A1REG=1;

parameter B0REG=0;
parameter B1REG=1;

parameter CREG=1;
parameter DREG=1;
parameter MREG=1;
parameter PREG=1;
parameter CARRYINREG=1;
parameter CARRYOUTREG=1;
parameter OPMODEREG=1;

parameter CARRYINSEL="OPMODE5"; //CARRYIN
parameter B_INPUT="DIRECT"; //CASCADE
parameter RSTTYPE="SYNC"; //ASYNC
/*................................... instances wires........................... */
wire [17:0] DFF,B0F,A0F,B1F,A1F;
wire [47:0] CFF;
wire [35:0] MFF;
wire CIF,COF;
wire [7:0] OPF;
wire [17:0] BMUX;

/*..................internal signals ...........................................*/
wire [17:0] PRE_MUX,PRE;
wire [35:0] MUL;
wire [47:0] POST;
wire [47:0] X,Z;
wire [47:0] CONCAT;
wire COUT,CIN;
/*................................ FIRST STAGE ..................................*/
MUX_REGISTER #(.width(18),.selection(1)) DUT_DREG(D,CLK,CED,RSTD,DFF);

assign BMUX=(B_INPUT=="DIRECT")? B:(B_INPUT=="CASCADE")?PCIN:0  ;
MUX_REGISTER #(.width(18),.selection(0)) DUT_B0REG(BMUX,CLK,CEB,RSTB,B0F);

MUX_REGISTER #(.width(18),.selection(0)) DUT_A0REG(A,CLK,CEA,RSTA,A0F);

MUX_REGISTER #(.width(48),.selection(1)) DUT_CREG(C,CLK,CEC,RSTC,CFF);

MUX_REGISTER #(.width(8),.selection(1)) DUT_OPMODEREG(OPMODE,CLK,CEOPMODE,RSTOPMODE,OPF);

/*................................ SECOND STAGE  .....................................*/
MUX_REGISTER #(.width(18),.selection(1)) DUT_B1REG(PRE_MUX,CLK,CEB,RSTB,B1F);

MUX_REGISTER #(.width(18),.selection(1)) DUT_A1REG(A0F,CLK,CEA,RSTA,A1F);

/*................................ THIRD STAGE  .....................................*/
MUX_REGISTER #(.width(36),.selection(1)) DUT_MREG(MUL,CLK,CEM,RSTM,MFF);

/*................................ FOURTH STAGE  .....................................*/
MUX_REGISTER #(.width(48),.selection(1)) DUT_PREG(POST,CLK,CEP,RSTP,P);
MUX_REGISTER #(.width(1),.selection(1)) DUT_COREG(COUT,CLK,CECARRYIN,RSTCARRYIN,COF);
MUX_REGISTER #(.width(1),.selection(1)) DUT_CINREG(CIN,CLK,CECARRYIN,RSTCARRYIN,CIF);

/*................ Calculate the internal signal.............................*/

assign CIN=(CARRYINSEL=="OPMODE5")? OPMODE[5]:(CARRYINSEL=="CARRYIN")? CARRYIN:0;
assign MUL=A1F*B1F;
assign BCOUT=B1F;
assign M=MFF;
assign CONCAT={DFF[12:0],A1F,B1F};
assign CARRYOUT=COF;
assign CARRYOUTF=COF;
assign PCOUT=P;
assign PRE=(OPMODE[6]==0)? (DFF+B0F):(DFF-B0F) ;
assign PRE_MUX=(OPMODE[4]==0) ? B0F:PRE;
assign X=({OPMODE[1],OPMODE[0]}==2'b00)? 0: ({OPMODE[1],OPMODE[0]}==2'b01)? ({12'b000000000000,MFF}):({OPMODE[1],OPMODE[0]}==2'b10)?P:CONCAT;
assign Z=({OPMODE[3],OPMODE[2]}==2'b00)? 0: ({OPMODE[3],OPMODE[2]}==2'b01)? PCIN:({OPMODE[3],OPMODE[2]}==2'b10)?P:CFF;
assign {COUT,POST}=(OPMODE[7]==0)? (Z+X+CIF):(Z-(X+CIF));


endmodule