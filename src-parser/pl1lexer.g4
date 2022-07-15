lexer grammar pl1lexer;
@header { 
package com.nttdata.imagn.antlr; 
}
@members {
    public static final int CHANNEL_UNKNOWN  = 1;
    public static final int CHANNEL_COMMENTS = 2;
    private String toHex(String s){ 
        StringBuffer hex = new StringBuffer();
        char[] raw = s.toCharArray();
        for (int i=0;i<raw.length;i++) {
          if     (raw[i]<=0x000F) { hex.append("000"); }
          else if(raw[i]<=0x00FF) { hex.append("00" ); }
          else if(raw[i]<=0x0FFF) { hex.append("0"  ); }
          hex.append(Integer.toHexString(raw[i]).toUpperCase());
        }
        return hex.toString();
    }
}

PP_INCLUDE      : '%' WSP* I N C L U D E WSP (.)*? ';' 
                   { /*System.out.println(">>> Include >"+getText()+"<");*/
                     performIncludeSourceFile(getText()); 
                     skip();
                   };

PROCESS: '*' WSP* P R O C E S S (.)*? ';' ->skip ;

        
A_              : A;
ABNORMAL        : A B N O R M A L;
ACTIVATE        : A C T (I V A T E)?;
ADDBUFF         : A D D B U F F;
ALIAS           : A L I A S;
ALIGNED         : A L I G N E D;
ALLOCATE        : A L L O C (A T E)?;
ANYCONDITION    : A N Y C O N D (I T I O N)?;
AREA            : A R E A;
ASCII           : A S C I I;
ASSIGNABLE      :(A S S I G N A B L E) | (A S G N);
ASSEMBLER       :(A S S E M B L E R) | (A S M);
ATTACH          :(A T T A C H);
ATTENTION       :(A T T E N T I O N) | (A T T N);
AUTOMATIC       : A U T O (M A T I C)?;
B_              : B;
B1              : B '1';
B2              : B '2';
B3              : B '3';
B4              : B '4';
BACKWARDS       : B A C K W A R D S ;
BASED           : B A S E D;
BEGIN           : B E G I N;
BIGENDIAN       : B I G E N D I A N;
BINARY          : (B I N) (A R Y)?;
BIT             : B I T;
BKWD            : B K W D;
BLKSIZE         : B L K S I Z E ;
BUFFERED        : B U F (F E R E D)?;
BUFFERS         : B U F F (E R S)?;
BUFFOFF         : B U F F O F F;
BUFND           : B U F N D;
BUFNI           : B U F N I;
BUFSP           : B U F S P;
BUILTIN         : B U I L T I N;
BY              : B Y;
BYADDR          : B Y A D D R;
BYVALUE         : B Y V A L U E;
BX              : B X;
C_              : C ;
CALL            : C A L L ;
CDECL           : C D E C L;
CELL            : C E L L;
CHARACTER       : C H A R (A C T E R)?;
CHARGRAPHIC     : C H A R G  (R A P H I C)?;
CHECK           : C H E C K;
CLOSE           : C L O S E;
COBOL           : C O B O L;
COLUMN          : C O L (U M N)?;
COMPLEX         :(C O M P L E X) | (C P L X);
CONNECTED       : C O N N (E C T E D)?;
CONDITION       : C O N D (I T I  O N)?;
CONSECUTIVE     : C O N S E C U T I V E;
CONSTANT        : C O N S T (A N T)?;
CTLASA          : C T L A S A;
CTL360          : C T L '360';
CONTROLLED      :(C O N T R O L L E D) |( C T L);
CONVERSION      : C O N V (E R S I O N)?;
COPY            : C O P Y;
D_              : D ;
DB              : D B;
DATA            : D A T A;
DATE            : D A T E;
DECLARE         :(D E C L A R E) | (D C L); //       specialKeyWord(DECLARE,DECLARE,VARNAME';
DEACTIVATE      : D E A C T (I V A T E)?;
DECIMAL         : D E C (I M A L)?;
DEFAULT         :(D E F A U L T)|(D F T); // specialKeyWord(DEFAULT,DEFAULT,VARNAME);
DELAY           : D E L A Y ;
DELETE          : D E L E T E;
DEFINE          : D E F I N E;
DEFINED         : D E F (I N E D)?;
DESCRIPTOR      : D E S C R I P T O R ;
DESCRIPTORS     : D E S C R I P T O R S;
DETACH          : D E T A C H;
DIMENSION       : D I M (E N S I O N)?;
DIRECT          : D I R E C T;
DISPLAY         : D I S P L A Y;
DO              : D O;
DOWNTHRU        : D O W N T H R U;
E_              : E ;
EDIT            : E D I T ;
ELSE            : E L S E;
END             : E N D; /* END can be a preprocessor stmt */ 
ENDFILE         : E N D F I L E;
ENDPAGE         : E N D P A G E;
ENTRY           : E N T R Y ; // specialKeyWord(ENTRY,ENTRY,ENTRY);
ENVIRONMENT     : E N V (I R O N M E N T)?;
ERROR           : E R R O R;
EVENT           : E V E N T;
EXCLUSIVE       : E X C L (U S I V E)?;
EXIT            : E X I T;
EXPORTS         : E X P O R T S;
EXTERNAL        : E X T (E R N A L)?;
F_              : F;
FB              : F B ;
FS              : F S;
FBS             : F B S; 
FETCH           : F E T C H ;
FETCHABLE       : F E T C H A B L E;
FILE            : F I L E ;
FINISH          : F I N I S H;
FIXED           : F I X E D;
FIXEDOVERFLOW   :(F I X E D O V E R F L O W) |(F O F L);
FLOAT           : F L O A T;
FLUSH           : F L U S H;
FREE            : F R E E ;
FOREVER         : F O R E V E R;
FORTRAN         : F O R T R A N ;
FORMAT          : F O R M A T; // specialKeyWord(FORMAT,FORMAT_STMT,FORMAT);
FROM            : F R O M;
FROMALIEN       : F R O M A L I E N;
G_              : G;
GENERIC         : G E N E R I C;
GENKEY          : G E N K E Y;
GET             : G E T;
GO              : G O;
GOTO            : G O T O; 
GRAPHIC         : G R A P H I C;
GX              : G X;
HANDLE          : H A N D L E;
HEXADEC         : H E X A D E C;
I_              : I;
IEEE            : I E E E ;
IF              : I F ;
IGNORE          : I G N O R E ;
IMPORTED        : I M P O R T E D;
IN              : I N ;
INCLUDE         : I N C L U D E;
INDEXAREA       : I N D E X A R E A;
INDEXED         : I N D E X E D;
INITIAL         : I N I T (I A L)?;
INLINE          : I N L I N E ;
INPUT           : I N P U T ;
INTER           : I N T E R;
INTERACTIVE     : I N T E R A C T I V E;
INTERNAL        : I N T (E R N A L)?;
INTO            : I N T O;
INVALIDOP       : I N V A L I D O P;
IRREDUCIBLE     : I R R E D (U C I B L E)?;
ITERATE         : I T E R A T E;
KEY             : K E Y ;
KEYED           : K E Y E D;
KEYFROM         : K E Y F R O M;
KEYLENGTH       : K E Y L E N G T H;
KEYLOC          : K E Y L O C;
KEYTO           : K E Y T O;
LABEL           : L A B E L;
LEAVE           : L E A V E ;
LIMITED         : L I M I T E D ;
LIKE            : L I K E ;
LINE            : L I N E ;
LINESIZE        : L I N E S I Z E;
LINKAGE         : L I N K A G E;
LIST            : L I S T ;
LITTLEENDIAN    : L I T T L E E N D I A N;
LOCAL           : L O C A L ;
LOCATE          : L O C A T E ;
LOOP            : L O O P ;
M_              : M;
MAIN            : M A I N ;
NAME            : N A M E ;
NCP             : N C P ;
NOCHARGRAPHIC   : N O C H A R G (R A P H I C)?;
NOCHECK         : N O C H E C K;
NOCONVERSION    : N O C O N V (E R S I O N)?;
NODESCRIPTOR    : N O D E S C R I P T O R;
NOEXECOPS       : N O E X E C O P S ;
NOFIXEDOVERFLOW : N O F ((I X E D O V E R F L O W) | (O F L));
NOLOCK          : N O L O C K;
NONASSIGNABLE   :(N O N A S S I G N A B L E)|(N O N A S G N);
NONCONNECTED    : N O N C O N N (E C T E D)?;
NONE            : N O N E;
NONVARYING      : N O N V A R (Y I N G)?;
NON_QUICK       : N O N '_' Q U I C K;
NO_QUICK_BLOCKS : N O '_' Q U I C K '_' B L O C K S;
NOINIT          : N O I N I T;
NOINLINE        : N O I N L I N E;
NOINVALIDOP     : N O I N V A L I D O P ;
NOOVERFLOW      : N O O ((V E R F L O W) | (F L));
NOPRINT         : N O P R I N T;
NORMAL          : N O R M A L;
NOSIZE          : N O S I Z E;
NOSUBSCRIPTRANGE: N O S U B ((S C R I P T R A N G E)|(R G));
NOSTRINGRANGE   : N O S T R ((I N G R A N G E)|(G));
NOSTRINGSIZE    : N O S T R ((I N G S I Z E)|(Z));
NOTE            : N O T E;
NOUNDERFLOW     : N O U ((N D E R F L O W) | (F L));
NOWRITE         : N O W R I T E;
NOZERODIVIDE    : N O Z ((E R O D I V I D E) | (D I V));
OFFSET          : O F F S E T;
ON              : O N;
OPEN            : O P E N ;
OPTIONAL        : O P T I O N A L;
OPTIONS         : O P T I O N S;
OPTLINK         : O P T L I N K;
ORDER           : O R D E R;
ORDINAL         : O R D I N A L;
OTHERWISE       : O T H E R (W I S E)?; // specialKeyWord(OTHERWISE,OTHERWISE,VARNAME);
OUTPUT          : O U T P U T;
OVERFLOW        :(O V E R F L O W) | (O F L);
P_              : P;
PACKAGE         : P A C K A G E ;
PACKED_DECIMAL  : P A C K E D '_' D E C I M A L;
PACKED          : P A C K E D;
PAGE            : P A G E;
PAGESIZE        : P A G E S I Z E;
PARAMETER       : P A R ((A M E T E R) | (M));
PASSWORD        : P A S S W O R D;
PENDING         : P E N D I N G ;
PICTURE         : P I C (T U R E)?;
POINTER         :(P O I N T E R) | (P T R);
POSITION        : P O S (I T I O N)?;
PRECISION       : P R E C (I S I O N)?;
PRINT           : P R I N T;
PRIORITY        : P R I O R I T Y;
PROCEDURE       : P R O C (E D U R E)?; // specialKeyWord(PROCEDURE,PROCEDURE,VARNAME);
PUT             : P U T;
R_              : R;
RANGE           : R A N G E;
READ            : R E A D;
REAL            : R E A L;
RECORD          : R E C O R D;
RECSIZE         : R E C S I Z E;
RECURSIVE       : R E C U R S I V E;
REDUCIBLE       : R E D (U C I B L E)?;
REENTRANT       : R E E N T R A N T;
REFER           : R E F E R ;
REGIONAL        : R E G I O N A L;
RELEASE         : R E L E A S E ;
RENAME          : R E N A M E;
REORDER         : R E O R D E R;
REPEAT          : R E P E A T;
REPLACE         : R E P L A  C E;
REPLY           : R E P L Y;
REREAD          : R E R E A D;
RESERVED        : R E S E R V E D;
RESERVES        : R E S E R V E S;
RESIGNAL        : R E S I G N A L;
RETCODE         : R E T C O D E;
RETURN          : R E T U R N;
RETURNS         : R E T U R N S;
REUSE           : R E U S E;
REVERT          : R E V E R T;
REWRITE         : R E W R I T E;
SCALARVARYING   : S C A L A R V A R Y I N G;
SELECT          : S E L E C T;
SEPARATE_STATIC : S E P A R A T E '_' S T A T I C;
SET             : S E T;
SEQUENTIAL      :(S E Q U E N T I A L) | (S E Q L);
SIGNAL          : S I G N A L;
SIGNED          : S I G N E D ;
SIS             : S I S ;
SIZE            : S I Z E;
SKIP            : S K I P;
SNAP            : S N A P; // specialKeyWord(SNAP,SNAP,VARNAME);
STATIC          : S T A T I C;
STDCALL         : S T D C A L L;
STORAGE         : S T O R A G E;
STOP            : S T O P ;
STREAM          : S T R E A M;
STRING          : S T R I N G;
STRINGRANGE     :(S T R I N G R A N G E) | (S T R G);
STRINGSIZE      :(S T R I N G S I Z E) | (S T R Z);
STRINGVALUE     : S T R I N G V A L U E;
STRUCTURE       : S T R U C T U R E;
SUB             : S U B;
SUBSCRIPTRANGE  :(S U B S C R I P T R A N G E) | (S U B R G);
SUPPORT         : S U P P O R T;
SYSTEM          : S Y S T E M;
TASK            : T A S K;
THEN            : T H E N;
THREAD          : T H R E A D;
TITLE           : T I T L E ;
TO              : T O;
TOTAL           : T O T A L;
TP              : T P;
TRANSIENT       : T R A N S I E N T;
TRANSMIT        : T R A N S M I T;
TRKOFL          : T R K O F L;
TSTACK          : T S T A C K;
TYPE            : T Y P E;
U_              : U;
UNALIGNED       : U N A L (I G N E D)?;
UNBUFFERED      : U N B U F (F E R E D)?;
UNCONNECTED     : U N C O N N E C T E D;
UNDEFINEDFILE   :(U N D E F I N E D F I L E) | (U N D F);
UNDERFLOW       :(U N D E R F L O W) | (U F L);
UNION           : U N I O N;
UNLOCK          : U N L O C K;
UNSIGNED        : U N S (I G N E D)?;
UNTIL           : U N T I L;
UPDATE          : U P D A T E;
UPTHRU          : U P T H R U;
V_              : V;
VALIDATE        : V A L I D A T E;
VALUE           : V A L U E;
VARIABLE        : V A R I A B L E;
VARYING         : V A R (Y I N G)?;
VARYINGZ        : V A R (Y I N G)? Z;
VB              : V B ;
VBS             : V B S;
VS              : V S;
VSAM            : V S A M;
WAIT            : W A I T;
WHEN            : W H E N;
WIDECHAR        : W (I D E)? C H A R;
WINMAIN         : W I N M A I N;
WHILE           : W H I L E;
WRITE           : W R I T E;
WX              : W X;
X_              : X;
XN              : X N;
XU              : X U;

