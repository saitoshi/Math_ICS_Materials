// The two lines below are necessary but are actually about
// parsing, which we'll discuss later

grammar MyLexer;
program : ;


// Reserved Keywords
////////////////////////////////

IF: 'if';
ENDIF: 'endif';
PRINT: 'print';
INT: 'int';

// Operators
PLUS: '+';
EQUAL: '==';
ASSIGN: '=';
NOTEQUAL: '!=';

// Semicolon and parentheses
SEMICOLON: ';';
LPAREN: '(';
RPAREN: ')';

// Integers
INTEGER: [0-9][0-9]*;

// Variable names
NAME: [a-z]+;   

// Ignore all white spaces 
WS: [ \t\r\n]+ -> skip ; 
