module com_mem #(parameter COLUMN_NUM=128, parameter ROW_NUM=128)
(
    input clk,

    input pe_en,
    input we_en,
    input cm_en,

    input [ROW_NUM-1:0] din,
    input [COLUMN_NUM-1:0] addr,   // should be changed to 7-bit, but with an additional decoder

    output reg [1023:0] dout,   // should be time-multiplexed to reduce the width
    output reg done
);

integer i;

reg [COLUMN_NUM-1:0] com_mem [ROW_NUM-1:0];    // storing the data in each computational memory cell 

// to store the output data
reg [127:0] mul_0;
reg [127:0] mul_1;
reg [127:0] mul_2;
reg [127:0] mul_3;
reg [127:0] mul_4;
reg [127:0] mul_5;
reg [127:0] mul_6;
reg [127:0] mul_7;
reg [127:0] mul_8;
reg [127:0] mul_9;
reg [127:0] mul_10;
reg [127:0] mul_11;
reg [127:0] mul_12;
reg [127:0] mul_13;
reg [127:0] mul_14;
reg [127:0] mul_15;
reg [127:0] mul_16;
reg [127:0] mul_17;
reg [127:0] mul_18;
reg [127:0] mul_19;
reg [127:0] mul_20;
reg [127:0] mul_21;
reg [127:0] mul_22;
reg [127:0] mul_23;
reg [127:0] mul_24;
reg [127:0] mul_25;
reg [127:0] mul_26;
reg [127:0] mul_27;
reg [127:0] mul_28;
reg [127:0] mul_29;
reg [127:0] mul_30;
reg [127:0] mul_31;
reg [127:0] mul_32;
reg [127:0] mul_33;
reg [127:0] mul_34;
reg [127:0] mul_35;
reg [127:0] mul_36;
reg [127:0] mul_37;
reg [127:0] mul_38;
reg [127:0] mul_39;
reg [127:0] mul_40;
reg [127:0] mul_41;
reg [127:0] mul_42;
reg [127:0] mul_43;
reg [127:0] mul_44;
reg [127:0] mul_45;
reg [127:0] mul_46;
reg [127:0] mul_47;
reg [127:0] mul_48;
reg [127:0] mul_49;
reg [127:0] mul_50;
reg [127:0] mul_51;
reg [127:0] mul_52;
reg [127:0] mul_53;
reg [127:0] mul_54;
reg [127:0] mul_55;
reg [127:0] mul_56;
reg [127:0] mul_57;
reg [127:0] mul_58;
reg [127:0] mul_59;
reg [127:0] mul_60;
reg [127:0] mul_61;
reg [127:0] mul_62;
reg [127:0] mul_63;
reg [127:0] mul_64;
reg [127:0] mul_65;
reg [127:0] mul_66;
reg [127:0] mul_67;
reg [127:0] mul_68;
reg [127:0] mul_69;
reg [127:0] mul_70;
reg [127:0] mul_71;
reg [127:0] mul_72;
reg [127:0] mul_73;
reg [127:0] mul_74;
reg [127:0] mul_75;
reg [127:0] mul_76;
reg [127:0] mul_77;
reg [127:0] mul_78;
reg [127:0] mul_79;
reg [127:0] mul_80;
reg [127:0] mul_81;
reg [127:0] mul_82;
reg [127:0] mul_83;
reg [127:0] mul_84;
reg [127:0] mul_85;
reg [127:0] mul_86;
reg [127:0] mul_87;
reg [127:0] mul_88;
reg [127:0] mul_89;
reg [127:0] mul_90;
reg [127:0] mul_91;
reg [127:0] mul_92;
reg [127:0] mul_93;
reg [127:0] mul_94;
reg [127:0] mul_95;
reg [127:0] mul_96;
reg [127:0] mul_97;
reg [127:0] mul_98;
reg [127:0] mul_99;
reg [127:0] mul_100;
reg [127:0] mul_101;
reg [127:0] mul_102;
reg [127:0] mul_103;
reg [127:0] mul_104;
reg [127:0] mul_105;
reg [127:0] mul_106;
reg [127:0] mul_107;
reg [127:0] mul_108;
reg [127:0] mul_109;
reg [127:0] mul_110;
reg [127:0] mul_111;
reg [127:0] mul_112;
reg [127:0] mul_113;
reg [127:0] mul_114;
reg [127:0] mul_115;
reg [127:0] mul_116;
reg [127:0] mul_117;
reg [127:0] mul_118;
reg [127:0] mul_119;
reg [127:0] mul_120;
reg [127:0] mul_121;
reg [127:0] mul_122;
reg [127:0] mul_123;
reg [127:0] mul_124;
reg [127:0] mul_125;
reg [127:0] mul_126;
reg [127:0] mul_127;




