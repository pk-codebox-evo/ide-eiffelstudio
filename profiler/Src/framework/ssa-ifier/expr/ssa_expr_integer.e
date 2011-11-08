note
  description: "Summary description for {SSA_EXPR_INTEGER}."
  author: ""
  date: "$Date$"
  revision: "$Revision$"

class
  SSA_EXPR_INTEGER

inherit
  SSA_EXPR

create
  make

feature
  make (a_int: INTEGER)
    do
      integer := a_int
    end

  integer: INTEGER

  goal_string (var_prefix: STRING): STRING
    do
      Result := integer.out
    end
  
  as_code: STRING
    do
      Result := integer.out
    end

  all_pre_conditions: ARRAYED_LIST [SSA_EXPR]
    do
      create Result.make (10)
    end
end
