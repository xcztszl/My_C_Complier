%error-verbose
%locations
%{
#include "stdio.h"
#include "math.h"
#include "string.h"
#include "def.h"
extern int yylineno;
extern char *yytext;
extern FILE *yyin;
void yyerror(const char* fmt, ...);
void display(struct ASTNode *,int);
%}

%union {
	int    type_int;
	float  type_float;
        char   type_char;
	char   type_id[32];
	struct ASTNode *ptr;
};

//  %type 瀹氫箟闈炵粓缁撶鐨勮涔夊€肩被鍨�
%type  <ptr> program ExtDefList ExtDef  Specifier ExtDecList FuncDec CompSt VarList Arraylist VarDec  ParamDec Stmt StmList DefList Def DecList Dec Exp Args 

//% token 瀹氫箟缁堢粨绗︾殑璇箟鍊肩被鍨�
%token <type_int> INT              /*鎸囧畾INT鐨勮涔夊€兼槸type_int锛屾湁璇嶆硶鍒嗘瀽寰楀埌鐨勬暟鍊�*/
%token <type_id> ID  RELOP TYPE    /*鎸囧畾ID,RELOP 鐨勮涔夊€兼槸type_id锛屾湁璇嶆硶鍒嗘瀽寰楀埌鐨勬爣璇嗙瀛楃涓�*/
%token <type_float> FLOAT          /*鎸囧畾FLOAT鐨勮涔夊€兼槸type_float锛屾湁璇嶆硶鍒嗘瀽寰楀埌鐨勬爣璇嗙瀛楃涓�*/
%token <type_char> CHAR            /*鎸囧畾CHAR鐨勮涔夊€兼槸type_char锛屾湁璇嶆硶鍒嗘瀽寰楀埌鐨勬暟鍊�*/

%token DPLUS LP RP LS RS LC RC SEMI COMMA      /*鐢╞ison瀵硅鏂囦欢缂栬瘧鏃讹紝甯﹀弬鏁�-d锛岀敓鎴愮殑.tab.h涓粰杩欎簺鍗曡瘝杩涜缂栫爜锛屽彲鍦╨ex.l涓寘鍚玴arser.tab.h浣跨敤杩欎簺鍗曡瘝绉嶇被鐮�*/
%token MINUSMINUS PLUSPLUS PLUS MINUS STAR DIV ASSIGNOP AND OR NOT IF ELSE WHILE FOR RETURN SWITCH CASE COLON DEFAULT PLUSASSIGNOP MINUSASSIGNOP STARASSIGNOP DIVASSIGNOP BREAK CONTINUE
/*浠ヤ笅涓烘帴鍦ㄤ笂杩皌oken鍚庝緷娆＄紪鐮佺殑鏋氫妇甯搁噺锛屼綔涓篈ST缁撶偣绫诲瀷鏍囪*/
%token EXT_DEF_LIST EXT_VAR_DEF FUNC_DEF FUNC_DEC EXT_DEC_LIST PARAM_LIST PARAM_DEC VAR_DEF DEC_LIST DEF_LIST COMP_STM STM_LIST EXP_STMT IF_THEN IF_THEN_ELSE ARRAY_LIST ARRAY_ID
%token FUNC_CALL ARGS FUNCTION PARAM ARG CALL LABEL GOTO JLT JLE JGT JGE EQ NEQ


%left ASSIGNOP PLUSASSIGNOP MINUSASSIGNOP STARASSIGNOP DIVASSIGNOP
%left OR
%left AND
%left RELOP
%left PLUS MINUS
%left PLUSPLUS MINUSMINUS
%left STAR DIV
%right UMINUS NOT DPLUS

%nonassoc LOWER_THEN_ELSE
%nonassoc ELSE

%%

program: ExtDefList    {  display($1,0);
                        semantic_Analysis0($1); }     //鏄剧ず璇硶鏍�,璇箟鍒嗘瀽
         ; 
ExtDefList: {$$=NULL;}
          | ExtDef ExtDefList {$$=mknode(2,EXT_DEF_LIST,yylineno,$1,$2);}   //姣忎竴涓狤XTDEFLIST鐨勭粨鐐癸紝鍏剁1妫靛瓙鏍戝搴斾竴涓閮ㄥ彉閲忓０鏄庢垨鍑芥暟
          ;  
ExtDef:   Specifier ExtDecList SEMI   {$$=mknode(2,EXT_VAR_DEF,yylineno,$1,$2);}   //璇ョ粨鐐瑰搴斾竴涓閮ㄥ彉閲忓０鏄�
         |Specifier FuncDec CompSt    {$$=mknode(3,FUNC_DEF,yylineno,$1,$2,$3);}         //璇ョ粨鐐瑰搴斾竴涓嚱鏁板畾涔�
         | error SEMI   {$$=NULL;}
         ;
