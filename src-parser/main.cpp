/* Copyright (c) 2012-2017 The ANTLR Project. All rights reserved.
 * Use of this file is governed by the BSD 3-clause license that
 * can be found in the LICENSE.txt file in the project root.
 */

//
//  main.cpp
//  antlr4-cpp-demo
//
//  Created by Mike Lischke on 13.03.16.
//

#include <iostream>

#include "antlr4-runtime.h"
#include "Pl1Lexer.h"
#include "Pl1Parser.h"

using namespace antlrcpptest;
using namespace antlr4;

int main(int , const char **) {
                        //00000000001111111111222222222233333333334444444444555555555566666666667777777777888888888899999999990000000000
                        //01234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789
  ANTLRInputStream input(" HI: PROC OPTIONS(MAIN); DISPLAY('HELLO WORLD'); END HI;");
  TLexer lexer(&input);
  CommonTokenStream tokens(&lexer);

  tokens.fill();
  for (auto token : tokens.getTokens()) {
    std::cout << token->toString() << std::endl;
  }

  TParser parser(&tokens);
  tree::ParseTree* tree = parser.main();

  std::cout << tree->toStringTree(&parser) << std::endl << std::endl;

  return 0;
}
