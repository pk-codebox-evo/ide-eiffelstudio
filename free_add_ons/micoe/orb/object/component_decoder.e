indexing

description: "Still to be entered";
keywords: "Still to be entered";
status: "See notice at end of class";
date: "$Date$";
revision: "$Revision$"

deferred class COMPONENT_DECODER

inherit
    IOR_STATICS

feature -- Initialization

    make is

        do
            register_comp_decoder (current)
        end
----------------------
feature -- Destruction

    destroy is

        do
            unregister_comp_decoder (current)
        end
----------------------
feature -- Decoding

    decode (dc : DATA_DECODER;


            component_id, len : INTEGER) : CORBA_COMPONENT is

        deferred
        end
-----------------------------------------------------------

    has_id (component_id : INTEGER) : BOOLEAN is

        deferred
        end

end -- class COMPONENT_DECODER

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
