void
lang_specific_driver (struct cl_decoded_option ** /* in_decoded_options */,
		      unsigned int * /* in_decoded_options_count */,
		      int * /*in_added_libraries */)
{
}

/* Called before linking.  Returns 0 on success and -1 on failure.  */
int
lang_specific_pre_link (void)
{
  /* Not used for Tiny.  */
  return 0;
}

/* Number of extra output files that lang_specific_pre_link may generate.  */
int lang_specific_extra_outfiles = 0; /* Not used for Tiny.  */