indexing
	description: "Objects that represent an EV_TITLED_WINDOW generated by Build."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	CHANGE_EIFFEL_FEATURE_NAME_DIALOG

inherit
	CHANGE_EIFFEL_FEATURE_NAME_DIALOG_IMP
	
feature {NONE} -- Implementation

	user_initialization is
			-- Called by `select_actions' of `execute'.
		local
			l_list: ARRAYED_LIST [EV_LIST_ITEM]
			cache: CACHE
			l_item: EV_LIST_ITEM
		do
			set_size (600, 80)
			set_default_push_button (ok_btn)
			set_default_cancel_button (cancel_btn)

			create cache
			create l_list.make (cache.assemblies.count)
			from
				cache.assemblies.start
			until
				cache.assemblies.after
			loop
				create l_item.make_with_text (cache.assemblies.item.name)
				l_item.set_data (cache.assemblies.item)
				l_list.extend (l_item)

				cache.assemblies.forth
			end
			assemblies_combo.append (l_list)
		end

	on_change_assembly is
			-- Called by `change_actions' of `assemblies_combo'.
		local
			l_list: ARRAYED_LIST [EV_LIST_ITEM]
			l_item: EV_LIST_ITEM_COMPARABLE
			l_tri_list: SORTABLE_ARRAY [EV_LIST_ITEM_COMPARABLE]
			eac: EAC_BROWSER
			cat: CONSUMED_ASSEMBLY_TYPES
			counter: INTEGER
			path: CACHE_PATH
			an_assembly: CONSUMED_ASSEMBLY
		do
			types_combo.wipe_out

			create eac
			create path
			an_assembly ?= assemblies_combo.selected_item.data
			cat := eac.consumed_assembly (an_assembly)
			from 
				counter := 1
				create l_tri_list.make (1, cat.dotnet_names.count)
			until
				counter > cat.dotnet_names.count
			loop
				create l_item
				l_item.set_text (cat.dotnet_names.item (counter))
				l_item.set_data (cat.dotnet_names)
				l_tri_list.put (l_item, counter)

				counter := counter + 1
			end

			from
				counter := 1
				create l_list.make (l_tri_list.count)
				l_tri_list.sort
			until
				counter > l_tri_list.count
			loop
				l_list.extend (l_tri_list.item (counter)) 
				counter := counter + 1
			end

			types_combo.append (l_list)
		end
	
	on_change_type is
			-- Called by `change_actions' of `types_combo'.
		local
			eac: EAC_BROWSER
			ct: CONSUMED_TYPE
			path: CACHE_PATH
			assembly_of_type: CONSUMED_ASSEMBLY
			dotnet_type_name: STRING
		do
			create eac
			create path
			create eac
			assembly_of_type ?= assemblies_combo.selected_item.data
			dotnet_type_name := types_combo.selected_item.text
			ct := eac.consumed_type (assembly_of_type, dotnet_type_name)

				-- Initialize `dotnet_features_combo'
			dotnet_features_combo.wipe_out
			dotnet_features_combo.append (dotnet_constructors_list (ct.constructors))
			dotnet_features_combo.append (dotnet_features_list (ct.fields))
			dotnet_features_combo.append (dotnet_features_list (ct.procedures))
			dotnet_features_combo.append (dotnet_features_list (ct.functions))

				-- Initialize `eiffel_features_combo'
			eiffel_features_combo.wipe_out
			eiffel_features_combo.append (eiffel_constructors_list (ct.constructors))
			eiffel_features_combo.append (eiffel_features_list (ct.fields))
			eiffel_features_combo.append (eiffel_features_list (ct.procedures))
			eiffel_features_combo.append (eiffel_features_list (ct.functions))
		end
	
	dotnet_constructors_list (array: ARRAY [CONSUMED_CONSTRUCTOR]): ARRAYED_LIST [EV_LIST_ITEM] is
			-- return classified list of constructors.
		require
			non_void_array: array /= Void
		local
			counter: INTEGER
			signature: SIGNATURE
			l_item: EV_LIST_ITEM_COMPARABLE
			l_tri_list: SORTABLE_ARRAY [EV_LIST_ITEM_COMPARABLE]
		do
			create signature
			from 
				counter := 1
				create l_tri_list.make (1, array.count)
			until
				counter > array.count
			loop
