parser grammar pl1parser;
@header {
package com.nttdata.imagn.antlr; 
}
options { tokenVocab=pl1lexer; }
pl1pgm: pl1stmtlist 
        EOF
    ;

pl1stmtlist:
        (pl1stmt ';')+              
    ;

// pl1stmt is used by all rules that allow for a pl1 stmt to follow.
pl1stmt:    
       (prestmtlist ':')* (stmt | stmtscope)?
    ;

preconditioncommalist:
        precondition (',' precondition)*
    ;

prestmtlist:    
      ( varnamequal | ( '(' preconditioncommalist ')' ) )
    ;


stmtscopeend:
        (prestmtlist ':')* endstmt     
    ;

stmtwhen:
    (prestmtlist ':')* whenstmt
    ;

stmtotherwise:
    (prestmtlist ':')* otherwisestmt
    ;

stmtelse:
    (prestmtlist ':')* elsestmt
    ;
    

/* stmtscope: all statements that need an END statement or special scope handling */
stmtscope:
      ( beginstmt    ';' pl1stmtlist? stmtscopeend )  # stmtscopebeginstmt
    | ( dostmt       ';' pl1stmtlist? stmtscopeend )  # stmtscopedostmt   
    | ( packagestmt  ';' pl1stmtlist? stmtscopeend )  # stmtscopepackagestmt //TODO: pl1stmtlist can be declare, define or procedure statement.
    | ( procedurestmt';' pl1stmtlist? stmtscopeend )  # stmtscopeprocedurestmt
    | ( selectstmt   ';' (stmtwhen ';')* (stmtotherwise ';' )? stmtscopeend) # stmtscopeselectstmt
    | ( ifstmt (';' stmtelse)? )                      # stmtscopeifstmt
    ;
stmt:
        allocatestmt 
    |   assignstmt  
    |   attachstmt  
    |   callstmt    
    |   closestmt   
    |   dclstmt     
    |   defaultstmt 
    |   definealiasstmt 
    |   defineordinalstmt 
    |   definestructurestmt 
    |   delaystmt   
    |   deletestmt  
    |   detachstmt  
    |   displaystmt 
    |   entrystmt                  
    |   exitstmt    
    |   fetchstmt   
    |   flushstmt   
    |   formatstmt  
    |   freestmt    
    |   getstmt     
    |   gotostmt    
    |   iteratestmt 
    |   leavestmt   
    |   locatestmt  
    |   onstmt      
    |   openstmt    
    |   putstmt    
    |   readstmt   
    |   releasestmt 
    |   resignalstmt
    |   returnstmt  
    |   revertstmt  
    |   rewritestmt 
    |   signalstmt  
    |   stopstmt    
    |   waitstmt    
    |   writestmt   
    |   unlockstmt  
    ;

allocatestmt:   ALLOCATE allocateoptionlist
    ;
allocateoptionlist:
        allocateoption (',' allocateoption)*
    ;
allocateoption: 
        varnameref
    |   varnameref IN  '(' varnameref ')'
    |   varnameref SET '(' varnameref ')'
    |   varnameref IN  '(' varnameref ')' SET '(' varnameref ')'
    |   varnameref SET '(' varnameref ')' IN  '(' varnameref ')'
    |   NUM varnameref
    |   varnameref ctloptionlist
    |   NUM varnameref ctloptionlist
    ;

attachstmt:
        ATTACH varnameref
    |   ATTACH varnameref THREAD '(' varnameref ')'
    |   ATTACH varnameref THREAD '(' varnameref ')' ENVIRONMENT '(' ')'
    |   ATTACH varnameref THREAD '(' varnameref ')' ENVIRONMENT '(' TSTACK '(' expr ')' ')'
    |   ATTACH varnameref ENVIRONMENT '(' ')'
    |   ATTACH varnameref ENVIRONMENT '(' TSTACK '(' expr ')' ')'
    |   ATTACH varnameref ENVIRONMENT '(' ')'   THREAD '(' varnameref ')'
    |   ATTACH varnameref ENVIRONMENT '(' TSTACK '(' expr ')' ')'   THREAD '(' varnameref ')'
    ;
    

/* dimension is part of the varnameref */
ctloptionlist:  
        ctlvarattribute
    |   ctlvarattribute dclinit
    |   dclinit
    ;

ctlvarattribute:
        CHARACTER '(' expr ')'
    |   BIT  '(' expr ')'
    |   GRAPHIC '(' expr ')'
    |   AREA '(' expr ')'
    ;

beginstmt:  
        BEGIN  
    |   BEGIN OPTIONS '(' beginstmtoptionlist ')'  
    ;

beginstmtoptionlist:
        beginstmtoption (','? beginstmtoption)*
    ;
    
beginstmtoption:
        ORDER
    |   REORDER
    |   NOCHARGRAPHIC
    |   CHARGRAPHIC
    |   NOINLINE
    |   INLINE
    |   NON_QUICK
    |   NO_QUICK_BLOCKS
    |   SUPPORT
    ;

delaystmt:  DELAY '(' expr ')' ;

callstmt:   CALL calloptionlist ;
closestmt:  CLOSE closegrouplist    ;

