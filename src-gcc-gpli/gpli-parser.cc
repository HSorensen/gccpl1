#include <iostream>
#include <memory>

#include "gpli/gpli-parser.h"

#include "config.h"
#include "system.h"
#include "coretypes.h"
#include "target.h"
#include "tree.h"
#include "tree-iterator.h"
#include "input.h"
#include "diagnostic.h"
#include "stringpool.h"
#include "cgraph.h"
#include "gimplify.h"
#include "gimple-expr.h"
#include "convert.h"
#include "print-tree.h"
#include "stor-layout.h"
#include "fold-const.h"

#include "antlr4-runtime.h"
#include "Pl1Lexer.h"
#include "Pl1Parser.h"

using namespace antlrcpptest;
using namespace antlr4;

namespace Gpli
{
}



// ------------------------------------------------------
// ------------------------------------------------------
// ------------------------------------------------------

static void gpli_parse_file (const char *filename);

void
gpli_parse_files (int num_files, const char **files)
{
  for (int i = 0; i < num_files; i++)
    {
      gpli_parse_file (files[i]);
    }
}

static void
gpli_parse_file (const char *filename)
{
  // FIXME: handle stdin "-"
  FILE *file = fopen (filename, "r");
  if (file == NULL)
    {
      fatal_error (UNKNOWN_LOCATION, "cannot open filename %s: %m", filename);
    }

  //Gpli::Lexer lexer (filename, file);
  //Gpli::Parser parser (lexer);

  //parser.parse_program ();

  fclose (file);
}
