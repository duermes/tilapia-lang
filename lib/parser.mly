%{ open Ast %}
%token TIL (**)
%token BYTE UBYTE WORD UWORD BYTESTRING 
%token <bool> BOOL
%token COLON SEMICOLON DOUBLE_QUOTE LPAREN
%token PLUS MINUS TIMES DIVIDE MOD
%token EQTO NOTEQTO GT LT GEQ LEQ
%token LSHIFT RSHIFT
%token AND OR
%token ID
%token ASG (*=*)
%token EOF 

(*Associativity and Precedence*)
%left OR
%left AND
%right EQTO, NEQTO (*== !=*)
%left GT, LT, GEW, LEQ

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
| ASG ; expr; { VarInit (Ast.Eq, $2) }
| EOF { VarInit (Ast.Eq, Ast.Empty) }


expr:
| 