defaultstmt:    
        DEFAULT defaultitemcommalist 
    |   DEFAULT NONE
    ;
definealiasstmt: DEFINE ALIAS varname dcloptionlist;
defineordinalstmt: 
        DEFINE ORDINAL varname  '(' ordinalmembercommalist  ')' ordinaloptionlist?
    ;
definestructurestmt:
        DEFINE STRUCTURE dclstructurecommalist
    ;
dclstructurecommalist:
        dclstructure (',' dclstructure)*
    ;
    
dclstructure:   
        NUM varname
    |   NUM varname CELL
    |   NUM varname UNION
    |   NUM varname dclfactor
    |   NUM '*'
    |   NUM '*' CELL
    |   NUM '*' UNION
    |   NUM '*' dclfactor
    ;

ordinalmembercommalist: 
        ordinalmember ( ',' ordinalmember)*
    ;
ordinalmember:  
        varname
    |   varname VALUE '(' NUM ')'
    ;
ordinaloptionlist:
        ordinaloption+
    ;
ordinaloption:
        PRECISION '(' NUM ')'
    |   SIGNED
    |   UNSIGNED
    ;

displaystmt:
        DISPLAY '(' expr ')'
    |   DISPLAY '(' expr ')' REPLY '(' varnameref ')'
    |   DISPLAY '(' expr ')' REPLY '(' varnameref ')' EVENT '(' varnameref ')'
    |   DISPLAY '(' expr ')' EVENT '(' varnameref ')' REPLY '(' varnameref ')'
    ;

deletestmt: DELETE FILE '(' varnameref ')' ( KEY '(' expr ')' )?
    ;

detachstmt: DETACH THREAD '(' varnameref ')'
    ;
elsestmt:   ELSE pl1stmt
    ;
endstmt:    
        END 
    |   END varname 
    ;

entrystmt:
        ENTRY entrygrouplist 
    |   ENTRY 
    ;
exitstmt:   EXIT            ;

fetchstmt:  FETCH fetchoptioncommalist ;

fetchoptioncommalist:
        fetchoption (',' fetchoption)*
    ;
fetchoption:
        varnameref
    |   varnameref SET   '(' varnameref ')'
    |   varnameref TITLE '(' expr ')'
    |   varnameref SET   '(' varnameref ')' TITLE '(' expr ')'
    |   varnameref TITLE '(' expr ')' SET   '(' varnameref ')'
    ;
flushstmt:  FLUSH FILE '(' varnameref ')'
    |       FLUSH FILE '(' '*' ')'
    ;
formatstmt: FORMAT formatgrouplist
    ;
freestmt:   FREE freeoption;

freeoption: 
        varnameref ( IN '(' varnameref ')' )? 
   (',' varnameref ( IN '(' varnameref ')' )?)*
    ;

getstmt:
        GET getoptionlist
    |   GET '(' varnamedimensioncommalist ')' /* check that varnamedimensioncommalist doesnt contain '*' */
    |   GET '(' varnamedimensioncommalist ')' getoptionlist
    ;

gotostmt:
        GO TO varnameref
    |   GOTO varnameref 
    ;
iteratestmt:
        ITERATE
    |   ITERATE varnameref
    ;
leavestmt:
        LEAVE
    |   LEAVE varnameref 
    ;
locatestmt: LOCATE varnameref 
        ( FILE '(' varnameref ')' )?
        ( SET   '(' varnameref ')' )?
        ( KEYFROM '(' expr ')' )? ;

onstmt:
        ON onconditioncommalist SYSTEM
    |   ON onconditioncommalist SNAP SYSTEM
    |   ON onconditioncommalist SNAP pl1stmt
    |   ON onconditioncommalist pl1stmt
    ;

openstmt:   OPEN opengrouplist  ;

packagestmt:
        PACKAGE    
    |   PACKAGE packagegrouplist  
    ;
    
packagegrouplist:
        packagegroup+
    ;
packagegroup:
        EXPORTS '(' '*' ')'
    |   EXPORTS '(' packagevarnamecommalist ')'
    |   RESERVES '(' '*' ')'
    |   RESERVES '(' varnamecommalist ')'
    |   OPTIONS '(' ')'
    |   OPTIONS '(' packageoptionlist ')'
    ;
packagevarnamecommalist:
        packagevarname (',' packagevarname)*
    ;

packagevarname:
        varname
    |   varname EXTERNAL '(' STR_CONSTANT ')'
    ;
packageoptionlist:
        packageoption (','? packageoption)+
    ;
packageoption: 
        NOCHARGRAPHIC
    |   CHARGRAPHIC
    |   ORDER
    |   REORDER
    |   REENTRANT
    ;
putstmt:
        PUT putoptionlist
//    |   PUT '(' varnamedimensioncommalist ')' /* check that varnamedimensioncommalist doesnt contain '*' */
//    |   PUT '(' varnamedimensioncommalist ')'  putoptionlist
    ;
procedurestmt:
        PROCEDURE procgrouplist
    |   PROCEDURE 
    ;
    
readstmt:   READ FILE '('varnameref ')' 
      (
        IGNORE '(' expr ')'
      | (SET | INTO) '(' varnameref ')' 
           (  (KEY | KEYTO) '(' expr ')' )?
      )?
      (EVENT '(' varnameref ')' ) ?
      NOLOCK?
