/*-----------------------------------------------------------
Writer for generated Eiffel to C mappers class
-----------------------------------------------------------*/

#ifndef __ECOM_GEC_ISE_H__
#define __ECOM_GEC_ISE_H__
#ifdef __cplusplus
extern "C" {


class ecom_gec_ISE;

}
#endif

#include "eif_com.h"

#include "eif_eiffel.h"

#include "ecom_rt_globals.h"

#include "ecom_eiffel_compiler_IEiffelCompiler_s.h"

#include "ecom_eiffel_compiler_IEiffelSystemBrowser_s.h"

#include "ecom_eiffel_compiler_IEiffelProjectProperties_s.h"

#include "ecom_eiffel_compiler_IEiffelCompletionInfo_s.h"

#include "ecom_eiffel_compiler_IEiffelHTMLDocGenerator_s.h"

#include "ecom_eiffel_compiler_IEnumEiffelClass_s.h"

#include "ecom_eiffel_compiler_IEnumCluster_s.h"

#include "ecom_eiffel_compiler_IEnumAssembly_s.h"

#include "ecom_eiffel_compiler_IEiffelClusterDescriptor_s.h"

#include "ecom_eiffel_compiler_IEiffelClassDescriptor_s.h"

#include "ecom_eiffel_compiler_IEiffelFeatureDescriptor_s.h"

#include "ecom_eiffel_compiler_IEnumFeature_s.h"

#include "ecom_eiffel_compiler_IEnumParameter_s.h"

#include "ecom_eiffel_compiler_IEiffelParameterDescriptor_s.h"

#include "ecom_eiffel_compiler_IEiffelAssemblyProperties_s.h"

#include "ecom_eiffel_compiler_IEiffelSystemClusters_s.h"

#include "ecom_eiffel_compiler_IEiffelSystemExternals_s.h"

#include "ecom_eiffel_compiler_IEiffelSystemAssemblies_s.h"

#include "ecom_eiffel_compiler_IEnumClusterProp_s.h"

#include "ecom_eiffel_compiler_IEiffelClusterProperties_s.h"

#include "ecom_eiffel_compiler_IEnumClusterExcludes_s.h"

#include "ecom_eiffel_compiler_IEnumIncludePaths_s.h"

#include "ecom_eiffel_compiler_IEnumObjectFiles_s.h"

#include "ecom_eiffel_compiler_IEiffelHTMLDocEvents_s.h"