--				signature_feature := array.item (counter).dotnet_name
--				from
--					counter_2 := 1
--				until
--					array.item (counter).arguments = Void
--					or else
--					counter_2 > array.item (counter).arguments.count
--				loop
--					if counter_2 = 1 then
--						signature_feature := signature_feature + " ("
--					else
--						signature_feature := signature_feature + "; "
--					end
--					signature_feature := signature_feature + array.item (counter).arguments.item (counter_2).dotnet_name + ": " + array.item (counter).arguments.item (counter_2).type.name
--
--					counter_2 := counter_2 + 1
--				end
--				if counter_2 /= 1 then
--					signature_feature := signature_feature + ")"
--				end

				create l_item
				l_item.set_text (signature.signature_constructor (array.item (counter)))
				l_item.set_data (array.item (counter))

				l_tri_list.put (l_item, counter)
				
				counter := counter + 1
			end
			
			from
				counter := 1
				create Result.make (l_tri_list.count)
				l_tri_list.sort
			until
				counter > l_tri_list.count
			loop
				Result.extend (l_tri_list.item (counter))
				counter := counter + 1
			end
		ensure
			non_void_result: Result /= Void
		end
	
	dotnet_features_list (array: ARRAY [CONSUMED_MEMBER]): ARRAYED_LIST [EV_LIST_ITEM] is
			-- return classified list of features contained in `array'.
		require
			non_void_array: array /= Void
		local
			counter, counter_2: INTEGER
--			signature_feature: STRING
			signature: SIGNATURE
			l_item: EV_LIST_ITEM_COMPARABLE
			l_tri_list: SORTABLE_ARRAY [EV_LIST_ITEM_COMPARABLE]
		do
			create signature
			from 
				counter := 1
				create l_tri_list.make (1, array.count)
			until
				counter > array.count
			loop
--				signature_feature := array.item (counter).dotnet_name
--				from
--					counter_2 := 1
--				until
--					array.item (counter).arguments = Void
--					or else
--					counter_2 > array.item (counter).arguments.count
--				loop
--					if counter_2 = 1 then
--						signature_feature := signature_feature + " ("
--					else
--						signature_feature := signature_feature + "; "
--					end
--					signature_feature := signature_feature + array.item (counter).arguments.item (counter_2).dotnet_name + ": " + array.item (counter).arguments.item (counter_2).type.name
--
--					counter_2 := counter_2 + 1
--				end
--				if counter_2 /= 1 then
--					signature_feature := signature_feature + ")"
--				end

				create l_item
				l_item.set_text (signature.signature_member (array.item (counter)))
				l_item.set_data (array.item (counter))

				l_tri_list.put (l_item, counter)
				
				counter := counter + 1
			end
			
			from
				counter := 1
				create Result.make (l_tri_list.count)
				l_tri_list.sort
			until
				counter > l_tri_list.count
			loop
				Result.extend (l_tri_list.item (counter))
				counter := counter + 1
			end
		ensure
			non_void_result: Result /= Void
		end
	
	eiffel_constructors_list (array: ARRAY [CONSUMED_CONSTRUCTOR]): ARRAYED_LIST [EV_LIST_ITEM] is
			-- return classified list of constructors.
		require
			non_void_array: array /= Void
		local
			counter: INTEGER
			l_item: EV_LIST_ITEM_COMPARABLE
			l_tri_list:  SORTABLE_ARRAY [EV_LIST_ITEM_COMPARABLE]
		do
			from 
				counter := 1
				create l_tri_list.make (1, array.count)
			until
				counter > array.count
			loop
				create l_item
				l_item.set_text (array.item (counter).eiffel_name)
				l_item.set_data (array.item (counter))

				l_tri_list.put (l_item, counter)
				
				counter := counter + 1
			end
			
			from
				counter := 1
				create Result.make (l_tri_list.count)
				l_tri_list.sort
			until
				counter > l_tri_list.count
			loop
				Result.extend (l_tri_list.item (counter))
				counter := counter + 1
			end
		ensure
			non_void_result: Result /= Void
		end
	
	eiffel_features_list (array: ARRAY [CONSUMED_MEMBER]): ARRAYED_LIST [EV_LIST_ITEM] is
			-- return classified list of features contained in `array'.
		require
			non_void_array: array /= Void
		local
			counter: INTEGER
			l_item: EV_LIST_ITEM_COMPARABLE
			l_tri_list:  SORTABLE_ARRAY [EV_LIST_ITEM_COMPARABLE]
		do
			from 
				counter := 1
				create l_tri_list.make (1, array.count)
			until
				counter > array.count
			loop
				create l_item
				l_item.set_text (array.item (counter).eiffel_name)
				l_item.set_data (array.item (counter))

				l_tri_list.put (l_item, counter)
				
				counter := counter + 1
			end
			
			from
				counter := 1
				create Result.make (l_tri_list.count)
				l_tri_list.sort
			until
				counter > l_tri_list.count
			loop
				Result.extend (l_tri_list.item (counter))
				counter := counter + 1
			end
		ensure
			non_void_result: Result /= Void
		end
	
	on_change_select_dotnet_feature is
			-- Called by `select_actions' of `dotnet_features_combo'.
		do
		end
	
	on_change_dotnet_feature is
			-- Called by `change_actions' of `dotnet_features_combo'.
		do
			new_eiffel_feature_name.set_text (eiffel_features_combo.text)
--			(create {EV_ENVIRONMENT}).application
		end
	
	on_change_select_eiffel_feature is
			-- Called by `select_actions' of `eiffel_features_combo'.
		do
		end
	
	on_change_eiffel_feature is
			-- Called by `change_actions' of `eiffel_features_combo'.
		local
			signature_feature: STRING
			l_constructor_feature: CONSUMED_CONSTRUCTOR
			l_feature: CONSUMED_MEMBER
			signature: SIGNATURE
		do
			l_feature ?= eiffel_features_combo.selected_item.data
			l_constructor_feature ?= eiffel_features_combo.selected_item.data
			
			create signature
			if l_feature /= Void then
				signature_feature := signature.signature_member (l_feature)
			else
				signature_feature := signature.signature_constructor (l_constructor_feature)
			end
			
			l_label_6.set_text (signature_feature)
			
			new_eiffel_feature_name.set_text (eiffel_features_combo.selected_item.text)
		end
	
	on_ok_btn is
			-- Called by `select_actions' of `ok_btn'.
		do
			destroy
		end
	
	on_cancel_btn is
			-- Called by `select_actions' of `cancel_btn'.
		do
			destroy
		end
	

end -- class CHANGE_EIFFEL_FEATURE_NAME_DIALOG