;
releasestmt:    
        RELEASE varnamecommalist
    |   RELEASE '*'
    ;
resignalstmt:   RESIGNAL ;
returnstmt: RETURN
    |   RETURN '(' expr ')'
    ;
rewritestmt:    REWRITE FILE'(' varnameref ')' ( FROM '(' varnameref ')' )? ( KEY '(' expr ')' )? (EVENT '(' varnameref ')' )? ;

revertstmt: REVERT onconditioncommalist ;

signalstmt: SIGNAL oncondition  ;
stopstmt:   STOP            ;

unlockstmt: UNLOCK unlockoptionlist ;

waitstmt:
        WAIT '(' varnamedimensioncommalist ')' /* varnamedimensioncommalist has to be varnameref's */
    |   WAIT '(' varnamedimensioncommalist ')' '(' expr ')'
    |   WAIT THREAD '(' varnameref ')'
    ;
    
writestmt:  WRITE FILE'(' varnameref ')' FROM '(' varnameref ')' (  (KEY | KEYFROM) '(' expr ')' )? (EVENT '(' varnameref ')' )? 
    ;

selectstmt:
        SELECT 
    |   SELECT '(' expr ')' 
    ;

whenstmt:   WHEN '(' expr (',' expr)* ')'  pl1stmt
    ;

otherwisestmt:  OTHERWISE pl1stmt
    ;

unlockoptionlist:
        unlockoption+
    ;

calloptionlist: 
        varnameref
    |   varnameref callmultitaskoptionlist
    ;

callmultitaskoptionlist:
        callmultitaskoption+
    ;

callmultitaskoption:
        TASK
    |   TASK '(' varnameref ')'
    |   EVENT '(' varnameref ')'
    |   PRIORITY '(' varnameref ')'
    ;
closegrouplist: 
        closegroup (',' closegroup)*
    ;

defaultitemcommalist:
        defaultitem (',' defaultitem)*
    ;
    
defaultitem:
        defaultpredicateexpr
    |   defaultpredicateexpr dcloptionlist
    |   defaultpredicateexpr dcloptionlist VALUE '(' dcloptionlist ')'
    |   '(' defaultitemcommalist ')'
    |   '(' defaultitemcommalist ')' dcloptionlist
    |   '(' defaultitemcommalist ')' dcloptionlist  VALUE '(' dcloptionlist ')'
    |   '(' defaultitemcommalist ')' ERROR
    ;

defaultrangespec:
            varname (':' varname)? 
       (',' varname (':' varname)?)*
    ;


defaultpredicateexpr: 
        defaultpredicateexpr AND defaultpredicateexpr
    |   defaultpredicateexpr OR  defaultpredicateexpr
    |   NOT defaultpredicateexpr /* %prec NOT */
    |   '(' defaultpredicateexpr ')' 
    |   RANGE '(' '*' ')'
    |   RANGE '(' defaultrangespec ')'
    |   DESCRIPTORS
    |   dcloption 
    ;

procgrouplist:
        procgroup+
    ;
entrygrouplist:
        entrygroup+
    ;
formatgrouplist:
        '(' editformatlist ')'
    ;

unlockoption:
        FILE '(' varnameref ')'
    |   KEY   '(' expr ')'
    ;

opengrouplist:
        opengroup (',' opengroup)*
    ;

opengroup:
        FILE '(' varnameref ')' openoptionlist?
    ;

openoptionlist:
        openoption+
    ;

openoption:
        STREAM
    |   RECORD
    |   INPUT
    |   OUTPUT
    |   UPDATE
    |   DIRECT
    |   SEQUENTIAL
    |   TRANSIENT
    |   BUFFERED
    |   UNBUFFERED
    |   BACKWARDS
    |   EXCLUSIVE
    |   KEYED
    |   PRINT
    |   TITLE '(' expr ')'
    |   LINESIZE '(' expr ')'
    |   PAGESIZE '(' expr ')'
    |   ENVIRONMENT '(' environmentspeclist ')'
    ;

closegroup:
        FILE '(' varnameref ')' ENVIRONMENT '(' LEAVE ')'
    |   FILE '(' varnameref ')' ENVIRONMENT '(' REREAD ')'
    |   FILE '(' varnameref ')'
    ;


putoptionlist:
        putoption+
    ;

putoption:
        FILE '(' varnameref ')'
    |   PAGE
    |   SKIP_
    |   SKIP_ '(' expr ')'
    |   LINE '(' expr ')'
    |   STRING '(' varnameref ')'
    |   dataspecification
    ;

entrygroup:
        '(' varnamecommalist ')' 
    |   RETURNS '(' entryparmcommalist ')' 
    |   REDUCIBLE 
    |   IRREDUCIBLE 
    |   OPTIONS '(' procoptionlist ')' 
    |   '(' ')' 
    ;

procgroup:
        '(' varnamecommalist? ')'               # ProcParmlist
    |   RETURNS '(' entryparmcommalist ')'      # ProcReturns
    |   OPTIONS '(' procoptionlist ')'          # ProcOptionsList
    |(  REDUCIBLE   
    |   IRREDUCIBLE 
    |   RECURSIVE   
    |   ORDER       
    |   REORDER     
    |   CHARGRAPHIC 
    |   NOCHARGRAPHIC )                         # ProcFlags
    ;

