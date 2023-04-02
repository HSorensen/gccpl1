/* Copyright (c) 2012-2017 The ANTLR Project. All rights reserved.
 * Use of this file is governed by the BSD 3-clause license that
 * can be found in the LICENSE.txt file in the project root.
 */

// Based on https://github.com/antlr/antlr4/blob/master/runtime/Cpp/demo/Linux/main.cpp
//  main.cpp
//  antlr4-cpp-demo
//
//  Created by Mike Lischke on 13.03.16.
//

#include <iostream>
#include <sys/stat.h>


#include "antlr4-runtime.h"
#include "Pl1Lexer.h"
#include "Pl1Parser.h"

using namespace antlrcpptest;
using namespace antlr4;



int main(int argc, const char **argv) {

 const std::string &lexerText = argv[1] ;
 struct stat buffer;
 if (stat(lexerText.c_str(), &buffer)) {
    std::cerr << std::string("file not found: ") << lexerText << std::endl;
    return 8;
  }

  ANTLRFileStream *input = new ANTLRFileStream();
  input->loadFromFile(lexerText);


  Pl1Lexer lexer(input);
  CommonTokenStream tokens(&lexer);

  // TODO: Set include handler, extend from LexerScannerIncludeSource
  // virtual void setLexerScannerIncludeSource( LexerScannerIncludeSource *lsis);
  /*
  class ANTLR4CPP_PUBLIC LexerScannerIncludeSource
{
    public:
        virtual ~LexerScannerIncludeSource() {}
        virtual CharStream * embedSource(const std::string &lexerText);
        virtual CharStream * embedSource(const std::string &currentName, size_t line, size_t offset, const std::string &lexerText);
};
}

//	TODO: public LexerScannerIncludeSource _lexerScannerIncludeSource = new LexerScannerIncludeSourceImpl();
   LexerScannerIncludeSource * _lexerScannerIncludeSource = new LexerScannerIncludeSource;
	

  */

  tokens.fill();
  for (auto token : tokens.getTokens()) {
    std::cout << token->toString() << std::endl;
  }

  Pl1Parser parser(&tokens);
  tree::ParseTree* tree = parser.pl1pgm();

  std::cout << tree->toStringTree(&parser) << std::endl << std::endl;

  return 0;
}
