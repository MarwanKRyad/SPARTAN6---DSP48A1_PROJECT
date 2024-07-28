module MUX_REGISTER(the_input,clk,CE,rst,the_output);
parameter width=18;
parameter selection=1;
parameter RSTTYPE="SYNC";
input [width-1:0] the_input;
input clk,rst,CE;
output reg [width-1:0] the_output;

generate
	if(selection==1)
	begin
		if(RSTTYPE=="SYNC")
		begin
			always @(posedge clk ) begin
				if (rst) 
					the_output<=0;	
				else if(CE==1)
					the_output<=the_input;
			end

		end
		else if(RSTTYPE=="ASYNC") begin
			always @(posedge clk or posedge rst ) begin
				if (rst) 
					the_output<=0;	
				else if(CE==1)
					the_output<=the_input;
			end
		end
	end
	else if(selection==0)
	begin
	    always @(the_input ) begin
		the_output=the_input;
	     end
	end
	
endgenerate



endmodule