procoptionlist:
        procoption (','? procoption)*
    ;

procoption:
        MAIN 
    |   REENTRANT
    |   NOEXECOPS
    |   TASK 
    |   VARIABLE
    |   NON_QUICK
    |   NO_QUICK_BLOCKS
    |   PACKED_DECIMAL
    |   SEPARATE_STATIC
    |   SUPPORT
    |   RENAME '(' renamepaircommalist ')'
    |   VALIDATE
    |   VALIDATE '(' varname ')'
    ;

renamepaircommalist:
        renamepair (',' renamepair)*
    ;
    
renamepair: '(' varname ',' varname ')'
    ;

getoptionlist:
        getoption+
    ;


getoption:
        FILE '(' varnameref ')'
    |   COPY  '(' varnameref ')'
    |   PAGE
    |   SKIP_
    |   SKIP_   '(' expr ')'
    |   STRING '(' expr ')'
    |   dataspecification
    ;

dataspecification:
        LIST? '(' datalist ')'
    |   DATA  '(' datalist ')'
    |   DATA
    |   EDIT ( '(' datalist ')' '(' editformatlist ')' )+
    ;

editformatexpr:
        A_
    |   A_ '(' expr ')'
    |   B_
    |   B_ '(' expr ')'
    |   C_ '(' realformatexpr ')'
    |   C_ '(' realformatexpr ',' realformatexpr ')'
    |   realformatexpr
    |   G_
    |   G_ '(' expr ')'
    |   P_ STR_CONSTANT
    |   R_ '(' varnameref ')'
    |   X_ '(' expr ')'
    |   LINE '(' expr ')'
    |   COLUMN '(' expr ')'
    |   PAGE
    |   SKIP_
    |   SKIP_ '(' expr ')'
    ;

realformatexpr: 
        E_ '(' expr ')'
    |   E_ '(' expr ',' expr ')'
    |   E_ '(' expr ',' expr ',' expr ')'
    |   F_ '(' expr ')'
    |   F_ '(' expr ',' expr ')'
    |   F_ '(' expr ',' expr ',' expr ')'
    ;


editformatitem: 
        editformatexpr
    |   NUM editformatexpr
    |   '(' NUM ')' editformatexpr
    ;

editformatlistitem:
        editformatitem
    |   NUM '(' editformatlist ')'
    |   '(' NUM ')' '(' editformatlist ')'
    ;

editformatlist:
       editformatlistitem (',' editformatlistitem)*
 ;

datalistitem:
        expr
    |   '(' datalist do_type_3 ')'
    ;

datalist:
        datalistitem (',' datalistitem)*
    ;


dostmt: do_type_1 
    |   do_type_2 
    |   do_type_3 
    ;

do_type_1:  DO ;
do_type_2:  DO do_spec_2 ;

do_spec_2:  
        WHILE '(' expr ')' ( UNTIL '(' expr ')' )?
    |   UNTIL '(' expr ')' ( WHILE '(' expr ')' )?
    |   LOOP
    |   FOREVER
    ;

do_type_3:
         DO varnameref '=' do_spec_3list
    ;

do_spec_3list: 
         do_spec_3 (',' do_spec_3)*
    ; 


do_spec_3:
         expr 
         do_spec_3_expr?
         do_spec_2? 
          
    ;

do_spec_3_expr:
        TO expr (BY expr)?
    |   BY expr (TO expr)?
    |   REPEAT expr
    |   UPTHRU expr
    |   DOWNTHRU expr
    ;


ifstmt:     IF expr THEN pl1stmt
    ;

assignstmt:
        varnamerefcommalist '=' expr (',' BY NAME)?
    |   varnamerefcommalist SELFOP expr (',' BY NAME)?
    ;

//expr:   exprbase
//    |   exprnested
//    ;
//exprnested: 
//        '(' expr ')'
//    |   '(' expr ')' exprstrconst /* repetition factor: expr can only be NUM */
//    ;
expr:
        expr '+' expr
    |   expr '-' expr
    |   expr '*' expr
    |   expr '/' expr
    |   expr AND expr
    |   expr OR  expr
    |   expr CONCAT expr
    |   expr POWER  expr
    |   expr '=' expr
    |   expr '<' expr
    |   expr '>' expr
    |   expr LE  expr
    |   expr GE  expr
    |   expr NE  expr
    |   varnameref
    |   exprconst
    |   '-' expr /* %prec UMINUS  */
    |   '+' expr /* %prec UPLUS  */
    |   NOT expr
    |   '(' expr ')'
    |   '(' expr ')' exprstrconst /* repetition factor: expr can only be NUM */
    ;
    
exprconst:
        exprnumconst
    |   exprstrconst
    ;