// intermediate xxxs to store the MAC results
reg [7:0] mac_0;
reg [7:0] mac_1;
reg [7:0] mac_2;
reg [7:0] mac_3;
reg [7:0] mac_4;
reg [7:0] mac_5;
reg [7:0] mac_6;
reg [7:0] mac_7;
reg [7:0] mac_8;
reg [7:0] mac_9;
reg [7:0] mac_10;
reg [7:0] mac_11;
reg [7:0] mac_12;
reg [7:0] mac_13;
reg [7:0] mac_14;
reg [7:0] mac_15;
reg [7:0] mac_16;
reg [7:0] mac_17;
reg [7:0] mac_18;
reg [7:0] mac_19;
reg [7:0] mac_20;
reg [7:0] mac_21;
reg [7:0] mac_22;
reg [7:0] mac_23;
reg [7:0] mac_24;
reg [7:0] mac_25;
reg [7:0] mac_26;
reg [7:0] mac_27;
reg [7:0] mac_28;
reg [7:0] mac_29;
reg [7:0] mac_30;
reg [7:0] mac_31;
reg [7:0] mac_32;
reg [7:0] mac_33;
reg [7:0] mac_34;
reg [7:0] mac_35;
reg [7:0] mac_36;
reg [7:0] mac_37;
reg [7:0] mac_38;
reg [7:0] mac_39;
reg [7:0] mac_40;
reg [7:0] mac_41;
reg [7:0] mac_42;
reg [7:0] mac_43;
reg [7:0] mac_44;
reg [7:0] mac_45;
reg [7:0] mac_46;
reg [7:0] mac_47;
reg [7:0] mac_48;
reg [7:0] mac_49;
reg [7:0] mac_50;
reg [7:0] mac_51;
reg [7:0] mac_52;
reg [7:0] mac_53;
reg [7:0] mac_54;
reg [7:0] mac_55;
reg [7:0] mac_56;
reg [7:0] mac_57;
reg [7:0] mac_58;
reg [7:0] mac_59;
reg [7:0] mac_60;
reg [7:0] mac_61;
reg [7:0] mac_62;
reg [7:0] mac_63;
reg [7:0] mac_64;
reg [7:0] mac_65;
reg [7:0] mac_66;
reg [7:0] mac_67;
reg [7:0] mac_68;
reg [7:0] mac_69;
reg [7:0] mac_70;
reg [7:0] mac_71;
reg [7:0] mac_72;
reg [7:0] mac_73;
reg [7:0] mac_74;
reg [7:0] mac_75;
reg [7:0] mac_76;
reg [7:0] mac_77;
reg [7:0] mac_78;
reg [7:0] mac_79;
reg [7:0] mac_80;
reg [7:0] mac_81;
reg [7:0] mac_82;
reg [7:0] mac_83;
reg [7:0] mac_84;
reg [7:0] mac_85;
reg [7:0] mac_86;
reg [7:0] mac_87;
reg [7:0] mac_88;
reg [7:0] mac_89;
reg [7:0] mac_90;
reg [7:0] mac_91;
reg [7:0] mac_92;
reg [7:0] mac_93;
reg [7:0] mac_94;
reg [7:0] mac_95;
reg [7:0] mac_96;
reg [7:0] mac_97;
reg [7:0] mac_98;
reg [7:0] mac_99;
reg [7:0] mac_100;
reg [7:0] mac_101;
reg [7:0] mac_102;
reg [7:0] mac_103;
reg [7:0] mac_104;
reg [7:0] mac_105;
reg [7:0] mac_106;
reg [7:0] mac_107;
reg [7:0] mac_108;
reg [7:0] mac_109;
reg [7:0] mac_110;
reg [7:0] mac_111;
reg [7:0] mac_112;
reg [7:0] mac_113;
reg [7:0] mac_114;
reg [7:0] mac_115;
reg [7:0] mac_116;
reg [7:0] mac_117;
reg [7:0] mac_118;
reg [7:0] mac_119;
reg [7:0] mac_120;
reg [7:0] mac_121;
reg [7:0] mac_122;
reg [7:0] mac_123;
reg [7:0] mac_124;
reg [7:0] mac_125;
reg [7:0] mac_126;
reg [7:0] mac_127;




