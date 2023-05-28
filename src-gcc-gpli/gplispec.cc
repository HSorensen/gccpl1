
#include <iostream>
#include "config.h"
#include "system.h"
//#include "coretypes.h"
//#include "tm.h"
//#include "opts.h"


void
lang_specific_driver (struct cl_decoded_option ** in_decoded_options,
		      unsigned int * in_decoded_options_count,
		      int * in_added_libraries )
{ // Note only called if compiler is started with gccgpli command
  fprintf (stderr, "gplispec.cc: lang_specific_driver in_decoded_options_count %i\n",*in_decoded_options_count);
}

/* Called before linking.  Returns 0 on success and -1 on failure.  */
int
lang_specific_pre_link (void)
{ // Note only called if compiler is started with gccgpli command
  fprintf (stderr, "gplispec.cc: lang_specific_pre_link\n");
  /* Not used for Gpli.  */
  return 0;
}

/* Number of extra output files that lang_specific_pre_link may generate.  */
int lang_specific_extra_outfiles = 0; /* Not used for Gpli.  */