exprstrconst:
        STR_CONSTANT
    |   STR_CONSTANT B_
    |   STR_CONSTANT B1
    |   STR_CONSTANT B2
    |   STR_CONSTANT B3
    |   STR_CONSTANT B4
    |   STR_CONSTANT BX
    |   STR_CONSTANT G_
    |   STR_CONSTANT GX
    |   STR_CONSTANT M_
    |   STR_CONSTANT WX
    |   STR_CONSTANT X_
    |   STR_CONSTANT XN
    |   STR_CONSTANT XU
    ;

exprnumconst:   
        NUM
    |   NUM I_
    |   NUMFLOAT
    |   NUMFLOAT I_
    |   NUM B_
    |   NUM B_ I_
    |   NUM B1
    |   NUM B1 I_
    |   NUM B2
    |   NUM B2 I_
    |   NUM B3
    |   NUM B3 I_
    |   NUM B4
    |   NUM B4 I_
    |   NUMFLOAT B_
    |   NUMFLOAT B_ I_
    |   NUMFLOAT B1
    |   NUMFLOAT B1 I_
    |   NUMFLOAT B2
    |   NUMFLOAT B2 I_
    |   NUMFLOAT B3
    |   NUMFLOAT B3 I_
    |   NUMFLOAT B4
    |   NUMFLOAT B4 I_
    ;

varnamerefcommalist:
        varnameref (',' varnameref)*
    ;

 
varnameref:
        varnamequal ( ('.' | PTR | HANDLEPTR ) varnamequal )*
    ;

/* note: the '(' varnamedimensioncommalist ')' following varname, can be either indexes to array or parameter list for procedure */
varnamequal:    
        varname ( '(' varnamedimensioncommalist ')'  )* (  '(' ')' )? 
    ;

varnamedimensioncommalist:
        varnamedimension ((','|':') varnamedimension)*
    ;

varnamedimension:
        expr
    |   '*'
    |   NUM SUB
    ;

varnamecommalist:
        varname (',' varname)*                      
    ;
 

varname:
        VARNAME            
    |   varname_kw         
    |   varname_kwpp 
    |   varname_conditions
    ;

/* Note: The varnames that are commented out, 
 *       are resolved in the scanner 
 *       and returned as token VARNAME 
 */         
varname_kw:
      A_
    | ABNORMAL
    | ADDBUFF
    | ALIAS
    | ALIGNED
    | ALLOCATE
    | ASCII
    | ASSIGNABLE
    | ASSEMBLER
    | ATTACH
    | AUTOMATIC
    | B_
    | B1
    | B2
    | B3
    | B4
    | BACKWARDS
    | BASED
    | BEGIN
    | BIGENDIAN
    | BINARY
    | BIT
    | BKWD
    | BLKSIZE
    | BUFFERED
    | BUFFERS
    | BUFFOFF
    | BUFND
    | BUFNI
    | BUFSP
    | BUILTIN
    | BY
    | BYADDR
    | BYVALUE
    | BX
    | C_
    | CALL
    | CELL
    | CDECL
    | CHARACTER
    | CHARGRAPHIC
    | CLOSE
    | COBOL
    | COLUMN
    | COMPLEX
    | CONNECTED
    | CONSECUTIVE
    | CONSTANT
    | CONTROLLED
    | COPY
    | CTLASA
    | CTL360
    | D_
    | DATA
    | DATE
    | DB
    | DECLARE // special
    | DECIMAL
    | DEFINE
    | DEFINED
    | DEFAULT // special
    | DELAY
    | DELETE
    | DESCRIPTOR
    | DESCRIPTORS
    | DETACH
    | DIMENSION
    | DISPLAY
    | DIRECT
    | DO
    | DOWNTHRU
    | E_
    | EDIT
    | ELSE
    | END
    | ENTRY     /* note the statement variant is returned as ENTRY_STMT */
    | ENVIRONMENT
    | EVENT
    | EXCLUSIVE
    | EXPORTS
    | EXTERNAL
    | EXIT
    | F_
    | FB
    | FS
    | FBS
    | FETCH
    | FETCHABLE
    | FILE
    | FIXED
    | FLOAT
    | FLUSH
    | FOREVER
    | FORMAT    /* note the statement variant is returned as FORMAT_STMT */
    | FORTRAN
    | FREE
    | FROM
    | FROMALIEN
    | G_
    | GENERIC
    | GENKEY
    | GET
    | GO
    | GOTO
    | GRAPHIC
    | GX
    | HANDLE
    | HEXADEC
    | I_
    | IEEE
    | IF
    | IGNORE
    | IMPORTED
    | IN
    | INDEXAREA
    | INDEXED
    | INITIAL
    | INLINE
    | INPUT
    | INTER
    | INTERACTIVE
    | INTERNAL
    | INTO
    | IRREDUCIBLE
    | ITERATE
    | KEYED
    | KEYLENGTH
    | KEYLOC
    | KEYTO
    | KEYFROM
    | LABEL
    | LEAVE
    | LIKE
    | LIMITED
    | LINE
    | LINESIZE
    | LINKAGE
    | LIST
    | LITTLEENDIAN
    | LOCAL
    | LOCATE
    | LOOP
    | M_
    | MAIN
    | NCP
    | NOCHARGRAPHIC
    | NOCHECK
    | NOCONVERSION
    | NODESCRIPTOR
    | NOEXECOPS
    | NOFIXEDOVERFLOW
    | NOINIT
    | NOINLINE
    | NOINVALIDOP
    | NOLOCK
    | NONASSIGNABLE
    | NONCONNECTED
    | NONE
    | NONVARYING
    | NON_QUICK
    | NO_QUICK_BLOCKS
    | NOOVERFLOW
    | NORMAL
    | NOSIZE
    | NOSUBSCRIPTRANGE
    | NOSTRINGRANGE
    | NOSTRINGSIZE
    | NOUNDERFLOW
    | NOWRITE
    | NOZERODIVIDE
    | OFFSET
    | ON
    | OPEN
    | OPTIONAL
    | OPTIONS
    | OPTLINK
    | ORDER
    | ORDINAL
    | OTHERWISE // special
    | OUTPUT
    | P_
    | PACKAGE
    | PACKED
    | PACKED_DECIMAL
    | PAGE
    | PAGESIZE
    | PARAMETER
    | PASSWORD
    | PICTURE
    | POINTER
    | POSITION
    | PRECISION
    | PRINT
    | PRIORITY
    | PROCEDURE // special
    | PUT
    | R_
    | RANGE
    | REAL
    | READ
    | RECSIZE
    | RECURSIVE
    | REENTRANT
    | REDUCIBLE
    | REFER
    | REGIONAL
    | RELEASE
    | RENAME
    | REORDER
    | REPEAT
    | REPLY
    | REREAD
    | RESERVED
    | RESERVES
    | RESIGNAL
    | RETCODE
    | RETURN
    | RETURNS
    | REUSE
    | REVERT
    | REWRITE
    | SCALARVARYING
    | SELECT
    | SEPARATE_STATIC
    | SEQUENTIAL
    | SET
    | SIGNAL
    | SIGNED
    | SIS
    | SKIP_
    | SNAP // special
    | STATIC
    | STDCALL
    | STOP
    | STREAM
    | STRING
    | STRINGVALUE
    | STRUCTURE
    | SUB
    | SUPPORT
    | SYSTEM
    | TASK
    | THEN
    | THREAD
    | TITLE
    | TO
    | TOTAL
    | TP
    | TRANSIENT
    | TRKOFL
    | TSTACK
    | TYPE
    | U_
    | UNALIGNED
    | UNBUFFERED
    | UNCONNECTED
    | UNDEFINEDFILE
    | UNION
    | UNLOCK
    | UNSIGNED
    | UNTIL
    | UPDATE
    | UPTHRU
    | V_
    | VALIDATE
    | VALUE
    | VARIABLE
    | VARYING
    | VARYINGZ
    | VB
    | VBS
    | VS
    | VSAM
    | WAIT
    | WHEN
    | WHILE
    | WIDECHAR
    | WINMAIN
    | WRITE
    | WX
    | X_
    | XN
    | XU
    ;
