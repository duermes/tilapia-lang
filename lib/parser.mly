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

%token FOR WHILE DO BREAK

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
  | FOR ;
    LPAREN ; init = expr ; SEMICOLON ; cond = expr ; SEMICOLON ; step = stmt ; RPAREN ;
    body = delimited(LBRACE, stmt*, RBRACE) ;
    { Ast.For { cond; init; step; body = Array.of_list body } }
  | WHILE ; cond = expr ; body = delimited(LBRACE, stmt*, RBRACE) ;
    { Ast.While (cond, Array.of_list body) }
  | DO ; body = delimited(LBRACE, stmt*, RBRACE) ; WHILE ; cond = expr ; SEMICOLON ;
    { Ast.DoWhile (cond, Array.of_list body) }
  | BREAK ; SEMICOLON ; { Ast.Break }

let expr :=
  | func = id ; args = delimited(LPAREN, expr*, RPAREN) ;
    { Ast.Call (func, Array.of_list args) }
  | binop
  | l = literal ; < Ast.Literal >
  | x = id ; < Ast.Variable >

let binop :=
  | e1 = expr ; PLUS ; e2 = expr ; { Ast.BinOp (Ast.Plus, e1, e2) }
  | e1 = expr ; MINUS ; e2 = expr ; { Ast.BinOp (Ast.Minus, e1, e2) }
  | e1 = expr ; TIMES ; e2 = expr ; { Ast.BinOp (Ast.Times, e1, e2) }
  | e1 = expr ; DIVIDE ; e2 = expr ; { Ast.BinOp (Ast.Divide, e1, e2) }
  | e1 = expr ; MOD ; e2 = expr ; { Ast.BinOp (Ast.Mod, e1, e2) }
  | e1 = expr ; EQ ; e2 = expr ; { Ast.BinOp (Ast.Eq, e1, e2) }
  | e1 = expr ; GT ; e2 = expr ; { Ast.BinOp (Ast.GT, e1, e2) }
  | e1 = expr ; LT ; e2 = expr ; { Ast.BinOp (Ast.LT, e1, e2) }
  | e1 = expr ; NEQ ; e2 = expr ; { Ast.BinOp (Ast.NEq, e1, e2) }
  | e1 = expr ; GEQ ; e2 = expr ; { Ast.BinOp (Ast.GEq, e1, e2) }
  | e1 = expr ; LEQ ; e2 = expr ; { Ast.BinOp (Ast.LEq, e1, e2) }
  | e1 = expr ; LAND ; e2 = expr ; { Ast.BinOp (Ast.LAnd, e1, e2) }
  | e1 = expr ; LOR ; e2 = expr ; { Ast.BinOp (Ast.LOr, e1, e2) }

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
