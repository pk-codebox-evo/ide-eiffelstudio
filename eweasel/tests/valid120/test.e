--| Copyright (c) 1993-2013 University of Southern California and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

class TEST
creation
	make
feature
	
	make is
		do
		end;

	x1: ANY
	x2: ARGUMENTS_32
	x3: ARRAY [DOUBLE]
	x4: BASIC_ROUTINES

	x6: BOOLEAN
	x7: BOOLEAN_REF
	x8: CHARACTER
	x9: CHARACTER_REF
	x10: COMPARABLE
	x11: CONSOLE
	x12: DECLARATOR
	x13: DIRECTORY
	x14: DIRECTORY_NAME
	x15: DOUBLE
	x16: DOUBLE_REF
	x17: EXCEP_CONST
	x18: EXCEPTIONS
	x19: FILE
	x20: FILE_NAME
	x21: FUNCTION [DOUBLE, TUPLE, DOUBLE]
	x22: GC_INFO
	x23: HASHABLE
	x24: INTEGER
	x25: INTEGER_16
	x26: INTEGER_16_REF
	x27: INTEGER_64
	x28: INTEGER_64_REF
	x29: INTEGER_8
	x30: INTEGER_8_REF
	x31: INTEGER_INTERVAL
	x32: INTEGER_REF
	x33: IO_MEDIUM
	x34: MEM_CONST
	x35: MEM_INFO
	x36: MEMORY
	x37: NUMERIC
	x38: PART_COMPARABLE
	x39: PATH_NAME
	x40: PLAIN_TEXT_FILE
	x41: PLATFORM
	x42: POINTER
	x43: POINTER_REF
	x44: PROCEDURE [DOUBLE, TUPLE]
	x45: RAW_FILE
	x46: REAL
	x47: REAL_REF
	x48: ROUTINE [DOUBLE, TUPLE]
	x49: SEQ_STRING
	x50: SPECIAL [DOUBLE]
	x51: STD_FILES
	x52: STORABLE
	x53: STREAM
	x54: STRING
	x55: STRING_HANDLER
	x56: TO_SPECIAL [DOUBLE]
	x57: TUPLE
	x58: UNIX_FILE_INFO
	x59: UNIX_SIGNALS
	-- x60: WIDE_CHARACTER		-- Now obsolete
	-- x61: WIDE_CHARACTER_REF	-- Now obsolete
	x62: ASCII
	x63: BOOL_STRING
	x64: COUNTABLE_SEQUENCE [DOUBLE]
	x65: DOUBLE_MATH
	x66: EXECUTION_ENVIRONMENT
	x67: FIBONACCI
	x68: FORMAT_DOUBLE
	x69: FORMAT_INTEGER
	x70: IDENTIFIED
	x71: IDENTIFIED_CONTROLLER
	x72: INTERNAL
	x73: MATH_CONST
	x74: OPERATING_ENVIRONMENT
	x75: PRIMES
	x76: PROFILING_SETTING
	x77: RANDOM
	x78: SINGLE_MATH
	x79: ACTIVE [DOUBLE]
	x80: BAG [DOUBLE]
	x81: COLLECTION [DOUBLE]
	x82: CONTAINER [DOUBLE]
	x83: CURSOR_STRUCTURE [DOUBLE]
	x84: INDEXABLE [DOUBLE, INTEGER]
	x85: TABLE [DOUBLE, DOUBLE]
	x86: ARRAYED_LIST_CURSOR
	x87: CIRCULAR_CURSOR
	x88: COMPACT_TREE_CURSOR
	x89: CURSOR
	x90: HASH_TABLE_CURSOR
	x91: LINKED_LIST_CURSOR [DOUBLE]
	x92: LINKED_TREE_CURSOR [DOUBLE]
	x93: MULTAR_LIST_CURSOR [DOUBLE]
	x94: RECURSIVE_TREE_CURSOR [DOUBLE]
	x95: TWO_WAY_TREE_CURSOR [DOUBLE]
	x96: COMPACT_CURSOR_TREE [DOUBLE]
	x97: CURSOR_TREE [DOUBLE]
	x98: LINKED_CURSOR_TREE [DOUBLE]
	x99: RECURSIVE_CURSOR_TREE [DOUBLE]
	x100: TWO_WAY_CURSOR_TREE [DOUBLE]
	x101: ARRAYED_QUEUE [DOUBLE]
	x102: ARRAYED_STACK [DOUBLE]
	x103: BOUNDED_QUEUE [DOUBLE]
	x104: BOUNDED_STACK [DOUBLE]
	x105: DISPENSER [DOUBLE]
	x106: HEAP_PRIORITY_QUEUE [DOUBLE]
	x107: LINKED_PRIORITY_QUEUE [DOUBLE]
	x108: LINKED_QUEUE [DOUBLE]
	x109: LINKED_STACK [DOUBLE]
	x110: PRIORITY_QUEUE [DOUBLE]
	x111: QUEUE [DOUBLE]
	x112: STACK [DOUBLE]
	x113: CURSOR_TREE_ITERATOR [DOUBLE]
	x114: ITERATOR [DOUBLE]
	x115: LINEAR_ITERATOR [DOUBLE]
	x116: TWO_WAY_CHAIN_ITERATOR [DOUBLE]
	x117: ARRAYED_CIRCULAR [DOUBLE]
	x118: ARRAYED_LIST [DOUBLE]
	x119: BI_LINKABLE [DOUBLE]
	x120: CELL [DOUBLE]
	x121: CHAIN [DOUBLE]
	x122: CIRCULAR [DOUBLE]
	x123: DYNAMIC_CHAIN [DOUBLE]
	x124: DYNAMIC_CIRCULAR [DOUBLE]
	x125: DYNAMIC_LIST [DOUBLE]
	x126: FIXED_LIST [DOUBLE]
	x127: LINKABLE [DOUBLE]
	x128: LINKED_CIRCULAR [DOUBLE]
	x129: LINKED_LIST [DOUBLE]
	x130: LIST [DOUBLE]
	x131: MULTI_ARRAY_LIST [DOUBLE]
	x132: PART_SORTED_LIST [DOUBLE]
	x133: PART_SORTED_TWO_WAY_LIST [DOUBLE]
	x134: SEQUENCE [DOUBLE]
	x135: SORTED_LIST [DOUBLE]
	x136: SORTED_TWO_WAY_LIST [DOUBLE]
	x137: TWO_WAY_CIRCULAR [DOUBLE]
	x138: TWO_WAY_LIST [DOUBLE]
	x139: BINARY_SEARCH_TREE_SET [DOUBLE]
	x140: COMPARABLE_SET [DOUBLE]
	x141: LINKED_SET [DOUBLE]
	x142: PART_SORTED_SET [DOUBLE]
	x143: SET [DOUBLE]
	x144: SUBSET [DOUBLE]
	x145: TWO_WAY_SORTED_SET [DOUBLE]
	x146: COMPARABLE_STRUCT [DOUBLE]
	x147: SORTED_STRUCT [DOUBLE]
	x148: BOUNDED [DOUBLE]
	x149: BOX [DOUBLE]
	x150: COUNTABLE [DOUBLE]
	x151: FINITE [DOUBLE]
	x152: FIXED [DOUBLE]
	x153: INFINITE [DOUBLE]
	x154: RESIZABLE [DOUBLE]
	x155: UNBOUNDED [DOUBLE]
	x156: ARRAY2 [DOUBLE]
	x157: HASH_TABLE [DOUBLE, DOUBLE]
	x158: BILINEAR [DOUBLE]
	x159: HIERARCHICAL [DOUBLE]
	x160: LINEAR [DOUBLE]
	x161: TRAVERSABLE [DOUBLE]
	x162: ARRAYED_TREE [DOUBLE]
	x163: BINARY_SEARCH_TREE [DOUBLE]
	x164: BINARY_TREE [DOUBLE]
	x165: DYNAMIC_TREE [DOUBLE]
	x166: FIXED_TREE [DOUBLE]
	x167: LINKED_TREE [DOUBLE]
	x168: TREE [DOUBLE]
	x169: TWO_WAY_TREE [DOUBLE]
end
