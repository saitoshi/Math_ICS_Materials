// A simple syntax-directed translator for a simple language

grammar MyLanguageV0Code;

// Root non-terminal symbol
// A program is a bunch of declarations followed by a bunch of statements
// The Java code outputs the necessary NASM code around these declarations

program       : 
              {System.out.println("%include \"asm_io.inc\"");
               System.out.println("segment .bss"); }
              declaration*
              {System.out.println("segment .text"); 
               System.out.println("\tglobal asm_main"); 
               System.out.println("asm_main:"); 
               System.out.println("\tenter 0,0"); 
               System.out.println("\tpusha"); }
              statement*
              {System.out.println("\tpopa"); 
               System.out.println("\tmov eax,0"); 
               System.out.println("\tleave"); 
               System.out.println("\tret"); } 
              ;

// Parse rule for variable declarations

declaration   : 
              {int a; }
              INT a=NAME SEMICOLON
              {System.out.println("\t"+$a.text + "  resd 1");}
              ;

// Parse rule for statements

statement      : 
               ifstmt 
             | printstmt 
             | assignstmt 
               ;

// Parse rule for if statements

ifstmt      : 
            {int a,b;} 
            {String label;}
            IF LPAREN a=identifier EQUAL b=integer RPAREN
            {System.out.println("\tcmp dword "+$a.toString+","+$b.toString);
             label = "label_"+Integer.toString($IF.index);
             System.out.println("\tjnz "+label); }
            statement*
            { System.out.println(label+":"); }
            ENDIF
            ;


// Parse rule for print statements

printstmt      : 
               PRINT term SEMICOLON 
               {System.out.println("\tmov eax, "+$term.toString);
                System.out.println("\tcall print_int");
                System.out.println("\tcall print_nl");} 
               ;

// Parse rule for assignment statements

assignstmt      : 
                {int a; }
                a=NAME ASSIGN expression SEMICOLON 
                {System.out.println("\tmov ["+$a.text+"], eax");} 
                ;

// Parse rule for expressions

expression      : 
                {int a,b; }
                a=term 
                {System.out.println("\tmov eax,"+$a.toString);}
              | 
                a=term PLUS b=term 
                {System.out.println("\tmov eax,"+$a.toString);}
                {System.out.println("\tadd eax,"+$b.toString);}
                ;

// Parse rule for terms

term returns [String toString]  : 
                                identifier {$toString = $identifier.toString;} 
                              | integer {$toString = $integer.toString;} 
                                ;

// Parse rule for identifiers

identifier returns [String toString]: NAME {$toString = "["+$NAME.text+"]";} ;

// Parse rule for numbers 

integer returns [String toString]: INTEGER {$toString = $INTEGER.text;} ;


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
