indexing
	description: "Summary description for {SCOOP_WORKBENCH}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	SCOOP_WORKBENCH

feature -- current feature

	current_feature_as: FEATURE_AS
		-- Current processed feature_as

feature -- Current class

	current_class_c: CLASS_C
		-- Current processed class_c - access from shared scoop workbench

	current_class_as: CLASS_AS
		-- Current processed class_as - access from shared scoop workbench

feature -- Access

	set_scoop_classes (a_list: SCOOP_SEPARATE_CLASS_LIST) is
			-- Setter for 'scoop_class_list'
		do
			scoop_classes := a_list
		end

	set_current_class_c (a_class: CLASS_C) is
			-- Setter for 'current_class_c'
		do
			current_class_c := a_class
		end

	set_current_class_as (a_class: CLASS_AS) is
			-- Setter for 'current_class_as'
		do
			current_class_as := a_class
		end

	set_current_feature_as (a_feature: FEATURE_AS) is
			-- Setter for 'current_feature_as'
		do
			current_feature_as := a_feature
		end

feature -- Current SCOOP class list

	scoop_classes: SCOOP_SEPARATE_CLASS_LIST
			-- contains all classes which have to be processed.

end
