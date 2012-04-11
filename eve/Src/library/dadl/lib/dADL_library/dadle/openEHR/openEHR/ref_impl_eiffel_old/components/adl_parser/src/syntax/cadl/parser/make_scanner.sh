#!/bin/sh
#	component:   "Deep Thought Reusable Libraries"
#	description: "ADL scanner builder script"
#	keywords:    "ADL, scanner"
#
#	author:      "Thomas Beale"
#	support:     "Ocean Informatics <support@OceanInformatics.biz>"
#	copyright:   "Copyright (c) 2000-2004 The openEHR Foundation <http://www.openEHR.org>"
#	license:     "See notice at bottom of class"
#
#	file:        "$URL: http://www.openehr.org/svn/ref_impl_eiffel/TRUNK/components/adl_parser/src/syntax/cadl/parser/make_scanner.sh $"
#	revision:    "$LastChangedRevision$"
#	last_change: "$LastChangedDate$"
#

$GOBO/bin/gelex cadl_scanner.l
