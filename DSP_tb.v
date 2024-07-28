module DSP_tb();


reg [17:0] A_tb,B_tb,D_tb,BCIN_tb;
reg [47:0] C_tb,PCIN_tb;
reg [7:0] OPMODE_tb;
reg CARRYIN_tb,CLK_tb,CEA_tb,CEB_tb,CECARRYIN_tb,CEC_tb,CED_tb,CEM_tb,CEOPMODE_tb,CEP_tb,RSTA_tb,RSTB_tb,RSTC_tb,RSTCARRYIN_tb,RSTD_tb,RSTM_tb,RSTP_tb,RSTOPMODE_tb;
wire CARRYOUTF,CARRYOUT;
wire [47:0] PCOUT,P;
wire [17:0] BCOUT;
wire [35:0] M;
DSP DUT(A_tb,B_tb,C_tb,D_tb,CARRYIN_tb,M,P,CARRYOUT,CARRYOUTF,CLK_tb,OPMODE_tb,CEA_tb,CEB_tb,CECARRYIN_tb,CEC_tb,CED_tb,CEM_tb,CEOPMODE_tb 
,CEP_tb,RSTA_tb,RSTB_tb,RSTC_tb,RSTCARRYIN_tb,RSTD_tb,RSTM_tb,RSTP_tb,RSTOPMODE_tb,BCOUT,PCIN_tb,BCIN_tb,PCOUT);
integer i;
initial begin
CLK_tb=0;
forever
#4 CLK_tb=~CLK_tb;
end

initial begin
CEA_tb=1;CEB_tb=1;CECARRYIN_tb=1; CEC_tb=1;CED_tb=1;CEM_tb=1;CEOPMODE_tb=1;CEP_tb=1; 
RSTA_tb=0;RSTB_tb=0;RSTC_tb=0;RSTCARRYIN_tb=0;RSTD_tb=0;RSTM_tb=0;RSTP_tb=0;RSTOPMODE_tb=0;

/* (D+B)*A+C+CIN */ /* 23 */
A_tb=2; B_tb=3; C_tb=4; D_tb=6; PCIN_tb=2; CARRYIN_tb=1; BCIN_tb=0;
OPMODE_tb[1]=0; OPMODE_tb[0]=1; OPMODE_tb[3]=1; OPMODE_tb[2]=1; OPMODE_tb[4]=1; OPMODE_tb[5]=1; OPMODE_tb[6]=0; OPMODE_tb[7]=0;
for(i=0;i<4;i=i+1)
@(negedge CLK_tb);

/* (D+B)*A+CIN */ /* 10 */
A_tb=3; B_tb=1; C_tb=5; D_tb=2; PCIN_tb=2; CARRYIN_tb=1; BCIN_tb=0;
OPMODE_tb[1]=0; OPMODE_tb[0]=1; OPMODE_tb[3]=0; OPMODE_tb[2]=0; OPMODE_tb[4]=1; OPMODE_tb[5]=1; OPMODE_tb[6]=0; OPMODE_tb[7]=0;
for(i=0;i<4;i=i+1)
@(negedge CLK_tb);

/* (D-B)*A+CIN*/ /* 57 */
A_tb=4; B_tb=1; C_tb=6; D_tb=15; PCIN_tb=2; CARRYIN_tb=1; BCIN_tb=0;
OPMODE_tb[1]=0; OPMODE_tb[0]=1; OPMODE_tb[3]=0; OPMODE_tb[2]=0; OPMODE_tb[4]=1; OPMODE_tb[5]=1; OPMODE_tb[6]=1; OPMODE_tb[7]=0;
for(i=0;i<4;i=i+1)
@(negedge CLK_tb);

/* (D-B)*A+C+CIN */ /* 268 */
A_tb=5; B_tb=8; C_tb=7; D_tb=60; PCIN_tb=2; CARRYIN_tb=1; BCIN_tb=0;
OPMODE_tb[1]=0; OPMODE_tb[0]=1; OPMODE_tb[3]=1; OPMODE_tb[2]=1; OPMODE_tb[4]=1; OPMODE_tb[5]=1; OPMODE_tb[6]=1; OPMODE_tb[7]=0;
for(i=0;i<4;i=i+1)
@(negedge CLK_tb);

/* B*A+CIN*/ /* 10 */
A_tb=1; B_tb=9; C_tb=1; D_tb=5; PCIN_tb=2; CARRYIN_tb=1; BCIN_tb=0;
OPMODE_tb[1]=0; OPMODE_tb[0]=1; OPMODE_tb[3]=0; OPMODE_tb[2]=0; OPMODE_tb[4]=0; OPMODE_tb[5]=1; OPMODE_tb[6]=0; OPMODE_tb[7]=0;
for(i=0;i<4;i=i+1)
@(negedge CLK_tb);

/* (B*A)+C+CIN */ /* 7 */
A_tb=4; B_tb=1; C_tb=2; D_tb=1; PCIN_tb=2; CARRYIN_tb=1; BCIN_tb=0;
OPMODE_tb[1]=0; OPMODE_tb[0]=1; OPMODE_tb[3]=1; OPMODE_tb[2]=1; OPMODE_tb[4]=0; OPMODE_tb[5]=1; OPMODE_tb[6]=0; OPMODE_tb[7]=0;
for(i=0;i<4;i=i+1)
@(negedge CLK_tb);

/* C+CIN*/ /* 5 */
A_tb=1; B_tb=3; C_tb=4; D_tb=2; PCIN_tb=2; CARRYIN_tb=1; BCIN_tb=0;
OPMODE_tb[1]=0; OPMODE_tb[0]=0; OPMODE_tb[3]=1; OPMODE_tb[2]=1; OPMODE_tb[4]=1; OPMODE_tb[5]=1; OPMODE_tb[6]=0; OPMODE_tb[7]=0;
for(i=0;i<4;i=i+1)
@(negedge CLK_tb);

/* CIN */ /* 1 */
A_tb=2; B_tb=10; C_tb=5; D_tb=4; PCIN_tb=1; CARRYIN_tb=1; BCIN_tb=0;
OPMODE_tb[1]=0; OPMODE_tb[0]=0; OPMODE_tb[3]=0; OPMODE_tb[2]=0; OPMODE_tb[4]=1; OPMODE_tb[5]=1; OPMODE_tb[6]=0; OPMODE_tb[7]=0;
for(i=0;i<4;i=i+1)
@(negedge CLK_tb);

/* PCIN+CIN */ /* 5 */
A_tb=7; B_tb=3; C_tb=4; D_tb=1; PCIN_tb=4; CARRYIN_tb=1; BCIN_tb=0;
OPMODE_tb[1]=0; OPMODE_tb[0]=0; OPMODE_tb[3]=0; OPMODE_tb[2]=1; OPMODE_tb[4]=1; OPMODE_tb[5]=1; OPMODE_tb[6]=0; OPMODE_tb[7]=0;
for(i=0;i<4;i=i+1)
@(negedge CLK_tb);

/* P+CIN */ /* 6 */
A_tb=2; B_tb=3; C_tb=2; D_tb=6; PCIN_tb=2; CARRYIN_tb=1; BCIN_tb=0;
OPMODE_tb[1]=1; OPMODE_tb[0]=0; OPMODE_tb[3]=0; OPMODE_tb[2]=0; OPMODE_tb[4]=1; OPMODE_tb[5]=1; OPMODE_tb[6]=0; OPMODE_tb[7]=0;
for(i=0;i<4;i=i+1)
@(negedge CLK_tb);





$stop;
end

endmodule