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
// NOTE
// - When using docker, mount this file via the --volume option, eg:
//   docker run --rm --hostname gccpli -it -v $PWD/workdir:/workdir -v $PWD/src-antlr/src-parser/main.cpp:/src-antlr/src-parser/main.cpp itsme/gccpl1x

#include <iostream>
#include <sys/stat.h>
#include <iterator>
#include <regex>


#include "antlr4-runtime.h"
#include "Pl1Lexer.h"
#include "Pl1Parser.h"

using namespace antlrcpptest;
using namespace antlr4;

  
class Myincl: public LexerScannerIncludeSource {
    /*
  class ANTLR4CPP_PUBLIC LexerScannerIncludeSource
    public:
        virtual CharStream * embedSource(const std::string &lexerText);
        virtual CharStream * embedSource(const std::string &currentName, size_t line, size_t offset, const std::string &lexerText);
  */

  public:
        CharStream * embedSource(const std::string &lexerText) {
          std::cout << std::string("!!embedSource ") << lexerText << std::endl;
          // TODO: Add includeDir option
          // TODO: Add suffix option
          // lexerText contains "%include name ;"
          std::regex e ("(%[ ]*include[ ]+)([a-z0-9_#@$|.]+)([ ]*;)"
          ,std::regex_constants::ECMAScript | std::regex_constants::icase);
          std::smatch sm;
          std::regex_match (lexerText,sm,e);
          std::cout << " 0 " << sm[0] << std::endl;
          std::cout << " 1 " << sm[1] << std::endl;
          std::cout << " 2 " << sm[2] << std::endl;
          std::cout << " 3 " << sm[3] << std::endl;
          if (sm.size()>2) {
            return LexerScannerIncludeSource::embedSource(sm[2]);
          }

          // TODO: Throw error
          return nullptr ;
        }
        //virtual CharStream * embedSource(const std::string &currentName, size_t line, size_t offset, const std::string &lexerText);

};


int main(int argc, const char **argv) {

 const std::string &lexerText = argv[1] ;
 struct stat buffer;
 if (stat(lexerText.c_str(), &buffer)) {
    std::cerr << std::string("file not found: ") << lexerText << std::endl;
    return 8;
  }

  ANTLRFileStream *input = new ANTLRFileStream();
  input->loadFromFile(lexerText);

  Myincl myincl;

  Pl1Lexer lexer(input);
  lexer.setLexerScannerIncludeSource(&myincl);
  CommonTokenStream tokens(&lexer);


  // TODO: Set include handler, extend from LexerScannerIncludeSource
  // virtual void setLexerScannerIncludeSource( LexerScannerIncludeSource *lsis);

  tokens.fill();
  for (auto token : tokens.getTokens()) {
    std::cout << token->toString() << std::endl;
  }

  Pl1Parser parser(&tokens);
  tree::ParseTree* tree = parser.pl1pgm();

  std::cout << tree->toStringTree(&parser) << std::endl << std::endl;

  return 0;
}
