indexing

description: "Still to be entered";
keywords: "Still to be entered";
status: "See notice at end of class";
date: "$Date$";
revision: "$Revision$"

class CONN_INTERCEPTOR

inherit
    ROOT
        redefine
            activate, deactivate, repoid
        end

feature

    repoid : STRING is

        do
            result := "IDL:omg.org/Interceptor/ConnInterceptor:1.0"
        end
------------------------------------

    client_connect (addr : STRING) : INTEGER is

        do
            result := Invoke_continue
        end
------------------------------------

    client_disconnect (addr : STRING) : INTEGER is

        do
            result := Invoke_continue
        end
------------------------------------

    activate (p : INTEGER) is

        do
            precursor (p)
            conn_ics.add (current)
        end
------------------------------------

   deactivate is

        do
            precursor
            conn_ics.remove (current)
        end

end -- class CONN_INTERCEPTOR

------------------------------------------------------------------------
--                                                                    --
--  MICO/E --- a free CORBA implementation                            --
--  Copyright (C) 1999 by Robert Switzer                              --
--                                                                    --
--  This library is free software; you can redistribute it and/or     --
--  modify it under the terms of the GNU Library General Public       --
--  License as published by the Free Software Foundation; either      --
--  version 2 of the License, or (at your option) any later version.  --
--                                                                    --
--  This library is distributed in the hope that it will be useful,   --
--  but WITHOUT ANY WARRANTY; without even the implied warranty of    --
--  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU --
--  Library General Public License for more details.                  --
--                                                                    --
--  You should have received a copy of the GNU Library General Public --
--  License along with this library; if not, write to the Free        --
--  Software Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.--
--                                                                    --
--  Send comments and/or bug reports to:                              --
--                 micoe@math.uni-goettingen.de                       --
--                                                                    --
------------------------------------------------------------------------