varname_kwpp: ACTIVATE
        | DEACTIVATE
        | INCLUDE
        | NOPRINT
        | NOTE
        | PAGE
        | REPLACE
        ;
varname_conditions:
      ANYCONDITION
    | AREA
    | ATTENTION
    | CHECK
    | CONDITION
    | CONVERSION
    | ENDFILE
    | ENDPAGE
    | ERROR
    | FINISH
    | FIXEDOVERFLOW
    | INVALIDOP
    | KEY
    | NAME
    | OVERFLOW
    | PENDING
    | RECORD
    | SIZE
    | STORAGE
    | STRINGRANGE
    | STRINGSIZE
    | SUBSCRIPTRANGE
    | TRANSMIT
    | UNDERFLOW
    | ZERODIVIDE
    ;
onconditioncommalist:
        oncondition (',' oncondition)*
    ;
    
oncondition:
        AREA
    |   ATTENTION
    |   ANYCONDITION
    |   CHECK
    |   CHECK '(' varnamerefcommalist ')'
    |   CONDITION '(' varnameref ')'
    |   CONVERSION
    |   ENDFILE '(' varnameref ')'
    |   ENDPAGE '(' varnameref ')'
    |   ERROR
    |   FINISH
    |   FIXEDOVERFLOW
    |   INVALIDOP
    |   KEY '(' varnameref ')'
    |   NAME '(' varnameref ')'
    |   OVERFLOW
    |   PENDING '(' varnameref ')'
    |   RECORD '(' varnameref ')'
    |   SIZE
    |   STORAGE
    |   STRINGRANGE
    |   STRINGSIZE
    |   SUBSCRIPTRANGE
    |   TRANSMIT '(' varnameref ')'
    |   UNDEFINEDFILE '(' varnameref ')'
    |   UNDERFLOW
    |   ZERODIVIDE
    |   VARNAME
    |   varname_kw
    ;

precondition:
        CHECK
    |   CHECK '(' varnamerefcommalist ')'
    |   CONVERSION
    |   FIXEDOVERFLOW
    |   INVALIDOP
    |   OVERFLOW
    |   SIZE
    |   STRINGRANGE
    |   STRINGSIZE
    |   SUBSCRIPTRANGE
    |   UNDERFLOW
    |   ZERODIVIDE
    |   NOCHECK
    |   NOCONVERSION
    |   NOFIXEDOVERFLOW
    |   NOINVALIDOP
    |   NOOVERFLOW
    |   NOSIZE
    |   NOSUBSCRIPTRANGE
    |   NOSTRINGRANGE
    |   NOSTRINGSIZE
    |   NOUNDERFLOW
    |   NOZERODIVIDE
    ;