ZERODIVIDE      :(Z E R O D I V I D E) | (Z D I V); 

COMMENT: '/*' (.)*? '*/' ->channel(CHANNEL_COMMENTS) ; 
STR_CONSTANT: ( '\'' ( ~'\'' | '\'\'' )* '\'')|( '"' ( ~'"' | '""' )* '"');

NUM: NBR ;
NUMFLOAT: (  '.'NBR NBREE   ) |
          (  '.'NBR         ) |
        ( NBR NBREE         ) |
        ( NBR '.'           ) |
        ( NBR '.' NBREE     ) |
        ( NBR '.' NBR NBREE ) |
        ( NBR '.' NBR       ) ;


CONCAT: '||' | '!!' ;
POWER: '**';
AND :'&';
OR: '|' | '!';
NOT: '0xAC' | '^' | '~' ; 

GE: '0xAC<' | '^<' | '~<' | '>=';
LE: '0xAC>' | '^>' | '~>' | '<=';
NE: '<>' | '0xAC=' | '^=' | '~=';


PTR: '->';
HANDLEPTR: '=>';
SELFOP: ([+\-*/\|!&]'=') | '||=' | '**=' | '!!=' ;

COMMA_:',';
DOT_:'.';
RPAR_: '(';
LPAR_: ')';
LT_:'<';
GT_:'>';
EQ_:'=';
MINUS_:'-';
PLUS_:'+';
STAR_:'*';
DASH_:'/';
COLON_:':';
SEMI_:';';