parameter address_head = 128'h0000_0000_0000_0000_0000_0000_0000_0001;
always@(posedge clk)
begin
	if(pe_en==1 && we_en==1) begin
	case(addr)
	    
    	address_head: com_mem[0]<=din;
    	address_head<<1: com_mem[1]<=din;
    	address_head<<2: com_mem[2]<=din;
        address_head<<3: com_mem[3]<=din;
        address_head<<4: com_mem[4]<=din;
        address_head<<5: com_mem[5]<=din;
        address_head<<6: com_mem[6]<=din;
        address_head<<7: com_mem[7]<=din;
        address_head<<8: com_mem[8]<=din;
        address_head<<9: com_mem[9]<=din;
        address_head<<10: com_mem[10]<=din;
        address_head<<11: com_mem[11]<=din;
        address_head<<12: com_mem[12]<=din;
        address_head<<13: com_mem[13]<=din;
        address_head<<14: com_mem[14]<=din;
        address_head<<15: com_mem[15]<=din;
        address_head<<16: com_mem[16]<=din;
        address_head<<17: com_mem[17]<=din;
        address_head<<18: com_mem[18]<=din;
        address_head<<19: com_mem[19]<=din;
        address_head<<20: com_mem[20]<=din;
        address_head<<21: com_mem[21]<=din;
        address_head<<22: com_mem[22]<=din;
        address_head<<23: com_mem[23]<=din;
        address_head<<24: com_mem[24]<=din;
        address_head<<25: com_mem[25]<=din;
        address_head<<26: com_mem[26]<=din;
        address_head<<27: com_mem[27]<=din;
        address_head<<28: com_mem[28]<=din;
        address_head<<29: com_mem[29]<=din;
        address_head<<30: com_mem[30]<=din;
        address_head<<31: com_mem[31]<=din;
        address_head<<32: com_mem[32]<=din;
        address_head<<33: com_mem[33]<=din;
        address_head<<34: com_mem[34]<=din;
        address_head<<35: com_mem[35]<=din;
        address_head<<36: com_mem[36]<=din;
        address_head<<37: com_mem[37]<=din;
        address_head<<38: com_mem[38]<=din;
        address_head<<39: com_mem[39]<=din;
        address_head<<40: com_mem[40]<=din;
        address_head<<41: com_mem[41]<=din;
        address_head<<42: com_mem[42]<=din;
        address_head<<43: com_mem[43]<=din;
        address_head<<44: com_mem[44]<=din;
        address_head<<45: com_mem[45]<=din;
        address_head<<46: com_mem[46]<=din;
        address_head<<47: com_mem[47]<=din;
        address_head<<48: com_mem[48]<=din;
        address_head<<49: com_mem[49]<=din;
        address_head<<50: com_mem[50]<=din;
        address_head<<51: com_mem[51]<=din;
        address_head<<52: com_mem[52]<=din;
        address_head<<53: com_mem[53]<=din;
        address_head<<54: com_mem[54]<=din;
        address_head<<55: com_mem[55]<=din;
        address_head<<56: com_mem[56]<=din;
        address_head<<57: com_mem[57]<=din;
        address_head<<58: com_mem[58]<=din;
        address_head<<59: com_mem[59]<=din;
        address_head<<60: com_mem[60]<=din;
        address_head<<61: com_mem[61]<=din;
        address_head<<62: com_mem[62]<=din;
        address_head<<63: com_mem[63]<=din;
        address_head<<64: com_mem[64]<=din;
        address_head<<65: com_mem[65]<=din;
        address_head<<66: com_mem[66]<=din;
        address_head<<67: com_mem[67]<=din;
        address_head<<68: com_mem[68]<=din;
        address_head<<69: com_mem[69]<=din;
        address_head<<70: com_mem[70]<=din;
        address_head<<71: com_mem[71]<=din;
        address_head<<72: com_mem[72]<=din;
        address_head<<73: com_mem[73]<=din;
        address_head<<74: com_mem[74]<=din;
        address_head<<75: com_mem[75]<=din;
        address_head<<76: com_mem[76]<=din;
        address_head<<77: com_mem[77]<=din;
        address_head<<78: com_mem[78]<=din;
        address_head<<79: com_mem[79]<=din;
        address_head<<80: com_mem[80]<=din;
        address_head<<81: com_mem[81]<=din;
        address_head<<82: com_mem[82]<=din;
        address_head<<83: com_mem[83]<=din;
        address_head<<84: com_mem[84]<=din;
        address_head<<85: com_mem[85]<=din;
        address_head<<86: com_mem[86]<=din;
        address_head<<87: com_mem[87]<=din;
        address_head<<88: com_mem[88]<=din;
        address_head<<89: com_mem[89]<=din;
        address_head<<90: com_mem[90]<=din;
        address_head<<91: com_mem[91]<=din;
        address_head<<92: com_mem[92]<=din;
        address_head<<93: com_mem[93]<=din;
        address_head<<94: com_mem[94]<=din;
        address_head<<95: com_mem[95]<=din;
        address_head<<96: com_mem[96]<=din;
        address_head<<97: com_mem[97]<=din;
        address_head<<98: com_mem[98]<=din;
        address_head<<99: com_mem[99]<=din;
        address_head<<100: com_mem[100]<=din;
        address_head<<101: com_mem[101]<=din;
        address_head<<102: com_mem[102]<=din;
        address_head<<103: com_mem[103]<=din;
        address_head<<104: com_mem[104]<=din;
        address_head<<105: com_mem[105]<=din;
        address_head<<106: com_mem[106]<=din;
        address_head<<107: com_mem[107]<=din;
        address_head<<108: com_mem[108]<=din;
        address_head<<109: com_mem[109]<=din;
        address_head<<110: com_mem[110]<=din;
        address_head<<111: com_mem[111]<=din;
        address_head<<112: com_mem[112]<=din;
        address_head<<113: com_mem[113]<=din;
        address_head<<114: com_mem[114]<=din;
        address_head<<115: com_mem[115]<=din;
        address_head<<116: com_mem[116]<=din;
        address_head<<117: com_mem[117]<=din;
        address_head<<118: com_mem[118]<=din;
        address_head<<119: com_mem[119]<=din;
        address_head<<120: com_mem[120]<=din;
        address_head<<121: com_mem[121]<=din;
        address_head<<122: com_mem[122]<=din;
        address_head<<123: com_mem[123]<=din;
        address_head<<124: com_mem[124]<=din;
        address_head<<125: com_mem[125]<=din;
        address_head<<126: com_mem[126]<=din;
        address_head<<127: com_mem[127]<=din;

	endcase
	end
