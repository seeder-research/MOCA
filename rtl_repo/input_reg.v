module input_reg #(parameter DATA_DIGITS=128, parameter INDEX_DEGITS=128)
(
	input clk,
	input sh_en,
	input wr_en,
	input rewr_en,
	
	input [DATA_DIGITS-1:0] din,
	input [DATA_DIGITS-1:0] row_mask,
	
	output reg [DATA_DIGITS-1:0] data,
	output reg done
);

always @(posedge clk) begin

	if(sh_en==1'b1 && wr_en==1'b0)
	begin
		data[DATA_DIGITS-1:1]<=data[DATA_DIGITS-2:0];
	end

	else if(sh_en==1'b0 && rewr_en==1'b0&& wr_en==1'b1)
	begin
		data<=din;
	end

	else if(sh_en==1'b0 && rewr_en==1'b1&& wr_en==1'b0)
	begin
		
		if(row_mask[0]==1) data[0]<=din[0];
		if(row_mask[1]==1) data[1]<=din[1];
		if(row_mask[2]==1) data[2]<=din[2];
		if(row_mask[3]==1) data[3]<=din[3];
		if(row_mask[4]==1) data[4]<=din[4];
		if(row_mask[5]==1) data[5]<=din[5];
		if(row_mask[6]==1) data[6]<=din[6];
		if(row_mask[7]==1) data[7]<=din[7];
		if(row_mask[8]==1) data[8]<=din[8];
		if(row_mask[9]==1) data[9]<=din[9];
		if(row_mask[10]==1) data[10]<=din[10];
		if(row_mask[11]==1) data[11]<=din[11];
		if(row_mask[12]==1) data[12]<=din[12];
		if(row_mask[13]==1) data[13]<=din[13];
		if(row_mask[14]==1) data[14]<=din[14];
		if(row_mask[15]==1) data[15]<=din[15];
		if(row_mask[16]==1) data[16]<=din[16];
		if(row_mask[17]==1) data[17]<=din[17];
		if(row_mask[18]==1) data[18]<=din[18];
		if(row_mask[19]==1) data[19]<=din[19];
		if(row_mask[20]==1) data[20]<=din[20];
		if(row_mask[21]==1) data[21]<=din[21];
		if(row_mask[22]==1) data[22]<=din[22];
		if(row_mask[23]==1) data[23]<=din[23];
		if(row_mask[24]==1) data[24]<=din[24];
		if(row_mask[25]==1) data[25]<=din[25];
		if(row_mask[26]==1) data[26]<=din[26];
		if(row_mask[27]==1) data[27]<=din[27];
		if(row_mask[28]==1) data[28]<=din[28];
		if(row_mask[29]==1) data[29]<=din[29];
		if(row_mask[30]==1) data[30]<=din[30];
		if(row_mask[31]==1) data[31]<=din[31];
		if(row_mask[32]==1) data[32]<=din[32];
		if(row_mask[33]==1) data[33]<=din[33];
		if(row_mask[34]==1) data[34]<=din[34];
		if(row_mask[35]==1) data[35]<=din[35];
		if(row_mask[36]==1) data[36]<=din[36];
		if(row_mask[37]==1) data[37]<=din[37];
		if(row_mask[38]==1) data[38]<=din[38];
		if(row_mask[39]==1) data[39]<=din[39];
		if(row_mask[40]==1) data[40]<=din[40];
		if(row_mask[41]==1) data[41]<=din[41];
		if(row_mask[42]==1) data[42]<=din[42];
		if(row_mask[43]==1) data[43]<=din[43];
		if(row_mask[44]==1) data[44]<=din[44];
		if(row_mask[45]==1) data[45]<=din[45];
		if(row_mask[46]==1) data[46]<=din[46];
		if(row_mask[47]==1) data[47]<=din[47];
		if(row_mask[48]==1) data[48]<=din[48];
		if(row_mask[49]==1) data[49]<=din[49];
		if(row_mask[50]==1) data[50]<=din[50];
		if(row_mask[51]==1) data[51]<=din[51];
		if(row_mask[52]==1) data[52]<=din[52];
		if(row_mask[53]==1) data[53]<=din[53];
		if(row_mask[54]==1) data[54]<=din[54];
		if(row_mask[55]==1) data[55]<=din[55];
		if(row_mask[56]==1) data[56]<=din[56];
		if(row_mask[57]==1) data[57]<=din[57];
		if(row_mask[58]==1) data[58]<=din[58];
		if(row_mask[59]==1) data[59]<=din[59];
		if(row_mask[60]==1) data[60]<=din[60];
		if(row_mask[61]==1) data[61]<=din[61];
		if(row_mask[62]==1) data[62]<=din[62];
		if(row_mask[63]==1) data[63]<=din[63];
		if(row_mask[64]==1) data[64]<=din[64];
		if(row_mask[65]==1) data[65]<=din[65];
		if(row_mask[66]==1) data[66]<=din[66];
		if(row_mask[67]==1) data[67]<=din[67];
		if(row_mask[68]==1) data[68]<=din[68];
		if(row_mask[69]==1) data[69]<=din[69];
		if(row_mask[70]==1) data[70]<=din[70];
		if(row_mask[71]==1) data[71]<=din[71];
		if(row_mask[72]==1) data[72]<=din[72];
		if(row_mask[73]==1) data[73]<=din[73];
		if(row_mask[74]==1) data[74]<=din[74];
		if(row_mask[75]==1) data[75]<=din[75];
		if(row_mask[76]==1) data[76]<=din[76];
		if(row_mask[77]==1) data[77]<=din[77];
		if(row_mask[78]==1) data[78]<=din[78];
		if(row_mask[79]==1) data[79]<=din[79];
		if(row_mask[80]==1) data[80]<=din[80];
		if(row_mask[81]==1) data[81]<=din[81];
		if(row_mask[82]==1) data[82]<=din[82];
		if(row_mask[83]==1) data[83]<=din[83];
		if(row_mask[84]==1) data[84]<=din[84];
		if(row_mask[85]==1) data[85]<=din[85];
		if(row_mask[86]==1) data[86]<=din[86];
		if(row_mask[87]==1) data[87]<=din[87];
		if(row_mask[88]==1) data[88]<=din[88];
		if(row_mask[89]==1) data[89]<=din[89];
		if(row_mask[90]==1) data[90]<=din[90];
		if(row_mask[91]==1) data[91]<=din[91];
		if(row_mask[92]==1) data[92]<=din[92];
		if(row_mask[93]==1) data[93]<=din[93];
		if(row_mask[94]==1) data[94]<=din[94];
		if(row_mask[95]==1) data[95]<=din[95];
		if(row_mask[96]==1) data[96]<=din[96];
		if(row_mask[97]==1) data[97]<=din[97];
		if(row_mask[98]==1) data[98]<=din[98];
		if(row_mask[99]==1) data[99]<=din[99];
		if(row_mask[100]==1) data[100]<=din[100];
		if(row_mask[101]==1) data[101]<=din[101];
		if(row_mask[102]==1) data[102]<=din[102];
		if(row_mask[103]==1) data[103]<=din[103];
		if(row_mask[104]==1) data[104]<=din[104];
		if(row_mask[105]==1) data[105]<=din[105];
		if(row_mask[106]==1) data[106]<=din[106];
		if(row_mask[107]==1) data[107]<=din[107];
		if(row_mask[108]==1) data[108]<=din[108];
		if(row_mask[109]==1) data[109]<=din[109];
		if(row_mask[110]==1) data[110]<=din[110];
		if(row_mask[111]==1) data[111]<=din[111];
		if(row_mask[112]==1) data[112]<=din[112];
		if(row_mask[113]==1) data[113]<=din[113];
		if(row_mask[114]==1) data[114]<=din[114];
		if(row_mask[115]==1) data[115]<=din[115];
		if(row_mask[116]==1) data[116]<=din[116];
		if(row_mask[117]==1) data[117]<=din[117];
		if(row_mask[118]==1) data[118]<=din[118];
		if(row_mask[119]==1) data[119]<=din[119];
		if(row_mask[120]==1) data[120]<=din[120];
		if(row_mask[121]==1) data[121]<=din[121];
		if(row_mask[122]==1) data[122]<=din[122];
		if(row_mask[123]==1) data[123]<=din[123];
		if(row_mask[124]==1) data[124]<=din[124];
		if(row_mask[125]==1) data[125]<=din[125];
		if(row_mask[126]==1) data[126]<=din[126];
		if(row_mask[127]==1) data[127]<=din[127];
		
	end
	
end
	
endmodule