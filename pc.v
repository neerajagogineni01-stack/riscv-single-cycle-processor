module pc(
input clk,
input rst,
output reg [31:0] pc_out
);

always @(posedge clk or posedge rst)
begin
if(rst)
pc_out <= 32'd0;
else
pc_out <= pc_out + 4;
end

endmodule