VARNAME: (CHR|LET)(CHR|LET|[0-9])* ;
WSP: (' '|'\t'|'\n'|'\r')+ -> skip;

UNKNOWN : .  //->channel(CHANNEL_UNKNOWN) ; 
          { //System.err.println("PL1Lexer error Unknown char>"+getText()+"<>"+toHex(getText()));
            setChannel(CHANNEL_UNKNOWN);  
          };

fragment NBR: [0-9][0-9_]*;
fragment LET: [A-Za-z]+;
fragment CHR: [_$#@]+;
fragment NBREE  : (D|E|F|S|Q)('+'|'-')? NBR ;

/* case handling */
fragment A: [aA];
fragment B: [bB];
fragment C: [cC];
fragment D: [dD];
fragment E: [eE];
fragment F: [fF];
fragment G: [gG];
fragment H: [hH];
fragment I: [iI];
fragment J: [jJ];
fragment K: [kK];
fragment L: [lL];
fragment M: [mM];
fragment N: [nN];
fragment O: [oO];
fragment P: [pP];
fragment Q: [qQ];
fragment R: [rR];
fragment S: [sS];
fragment T: [tT];
fragment U: [uU];
fragment V: [vV];
fragment W: [wW];
fragment X: [xX];
fragment Y: [yY];
fragment Z: [zZ];
