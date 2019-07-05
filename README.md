# Code
MIPSCODE

day 7.4, hjw
1. alter get_instr.v:
	1) sram interface
	2) pass PC to instr_decode
2. alter instr_decode
	1) pass PC to id_ie
3. alter id_ie
	1) pass PC to ie_im
4. alter im_iw
	1) pass PC to im_iw
	2) sram interface(debug)(registers to write, write enable signal, PC)
5. alter access_memory
	1) sram interface
	2) comment  LWL\LWR\SWL\SWR which is not required
6. alter get_ResultW_withHilo_withPC
	1) sram interface(debug)(data to write registers)
7. The get_instr.v and access_memory.v contains the function of converting from small end to large end