dclstmt:
        DECLARE dcltermcommalist
    |   DECLARE
    ;

dcltermcommalist:
        (dclterm|dclnamebase) (',' (dclterm|dclnamebase) )*                          
    ; 

dclterm:
        '(' dcltermcommalist ')' 
    |   '(' dcltermcommalist ')' dclfactor  
    |   NUM '(' dcltermcommalist ')'
    |   NUM '(' dcltermcommalist ')' dclfactor  
    |   NUM '(' dcltermcommalist ')' CELL  
    |   NUM '(' dcltermcommalist ')' UNION 
    ;

dclnamebase:
       varname           
    |  varname dclfactor 
    |   NUM varname      
    |   NUM varname dclfactor 
    |   NUM varname CELL 
    |   NUM varname UNION 
    |   NUM '*'           
    |   NUM '*' dclfactor 
    |   NUM '*' CELL      
    |   NUM '*' UNION     
    ;
    
dclfactor:
        '(' dclarrayboundcommalist ')'               
    |   '(' dclarrayboundcommalist ')' dcloptionlist 
    |   dcloptionlist                                
    ;

dclarrayboundcommalist:
        dclarraybound (':' dclarraybound)? (',' dclarraybound (':' dclarraybound)?)*
    ;

dclarraybound:  
        expr
    |   expr REFER '(' varnameref ')'
    |   '*'
    ;

dcloptionlist:
        dcloption+
    ;

dcloption:
      dclnumeric
    | dclio
    | dclchar
    | dclstg
    | dclpgm
    | dclmisc
    | dclinit
    ;

dclnumeric: 
        FIXED                        
    |   FIXED '(' dclnumericNUM ')' 
    |   FIXED '(' dclnumericNUM ',' dclnumericNUM ')'
    |   FLOAT                       
    |   FLOAT '(' dclnumericNUM ')' 
    |   DECIMAL                     
    |   DECIMAL '(' dclnumericNUM ')'
    |   DECIMAL '(' dclnumericNUM ',' dclnumericNUM ')' 
    |   BINARY                      
    |   BINARY '(' dclnumericNUM ')' 
    |   BINARY '(' dclnumericNUM ',' dclnumericNUM ')'
    |   REAL 
    |   COMPLEX 
    |   COMPLEX '(' dclnumericNUM ')'
    |   PRECISION /* used by defaultpredicateexpr */
    |   PRECISION '(' dclnumericNUM ')'
    |   PRECISION '(' dclnumericNUM ':' dclnumericNUM ')' /* used as range selector in genericwhenoption */
    |   PRECISION '(' dclnumericNUM ',' dclnumericNUM ')'   
    ;
 
dclnumericNUM:
            NUM 
    |   '-' NUM 
    |   '+' NUM  
    ;

dclio:  BACKWARDS
    |   BUFFERED
    |   DIRECT
    |   ENVIRONMENT '(' environmentspeclist ')'
    |   EXCLUSIVE
    |   FILE
    |   INPUT
    |   KEYED
    |   LINESIZE '(' expr ')'
    |   OUTPUT
    |   PAGESIZE '(' expr ')'
    |   PRINT
    |   RECORD
    |   SEQUENTIAL
    |   STREAM
    |   TITLE '(' expr ')'
    |   TRANSIENT
    |   UNBUFFERED
    |   UPDATE
    ;

dclchar:
        AREA charspec 
    |   BIT charspec 
    |   CHARACTER charspec
    |   GRAPHIC charspec
    |   G_ charspec
    |   PICTURE STR_CONSTANT
    |   WIDECHAR charspec
    |   DATE 
    |   DATE '(' STR_CONSTANT ')' 
    ;

dclstg: ALIGNED
    |   AUTOMATIC 
    |   BASED 
    |   BASED '(' varnameref ')' 
    |   BYADDR
    |   BYVALUE
    |   CONNECTED
    |   CONSTANT
    |   CONTROLLED 
    |   DEFINED varnameref 
    |   DEFINED '(' varnameref ')' 
    |   DIMENSION '(' dclarrayboundcommalist ')'
    |   EXTERNAL 
    |   EXTERNAL '(' STR_CONSTANT ')' 
    |   INTERNAL 
    |   LIKE varnameref
    |   LOCAL
    |   NONCONNECTED
    |   STATIC 
    |   OFFSET
    |   OFFSET '(' varnameref ')'
    |   OPTIONAL
    |   PARAMETER 
    |   POSITION '(' expr ')'
    |   RESERVED
    |   RESERVED '(' IMPORTED ')'
    |   UNALIGNED
    |   UNCONNECTED
    |   STRUCTURE
    ; 

