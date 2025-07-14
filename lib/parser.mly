%token TYP_BOOL TYP_WORD TYP_BYTE TYP_BYTESTRING

%token <bool> LIT_BOOL
%token <int64> LIT_WORD
%token <char> LIT_BYTE
%token <string> LIT_BYTESTRING

%token <string> ID

%token PLUS MINUS TIMES DIVIDE MOD
%token EQ GT LT NEQ GEQ LEQ
%token LAND LOR

%left TIMES DIVIDE MOD
%left PLUS MINUS
%left LT LEQ GT GEQ
%left EQ NEQ
%left LAND
%left LOR

%token ASSIGN

%token COMMA

%token COLON SEMICOLON

%token ARROW

%token LPAREN RPAREN
%token LBRACE RBRACE

%token DEFUN LET

%token IF ELSE

%token EOF

%start <Ast.program> root
%%

let root := content = toplevel+ ; EOF ; { Array.of_list content}

let toplevel :=
  | DEFUN ; id = ID ; args = funargs ; ARROW ; rettyp = typ ; (body, retval) = funbody ;
    { Ast.FunDef { id; args = Array.of_list args; rettyp; body = Array.of_list body; retval } }

let funargs := delimited(LPAREN, separated_list(COMMA, funarg), RPAREN)
let funarg := id = id ; COLON ; typ = typ ; <>

let funbody := delimited(LBRACE, body = stmt* ; retval = expr? ; <>, RBRACE)

let stmt :=
  | LET ; id = id ; COLON ; typ = typ ; init = option(ASSIGN ; expr) ;
    { Ast.VarDecl { id; typ; init } }
  | x = id ; ASSIGN ; e = expr ; < Ast.Assign >
  | IF ; cond = expr ; blk = delimited(LBRACE, stmt*, RBRACE) ; tail = option(ELSE ; stmt) ;
    { Ast.If { cond; blk = Array.of_list blk ; tail } }
  | e = expr ; SEMICOLON ; < Ast.Ignore >

let expr :=
  | func = id ; args = delimited(LPAREN, expr*, RPAREN) ;
    { Ast.Call (func, Array.of_list args) }
  | lhs = expr ; op = binop ; rhs = expr ;
    { Ast.BinOp (op, lhs, rhs) }
  | l = literal ; < Ast.Literal >
  | x = id ; < Ast.Variable >

let binop :=
  | PLUS ; { Ast.Plus }
  | MINUS ; { Ast.Minus }
  | TIMES ; { Ast.Times }
  | DIVIDE ; { Ast.Divide }
  | MOD ; { Ast.Mod }
  | EQ ; { Ast.Eq }
  | GT ; { Ast.GT }
  | LT ; { Ast.LT }
  | NEQ ; { Ast.NEq }
  | GEQ ; { Ast.GEq }
  | LEQ ; { Ast.LEq }
  | LAND ; { Ast.LAnd }
  | LOR ; { Ast.LOr }

let id := ID

let literal :=
  | l = LIT_BOOL ; < Literal.Bool >
  | l = LIT_WORD ; < Literal.Word >
  | l = LIT_BYTE ; < Literal.Byte >
  | l = LIT_BYTESTRING ; < Literal.ByteString >

let typ :=
  | TYP_BOOL ; { Typ.Bool }
  | TYP_WORD ; { Typ.Word }
  | TYP_BYTE ; { Typ.Byte }
  | TYP_BYTESTRING ; { Typ.ByteString }
