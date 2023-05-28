#include "config.h"
#include "system.h"
#include "coretypes.h"
#include "target.h"
#include "tree.h"
#include "gimple-expr.h"
#include "diagnostic.h"
#include "opts.h"
#include "fold-const.h"
#include "gimplify.h"
#include "stor-layout.h"
#include "debug.h"
#include "convert.h"
#include "langhooks.h"
#include "langhooks-def.h"
#include "common/common-target.h"
#include "gpli/gpli-parser.h"

/* Language-dependent contents of a type.  */

struct GTY (()) lang_type
{
  char dummy;
};

/* Language-dependent contents of a decl.  */

struct GTY (()) lang_decl
{
  char dummy;
};

/* Language-dependent contents of an identifier.  This must include a
   tree_identifier.  */

struct GTY (()) lang_identifier
{
  struct tree_identifier common;
};

/* The resulting tree type.  */

union GTY ((desc ("TREE_CODE (&%h.generic) == IDENTIFIER_NODE"),
	    chain_next ("CODE_CONTAINS_STRUCT (TREE_CODE (&%h.generic), "
			"TS_COMMON) ? ((union lang_tree_node *) TREE_CHAIN "
			"(&%h.generic)) : NULL"))) lang_tree_node
{
  union tree_node GTY ((tag ("0"), desc ("tree_node_structure (&%h)"))) generic;
  struct lang_identifier GTY ((tag ("1"))) identifier;
};

/* We don't use language_function.  */

struct GTY (()) language_function
{
  int dummy;
};

/* Language hooks.  */

static bool
gpli_langhook_init (void)
{
  /* NOTE: Newer versions of GCC use only:
           build_common_tree_nodes (false);
     See Eugene's comment in the comments section. */
  build_common_tree_nodes (false);

  /* I don't know why this has to be done explicitly.  */
  void_list_node = build_tree_list (NULL_TREE, void_type_node);

  build_common_builtin_nodes ();

  return true;
}

static void
gpli_langhook_parse_file (void)
{
   if (flag_gpli_verbose)
    fprintf (stderr, "gpli_langhook_parse_file: option verbose enabled\n");
  else
    fprintf (stderr, "gpli_langhook_parse_file: option verbose not enabled\n");

  fprintf(stderr, "Hello mighty gccpli!!!!\n");
  fprintf(stderr, "Numfiles %i\n",num_in_fnames);
  gpli_parse_files (num_in_fnames, in_fnames);
}

static tree
gpli_langhook_type_for_mode (enum machine_mode mode, int unsignedp)
{ 
  
  if (mode == TYPE_MODE (float_type_node))
    return float_type_node;

  if (mode == TYPE_MODE (double_type_node))
    return double_type_node;

  if (mode == TYPE_MODE (intQI_type_node))
    return unsignedp ? unsigned_intQI_type_node : intQI_type_node;
  if (mode == TYPE_MODE (intHI_type_node))
    return unsignedp ? unsigned_intHI_type_node : intHI_type_node;
  if (mode == TYPE_MODE (intSI_type_node))
    return unsignedp ? unsigned_intSI_type_node : intSI_type_node;
  if (mode == TYPE_MODE (intDI_type_node))
    return unsignedp ? unsigned_intDI_type_node : intDI_type_node;
  if (mode == TYPE_MODE (intTI_type_node))
    return unsignedp ? unsigned_intTI_type_node : intTI_type_node;

  if (mode == TYPE_MODE (integer_type_node))
    return unsignedp ? unsigned_type_node : integer_type_node;

  if (mode == TYPE_MODE (long_integer_type_node))
    return unsignedp ? long_unsigned_type_node : long_integer_type_node;

  if (mode == TYPE_MODE (long_long_integer_type_node))
    return unsignedp ? long_long_unsigned_type_node
		     : long_long_integer_type_node;

  if (COMPLEX_MODE_P (mode))
    {
      if (mode == TYPE_MODE (complex_float_type_node))
	return complex_float_type_node;
      if (mode == TYPE_MODE (complex_double_type_node))
	return complex_double_type_node;
      if (mode == TYPE_MODE (complex_long_double_type_node))
	return complex_long_double_type_node;
      if (mode == TYPE_MODE (complex_integer_type_node) && !unsignedp)
	return complex_integer_type_node;
    }

  /* gcc_unreachable */
  return NULL;
}

static tree
gpli_langhook_type_for_size (unsigned int bits ATTRIBUTE_UNUSED,
			     int unsignedp ATTRIBUTE_UNUSED)
{
  gcc_unreachable ();
  return NULL;
}

/* Record a builtin function.  We just ignore builtin functions.  */

static tree
gpli_langhook_builtin_function (tree decl)
{
  return decl;
}

static bool
gpli_langhook_global_bindings_p (void)
{
  return false;
}

static tree
gpli_langhook_pushdecl (tree decl ATTRIBUTE_UNUSED)
{
  gcc_unreachable ();
}

static tree
gpli_langhook_getdecls (void)
{
  return NULL;
}