dclpgm: ENTRY
    |   ENTRY '(' entryparmcommalist ')'
    |   RETURNS '(' entryparmcommalist ')' /* only when a structure is commalist ok */
    |   LABEL
    |   CONDITION
    |   GENERIC '(' genericspeccommalist ')'
    |   TASK
    |   LIMITED
    |   FROMALIEN
    |   FETCHABLE
    |   CDECL
    |   OPTLINK
    |   STDCALL
    |   WINMAIN
    |   FORTRAN
    |   DESCRIPTOR
    |   NODESCRIPTOR
    |   LINKAGE '(' STR_CONSTANT ')'
    |   REDUCIBLE 
    |   IRREDUCIBLE
    ;

dclmisc:VARIABLE
    |   VARYING
    |   NONVARYING
    |   VARYINGZ
    |   SYSTEM
    |   BUILTIN
    |   POINTER
    |   ABNORMAL
    |   NORMAL
    |   ASSIGNABLE
    |   NONASSIGNABLE
    |   HEXADEC
    |   IEEE
    |   BIGENDIAN
    |   LIST
    |   LITTLEENDIAN
    |   SIGNED
    |   UNSIGNED
    |   NOINIT
    |   HANDLE varnameref
    |   HANDLE '(' varnameref ')'
    |   TYPE varnameref
    |   TYPE '(' varnameref ')'
    |   ORDINAL varnameref
    |   OPTIONS '(' entryoptionlist ')'
    |   FORMAT
    ;

environmentspeclist:
        environmentspec (','? environmentspec)*
    ;
    
environmentspec:
        F_   
    |   F_ '(' NUM ')'
    |   FB
    |   FS
    |   FBS
    |   V_
    |   VB
    |   VS
    |   VBS
    |   ADDBUFF
    |   ASCII

    |   BKWD
    |   BLKSIZE '(' environmentspecparm ')'
    |   BUFFERS '(' environmentspecparm ')'
    |   BUFFOFF '(' environmentspecparm ')'
    |   BUFND '(' environmentspecparm ')'
    |   BUFNI '(' environmentspecparm ')'
    |   BUFSP '(' environmentspecparm ')'

    |   COBOL
    |   CONSECUTIVE
    |   CTLASA
    |   CTL360

    |   D_
    |   DB

    |   GENKEY

    |   INDEXAREA '(' environmentspecparm ')'
    |   INDEXED
    |   INTERACTIVE

    |   KEYLENGTH '(' environmentspecparm ')'
    |   KEYLOC '(' environmentspecparm ')'

    |   LEAVE

    |   NCP '(' environmentspecparm ')'
    |   NOWRITE

    |   RECSIZE '(' environmentspecparm ')'
    |   REGIONAL '(' environmentspecparm ')'
    |   REREAD
    |   REUSE

    |   PASSWORD

    |   SCALARVARYING
    |   SIS
    |   SKIP_
    |   STRINGVALUE

    |   TOTAL
    |   TP '(' M_ ')'
    |   TP '(' R_ ')'
    |   TRKOFL

    |   U_

    |   VSAM
    ;
    
environmentspecparm: 
        NUM
    |   VARNAME
    ;

entryparmcommalist:
        entryparm (',' entryparm)*
    ;
entryparm:  /* empty */
    |   dcloptionlist
    |   '*'
    |   '*' dcloptionlist
    |   NUM dcloptionlist
    |   NUM
    |   '(' entryarrayspeccommalist ')' dcloptionlist
    |   NUM '(' entryarrayspeccommalist ')' dcloptionlist
    |   NUM '(' entryarrayspeccommalist ')' 
    ;
    
entryarrayspec: 
      '*'
    | NUM
    | NUM ':' NUM
    | NUM ':' '*'
    | '*' ':' NUM
    | '*' ':' '*'
    ;
    
entryarrayspeccommalist:
        entryarrayspec (',' entryarrayspec)*
    ;
    
entryoptionlist:
        entryoption (','? entryoption)*
    ;

entryoption:
        ASSEMBLER
    |   COBOL
    |   FORTRAN
    |   INTER
    |   RETCODE
    |   CONSTANT
    |   VARIABLE
    |   PACKED
    |   SUPPORT
    ;

genericspeccommalist:
        genericspec (',' genericspec)*
    ;

genericspec:
        varname WHEN '(' genericwhenoptionlist ')'
    ;

genericwhenoptionlist:
        genericwhenoption (',' genericwhenoption)*
    ;

genericwhenoption:
        /* EMPTY */
    |   '*'
    |   dcloptionlist
    ;

charspec:   /* EMPTY */
    |   '(' '*' ')'
    |   '(' expr ')'
    |   '(' expr REFER '(' varnameref ')' ')'
    ;

dclinit:
        INITIAL '(' inititemcommalist ')'
    |   INITIAL CALL varnameref
    |   INITIAL TO '(' initialtospec ')' '(' inititemcommalist ')'
    ;
    
initialtospec: 
        VARYING
    |   VARYINGZ
    |   NONVARYING
    ;


inititemcommalist:
        inititem (',' inititem)*
    ;

inititem:
        expr
    |   '*'
    |   inititerationfactorlist 
    |   inititerationfactorlist '*'
    |   inititerationfactorlist expr
    |   inititerationfactorlist '(' inititemcommalist ')' 
    ;

inititerationfactorlist:
        '(' expr ')'
    |   inititerationfactorlist '(' expr ')'
    ;

