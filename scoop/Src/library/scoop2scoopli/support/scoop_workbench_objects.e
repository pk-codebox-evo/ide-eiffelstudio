indexing
	description: "Summary description for {SCOOP_WORKBENCH_OBJECTS}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	SCOOP_WORKBENCH_OBJECTS

create
	make

feature -- Initialization

	make
			-- Initialize the SCOOP workbench objects
		do
			create proxy_parent_objects.make
		end

feature -- Access

	reset is
			-- Resets classdependant values
		do
			current_class_as := Void
			current_class_c := Void
			current_feature_as := Void
			current_feature_object := Void
			proxy_parent_objects.wipe_out
		end

feature -- Current CLASS_C access

	current_class_c: CLASS_C
		-- Current processed class_c - access from shared scoop workbench

	set_current_class_c (a_class: CLASS_C) is
			-- Setter for 'current_class_c'
		do
			current_class_c := a_class
		end

feature -- Current CLASS_AS access

	current_class_as: CLASS_AS
		-- Current processed class_as - access from shared scoop workbench

	set_current_class_as (a_class: CLASS_AS) is
			-- Setter for 'current_class_as'
		do
			current_class_as := a_class
		end

feature -- Current FEATURE_AS access

	current_feature_as: FEATURE_AS
		-- Current processed feature_as

	set_current_feature_as (a_feature: FEATURE_AS) is
			-- Setter for 'current_feature_as'
		do
			current_feature_as := a_feature
		end

feature -- SCOOP_SEPARATE_CLASS_LIST access

	scoop_classes: SCOOP_SEPARATE_CLASS_LIST
			-- contains all classes which have to be processed.

	set_scoop_classes (a_list: SCOOP_SEPARATE_CLASS_LIST) is
			-- Setter for 'scoop_class_list'
		do
			scoop_classes := a_list
		end

feature -- SCOOP_CLIENT_FEATURE_OBJECT access

	current_feature_object: SCOOP_CLIENT_FEATURE_OBJECT
			-- Reference to current feature object

	set_current_feature_object (a_feature_object: SCOOP_CLIENT_FEATURE_OBJECT) IS
			-- Setter for `current_feature_object'.
		do
			current_feature_object := a_feature_object
		end

feature -- SCOOP_CLIENT_FEATURE_OBJECT access

	add_proxy_parent_object (a_proxy_parent_object: SCOOP_PROXY_PARENT_OBJECT) is
			-- Adds `a_proxy_parent_object' to the `proxy_parent_objects'.
		require
			a_proxy_parent_object_not_void: a_proxy_parent_object /= Void
		do
			if not has_proxy_parent_object (a_proxy_parent_object.parent_name) then
				proxy_parent_objects.extend (a_proxy_parent_object)
			end
		end

	get_proxy_parent_object (a_parent_name: STRING): SCOOP_PROXY_PARENT_OBJECT is
			-- Get the proxy parent object with name `a_parent_name'.
		require
			a_parent_name_not_void: a_parent_name /= Void
		local
			i, nb: INTEGER
		do
			from
				i := 1
				nb := proxy_parent_objects.count
			until
				i > nb
			loop
				if proxy_parent_objects.i_th (i).parent_name.is_equal (a_parent_name) then
					Result := proxy_parent_objects.i_th (i)
				end
				i := i + 1
			end
		end

	has_proxy_parent_object (a_parent_name: STRING): BOOLEAN is
			-- Returns true if there is already a parent object
			-- with name `a_parent_name' in the list
		require
			a_parent_name_not_void: a_parent_name /=  Void
		local
			i, nb: INTEGER
		do
			from
				i := 1
				nb := proxy_parent_objects.count
			until
				i > nb
			loop
				if proxy_parent_objects.i_th (i).parent_name.is_equal (a_parent_name) then
					Result := True
				end
				i := i + 1
			end
		end

feature {NONE} -- SCOOP_CLIENT_FEATURE_OBJECT implementation

	proxy_parent_objects: LINKED_LIST[SCOOP_PROXY_PARENT_OBJECT]
			-- List of proxy parent objects

invariant
	proxy_parent_objects_not_void: proxy_parent_objects /= Void

end
