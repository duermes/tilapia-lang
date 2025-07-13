%{
(* open Ast *)
%}
%token FUNCALL
%token TIL (*til*)
%token WORD BYTESTRING BOOL
%token <string> LBYTESTRING
%token <int> LWORD
%token <bool> LBOOL
%token COLON SEMICOLON DOUBLE_QUOTE LPAREN RPAREN LBRACE RBRACE QUOTE COMMA
%token PLUS MINUS TIMES DIVIDE MOD
%token EQ GT LT NEQ GEQ LEQ
%token LSHIFT RSHIFT
%token AND OR
%token <string> ID
%token ASG (*= ASSIGMENT*)
%token EOF
%token TYPE FUNC IF ELSE WHILE DO FOR BREAK ARROW
%token PRINTSTR PRINTINT

(*Associativity and Precedence*)
%left OR
%left AND
%nonassoc EQ, NEQ (*== !=*)
%left GT, LT, GEQ, LEQ

%left PLUS MINUS
%right TIMES DIVIDE MOD

%start <Ast.program> progam
%%

// Grammar rules, valid ways to writte my lang
progam:
| stmt list EOF {[$1]}
| EOF {[]}

expr:
| LBYTESTRING { Literal.ByteString $1 }
| LWORD { Literal.Word $1 }
| LBOOL { Literal.BOOL $1 }
| expr operator expr { Operation($2, $1, $3) }
| ID { Id $1 }
| FUNCALL ID params { FunctionCall($2, $3) }

stmt:
| TIL ID COLON dtype
| FUNC ID funparams bracedBody ARROW dtype { FunctionDef($2, $3) } //fish Die (mood: byte) -> bytestring {<body> <return-value>}
| ID ASG expr { Assign($1, $3) }
| IF params bracedBody iftail { If($2, $3, $4) }
| BREAK { Break }
| WHILE params loopBody { While($2, $3) }
| DO loopBody WHILE params  { While($2, $3) }
| PRINTINT LWORD { PrintWord($2) }
| PRINTSTR LBYTESTRING { PrintString($2) }



iftail:
| ELSE bracedBody { $2 }
| ELSE IF params bracedBody iftail { If($3, $4, $5) }
| /* As empty as my memory */ { [] }


// WE might (MUST) re-writte this because we are missing expressions literals (or not anymore)
param:
| expr { $1 }

params:
| separated_list(COMMA, param) { $1 }

funparam:
| ID COLON dtype  { ($1, $2) }  // mood: byte

funparams:
| LPAREN separated_list(COMMA, funparam) RPAREN { $2 }

body:
| expr SEMICOLON { $1 }
| stmt SEMICOLON { $1 }

loopBody:
| LBRACE body* RBRACE { $2 }

bracedBody:
| LBRACE body expr RBRACE { ($2, $3) }


// auxiliar rules to identify "operators" inline doesn't generate a node
%inline operator:
| PLUS { Plus }
| MINUS { Minus }
| TIMES { Times }
| DIVIDE { Divide }
| MOD { Mod }
| EQ { Eq }
| GT { Gt }
| LT { Lt }
| NEQ { NEq }
| GEQ { GEq }
| LEQ { LEq }
| AND { And }
| OR { And }
| LSHIFT { LShift }
| RSHIFT { RShift }

%inline dtype:
| WORD { DType.Word }
| BYTESTRING { DType.Bytestring }
| BOOL { DType.Bool }
