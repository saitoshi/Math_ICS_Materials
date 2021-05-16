// A simple syntax-directed translator for a simple language
//Shinya Saito
//ICS 312
//Homework 9
// worked with Robert L on this assignment
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
             | lshiftstmt
             | ifnotstmt
             | forloopstmt
             | subprogstmt
             | funstmt
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
//Parse rule for left shift
lshiftstmt      :
                {int a,b;}
                a=NAME LSHIFT b=INTEGER SEMICOLON
                {System.out.println("\tmov eax, ["+$a.text+"]");");}
                {System.out.println("\tshl eax,"+$b.text);}
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

// Parse rule for the if not equal statement for part (b)
ifnotstmt:
          {int a,b;}
          {String label;}
          IF LPAREN a=identifier NOTEQUAL b=integer RPAREN
          {System.out.println("\tcmp dword"+$a.toString+","$b.toString)};
          label = "label_"+Integer.toString($IF.index);
          System.out.println("\tjz "+label); }
         statement*
         { System.out.println(label+":"); }
         ENDIF
          ;
// Parse rule for the for loop statement
forloopstmt:
          {int a, b, c; String label1, label2;}
          FOR a = NAME ASSIGN b=INTEGER COMMA c=INTEGER
          {label1 ="label_"+Integer.toString($FOR.index);
          label2 ="label_"+Integer.toString($FOR.index)+"_end";
          System.out.println("\tmov ecx,"+$b.text);
          System.out.println("\tmov ["+a.text+"], ecx");
          System.out.println(label1+":");
          System.out.println("\tmov ecx,["+$a.text+"]");
          System.out.println("\tcmp ecx,"+$c.text);
          System.out.println("\tjg"+label2);}
          statement*
          {
          System.out.println("\tmov ecx, ["+$a.text+"]");
          System.out.println("\tinc ecx");
          System.out.println("\tmov ["$+a.text+"], ecx");
          System.out.println("\tjmp"+label1);
          System.out.println(label2+":");
          }
          ;
//parse rule for the subprogram statements
subprogstmt:
          {int a;}
          a=NAME LPAREN RPAREN SEMICOLON
          { System.out.println("\tcall "+$a.text);}
          ;
funstmt:
          {int a;}
          VOID a=NAME LPAREN RPAREN LCURLY
          { System.out.println("\tjmp asm_main_cleanup");
      		  System.out.println($a.text+":");
      		  System.out.println("\tpush ebp");
      		  System.out.println("\tmov ebp, esp"); }
      		statement*
      		{ System.out.println("\tpop ebp");
      		  System.out.println("\tret"); }
      		RCURLY
      		;
// Reserved Keywords
////////////////////////////////

IF: 'if';
ENDIF: 'endif';
FOR:'for';
ENDFOR:'endfor';
PRINT: 'print';
INT: 'int';
VOID: 'void';

// Operators
PLUS: '+';
LSHIFT: '<<'
EQUAL: '==';
ASSIGN: '=';
NOTEQUAL: '!=';

// Semicolon and parentheses
SEMICOLON: ';';
LPAREN: '(';
RPAREN: ')';
LCURLY: '{';
RCURLYL '}'

// Integers
INTEGER: [0-9][0-9]*;

// Variable names
NAME: [a-z]+;

// Ignore all white spaces
WS: [ \t\r\n]+ -> skip ;