end






always@(posedge clk) begin
done=1'b0;
if(pe_en==1 && cm_en==1) begin
	begin
    	mul_0=com_mem[0]&din;
    	mul_1=com_mem[1]&din;
    	mul_2=com_mem[2]&din;
    	mul_3=com_mem[3]&din;
    	mul_4=com_mem[4]&din;
        mul_5=com_mem[5]&din;
        mul_6=com_mem[6]&din;
        mul_7=com_mem[7]&din;
        mul_8=com_mem[8]&din;
        mul_9=com_mem[9]&din;
        mul_10=com_mem[10]&din;
        mul_11=com_mem[11]&din;
        mul_12=com_mem[12]&din;
        mul_13=com_mem[13]&din;
        mul_14=com_mem[14]&din;
        mul_15=com_mem[15]&din;
        mul_16=com_mem[16]&din;
        mul_17=com_mem[17]&din;
        mul_18=com_mem[18]&din;
        mul_19=com_mem[19]&din;
        mul_20=com_mem[20]&din;
        mul_21=com_mem[21]&din;
        mul_22=com_mem[22]&din;
        mul_23=com_mem[23]&din;
        mul_24=com_mem[24]&din;
        mul_25=com_mem[25]&din;
        mul_26=com_mem[26]&din;
        mul_27=com_mem[27]&din;
        mul_28=com_mem[28]&din;
        mul_29=com_mem[29]&din;
        mul_30=com_mem[30]&din;
        mul_31=com_mem[31]&din;
        mul_32=com_mem[32]&din;
        mul_33=com_mem[33]&din;
        mul_34=com_mem[34]&din;
        mul_35=com_mem[35]&din;
        mul_36=com_mem[36]&din;
        mul_37=com_mem[37]&din;
        mul_38=com_mem[38]&din;
        mul_39=com_mem[39]&din;
        mul_40=com_mem[40]&din;
        mul_41=com_mem[41]&din;
        mul_42=com_mem[42]&din;
        mul_43=com_mem[43]&din;
        mul_44=com_mem[44]&din;
        mul_45=com_mem[45]&din;
        mul_46=com_mem[46]&din;
        mul_47=com_mem[47]&din;
        mul_48=com_mem[48]&din;
        mul_49=com_mem[49]&din;
        mul_50=com_mem[50]&din;
        mul_51=com_mem[51]&din;
        mul_52=com_mem[52]&din;
        mul_53=com_mem[53]&din;
        mul_54=com_mem[54]&din;
        mul_55=com_mem[55]&din;
        mul_56=com_mem[56]&din;
        mul_57=com_mem[57]&din;
        mul_58=com_mem[58]&din;
        mul_59=com_mem[59]&din;
        mul_60=com_mem[60]&din;
        mul_61=com_mem[61]&din;
        mul_62=com_mem[62]&din;
        mul_63=com_mem[63]&din;
        mul_64=com_mem[64]&din;
        mul_65=com_mem[65]&din;
        mul_66=com_mem[66]&din;
        mul_67=com_mem[67]&din;
        mul_68=com_mem[68]&din;
        mul_69=com_mem[69]&din;
        mul_70=com_mem[70]&din;
        mul_71=com_mem[71]&din;
        mul_72=com_mem[72]&din;
        mul_73=com_mem[73]&din;
        mul_74=com_mem[74]&din;
        mul_75=com_mem[75]&din;
        mul_76=com_mem[76]&din;
        mul_77=com_mem[77]&din;
        mul_78=com_mem[78]&din;
        mul_79=com_mem[79]&din;
        mul_80=com_mem[80]&din;
        mul_81=com_mem[81]&din;
        mul_82=com_mem[82]&din;
        mul_83=com_mem[83]&din;
        mul_84=com_mem[84]&din;
        mul_85=com_mem[85]&din;
        mul_86=com_mem[86]&din;
        mul_87=com_mem[87]&din;
        mul_88=com_mem[88]&din;
        mul_89=com_mem[89]&din;
        mul_90=com_mem[90]&din;
        mul_91=com_mem[91]&din;
        mul_92=com_mem[92]&din;
        mul_93=com_mem[93]&din;
        mul_94=com_mem[94]&din;
        mul_95=com_mem[95]&din;
        mul_96=com_mem[96]&din;
        mul_97=com_mem[97]&din;
        mul_98=com_mem[98]&din;
        mul_99=com_mem[99]&din;
        mul_100=com_mem[100]&din;
        mul_101=com_mem[101]&din;
        mul_102=com_mem[102]&din;
        mul_103=com_mem[103]&din;
        mul_104=com_mem[104]&din;
        mul_105=com_mem[105]&din;
        mul_106=com_mem[106]&din;
        mul_107=com_mem[107]&din;
        mul_108=com_mem[108]&din;
        mul_109=com_mem[109]&din;
        mul_110=com_mem[110]&din;
        mul_111=com_mem[111]&din;
        mul_112=com_mem[112]&din;
        mul_113=com_mem[113]&din;
        mul_114=com_mem[114]&din;
        mul_115=com_mem[115]&din;
        mul_116=com_mem[116]&din;
        mul_117=com_mem[117]&din;
        mul_118=com_mem[118]&din;
        mul_119=com_mem[119]&din;
        mul_120=com_mem[120]&din;
        mul_121=com_mem[121]&din;
        mul_122=com_mem[122]&din;
        mul_123=com_mem[123]&din;
        mul_124=com_mem[124]&din;
        mul_125=com_mem[125]&din;
        mul_126=com_mem[126]&din;
        mul_127=com_mem[127]&din;

	end



	begin
	    mac_0=7'b0;
        mac_1=7'b0;
        mac_2=7'b0;
        mac_3=7'b0;
	    mac_4=7'b0;
        mac_5=7'b0;
        mac_6=7'b0;
        mac_7=7'b0;
        mac_8=7'b0;
        mac_9=7'b0;
        mac_10=7'b0;
        mac_11=7'b0;
        mac_12=7'b0;
        mac_13=7'b0;
        mac_14=7'b0;
        mac_15=7'b0;
        mac_16=7'b0;
        mac_17=7'b0;
        mac_18=7'b0;
        mac_19=7'b0;
        mac_20=7'b0;
        mac_21=7'b0;
        mac_22=7'b0;
        mac_23=7'b0;
        mac_24=7'b0;
        mac_25=7'b0;
        mac_26=7'b0;
        mac_27=7'b0;
        mac_28=7'b0;
        mac_29=7'b0;
        mac_30=7'b0;
        mac_31=7'b0;
        mac_32=7'b0;
        mac_33=7'b0;
        mac_34=7'b0;
        mac_35=7'b0;
        mac_36=7'b0;
        mac_37=7'b0;
        mac_38=7'b0;
        mac_39=7'b0;
        mac_40=7'b0;
        mac_41=7'b0;
        mac_42=7'b0;
        mac_43=7'b0;
        mac_44=7'b0;
        mac_45=7'b0;
        mac_46=7'b0;
        mac_47=7'b0;
        mac_48=7'b0;
        mac_49=7'b0;
        mac_50=7'b0;
        mac_51=7'b0;
        mac_52=7'b0;
        mac_53=7'b0;
        mac_54=7'b0;
        mac_55=7'b0;
        mac_56=7'b0;
        mac_57=7'b0;
        mac_58=7'b0;
        mac_59=7'b0;
        mac_60=7'b0;
        mac_61=7'b0;
        mac_62=7'b0;
        mac_63=7'b0;
        mac_64=7'b0;
        mac_65=7'b0;
        mac_66=7'b0;
        mac_67=7'b0;
        mac_68=7'b0;
        mac_69=7'b0;
        mac_70=7'b0;
        mac_71=7'b0;
        mac_72=7'b0;
        mac_73=7'b0;
        mac_74=7'b0;
        mac_75=7'b0;
        mac_76=7'b0;
        mac_77=7'b0;
        mac_78=7'b0;
        mac_79=7'b0;
        mac_80=7'b0;
        mac_81=7'b0;
        mac_82=7'b0;
        mac_83=7'b0;
        mac_84=7'b0;
        mac_85=7'b0;
        mac_86=7'b0;
        mac_87=7'b0;
        mac_88=7'b0;
        mac_89=7'b0;
        mac_90=7'b0;
        mac_91=7'b0;
        mac_92=7'b0;
        mac_93=7'b0;
        mac_94=7'b0;
        mac_95=7'b0;
        mac_96=7'b0;
        mac_97=7'b0;
        mac_98=7'b0;
        mac_99=7'b0;
        mac_100=7'b0;
        mac_101=7'b0;
        mac_102=7'b0;
        mac_103=7'b0;
        mac_104=7'b0;
        mac_105=7'b0;
        mac_106=7'b0;
        mac_107=7'b0;
        mac_108=7'b0;
        mac_109=7'b0;
        mac_110=7'b0;
        mac_111=7'b0;
        mac_112=7'b0;
        mac_113=7'b0;
        mac_114=7'b0;
        mac_115=7'b0;
        mac_116=7'b0;
        mac_117=7'b0;
        mac_118=7'b0;
        mac_119=7'b0;
        mac_120=7'b0;
        mac_121=7'b0;
        mac_122=7'b0;
        mac_123=7'b0;
        mac_124=7'b0;
        mac_125=7'b0;
        mac_126=7'b0;
        mac_127=7'b0;
	end



	for (i=0;i<128;i=i+1) begin
		mac_0=mac_0+mul_0[i];
        mac_1=mac_1+mul_1[i];
        mac_2=mac_2+mul_2[i];
        mac_3=mac_3+mul_3[i];
        mac_4=mac_4+mul_4[i];
        mac_5=mac_5+mul_5[i];
        mac_6=mac_6+mul_6[i];
        mac_7=mac_7+mul_7[i];
        mac_8=mac_8+mul_8[i];
        mac_9=mac_9+mul_9[i];
        mac_10=mac_10+mul_10[i];
        mac_11=mac_11+mul_11[i];
        mac_12=mac_12+mul_12[i];
        mac_13=mac_13+mul_13[i];
        mac_14=mac_14+mul_14[i];
        mac_15=mac_15+mul_15[i];
        mac_16=mac_16+mul_16[i];
        mac_17=mac_17+mul_17[i];
        mac_18=mac_18+mul_18[i];
        mac_19=mac_19+mul_19[i];
        mac_20=mac_20+mul_20[i];
        mac_21=mac_21+mul_21[i];
        mac_22=mac_22+mul_22[i];
        mac_23=mac_23+mul_23[i];
        mac_24=mac_24+mul_24[i];
        mac_25=mac_25+mul_25[i];
        mac_26=mac_26+mul_26[i];
        mac_27=mac_27+mul_27[i];
        mac_28=mac_28+mul_28[i];
        mac_29=mac_29+mul_29[i];
        mac_30=mac_30+mul_30[i];
        mac_31=mac_31+mul_31[i];
        mac_32=mac_32+mul_32[i];
        mac_33=mac_33+mul_33[i];
        mac_34=mac_34+mul_34[i];
        mac_35=mac_35+mul_35[i];
        mac_36=mac_36+mul_36[i];
        mac_37=mac_37+mul_37[i];
        mac_38=mac_38+mul_38[i];
        mac_39=mac_39+mul_39[i];
        mac_40=mac_40+mul_40[i];
        mac_41=mac_41+mul_41[i];
        mac_42=mac_42+mul_42[i];
        mac_43=mac_43+mul_43[i];
        mac_44=mac_44+mul_44[i];
        mac_45=mac_45+mul_45[i];
        mac_46=mac_46+mul_46[i];
        mac_47=mac_47+mul_47[i];
        mac_48=mac_48+mul_48[i];
        mac_49=mac_49+mul_49[i];
        mac_50=mac_50+mul_50[i];
        mac_51=mac_51+mul_51[i];
        mac_52=mac_52+mul_52[i];
        mac_53=mac_53+mul_53[i];
        mac_54=mac_54+mul_54[i];
        mac_55=mac_55+mul_55[i];
        mac_56=mac_56+mul_56[i];
        mac_57=mac_57+mul_57[i];
        mac_58=mac_58+mul_58[i];
        mac_59=mac_59+mul_59[i];
        mac_60=mac_60+mul_60[i];
        mac_61=mac_61+mul_61[i];
        mac_62=mac_62+mul_62[i];
        mac_63=mac_63+mul_63[i];
        mac_64=mac_64+mul_64[i];
        mac_65=mac_65+mul_65[i];
        mac_66=mac_66+mul_66[i];
        mac_67=mac_67+mul_67[i];
        mac_68=mac_68+mul_68[i];
        mac_69=mac_69+mul_69[i];
        mac_70=mac_70+mul_70[i];
        mac_71=mac_71+mul_71[i];
        mac_72=mac_72+mul_72[i];
        mac_73=mac_73+mul_73[i];
        mac_74=mac_74+mul_74[i];
        mac_75=mac_75+mul_75[i];
        mac_76=mac_76+mul_76[i];
        mac_77=mac_77+mul_77[i];
        mac_78=mac_78+mul_78[i];
        mac_79=mac_79+mul_79[i];
        mac_80=mac_80+mul_80[i];
        mac_81=mac_81+mul_81[i];
        mac_82=mac_82+mul_82[i];
        mac_83=mac_83+mul_83[i];
        mac_84=mac_84+mul_84[i];
        mac_85=mac_85+mul_85[i];
        mac_86=mac_86+mul_86[i];
        mac_87=mac_87+mul_87[i];
        mac_88=mac_88+mul_88[i];
        mac_89=mac_89+mul_89[i];
        mac_90=mac_90+mul_90[i];
        mac_91=mac_91+mul_91[i];
        mac_92=mac_92+mul_92[i];
        mac_93=mac_93+mul_93[i];
        mac_94=mac_94+mul_94[i];
        mac_95=mac_95+mul_95[i];
        mac_96=mac_96+mul_96[i];
        mac_97=mac_97+mul_97[i];
        mac_98=mac_98+mul_98[i];
        mac_99=mac_99+mul_99[i];
        mac_100=mac_100+mul_100[i];
        mac_101=mac_101+mul_101[i];
        mac_102=mac_102+mul_102[i];
        mac_103=mac_103+mul_103[i];
        mac_104=mac_104+mul_104[i];
        mac_105=mac_105+mul_105[i];
        mac_106=mac_106+mul_106[i];
        mac_107=mac_107+mul_107[i];
        mac_108=mac_108+mul_108[i];
        mac_109=mac_109+mul_109[i];
        mac_110=mac_110+mul_110[i];
        mac_111=mac_111+mul_111[i];
        mac_112=mac_112+mul_112[i];
        mac_113=mac_113+mul_113[i];
        mac_114=mac_114+mul_114[i];
        mac_115=mac_115+mul_115[i];
        mac_116=mac_116+mul_116[i];
        mac_117=mac_117+mul_117[i];
        mac_118=mac_118+mul_118[i];
        mac_119=mac_119+mul_119[i];
        mac_120=mac_120+mul_120[i];
        mac_121=mac_121+mul_121[i];
        mac_122=mac_122+mul_122[i];
        mac_123=mac_123+mul_123[i];
        mac_124=mac_124+mul_124[i];
        mac_125=mac_125+mul_125[i];
        mac_126=mac_126+mul_126[i];
        mac_127=mac_127+mul_127[i];

	end

	
	begin
	dout={mac_0,
        mac_1,mac_2,mac_3,mac_4,mac_5,mac_6,mac_7,mac_8,
        mac_9,mac_10,mac_11,mac_12,mac_13,mac_14,mac_15,mac_16,
        mac_17,mac_18,mac_19,mac_20,mac_21,mac_22,mac_23,mac_24,
        mac_25,mac_26,mac_27,mac_28,mac_29,mac_30,mac_31,mac_32,
        mac_33,mac_34,mac_35,mac_36,mac_37,mac_38,mac_39,mac_40,
        mac_41,mac_42,mac_43,mac_44,mac_45,mac_46,mac_47,mac_48,
        mac_49,mac_50,mac_51,mac_52,mac_53,mac_54,mac_55,mac_56,
        mac_57,mac_58,mac_59,mac_60,mac_61,mac_62,mac_63,mac_64,
        mac_65,mac_66,mac_67,mac_68,mac_69,mac_70,mac_71,mac_72,
        mac_73,mac_74,mac_75,mac_76,mac_77,mac_78,mac_79,mac_80,
        mac_81,mac_82,mac_83,mac_84,mac_85,mac_86,mac_87,mac_88,
        mac_89,mac_90,mac_91,mac_92,mac_93,mac_94,mac_95,mac_96,
        mac_97,mac_98,mac_99,mac_100,mac_101,mac_102,mac_103,mac_104,
        mac_105,mac_106,mac_107,mac_108,mac_109,mac_110,mac_111,mac_112,
        mac_113,mac_114,mac_115,mac_116,mac_117,mac_118,mac_119,mac_120,
        mac_121,mac_122,mac_123,mac_124,mac_125,mac_126,mac_127};
	end

done=1'b1;
end

end

endmodule
	
		