Specifier:  TYPE    {$$=mknode(0,TYPE,yylineno);strcpy($$->type_id,$1);$$->type=!strcmp($1,"int")?INT:(!strcmp($1,"float")?FLOAT:CHAR);}   
           ;      
ExtDecList:  VarDec      {$$=$1;}       /*姣忎竴涓狤XT_DECLIST鐨勭粨鐐癸紝鍏剁涓€妫靛瓙鏍戝搴斾竴涓彉閲忓悕(ID绫诲瀷鐨勭粨鐐�),绗簩妫靛瓙鏍戝搴斿墿涓嬬殑澶栭儴鍙橀噺鍚�*/
           | VarDec COMMA ExtDecList {$$=mknode(2,EXT_DEC_LIST,yylineno,$1,$3);}
           ;  
VarDec:  ID          {$$=mknode(0,ID,yylineno);strcpy($$->type_id,$1);}   //ID缁撶偣锛屾爣璇嗙绗﹀彿涓插瓨鏀剧粨鐐圭殑type_id
         | ID Arraylist {$$=mknode(1,ARRAY_LIST,yylineno,$2);strcpy($$->type_id,$1);}
         ;
Arraylist:  LS Exp RS                   {$$=$2;}
            | LS Exp RS Arraylist       {$$=mknode(2,ARRAY_LIST,yylineno,$2,$4);}
            ;



FuncDec: ID LP VarList RP   {$$=mknode(1,FUNC_DEC,yylineno,$3);strcpy($$->type_id,$1);}//鍑芥暟鍚嶅瓨鏀惧湪$$->type_id
		|ID LP  RP   {$$=mknode(0,FUNC_DEC,yylineno);strcpy($$->type_id,$1);$$->ptr[0]=NULL;}//鍑芥暟鍚嶅瓨鏀惧湪$$->type_id

        ;  
VarList: ParamDec  {$$=mknode(1,PARAM_LIST,yylineno,$1);}
        | ParamDec COMMA  VarList  {$$=mknode(2,PARAM_LIST,yylineno,$1,$3);}
        ;
ParamDec: Specifier VarDec         {$$=mknode(2,PARAM_DEC,yylineno,$1,$2);}
         ;

CompSt: LC DefList StmList RC    {$$=mknode(2,COMP_STM,yylineno,$2,$3);}
       ;
StmList: {$$=NULL; }  
        | Stmt StmList  {$$=mknode(2,STM_LIST,yylineno,$1,$2);}
        ;
Stmt:   Exp SEMI    {$$=mknode(1,EXP_STMT,yylineno,$1);}
      | CompSt      {$$=$1;}      //澶嶅悎璇彞缁撶偣鐩存帴鏈€涓鸿鍙ョ粨鐐癸紝涓嶅啀鐢熸垚鏂扮殑缁撶偣
      | CONTINUE SEMI {$$=mknode(0,CONTINUE,yylineno);}
      | BREAK SEMI {$$=mknode(0,BREAK,yylineno);}
      | RETURN Exp SEMI   {$$=mknode(1,RETURN,yylineno,$2);}
      | IF LP Exp RP Stmt %prec LOWER_THEN_ELSE   {$$=mknode(2,IF_THEN,yylineno,$3,$5);}
      | IF LP Exp RP Stmt ELSE Stmt   {$$=mknode(3,IF_THEN_ELSE,yylineno,$3,$5,$7);}
      | WHILE LP Exp RP Stmt {$$=mknode(2,WHILE,yylineno,$3,$5);}
      | FOR LP Def Exp SEMI Exp RP Stmt{$$=mknode(4,FOR,yylineno,$3,$4,$6,$8);} 
      | FOR LP Exp SEMI Exp SEMI Exp RP Stmt{$$=mknode(4,FOR,yylineno,$3,$5,$7,$9);} 
      ;
DefList: {$$=NULL; }
        | Def DefList {$$=mknode(2,DEF_LIST,yylineno,$1,$2);}
        | error SEMI   {$$=NULL;}
        ;
Def:    Specifier DecList SEMI {$$=mknode(2,VAR_DEF,yylineno,$1,$2);}
        ;
DecList: Dec  {$$=mknode(1,DEC_LIST,yylineno,$1);}
       | Dec COMMA DecList  {$$=mknode(2,DEC_LIST,yylineno,$1,$3);}
	   ;
Dec:     VarDec  {$$=$1;}
       | VarDec ASSIGNOP Exp  {$$=mknode(2,ASSIGNOP,yylineno,$1,$3);strcpy($$->type_id,"ASSIGNOP");}
       ;
