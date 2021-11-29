
module BTB #(
	parameter  BUFFER_ADDR_LEN = 12    //Buffer 的大小
)(
	input  clk, rst,					//时钟、复位
	input [31:0] PCRead,				//输入PC
	output reg ReadPredict,				//对外输出的信号, 为 1 表示 PCRead 是Branch指令，对应 PCReadPredict 是有效数据
	output reg [31:0] PCReadPredict,	//从 buffer 中读出的预测 PC

	input BTBWrite,						//写请求
	input [31:0] PCWrite,			    //要写入的分支 Branch
	input [31:0] PCWritePredict,		//要写入的PredictPC
	input StateBitWritePredict		    //要写入的预测状态位
);

localparam TAG_ADDR_LEN = 32 - BUFFER_ADDR_LEN - 2; 	//计算tag的数据位宽
localparam BUFFER_SIZE = 1 << BUFFER_ADDR_LEN;		   //计算buffer的大小

wire [BUFFER_ADDR_LEN - 1 : 0] ReadBufferAddr; 
wire [   TAG_ADDR_LEN - 1 : 0] ReadTagAddr;
wire [                  1 : 0] ReadWordAddr; 

wire [BUFFER_ADDR_LEN - 1 : 0] WriteBufferAddr; 
wire [   TAG_ADDR_LEN - 1 : 0] WriteTagAddr;
wire [                  1 : 0] WriteWordAddr; 

assign {ReadTagAddr, ReadBufferAddr, ReadWordAddr} = PCRead;  //拆分 32bits PCRead
assign {WriteTagAddr, WriteBufferAddr, WriteWordAddr} = PCWrite;  //拆分 32bits PCWrite

reg [TAG_ADDR_LEN - 1 : 0] PCTag			[0 : BUFFER_SIZE - 1]; //分支PC TAG
reg [              31 : 0] PCPredict		[0 : BUFFER_SIZE - 1]; //预测PC
reg                        StateBitPredict	[0 : BUFFER_SIZE - 1]; //预测状态位

// 读取 buffer
always @(*) 
begin 
    //判断输入的 PC 是否在 buffer 中命中
	if(PCTag[ReadBufferAddr] == ReadTagAddr && StateBitPredict[ReadBufferAddr])//如果tag与输入地址中的tag部分相等且buffer的该项有效，则命中
		ReadPredict = 1'b1;
	else
		ReadPredict = 1'b0;
	PCReadPredict = PCPredict[ReadBufferAddr];
end

// 写入 buffer
integer i;
always @(posedge clk or posedge rst) 
begin
	if(rst) 
    begin
		for(i = 0; i < BUFFER_SIZE; i = i + 1) 
        begin
			PCTag[i] = 0;
			PCPredict[i] = 0;
			StateBitPredict[i] = 1'b0;
		end
        PCReadPredict = 0;
		ReadPredict = 1'b0;	
	end 
    else 
    begin
		if(BTBWrite) 
        begin
			PCTag[WriteBufferAddr] <= WriteTagAddr;
			PCPredict[WriteBufferAddr] <= PCWritePredict;
			StateBitPredict[WriteBufferAddr] <= StateBitWritePredict;
		end
	end
end

endmodule





