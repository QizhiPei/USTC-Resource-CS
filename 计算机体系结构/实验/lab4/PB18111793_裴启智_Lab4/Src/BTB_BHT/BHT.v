
module BHT #( 
	parameter  TABLE_ADDR_LEN = 12 //BHTTable 大小，与BTB中的 BUFFER_ADDR_LEN 保持一致
)(
	input  clk, rst,
	input [31:0] PCRead,				//输入PC
	output reg ReadPredictTaken,		//输出信号, 为 1 表示预测 PCRead 跳转
	input BHTWrite,						//写请求
	input [31:0] PCWrite,				//要更新的 Branch
	input WriteTaken				//要更新的 Branch 实际是否跳转
);

localparam TABLE_SIZE = 1 << TABLE_ADDR_LEN;		//buffer的大小

reg [1 : 0] BHTTable [0 : TABLE_SIZE - 1];    //TABLE_SIZE个 Branch PC项，每个状态两位

wire [TABLE_ADDR_LEN - 1 : 0] ReadTableAddr;
wire [TABLE_ADDR_LEN - 1 : 0] WriteTableAddr;

assign ReadTableAddr = PCRead[TABLE_ADDR_LEN + 1 : 2]; 
assign WriteTableAddr = PCWrite[TABLE_ADDR_LEN + 1 : 2]; 

// 读取 buffer：0，1预测不跳转，2，3预测跳转
always @(*) 
begin 
	ReadPredictTaken = BHTTable[ReadTableAddr] >= 2'b10;
end

integer i;

// 写入buffer
always @(posedge clk or posedge rst) 
begin
	if(rst) 
    begin
		for(i= 0; i < TABLE_SIZE; i = i + 1) 
        begin
			BHTTable[i] = 2'b00;
		end
		ReadPredictTaken = 1'b0;
	end 
    else 
    begin
        // 按照给出的状态转换图更新PC对应表项的状态
		if(BHTWrite) begin
			if(WriteTaken) 
            begin
				if(BHTTable[WriteTableAddr] != 2'b11) 
					BHTTable[WriteTableAddr] <= BHTTable[WriteTableAddr] + 2'b01;
				else
					BHTTable[WriteTableAddr] <= BHTTable[WriteTableAddr];
			end 
            else 
            begin
				if(BHTTable[WriteTableAddr] != 2'b00) 
					BHTTable[WriteTableAddr] <= BHTTable[WriteTableAddr] - 2'b01;
				else
					BHTTable[WriteTableAddr] <= BHTTable[WriteTableAddr];
			end
		end
	end
end

endmodule