#ifdef __cplusplus
extern "C" {
#endif

#ifdef __cplusplus
extern "C" {
class ecom_gec_ISE
{
public:
	ecom_gec_ISE ();
	virtual ~ecom_gec_ISE () {};

	/*-----------------------------------------------------------
	Convert CELL [STRING] to BSTR *.
	-----------------------------------------------------------*/
	BSTR * ccom_ec_pointed_cell_1( EIF_REFERENCE eif_ref, BSTR * old );


	/*-----------------------------------------------------------
	Convert CELL [STRING] to BSTR *.
	-----------------------------------------------------------*/
	BSTR * ccom_ec_pointed_cell_2( EIF_REFERENCE eif_ref, BSTR * old );


	/*-----------------------------------------------------------
	Convert CELL [STRING] to BSTR *.
	-----------------------------------------------------------*/
	BSTR * ccom_ec_pointed_cell_3( EIF_REFERENCE eif_ref, BSTR * old );


	/*-----------------------------------------------------------
	Convert CELL [STRING] to BSTR *.
	-----------------------------------------------------------*/
	BSTR * ccom_ec_pointed_cell_5( EIF_REFERENCE eif_ref, BSTR * old );


	/*-----------------------------------------------------------
	Convert IEIFFEL_COMPILER_INTERFACE to ecom_eiffel_compiler::IEiffelCompiler *.
	-----------------------------------------------------------*/
	ecom_eiffel_compiler::IEiffelCompiler * ccom_ec_pointed_interface_7( EIF_REFERENCE eif_ref );


	/*-----------------------------------------------------------
	Convert CELL [IEIFFEL_COMPILER_INTERFACE] to ecom_eiffel_compiler::IEiffelCompiler * *.
	-----------------------------------------------------------*/
	ecom_eiffel_compiler::IEiffelCompiler * * ccom_ec_pointed_cell_8( EIF_REFERENCE eif_ref, ecom_eiffel_compiler::IEiffelCompiler * * old );


	/*-----------------------------------------------------------
	Convert IEIFFEL_SYSTEM_BROWSER_INTERFACE to ecom_eiffel_compiler::IEiffelSystemBrowser *.
	-----------------------------------------------------------*/
	ecom_eiffel_compiler::IEiffelSystemBrowser * ccom_ec_pointed_interface_12( EIF_REFERENCE eif_ref );


	/*-----------------------------------------------------------
	Convert CELL [IEIFFEL_SYSTEM_BROWSER_INTERFACE] to ecom_eiffel_compiler::IEiffelSystemBrowser * *.
	-----------------------------------------------------------*/
	ecom_eiffel_compiler::IEiffelSystemBrowser * * ccom_ec_pointed_cell_13( EIF_REFERENCE eif_ref, ecom_eiffel_compiler::IEiffelSystemBrowser * * old );


	/*-----------------------------------------------------------
	Convert IEIFFEL_PROJECT_PROPERTIES_INTERFACE to ecom_eiffel_compiler::IEiffelProjectProperties *.
	-----------------------------------------------------------*/
	ecom_eiffel_compiler::IEiffelProjectProperties * ccom_ec_pointed_interface_15( EIF_REFERENCE eif_ref );


	/*-----------------------------------------------------------
	Convert CELL [IEIFFEL_PROJECT_PROPERTIES_INTERFACE] to ecom_eiffel_compiler::IEiffelProjectProperties * *.
	-----------------------------------------------------------*/
	ecom_eiffel_compiler::IEiffelProjectProperties * * ccom_ec_pointed_cell_16( EIF_REFERENCE eif_ref, ecom_eiffel_compiler::IEiffelProjectProperties * * old );


	/*-----------------------------------------------------------
	Convert IEIFFEL_COMPLETION_INFO_INTERFACE to ecom_eiffel_compiler::IEiffelCompletionInfo *.
	-----------------------------------------------------------*/
	ecom_eiffel_compiler::IEiffelCompletionInfo * ccom_ec_pointed_interface_18( EIF_REFERENCE eif_ref );


	/*-----------------------------------------------------------
	Convert CELL [IEIFFEL_COMPLETION_INFO_INTERFACE] to ecom_eiffel_compiler::IEiffelCompletionInfo * *.
	-----------------------------------------------------------*/
	ecom_eiffel_compiler::IEiffelCompletionInfo * * ccom_ec_pointed_cell_19( EIF_REFERENCE eif_ref, ecom_eiffel_compiler::IEiffelCompletionInfo * * old );


	/*-----------------------------------------------------------
	Convert IEIFFEL_HTMLDOC_GENERATOR_INTERFACE to ecom_eiffel_compiler::IEiffelHTMLDocGenerator *.
	-----------------------------------------------------------*/
	ecom_eiffel_compiler::IEiffelHTMLDocGenerator * ccom_ec_pointed_interface_21( EIF_REFERENCE eif_ref );


	/*-----------------------------------------------------------
	Convert CELL [IEIFFEL_HTMLDOC_GENERATOR_INTERFACE] to ecom_eiffel_compiler::IEiffelHTMLDocGenerator * *.
	-----------------------------------------------------------*/
	ecom_eiffel_compiler::IEiffelHTMLDocGenerator * * ccom_ec_pointed_cell_22( EIF_REFERENCE eif_ref, ecom_eiffel_compiler::IEiffelHTMLDocGenerator * * old );


	/*-----------------------------------------------------------
	Convert CELL [STRING] to BSTR *.
	-----------------------------------------------------------*/
	BSTR * ccom_ec_pointed_cell_25( EIF_REFERENCE eif_ref, BSTR * old );


	/*-----------------------------------------------------------
	Convert CELL [STRING] to BSTR *.
	-----------------------------------------------------------*/
	BSTR * ccom_ec_pointed_cell_26( EIF_REFERENCE eif_ref, BSTR * old );


	/*-----------------------------------------------------------
	Convert CELL [STRING] to BSTR *.
	-----------------------------------------------------------*/
	BSTR * ccom_ec_pointed_cell_27( EIF_REFERENCE eif_ref, BSTR * old );


	/*-----------------------------------------------------------
	Convert CELL [STRING] to BSTR *.
	-----------------------------------------------------------*/
	BSTR * ccom_ec_pointed_cell_28( EIF_REFERENCE eif_ref, BSTR * old );


	/*-----------------------------------------------------------
	Convert CELL [STRING] to BSTR *.
	-----------------------------------------------------------*/
	BSTR * ccom_ec_pointed_cell_30( EIF_REFERENCE eif_ref, BSTR * old );


	/*-----------------------------------------------------------
	Convert IENUM_EIFFEL_CLASS_INTERFACE to ecom_eiffel_compiler::IEnumEiffelClass *.
	-----------------------------------------------------------*/
	ecom_eiffel_compiler::IEnumEiffelClass * ccom_ec_pointed_interface_34( EIF_REFERENCE eif_ref );


	/*-----------------------------------------------------------
	Convert CELL [IENUM_EIFFEL_CLASS_INTERFACE] to ecom_eiffel_compiler::IEnumEiffelClass * *.
	-----------------------------------------------------------*/
	ecom_eiffel_compiler::IEnumEiffelClass * * ccom_ec_pointed_cell_35( EIF_REFERENCE eif_ref, ecom_eiffel_compiler::IEnumEiffelClass * * old );


	/*-----------------------------------------------------------
	Convert IENUM_CLUSTER_INTERFACE to ecom_eiffel_compiler::IEnumCluster *.
	-----------------------------------------------------------*/
	ecom_eiffel_compiler::IEnumCluster * ccom_ec_pointed_interface_38( EIF_REFERENCE eif_ref );


	/*-----------------------------------------------------------
	Convert CELL [IENUM_CLUSTER_INTERFACE] to ecom_eiffel_compiler::IEnumCluster * *.
	-----------------------------------------------------------*/
	ecom_eiffel_compiler::IEnumCluster * * ccom_ec_pointed_cell_39( EIF_REFERENCE eif_ref, ecom_eiffel_compiler::IEnumCluster * * old );


	/*-----------------------------------------------------------
	Convert IENUM_ASSEMBLY_INTERFACE to ecom_eiffel_compiler::IEnumAssembly *.
	-----------------------------------------------------------*/
	ecom_eiffel_compiler::IEnumAssembly * ccom_ec_pointed_interface_41( EIF_REFERENCE eif_ref );


	/*-----------------------------------------------------------
	Convert CELL [IENUM_ASSEMBLY_INTERFACE] to ecom_eiffel_compiler::IEnumAssembly * *.
	-----------------------------------------------------------*/
	ecom_eiffel_compiler::IEnumAssembly * * ccom_ec_pointed_cell_42( EIF_REFERENCE eif_ref, ecom_eiffel_compiler::IEnumAssembly * * old );


	/*-----------------------------------------------------------
	Convert IEIFFEL_CLUSTER_DESCRIPTOR_INTERFACE to ecom_eiffel_compiler::IEiffelClusterDescriptor *.
	-----------------------------------------------------------*/
	ecom_eiffel_compiler::IEiffelClusterDescriptor * ccom_ec_pointed_interface_45( EIF_REFERENCE eif_ref );


	/*-----------------------------------------------------------
	Convert CELL [IEIFFEL_CLUSTER_DESCRIPTOR_INTERFACE] to ecom_eiffel_compiler::IEiffelClusterDescriptor * *.
	-----------------------------------------------------------*/
	ecom_eiffel_compiler::IEiffelClusterDescriptor * * ccom_ec_pointed_cell_46( EIF_REFERENCE eif_ref, ecom_eiffel_compiler::IEiffelClusterDescriptor * * old );


	/*-----------------------------------------------------------
	Convert IEIFFEL_CLASS_DESCRIPTOR_INTERFACE to ecom_eiffel_compiler::IEiffelClassDescriptor *.
	-----------------------------------------------------------*/
	ecom_eiffel_compiler::IEiffelClassDescriptor * ccom_ec_pointed_interface_48( EIF_REFERENCE eif_ref );


	/*-----------------------------------------------------------
	Convert CELL [IEIFFEL_CLASS_DESCRIPTOR_INTERFACE] to ecom_eiffel_compiler::IEiffelClassDescriptor * *.
	-----------------------------------------------------------*/
	ecom_eiffel_compiler::IEiffelClassDescriptor * * ccom_ec_pointed_cell_49( EIF_REFERENCE eif_ref, ecom_eiffel_compiler::IEiffelClassDescriptor * * old );


	/*-----------------------------------------------------------
	Convert IEIFFEL_FEATURE_DESCRIPTOR_INTERFACE to ecom_eiffel_compiler::IEiffelFeatureDescriptor *.
	-----------------------------------------------------------*/
	ecom_eiffel_compiler::IEiffelFeatureDescriptor * ccom_ec_pointed_interface_51( EIF_REFERENCE eif_ref );


	/*-----------------------------------------------------------
	Convert CELL [IEIFFEL_FEATURE_DESCRIPTOR_INTERFACE] to ecom_eiffel_compiler::IEiffelFeatureDescriptor * *.
	-----------------------------------------------------------*/
	ecom_eiffel_compiler::IEiffelFeatureDescriptor * * ccom_ec_pointed_cell_52( EIF_REFERENCE eif_ref, ecom_eiffel_compiler::IEiffelFeatureDescriptor * * old );


	/*-----------------------------------------------------------
	Convert IENUM_FEATURE_INTERFACE to ecom_eiffel_compiler::IEnumFeature *.
	-----------------------------------------------------------*/
	ecom_eiffel_compiler::IEnumFeature * ccom_ec_pointed_interface_54( EIF_REFERENCE eif_ref );


	/*-----------------------------------------------------------
	Convert CELL [IENUM_FEATURE_INTERFACE] to ecom_eiffel_compiler::IEnumFeature * *.
	-----------------------------------------------------------*/
	ecom_eiffel_compiler::IEnumFeature * * ccom_ec_pointed_cell_55( EIF_REFERENCE eif_ref, ecom_eiffel_compiler::IEnumFeature * * old );


	/*-----------------------------------------------------------
	Convert CELL [STRING] to BSTR *.
	-----------------------------------------------------------*/
	BSTR * ccom_ec_pointed_cell_56( EIF_REFERENCE eif_ref, BSTR * old );


	/*-----------------------------------------------------------
	Convert CELL [STRING] to BSTR *.
	-----------------------------------------------------------*/
	BSTR * ccom_ec_pointed_cell_57( EIF_REFERENCE eif_ref, BSTR * old );


	/*-----------------------------------------------------------
	Convert CELL [STRING] to BSTR *.
	-----------------------------------------------------------*/
	BSTR * ccom_ec_pointed_cell_60( EIF_REFERENCE eif_ref, BSTR * old );


	/*-----------------------------------------------------------
	Convert CELL [STRING] to BSTR *.
	-----------------------------------------------------------*/
	BSTR * ccom_ec_pointed_cell_61( EIF_REFERENCE eif_ref, BSTR * old );


	/*-----------------------------------------------------------
	Convert CELL [STRING] to BSTR *.
	-----------------------------------------------------------*/
	BSTR * ccom_ec_pointed_cell_62( EIF_REFERENCE eif_ref, BSTR * old );


	/*-----------------------------------------------------------
	Convert CELL [STRING] to BSTR *.
	-----------------------------------------------------------*/
	BSTR * ccom_ec_pointed_cell_63( EIF_REFERENCE eif_ref, BSTR * old );


	/*-----------------------------------------------------------
	Convert CELL [ECOM_ARRAY [STRING]] to SAFEARRAY *  *.
	-----------------------------------------------------------*/
	SAFEARRAY *  * ccom_ec_pointed_cell_66( EIF_REFERENCE eif_ref, SAFEARRAY *  * old );


	/*-----------------------------------------------------------
	Convert CELL [STRING] to BSTR *.
	-----------------------------------------------------------*/
	BSTR * ccom_ec_pointed_cell_75( EIF_REFERENCE eif_ref, BSTR * old );


	/*-----------------------------------------------------------
	Convert CELL [STRING] to BSTR *.
	-----------------------------------------------------------*/
	BSTR * ccom_ec_pointed_cell_82( EIF_REFERENCE eif_ref, BSTR * old );


	/*-----------------------------------------------------------
	Convert CELL [STRING] to BSTR *.
	-----------------------------------------------------------*/
	BSTR * ccom_ec_pointed_cell_83( EIF_REFERENCE eif_ref, BSTR * old );


	/*-----------------------------------------------------------
	Convert CELL [STRING] to BSTR *.
	-----------------------------------------------------------*/
	BSTR * ccom_ec_pointed_cell_84( EIF_REFERENCE eif_ref, BSTR * old );


	/*-----------------------------------------------------------
	Convert CELL [STRING] to BSTR *.
	-----------------------------------------------------------*/
	BSTR * ccom_ec_pointed_cell_85( EIF_REFERENCE eif_ref, BSTR * old );


	/*-----------------------------------------------------------
	Convert CELL [STRING] to BSTR *.
	-----------------------------------------------------------*/
	BSTR * ccom_ec_pointed_cell_86( EIF_REFERENCE eif_ref, BSTR * old );


	/*-----------------------------------------------------------
	Convert CELL [STRING] to BSTR *.
	-----------------------------------------------------------*/
	BSTR * ccom_ec_pointed_cell_87( EIF_REFERENCE eif_ref, BSTR * old );


	/*-----------------------------------------------------------
	Convert IENUM_PARAMETER_INTERFACE to ecom_eiffel_compiler::IEnumParameter *.
	-----------------------------------------------------------*/
	ecom_eiffel_compiler::IEnumParameter * ccom_ec_pointed_interface_89( EIF_REFERENCE eif_ref );


	/*-----------------------------------------------------------
	Convert CELL [IENUM_PARAMETER_INTERFACE] to ecom_eiffel_compiler::IEnumParameter * *.
	-----------------------------------------------------------*/
	ecom_eiffel_compiler::IEnumParameter * * ccom_ec_pointed_cell_90( EIF_REFERENCE eif_ref, ecom_eiffel_compiler::IEnumParameter * * old );


	/*-----------------------------------------------------------
	Convert CELL [STRING] to BSTR *.
	-----------------------------------------------------------*/
	BSTR * ccom_ec_pointed_cell_91( EIF_REFERENCE eif_ref, BSTR * old );


	/*-----------------------------------------------------------
	Convert CELL [STRING] to BSTR *.
	-----------------------------------------------------------*/
	BSTR * ccom_ec_pointed_cell_92( EIF_REFERENCE eif_ref, BSTR * old );


	/*-----------------------------------------------------------
	Convert IEIFFEL_PARAMETER_DESCRIPTOR_INTERFACE to ecom_eiffel_compiler::IEiffelParameterDescriptor *.
	-----------------------------------------------------------*/
	ecom_eiffel_compiler::IEiffelParameterDescriptor * ccom_ec_pointed_interface_116( EIF_REFERENCE eif_ref );


	/*-----------------------------------------------------------
	Convert CELL [IEIFFEL_PARAMETER_DESCRIPTOR_INTERFACE] to ecom_eiffel_compiler::IEiffelParameterDescriptor * *.
	-----------------------------------------------------------*/
	ecom_eiffel_compiler::IEiffelParameterDescriptor * * ccom_ec_pointed_cell_117( EIF_REFERENCE eif_ref, ecom_eiffel_compiler::IEiffelParameterDescriptor * * old );


	/*-----------------------------------------------------------
	Convert CELL [STRING] to BSTR *.
	-----------------------------------------------------------*/
	BSTR * ccom_ec_pointed_cell_120( EIF_REFERENCE eif_ref, BSTR * old );


	/*-----------------------------------------------------------
	Convert CELL [STRING] to BSTR *.
	-----------------------------------------------------------*/
	BSTR * ccom_ec_pointed_cell_121( EIF_REFERENCE eif_ref, BSTR * old );


	/*-----------------------------------------------------------
	Convert CELL [STRING] to BSTR *.
	-----------------------------------------------------------*/
	BSTR * ccom_ec_pointed_cell_124( EIF_REFERENCE eif_ref, BSTR * old );


	/*-----------------------------------------------------------
	Convert CELL [STRING] to BSTR *.
	-----------------------------------------------------------*/
	BSTR * ccom_ec_pointed_cell_125( EIF_REFERENCE eif_ref, BSTR * old );


	/*-----------------------------------------------------------
	Convert CELL [STRING] to BSTR *.
	-----------------------------------------------------------*/
	BSTR * ccom_ec_pointed_cell_126( EIF_REFERENCE eif_ref, BSTR * old );


	/*-----------------------------------------------------------
	Convert CELL [STRING] to BSTR *.
	-----------------------------------------------------------*/
	BSTR * ccom_ec_pointed_cell_129( EIF_REFERENCE eif_ref, BSTR * old );


	/*-----------------------------------------------------------
	Convert CELL [STRING] to BSTR *.
	-----------------------------------------------------------*/
	BSTR * ccom_ec_pointed_cell_130( EIF_REFERENCE eif_ref, BSTR * old );


	/*-----------------------------------------------------------
	Convert IEIFFEL_ASSEMBLY_PROPERTIES_INTERFACE to ecom_eiffel_compiler::IEiffelAssemblyProperties *.
	-----------------------------------------------------------*/
	ecom_eiffel_compiler::IEiffelAssemblyProperties * ccom_ec_pointed_interface_134( EIF_REFERENCE eif_ref );


	/*-----------------------------------------------------------
	Convert CELL [IEIFFEL_ASSEMBLY_PROPERTIES_INTERFACE] to ecom_eiffel_compiler::IEiffelAssemblyProperties * *.
	-----------------------------------------------------------*/
	ecom_eiffel_compiler::IEiffelAssemblyProperties * * ccom_ec_pointed_cell_135( EIF_REFERENCE eif_ref, ecom_eiffel_compiler::IEiffelAssemblyProperties * * old );


	/*-----------------------------------------------------------
	Convert CELL [STRING] to BSTR *.
	-----------------------------------------------------------*/
	BSTR * ccom_ec_pointed_cell_138( EIF_REFERENCE eif_ref, BSTR * old );


	/*-----------------------------------------------------------
	Convert CELL [STRING] to BSTR *.
	-----------------------------------------------------------*/
	BSTR * ccom_ec_pointed_cell_139( EIF_REFERENCE eif_ref, BSTR * old );


	/*-----------------------------------------------------------
	Convert CELL [STRING] to BSTR *.
	-----------------------------------------------------------*/
	BSTR * ccom_ec_pointed_cell_140( EIF_REFERENCE eif_ref, BSTR * old );


	/*-----------------------------------------------------------
	Convert CELL [STRING] to BSTR *.
	-----------------------------------------------------------*/
	BSTR * ccom_ec_pointed_cell_141( EIF_REFERENCE eif_ref, BSTR * old );


	/*-----------------------------------------------------------
	Convert CELL [STRING] to BSTR *.
	-----------------------------------------------------------*/
	BSTR * ccom_ec_pointed_cell_143( EIF_REFERENCE eif_ref, BSTR * old );


	/*-----------------------------------------------------------
	Convert CELL [STRING] to BSTR *.
	-----------------------------------------------------------*/
	BSTR * ccom_ec_pointed_cell_144( EIF_REFERENCE eif_ref, BSTR * old );


	/*-----------------------------------------------------------
	Convert CELL [STRING] to BSTR *.
	-----------------------------------------------------------*/
	BSTR * ccom_ec_pointed_cell_146( EIF_REFERENCE eif_ref, BSTR * old );


	/*-----------------------------------------------------------
	Convert CELL [STRING] to BSTR *.
	-----------------------------------------------------------*/
	BSTR * ccom_ec_pointed_cell_147( EIF_REFERENCE eif_ref, BSTR * old );


	/*-----------------------------------------------------------
	Convert CELL [STRING] to BSTR *.
	-----------------------------------------------------------*/
	BSTR * ccom_ec_pointed_cell_148( EIF_REFERENCE eif_ref, BSTR * old );


	/*-----------------------------------------------------------
	Convert IEIFFEL_SYSTEM_CLUSTERS_INTERFACE to ecom_eiffel_compiler::IEiffelSystemClusters *.
	-----------------------------------------------------------*/
	ecom_eiffel_compiler::IEiffelSystemClusters * ccom_ec_pointed_interface_159( EIF_REFERENCE eif_ref );


	/*-----------------------------------------------------------
	Convert CELL [IEIFFEL_SYSTEM_CLUSTERS_INTERFACE] to ecom_eiffel_compiler::IEiffelSystemClusters * *.
	-----------------------------------------------------------*/
	ecom_eiffel_compiler::IEiffelSystemClusters * * ccom_ec_pointed_cell_160( EIF_REFERENCE eif_ref, ecom_eiffel_compiler::IEiffelSystemClusters * * old );


	/*-----------------------------------------------------------
	Convert IEIFFEL_SYSTEM_EXTERNALS_INTERFACE to ecom_eiffel_compiler::IEiffelSystemExternals *.
	-----------------------------------------------------------*/
	ecom_eiffel_compiler::IEiffelSystemExternals * ccom_ec_pointed_interface_162( EIF_REFERENCE eif_ref );


	/*-----------------------------------------------------------
	Convert CELL [IEIFFEL_SYSTEM_EXTERNALS_INTERFACE] to ecom_eiffel_compiler::IEiffelSystemExternals * *.
	-----------------------------------------------------------*/
	ecom_eiffel_compiler::IEiffelSystemExternals * * ccom_ec_pointed_cell_163( EIF_REFERENCE eif_ref, ecom_eiffel_compiler::IEiffelSystemExternals * * old );


	/*-----------------------------------------------------------
	Convert CELL [STRING] to BSTR *.
	-----------------------------------------------------------*/
	BSTR * ccom_ec_pointed_cell_164( EIF_REFERENCE eif_ref, BSTR * old );


	/*-----------------------------------------------------------
	Convert IEIFFEL_SYSTEM_ASSEMBLIES_INTERFACE to ecom_eiffel_compiler::IEiffelSystemAssemblies *.
	-----------------------------------------------------------*/
	ecom_eiffel_compiler::IEiffelSystemAssemblies * ccom_ec_pointed_interface_166( EIF_REFERENCE eif_ref );


	/*-----------------------------------------------------------
	Convert CELL [IEIFFEL_SYSTEM_ASSEMBLIES_INTERFACE] to ecom_eiffel_compiler::IEiffelSystemAssemblies * *.
	-----------------------------------------------------------*/
	ecom_eiffel_compiler::IEiffelSystemAssemblies * * ccom_ec_pointed_cell_167( EIF_REFERENCE eif_ref, ecom_eiffel_compiler::IEiffelSystemAssemblies * * old );


	/*-----------------------------------------------------------
	Convert CELL [STRING] to BSTR *.
	-----------------------------------------------------------*/
	BSTR * ccom_ec_pointed_cell_168( EIF_REFERENCE eif_ref, BSTR * old );


	/*-----------------------------------------------------------
	Convert CELL [STRING] to BSTR *.
	-----------------------------------------------------------*/
	BSTR * ccom_ec_pointed_cell_169( EIF_REFERENCE eif_ref, BSTR * old );


	/*-----------------------------------------------------------
	Convert CELL [STRING] to BSTR *.
	-----------------------------------------------------------*/
	BSTR * ccom_ec_pointed_cell_170( EIF_REFERENCE eif_ref, BSTR * old );


	/*-----------------------------------------------------------
	Convert CELL [STRING] to BSTR *.
	-----------------------------------------------------------*/
	BSTR * ccom_ec_pointed_cell_171( EIF_REFERENCE eif_ref, BSTR * old );


	/*-----------------------------------------------------------
	Convert CELL [STRING] to BSTR *.
	-----------------------------------------------------------*/
	BSTR * ccom_ec_pointed_cell_172( EIF_REFERENCE eif_ref, BSTR * old );


	/*-----------------------------------------------------------
	Convert CELL [STRING] to BSTR *.
	-----------------------------------------------------------*/
	BSTR * ccom_ec_pointed_cell_173( EIF_REFERENCE eif_ref, BSTR * old );


	/*-----------------------------------------------------------
	Convert CELL [STRING] to BSTR *.
	-----------------------------------------------------------*/
	BSTR * ccom_ec_pointed_cell_174( EIF_REFERENCE eif_ref, BSTR * old );


	/*-----------------------------------------------------------
	Convert CELL [STRING] to BSTR *.
	-----------------------------------------------------------*/
	BSTR * ccom_ec_pointed_cell_175( EIF_REFERENCE eif_ref, BSTR * old );


	/*-----------------------------------------------------------
	Convert CELL [STRING] to BSTR *.
	-----------------------------------------------------------*/
	BSTR * ccom_ec_pointed_cell_176( EIF_REFERENCE eif_ref, BSTR * old );


	/*-----------------------------------------------------------
	Convert CELL [STRING] to BSTR *.
	-----------------------------------------------------------*/
	BSTR * ccom_ec_pointed_cell_177( EIF_REFERENCE eif_ref, BSTR * old );


	/*-----------------------------------------------------------
	Convert IENUM_CLUSTER_PROP_INTERFACE to ecom_eiffel_compiler::IEnumClusterProp *.
	-----------------------------------------------------------*/
	ecom_eiffel_compiler::IEnumClusterProp * ccom_ec_pointed_interface_179( EIF_REFERENCE eif_ref );


	/*-----------------------------------------------------------
	Convert CELL [IENUM_CLUSTER_PROP_INTERFACE] to ecom_eiffel_compiler::IEnumClusterProp * *.
	-----------------------------------------------------------*/
	ecom_eiffel_compiler::IEnumClusterProp * * ccom_ec_pointed_cell_180( EIF_REFERENCE eif_ref, ecom_eiffel_compiler::IEnumClusterProp * * old );


	/*-----------------------------------------------------------
	Convert IEIFFEL_CLUSTER_PROPERTIES_INTERFACE to ecom_eiffel_compiler::IEiffelClusterProperties *.
	-----------------------------------------------------------*/
	ecom_eiffel_compiler::IEiffelClusterProperties * ccom_ec_pointed_interface_182( EIF_REFERENCE eif_ref );


	/*-----------------------------------------------------------
	Convert CELL [IEIFFEL_CLUSTER_PROPERTIES_INTERFACE] to ecom_eiffel_compiler::IEiffelClusterProperties * *.
	-----------------------------------------------------------*/
	ecom_eiffel_compiler::IEiffelClusterProperties * * ccom_ec_pointed_cell_183( EIF_REFERENCE eif_ref, ecom_eiffel_compiler::IEiffelClusterProperties * * old );


	/*-----------------------------------------------------------
	Convert CELL [STRING] to BSTR *.
	-----------------------------------------------------------*/
	BSTR * ccom_ec_pointed_cell_185( EIF_REFERENCE eif_ref, BSTR * old );


	/*-----------------------------------------------------------
	Convert CELL [STRING] to BSTR *.
	-----------------------------------------------------------*/
	BSTR * ccom_ec_pointed_cell_188( EIF_REFERENCE eif_ref, BSTR * old );


	/*-----------------------------------------------------------
	Convert CELL [STRING] to BSTR *.
	-----------------------------------------------------------*/
	BSTR * ccom_ec_pointed_cell_189( EIF_REFERENCE eif_ref, BSTR * old );


	/*-----------------------------------------------------------
	Convert IENUM_CLUSTER_EXCLUDES_INTERFACE to ecom_eiffel_compiler::IEnumClusterExcludes *.
	-----------------------------------------------------------*/
	ecom_eiffel_compiler::IEnumClusterExcludes * ccom_ec_pointed_interface_200( EIF_REFERENCE eif_ref );


	/*-----------------------------------------------------------
	Convert CELL [IENUM_CLUSTER_EXCLUDES_INTERFACE] to ecom_eiffel_compiler::IEnumClusterExcludes * *.
	-----------------------------------------------------------*/
	ecom_eiffel_compiler::IEnumClusterExcludes * * ccom_ec_pointed_cell_201( EIF_REFERENCE eif_ref, ecom_eiffel_compiler::IEnumClusterExcludes * * old );


	/*-----------------------------------------------------------
	Convert CELL [STRING] to BSTR *.
	-----------------------------------------------------------*/
	BSTR * ccom_ec_pointed_cell_202( EIF_REFERENCE eif_ref, BSTR * old );


	/*-----------------------------------------------------------
	Convert CELL [STRING] to BSTR *.
	-----------------------------------------------------------*/
	BSTR * ccom_ec_pointed_cell_207( EIF_REFERENCE eif_ref, BSTR * old );


	/*-----------------------------------------------------------
	Convert CELL [STRING] to BSTR *.
	-----------------------------------------------------------*/
	BSTR * ccom_ec_pointed_cell_208( EIF_REFERENCE eif_ref, BSTR * old );


	/*-----------------------------------------------------------
	Convert CELL [STRING] to BSTR *.
	-----------------------------------------------------------*/
	BSTR * ccom_ec_pointed_cell_209( EIF_REFERENCE eif_ref, BSTR * old );


	/*-----------------------------------------------------------
	Convert CELL [STRING] to BSTR *.
	-----------------------------------------------------------*/
	BSTR * ccom_ec_pointed_cell_211( EIF_REFERENCE eif_ref, BSTR * old );


	/*-----------------------------------------------------------
	Convert IENUM_INCLUDE_PATHS_INTERFACE to ecom_eiffel_compiler::IEnumIncludePaths *.
	-----------------------------------------------------------*/
	ecom_eiffel_compiler::IEnumIncludePaths * ccom_ec_pointed_interface_214( EIF_REFERENCE eif_ref );


	/*-----------------------------------------------------------
	Convert CELL [IENUM_INCLUDE_PATHS_INTERFACE] to ecom_eiffel_compiler::IEnumIncludePaths * *.
	-----------------------------------------------------------*/
	ecom_eiffel_compiler::IEnumIncludePaths * * ccom_ec_pointed_cell_215( EIF_REFERENCE eif_ref, ecom_eiffel_compiler::IEnumIncludePaths * * old );


	/*-----------------------------------------------------------
	Convert IENUM_OBJECT_FILES_INTERFACE to ecom_eiffel_compiler::IEnumObjectFiles *.
	-----------------------------------------------------------*/
	ecom_eiffel_compiler::IEnumObjectFiles * ccom_ec_pointed_interface_217( EIF_REFERENCE eif_ref );


	/*-----------------------------------------------------------
	Convert CELL [IENUM_OBJECT_FILES_INTERFACE] to ecom_eiffel_compiler::IEnumObjectFiles * *.
	-----------------------------------------------------------*/
	ecom_eiffel_compiler::IEnumObjectFiles * * ccom_ec_pointed_cell_218( EIF_REFERENCE eif_ref, ecom_eiffel_compiler::IEnumObjectFiles * * old );


	/*-----------------------------------------------------------
	Convert CELL [STRING] to BSTR *.
	-----------------------------------------------------------*/
	BSTR * ccom_ec_pointed_cell_219( EIF_REFERENCE eif_ref, BSTR * old );


	/*-----------------------------------------------------------
	Convert CELL [STRING] to BSTR *.
	-----------------------------------------------------------*/
	BSTR * ccom_ec_pointed_cell_221( EIF_REFERENCE eif_ref, BSTR * old );


	/*-----------------------------------------------------------
	Convert CELL [STRING] to BSTR *.
	-----------------------------------------------------------*/
	BSTR * ccom_ec_pointed_cell_223( EIF_REFERENCE eif_ref, BSTR * old );


	/*-----------------------------------------------------------
	Convert CELL [STRING] to BSTR *.
	-----------------------------------------------------------*/
	BSTR * ccom_ec_pointed_cell_225( EIF_REFERENCE eif_ref, BSTR * old );


	/*-----------------------------------------------------------
	Convert CELL [STRING] to BSTR *.
	-----------------------------------------------------------*/
	BSTR * ccom_ec_pointed_cell_231( EIF_REFERENCE eif_ref, BSTR * old );


	/*-----------------------------------------------------------
	Convert CELL [STRING] to BSTR *.
	-----------------------------------------------------------*/
	BSTR * ccom_ec_pointed_cell_232( EIF_REFERENCE eif_ref, BSTR * old );


	/*-----------------------------------------------------------
	Convert ECOM_VARIANT to VARIANT *.
	-----------------------------------------------------------*/
	VARIANT * ccom_ec_pointed_record_234( EIF_REFERENCE eif_ref );


	/*-----------------------------------------------------------
	Convert ECOM_VARIANT to VARIANT *.
	-----------------------------------------------------------*/
	VARIANT * ccom_ec_pointed_record_235( EIF_REFERENCE eif_ref );


	/*-----------------------------------------------------------
	Convert ECOM_VARIANT to VARIANT *.
	-----------------------------------------------------------*/
	VARIANT * ccom_ec_pointed_record_236( EIF_REFERENCE eif_ref );


	/*-----------------------------------------------------------
	Convert IEIFFEL_HTMLDOC_EVENTS_INTERFACE to ecom_eiffel_compiler::IEiffelHTMLDocEvents *.
	-----------------------------------------------------------*/
	ecom_eiffel_compiler::IEiffelHTMLDocEvents * ccom_ec_pointed_interface_241( EIF_REFERENCE eif_ref );



protected:


private:


};
}
#endif

#ifdef __cplusplus
}
#endif
#include "ecom_grt_globals_ISE.h"


#endif