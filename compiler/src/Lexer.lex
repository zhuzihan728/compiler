import java_cup.runtime.*;

%%
%class Lexer
%unicode
%cup
%line
%column
%states STRING


%{
  private Symbol symbol(int type) {
    return new Symbol(type, yyline, yycolumn);
  }
  private Symbol symbol(int type, Object value) {
    return new Symbol(type, yyline, yycolumn, value);
  }
%}

Newline = \r | \n | \r\n
Whitespace = {Newline} | " " | \t
InputCharacter = [^\n\r]
Letter = [a-zA-Z] 
Digit = [0-9]
IdChar = {Letter} | {Digit} | "_"
Identifier = {Letter}{IdChar}*  
Integer = (0|[1-9]{Digit}*) 
Positive = [1-9]{Digit}*
Comment = {EndofLineComent} | {MultipleLinesComent}
EndofLineComent = "#"{InputCharacter}*({Newline}?)
MultipleLinesComent = "/#"~"#/"
Partial = {Positive}"_"
Rational = ({Partial}?){Positive}"/"{Positive}
Float = {Integer}"."{Digit}*

%%
<YYINITIAL> {
  "main"         { return symbol(sym.MAIN);                               }
  "lambda"       { return symbol(sym.LAMBDA);                             }
  "top"          { return symbol(sym.TOP);                                }
  "int"          { return symbol(sym.TINT);                               }
  "range"        { return symbol(sym.RANGE);                              }
  "for"          { return symbol(sym.FOR);                                }
  "in"           { return symbol(sym.IN);                                 }
  "if"           { return symbol(sym.IF);                                 }
  "char"         { return symbol(sym.TCHAR);                              }
  "rat"          { return symbol(sym.TRAT);                               }
  "float"        { return symbol(sym.TFLOAT);                             }
  "bool"         { return symbol(sym.TBOOL);                              }
  "T"            { return symbol(sym.TRUE);                               }
  "F"            { return symbol(sym.FALSE);                              }
  "seq"          { return symbol(sym.SEQ);                                }
  "len"          { return symbol(sym.LEN);                                }
  "tdef"         { return symbol(sym.TDEF);                               }
  "alias"        { return symbol(sym.ALIAS);                              }
  "fdef"         { return symbol(sym.FDEF);                               }
  "return"       { return symbol(sym.RETURN);                             }
  "else"         { return symbol(sym.ELSE);                               }
  "loop"         { return symbol(sym.LOOP);                               }
  "read"         { return symbol(sym.READ);                               }
  "print"        { return symbol(sym.PRINT);                              }
  "fi"           { return symbol(sym.FI);                                 }
  "pool"         { return symbol(sym.POOL);                               }
  "break"        { return symbol(sym.BREAK);                              }
  "then"         { return symbol(sym.THEN);                               }
  {Integer}      { return symbol(sym.INTEGER,Integer.parseInt(yytext())); }
  {Rational}     { return symbol(sym.RAT);                                }
  {Float}        { return symbol(sym.FLOAT);                              }
  {Identifier}   { return symbol(sym.IDENTIFIER, yytext());               }
  {Whitespace}   { /* do nothing */                                       }
  {Comment}      {/* do nothing */                                        }
  \'{InputCharacter}\'  {return symbol(sym.CHAR, yytext());               }
  "!"            { return symbol(sym.QMARK);                              }
  "&&"           { return symbol(sym.AND);                                }
  "||"           { return symbol(sym.OR);                                 }
  "::"           { return symbol(sym.CONCATE);                            }
  "<="           { return symbol(sym.ELT);                                }
  "="            { return symbol(sym.INIT);                               }
  "!="           { return symbol(sym.NOTEQ);                              }
  ":"            { return symbol(sym.COLON);                              }
  "<"            { return symbol(sym.LT);                                 }
  ">"            { return symbol(sym.GT);                                 }
  "["            { return symbol(sym.LEFTSQ);                             }
  "]"            { return symbol(sym.RIGHTSQ);                            }
  ","            { return symbol(sym.COMMA);                              }
  ":="           { return symbol(sym.EQUAL);                              }
  ";"            { return symbol(sym.SEMICOL);                            }
  "+"            { return symbol(sym.PLUS);                               }
  "-"            { return symbol(sym.MINUS);                              }
  "*"            { return symbol(sym.MULT);                               }
  "/"            { return symbol(sym.DIV);                                }
  "("            { return symbol(sym.LPAREN);                             }
  ")"            { return symbol(sym.RPAREN);                             }
  "{"            { return symbol(sym.LCB);                                }
  "}"            { return symbol(sym.RCB);                                }
  "."            { return symbol(sym.DOT);                                }
  "^"            { return symbol(sym.POWER);                              }
  \"             { yybegin(STRING);                                       }

}
<STRING> {
  \"            { yybegin(YYINITIAL); return symbol(sym.STRING_LITERAL);  }
  \\\"          {                                                         }
  [^\"]         {                                                         }
  
}


/* Your code goes here */
/* Your code goes here */                                                        
/* error fallback */
[^]  {
    System.out.println("Error in line "
        + (yyline+1) +": Invalid input '" + yytext()+"'");
    return symbol(sym.ILLEGAL_CHARACTER);
}
