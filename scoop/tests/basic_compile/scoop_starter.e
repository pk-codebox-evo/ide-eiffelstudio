class SCOOP_STARTER

inherit
  SCOOP_STARTER_IMP
    redefine
      root_object,
      execute
    end

create
  make

feature
  execute (a_root_object: like root_object)
    do
      io.put_string ("%N")
      a_root_object.effective_make_scoop_separate_application
    end
    
    root_object: SCOOP_SEPARATE__APPLICATION

end
