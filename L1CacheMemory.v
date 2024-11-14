`timescale 1ns / 1ps

/* L1 Instruction Cache Memory */
module L1_INSTRUCTION_CACHE_MEMORY();
parameter no_of_l1_instruction_ways=2;         		 //No. of ways in the set ...2 as it is 2-way set-associative here
parameter no_of_l1_instruction_ways_bits=1;     	 //No. of bits required to describe the way to which a block belongs =1 as 2^1=2
parameter no_of_l1_instruction_blocks=16384;        //No. of lines in L1 instruction block ...we can also describe it as the number of sets in L1 instruction Cache
parameter no_of_bytes_l1_instruction_block=64;      //No. of bytes in a single block 64 bytes
parameter l1_instruction_block_bit_size=512;        //The size of L2 block line in bits = NO. of blocks in a singl line * No. of bits in a block=4*16=128
parameter byte_size=8;                  				 //No. of bits in a byte 1 byte = 8 bit
parameter no_of_address_bits=32;        				 //the bits in address 32 bit
parameter no_of_l1_instruction_index_bits=14;       //the no. of bits required for indexing as 2^14=16384
parameter no_of_blkoffset_bits=6;        				 //as there are 64 bytes in a block... to index the bytes in a block 2^6=64
parameter no_of_l1_instruction_tag_bits=24;         //No. of bits in tag= No. of address bits - No. of index bits - No. of offset bits=32-14-6=12

reg [l1_instruction_block_bit_size-1:0]l1_instruction_cache_memory[0:no_of_l1_instruction_blocks-1];    								 //An array where each element if of l1_instruction_block_bit_size bits..for memory in L1 instruction Cache
reg [(no_of_l1_instruction_tag_bits*no_of_l1_instruction_ways)-1:0]l1_instruction_tag_array[0:no_of_l1_instruction_blocks-1];  //The tag array where each element contains no_of_l1_instruction_tag_bits*NO_of_l1_instruction_ways bits
reg [no_of_l1_instruction_ways-1:0]l1_intruction_valid[0:no_of_l1_instruction_blocks-1];   		     								 	 //Is valid array where each element is of no_of_l1_instruction_ways bits
reg [no_of_l1_instruction_ways*no_of_l1_instruction_ways_bits-1:0]l1_instruction_lru[0:no_of_l1_instruction_blocks-1];   	    //LRU array where each element is of no_of_l1_instruction_ways*no_of_l1_instruction_ways_bits bits

initial 
begin: initialization_l1_instruction           
    integer i;
    for  (i=0;i<no_of_l1_instruction_blocks;i=i+1)
    begin
        l1_instruction_valid[i]=0;   								//initially as the cache is empty...all the locations on the Cache are invalid
        l1_instruction_tag_array[i]=0;  							//set tag to 0...we can set tag to some other random value as well
		  l1_instruction_lru[i]=8'b11100100;        				//set the lru values to some random permutation of 0, 1, 2, 3 initially
    end
end
endmodule