/* The option mask. Set in lang.opt. This enables the init_handle_option function. */
static unsigned int
gpli_langhook_option_lang_mask (void)
{
  return CL_gpli;
}


/* Generic hook that takes a struct gcc_options * and returns void.  */

void
gpli_init_options_struct (struct gcc_options *cli_options)
{ fprintf (stderr, "gpli_init_options_struct: x_verbose_flag %i \n",cli_options->x_verbose_flag);
flag_gpli_verbose=false;
}

/* Called to perform language-specific options initialization.  */
void gpli_init_options(unsigned int decoded_options_count,
                       struct cl_decoded_option *decoded_options)
{
  fprintf(stderr, "gpli_init_options: decoded_options_count %i\n", decoded_options_count);

  unsigned int i;

  for (i = 1; i < decoded_options_count; i++)
  {
      enum opt_code code = (enum opt_code)decoded_options[i].opt_index;
      const struct cl_option *option = &cl_options[code];
      const char *opt = (const char *)option->opt_text;
      const char *none = "<none>";
      const char *arg = decoded_options[i].arg;
      HOST_WIDE_INT value = decoded_options[i].value;
      switch (code)
      {
      case OPT_o:
  fprintf(stderr, "gpli_init_options: OPT_o %i %s %s\n", OPT_o,opt,arg);
  break;
      default:
  fprintf(stderr, "gpli_init_options: not handled option %i %x\n", code, opt);
      }
  }
}

/* By default, no language-specific options are valid.
   Return true: Option handled.
         false: Option not handled. Will produce an "unrecognized command-line option" message.
 */
bool
gpli_handle_option (size_t code ,
		   const char *arg,
		   HOST_WIDE_INT value ATTRIBUTE_UNUSED,
		   int kind ATTRIBUTE_UNUSED,
		   location_t loc ATTRIBUTE_UNUSED,
		   const struct cl_option_handlers *handlers ATTRIBUTE_UNUSED)
{  bool out=true;

      switch (code)
      {
      case OPT_I:
  fprintf(stderr, "gpli_handle_option: OPT_I %i %s\n", OPT_I,arg);
  break;
      case OPT_fgpli_verbose:
  fprintf(stderr, "gpli_handle_option: OPT_fgpli-verbose %i\n", OPT_I);
  flag_gpli_verbose=true;
  break;
      default: 
      fprintf (stderr, "gpli_handle_option: unhandled code %li \n",code);
      out=false;
      }
  return out;
}

bool
gpli_post_options (const char ** (pfilename))
{fprintf (stderr, "gpli_post_options: arg %s \n",pfilename[0]);
  /* Excess precision other than "fast" requires front-end
     support.  */
  flag_excess_precision = EXCESS_PRECISION_FAST;
  return false;
}

/* See langhooks-def.h */

#undef LANG_HOOKS_NAME
#define LANG_HOOKS_NAME "GNU PL/I"

#undef LANG_HOOKS_OPTION_LANG_MASK
#define LANG_HOOKS_OPTION_LANG_MASK gpli_langhook_option_lang_mask

#undef LANG_HOOKS_INIT
#define LANG_HOOKS_INIT gpli_langhook_init

#undef LANG_HOOKS_PARSE_FILE
#define LANG_HOOKS_PARSE_FILE gpli_langhook_parse_file

#undef LANG_HOOKS_INIT_OPTIONS_STRUCT
#define LANG_HOOKS_INIT_OPTIONS_STRUCT gpli_init_options_struct

#undef LANG_HOOKS_INIT_OPTIONS
#define LANG_HOOKS_INIT_OPTIONS gpli_init_options

#undef LANG_HOOKS_HANDLE_OPTION
#define LANG_HOOKS_HANDLE_OPTION gpli_handle_option

#undef LANG_HOOKS_POST_OPTIONS
#define LANG_HOOKS_POST_OPTIONS gpli_post_options

#undef LANG_HOOKS_TYPE_FOR_MODE
#define LANG_HOOKS_TYPE_FOR_MODE gpli_langhook_type_for_mode

#undef LANG_HOOKS_TYPE_FOR_SIZE
#define LANG_HOOKS_TYPE_FOR_SIZE gpli_langhook_type_for_size

#undef LANG_HOOKS_BUILTIN_FUNCTION
#define LANG_HOOKS_BUILTIN_FUNCTION gpli_langhook_builtin_function

#undef LANG_HOOKS_GLOBAL_BINDINGS_P
#define LANG_HOOKS_GLOBAL_BINDINGS_P gpli_langhook_global_bindings_p

#undef LANG_HOOKS_PUSHDECL
#define LANG_HOOKS_PUSHDECL gpli_langhook_pushdecl

#undef LANG_HOOKS_GETDECLS
#define LANG_HOOKS_GETDECLS gpli_langhook_getdecls

struct lang_hooks lang_hooks = LANG_HOOKS_INITIALIZER;

#include "gt-gpli-gpli1.h"
#include "gtype-gpli.h"