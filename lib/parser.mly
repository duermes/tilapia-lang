%{ open Ast %}
%token TIL (**)
%token WORD BYTESTRING
%token LBYTESTRING LWORD
%token COLON SEMICOLON DOUBLE_QUOTE LPAREN RPAREN LBRACE RBRACE QUOTE
%token PLUS MINUS TIMES DIVIDE MOD
%token EQ GT LT NEQ GEQ LEQ
%token LSHIFT RSHIFT
%token AND OR
%token ID
%token ASG (*= ASSIGMENT*) 
%token EOF 
%token TYPE FUNC IF ELSE WHILE DO FOR BREAK

(*Associativity and Precedence*)
%left OR
%left AND
%right EQ, NEQ (*== !=*)
%left GT, LT, GEQ, LEQ

%left PLUS MINUS
%right TIMES DIVIDE MOD

%right LPAREN

%start <Ast.program> progam
%%
progam:
| EOF {[]}


datatype:
| BYTE { Byte }
| UBYTE { UByte }
| WORD { Word }
| UWORD { UWord }
| BYTESTRING { ByteString }
| BOOL { Bool }


varinit:
// | ASG ; expr; { VarInit (Ast.Eq, $2) }
| EOF { VarInit (Ast.Eq, Ast.Empty) }


// expr:
// | 