Exp:    Exp ASSIGNOP Exp {$$=mknode(2,ASSIGNOP,yylineno,$1,$3);strcpy($$->type_id,"ASSIGNOP");}//$$缁撶偣type_id绌虹疆鏈敤锛屾濂藉瓨鏀捐繍绠楃
      | Exp STARASSIGNOP Exp {$$=mknode(2,STARASSIGNOP,yylineno,$1,$3);strcpy($$->type_id,"STARASSIGNOP");}
      | Exp DIVASSIGNOP Exp {$$=mknode(2,DIVASSIGNOP,yylineno,$1,$3);strcpy($$->type_id,"DIVASSIGNOP");}
      | Exp PLUSASSIGNOP Exp {$$=mknode(2,PLUSASSIGNOP,yylineno,$1,$3);strcpy($$->type_id,"PLUSASSIGNOP");}
      | Exp MINUSASSIGNOP Exp {$$=mknode(2,MINUSASSIGNOP,yylineno,$1,$3);strcpy($$->type_id,"MINUSASSIGNOP");}
      | Exp AND Exp   {$$=mknode(2,AND,yylineno,$1,$3);strcpy($$->type_id,"AND");}
      | Exp OR Exp    {$$=mknode(2,OR,yylineno,$1,$3);strcpy($$->type_id,"OR");}
      | Exp RELOP Exp {$$=mknode(2,RELOP,yylineno,$1,$3);strcpy($$->type_id,$2);}  //璇嶆硶鍒嗘瀽鍏崇郴杩愮畻绗﹀彿鑷韩鍊间繚瀛樺湪$2涓�
      | Exp PLUSPLUS {$$=mknode(1,PLUSPLUS,yylineno,$1);strcpy($$->type_id,"RPLUSPLUS");}
      | PLUSPLUS Exp {$$=mknode(1,PLUSPLUS,yylineno,$2);strcpy($$->type_id,"LPLUSPLUS");}
      | MINUSMINUS  Exp      {$$=mknode(1,MINUSMINUS,yylineno,$2);strcpy($$->type_id,"LMINUSMINUS");}
      | Exp MINUSMINUS      {$$=mknode(1,MINUSMINUS,yylineno,$1);strcpy($$->type_id,"RMINUSMINUS");}
      | Exp PLUS Exp  {$$=mknode(2,PLUS,yylineno,$1,$3);strcpy($$->type_id,"PLUS");}
      | Exp MINUS Exp {$$=mknode(2,MINUS,yylineno,$1,$3);strcpy($$->type_id,"MINUS");}
      | Exp STAR Exp  {$$=mknode(2,STAR,yylineno,$1,$3);strcpy($$->type_id,"STAR");}
      | Exp DIV Exp   {$$=mknode(2,DIV,yylineno,$1,$3);strcpy($$->type_id,"DIV");}
      | LP Exp RP     {$$=$2;}
      | MINUS Exp %prec UMINUS   {$$=mknode(1,UMINUS,yylineno,$2);strcpy($$->type_id,"UMINUS");}
      | NOT Exp       {$$=mknode(1,NOT,yylineno,$2);strcpy($$->type_id,"NOT");}
      | DPLUS  Exp      {$$=mknode(1,DPLUS,yylineno,$2);strcpy($$->type_id,"DPLUS");}
      |   Exp DPLUS      {$$=mknode(1,DPLUS,yylineno,$1);strcpy($$->type_id,"DPLUS");}
      | ID LP Args RP {$$=mknode(1,FUNC_CALL,yylineno,$3);strcpy($$->type_id,$1);}
      | ID LP RP      {$$=mknode(0,FUNC_CALL,yylineno);strcpy($$->type_id,$1);}
      | ID            {$$=mknode(0,ID,yylineno);strcpy($$->type_id,$1);}
      | INT           {$$=mknode(0,INT,yylineno);$$->type_int=$1;$$->type=INT;}
      | FLOAT         {$$=mknode(0,FLOAT,yylineno);$$->type_float=$1;$$->type=FLOAT;}
      | CHAR          {$$=mknode(0,CHAR,yylineno);$$->type_char=$1;$$->type=CHAR;}
      | ID Arraylist {$$=mknode(1,ARRAY_ID,yylineno,$2);strcpy($$->type_id,$1);}
      ;
Args:    Exp COMMA Args    {$$=mknode(2,ARGS,yylineno,$1,$3);}
       | Exp               {$$=mknode(1,ARGS,yylineno,$1);}
       ;
       
%%

int main(int argc, char *argv[]){
	yyin=fopen(argv[1],"r");
	if (!yyin) return;
	yylineno=1;
	yyparse();
	return 0;
	}

#include<stdarg.h>
void yyerror(const char* fmt, ...)
{
    va_list ap;
    va_start(ap, fmt);
    fprintf(stderr, "Grammar Error at Line %d Column %d: ", yylloc.first_line,yylloc.first_column);
    vfprintf(stderr, fmt, ap);
    fprintf(stderr, ".\n");
}
