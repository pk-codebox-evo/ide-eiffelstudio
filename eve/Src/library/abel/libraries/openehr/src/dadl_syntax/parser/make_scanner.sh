# 
#	component:   "openEHR Reusable Libraries"
#	description: "ADL scanner builder script"
#	keywords:    "ADL, scanner"
#
#	author:      "Thomas Beale"
#	support:     "Ocean Informatics <support@OceanInformatics.biz>"
#	copyright:   "Copyright (c) 2000-2005 Ocean Informatics <http://OceanInformatics.biz>"
#	license:     "See notice at bottom of class"
#
#	file:        "$URL: https://svn.origo.ethz.ch/abel/trunk/libraries/openehr/src/dadl_syntax/parser/make_scanner.sh $"
#	revision:    "$LastChangedRevision$"
#	last_change: "$LastChangedDate$"
#

$GOBO/bin/gelex dadl_scanner.l
