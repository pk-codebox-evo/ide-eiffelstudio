indexing

	description: 
		"Yacc to Eiffel interface for AST structures.";
	date: "$Date$";
	revision: "$Revision $"

class YACC_EIFFEL

inherit

	LACE_YACC_CONST;
	EIFFEL_YACC_CONST;
	COMPILER_EXPORTER

creation

	init

feature -- Initialization

	init is
			-- Initialization of the Eiffel-Yacc interface
		local
			as1: like anchor_class_as
			as2: ID_AS;
			as3: EIFFEL_LIST[AST_EIFFEL];
			as4: STRING_AS;
			as5: INTEGER_AS;
			as6: INDEX_AS;
			as7: EXPORT_ITEM_AS;
			as8: ALL_AS;
			as10: FEAT_NAME_ID_AS;
			as11: INFIX_AS;
			as12: PREFIX_AS;
			as13: FORMAL_AS;
			as14: CHAR_TYPE_AS;
			as15: BOOL_TYPE_AS;
			as16: INT_TYPE_AS;
			as17: REAL_TYPE_AS;
			as18: DOUBLE_TYPE_AS;
			as19: FORMAL_DEC_AS;
			as20: LIKE_CUR_AS;
			as21: LIKE_ID_AS;
			as22: CLASS_TYPE_AS;
			as23: EXP_TYPE_AS;
			as24: BITS_AS;
			as25: PARENT_AS;
			as26: RENAME_AS;
			as27: REAL_AS;
			as28: BOOL_AS;
			as29: VALUE_AS;
			as31: ADDRESS_AS;
			as32: PARAN_AS;
			as33: UN_MINUS_AS;
			as34: UN_PLUS_AS;
			as35: UN_OLD_AS;
			as36: UN_NOT_AS;
			as37: BIN_PLUS_AS;
			as38: BIN_MINUS_AS;
			as39: BIN_MOD_AS;
			as40: BIN_POWER_AS;
			as41: BIN_AND_AS;
			as42: BIN_AND_THEN_AS;
			as43: BIN_OR_AS;
			as44: BIN_OR_ELSE_AS;
			as45: BIN_IMPLIES_AS;
			as46: BIN_XOR_AS;
			as47: BIN_EQ_AS;
			as48: BIN_NE_AS;
			as49: BIN_GT_AS;
			as50: BIN_GE_AS;
			as51: BIN_LT_AS;
			as52: BIN_LE_AS;
			as53: BIN_SLASH_AS;
			as54: BIN_STAR_AS;
			as55: BIN_DIV_AS;
			as56: CHAR_AS;
			as57: RESULT_AS;
			as58: CURRENT_AS;
			as59: ACCESS_ID_AS;
			as61: NESTED_AS;
			as62: EXPR_CALL_AS;
			as63: CREATE_AS;
			as66: INSPECT_AS;
			as67: CASE_AS;
			as68: INTERVAL_AS;
			as69: IF_AS;
			as70: ELSIF_AS;
			as71: ASSIGN_AS;
			as72: REVERSE_AS;
			as73: DEBUG_AS;
			as74: RETRY_AS;
			as75: INSTR_CALL_AS;
			as76: TAGGED_AS;
			as77: LOOP_AS;
			as78: CHECK_AS;
			as79: BODY_AS;
			as80: TYPE_DEC_AS;
			as81: UNIQUE_AS;
			as82: ROUTINE_AS;
			as83: EXTERNAL_AS;
			as85: CONSTANT_AS;
			as86: like anchor_feature_as;
			as87: SUPPLIERS_AS;
			as88: INVARIANT_AS;
			as89: VARIANT_AS;
			as90: FEATURE_LIST_AS;
			as91: DEFERRED_AS;
			as92: DO_AS;
			as93: ONCE_AS;
			as94: REQUIRE_AS;
			as95: REQUIRE_ELSE_AS;
			as96: ENSURE_AS;
			as97: ENSURE_THEN_AS;
			as98: like anchor_feature_clause_as;
			as99: CREATION_AS;
			as100: ARRAY_AS;
			as101: UN_STRIP_AS;
			as102: NONE_TYPE_AS;
			as103: CLIENT_AS;
			as104: ACCESS_FEAT_AS;
			as105: ACCESS_INV_AS;
			as106: ACCESS_ASSERT_AS;
			as107: BIN_FREE_AS;
			as108: UN_FREE_AS;
			as109: NESTED_EXPR_AS;
			as110: BIT_CONST_AS;
			as111: BITS_SYMBOL_AS;
			as112: POINTER_TYPE_AS;
			as113: ADDRESS_CURRENT_AS;
			as114: ADDRESS_RESULT_AS;
			as115: EXTERNAL_LANG_AS;
			as116: EXPR_ADDRESS_AS;
			as117: SEPARATE_TYPE_AS;
			as118: PRECURSOR_AS

			-- Initialized by lace normally but since we are not
			-- using lace for parsing eiffel we need to initialize
			-- here.
			as141: CLICK_LIST;
			as142: CLICK_AST;
		do
			!!as1;
			as1.pass_address(class_as);
			!!as2.make (0);
			as2.pass_address(id_as);
			!!as3.make_filled (0);
			as3.pass_address(construct_list_as);
			!!as4;
			as4.pass_address(string_as);
			!!as5;
			as5.pass_address(integer_as);
			!!as6;
			as6.pass_address(index_as);
			!!as7;
			as7.pass_address(export_item_as);
			!!as8;
			as8.pass_address(all_as);
			!!as10;
			as10.pass_address(feat_name_id_as);
			!!as11;
			as11.pass_address(infix_as);
			!!as12;
			as12.pass_address(prefix_as);
			!!as13;
			as13.pass_address(formal_as);
			!!as14;
			as14.pass_address(char_type_as);
			!!as15;
			as15.pass_address (bool_type_as);
			!!as16;
			as16.pass_address (int_type_as);
			!!as17;
			as17.pass_address (real_type_as);
			!!as18;
			as18.pass_address (double_type_as);
			!!as19;
			as19.pass_address (formal_dec_as);
			!!as20;
			as20.pass_address (like_cur_as);
			!!as21;
			as21.pass_address (like_id_as);
			!!as22;
			as22.pass_address (class_type_as);
			!!as23;
			as23.pass_address (exp_type_as);
			!!as24;
			as24.pass_address (bits_as);
			!!as25;
			as25.pass_address (parent_as);
			!!as26;
			as26.pass_address (rename_as);
			!!as27;
			as27.pass_address (real_as);
			!!as28;
			as28.pass_address (bool_as);
			!!as29;
			as29.pass_address (value_as);
			!!as31;
			as31.pass_address (address_as);
			!!as32;
			as32.pass_address (paran_as);
			!!as33;
			as33.pass_address (un_minus_as);
			!!as34;
			as34.pass_address (un_plus_as);
			!!as35;
			as35.pass_address (un_old_as);
			!!as36;
			as36.pass_address (un_not_as);
			!!as37;
			as37.pass_address (bin_plus_as);
			!!as38;
			as38.pass_address (bin_minus_as);
			!!as39;
			as39.pass_address (bin_mod_as);
			!!as40;
			as40.pass_address (bin_power_as);
			!!as41;
			as41.pass_address (bin_and_as);
			!!as42;
			as42.pass_address (bin_and_then_as);
			!!as43;
			as43.pass_address (bin_or_as);
			!!as44;
			as44.pass_address (bin_or_else_as);
			!!as45;
			as45.pass_address (bin_implies_as);
			!!as46;
			as46.pass_address (bin_xor_as);
			!!as47;
			as47.pass_address (bin_eq_as);
			!!as48;
			as48.pass_address (bin_ne_as);
			!!as49;
			as49.pass_address (bin_gt_as);
			!!as50;
			as50.pass_address (bin_ge_as);
			!!as51;
			as51.pass_address (bin_lt_as);
			!!as52;
			as52.pass_address (bin_le_as);
			!!as53;
			as53.pass_address (bin_slash_as);
			!!as54;
			as54.pass_address (bin_star_as);
			!!as55;
			as55.pass_address (bin_div_as);
			!!as56;
			as56.pass_address (char_as);
			!!as57;
			as57.pass_address (result_as);
			!!as58;
			as58.pass_address (current_as);
			!!as59;
			as59.pass_address (access_id_as);
			!!as61;
			as61.pass_address (nested_as);
			!!as62;
			as62.pass_address (expr_call_as);
			!!as63;
			as63.pass_address (create_as);
			!!as66;
			as66.pass_address (inspect_as);
			!!as67;
			as67.pass_address (case_as);
			!!as68;
			as68.pass_address (interval_as);
			!!as69;
			as69.pass_address (if_as);
			!!as70;
			as70.pass_address (elsif_as);
			!!as71;
			as71.pass_address (assign_as);
			!!as72;
			as72.pass_address (reverse_as);
			!!as73;
			as73.pass_address (debug_as);
			!!as74;
			as74.pass_address (retry_as);
			!!as75;
			as75.pass_address (instr_call_as);
			!!as76;
			as76.pass_address (tagged_as);
			!!as77;
			as77.pass_address (loop_as);
			!!as78;
			as78.pass_address (check_as);
			!!as79;
			as79.pass_address (body_as);
			!!as80;
			as80.pass_address (type_dec_as);
			!!as81;
			as81.pass_address (unique_as);
			!!as82;
			as82.pass_address (routine_as);
			!!as83;
			as83.pass_address (external_as);
			!!as85;
			as85.pass_address (constant_as);
			!!as86;
			as86.pass_address (feature_as);
			!!as87.make;
			as87.pass_address (suppliers_as);
			!!as88;
			as88.pass_address (invariant_as);
			!!as89;
			as89.pass_address (variant_as);
			!!as90;
			as90.pass_address (feature_list_as);
			!!as91;
			as91.pass_address (deferred_as);
			!!as92;
			as92.pass_address (do_as);
			!!as93;
			as93.pass_address (once_as);
			!!as94;
			as94.pass_address (require_as);
			!!as95;
			as95.pass_address (require_else_as);
			!!as96;
			as96.pass_address (ensure_as);
			!!as97;
			as97.pass_address (ensure_then_as);
			!!as98;
			as98.pass_address (feature_clause_as);
			!!as99;
			as99.pass_address (creation_as);
			!!as100;
			as100.pass_address (array_as);
			!!as101;
			as101.pass_address (un_strip_as);
			!!as102;
			as102.pass_address (none_type_as);
			!!as103;
			as103.pass_address (client_as);
			!!as104;
			as104.pass_address (access_feat_as);
			!!as105;
			as105.pass_address (access_inv_as);
			!!as106;
			as106.pass_address (access_assert_as);
			!!as107;
			as107.pass_address (bin_free_as);
			!!as108;
			as108.pass_address (un_free_as);
			!!as109;
			as109.pass_address (nested_expr_as);
			!!as110;
			as110.pass_address (bit_const_as);
			!!as111;
			as111.pass_address (bits_symbol_as);
			!!as112;
			as112.pass_address (pointer_type_as);
			!!as113;
			as113.pass_address (address_current_as);
			!!as114;
			as114.pass_address (address_result_as);
			!!as115;
			as115.pass_address (external_lang_as);
			!!as116;
			as116.pass_address (expr_address_as);
			!!as117;
			as117.pass_address (separate_type_as);
			!!as118;
			as118.pass_address (precursor_as);

			!!as141.make (0);
			as141.pass_address (click_list_sd);
			!!as142;
			as142.pass_address (click_elem_sd);
			as142.pass_click_set;
		end;

feature {NONE} -- Implementation

	-- Dummies, intended to be redefined if a specific version is
	-- needed.

	anchor_class_as: CLASS_AS is
		do
		end;

	anchor_feature_as: FEATURE_AS is
		do
		end;

	anchor_feature_clause_as: FEATURE_CLAUSE_AS is
		do
		end;

end -- class YACC_EIFFEL
