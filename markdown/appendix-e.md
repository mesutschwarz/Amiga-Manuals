# Appendix E Distribution Files 
This appendix lists the directories of the standard ARexx distribution disk. The contents of some of the directories may change from time to time, so your disk may not show exactly the same files. Most notably, the : rexx directory will expand as more program examples are included in it.

The second section of the Appendix lists the HEADER files that define the constants and data structures used with ARexx. All of these files are available in the :INCLUDE directory, but are listed here for convenience in studying the structures.

The files are listed below as they would be using the system dir command. For example, "dir dfl:c opt a" would list the contents of the : c directory on disk drive 1.

The : C Directory

This directory contains the command utilities used with ARexx. These files should be copied to your system C: directory when you install the program.

c (dir)

hi rexxmast rxc

tee te

The : INCLUDE Directory

loadlib rx rxset tco

ts

This directory has the INCLUDE and HEADER files used for assembly language and "C" programming, respectively. These files contain the structure definitions necessary to build an interface to ARexx.

include (dir)

errors.h rxslib.h errors.i rxslib.i

rexxio.h storage.h rexxio.i storage.i

The : LIBS Directory

These are the library files for the language interpreter and the Support Library functions. Both files should be copied to your system LIBS: directory when you install ARexx.

libs (dir) rexxsupport.library

rexxsyslib.library

The : REXX Directory

The : **rexx** directory contains example programs to illustrate various features of the lan-guage. New files will be added from time to time, and users are welcome to contribute files to be distributed in this way.

rexx (dir) bigif.rexx builtin.rexx cmdtest.rexx factw.rexx hosttest.rexx marquis.rexx paver.rexx rslib.rexx sigtest.rexx test1.rexx

```rexx

break.rexx calc.rexx fact.rexx haltme.rexx iftest.rexx nesttest.rexx potpourri.rexx select.rexx support.rexx timer.rexx
```

The :TOOLS Directory

These files are intended for software developers, and include examples of interfacing to ARexx. The file rexxtest is of particular interest; it calls the ARexx interpreter directly, and can be run under a debugger to aid with developing new function libraries.

tools (dir) hosttest loadlib.asm rexxtest.asm

.info README

hosttest.asm rexxtest rxoffsets.o

Listings of Header Files

This section of the chapter consists of listings of the header files contained in the : include directory.

storage.h

This is the main header file and contains definitions for all of the important data structures used by ARexx.

```rexx

I* === rexx/storage.h ==================================================
```

#ifndef REXX_STORAGE_H #define REXX_STORAGE_H

#ifndef EXEC_TYPES_H #include "exec/types.h" #endif

#ifndef EXEC_NODES_H #include "exec/nodes.h" #endif

#ifndef EXEC_LISTS_H #include "exec/lists.h" #endif

#ifndef EXEC_PORTS_H #include "exec/ports.h" #endif

#ifndef EXEC_LIBRARIES_H #include "exec/libraries.h" #endif

/â€¢ The NexxStr structure is used to maintain the internal strings in REXX.

(since it's used for recycling).

storage.h (cont.)

struct NexxStr {

LONG ns_Ivalue;

UliORD ns_Length;

UBYTE ns_Flags;

UBYTE ns_Hash;

BYTE ns_Buff [8] ;

};

#define NXADDLEN 9

/â€¢ integer value

```rexx

I* length in bytes (excl null)
```

Iâ€¢ attribute flags â€¢/

/â€¢ hash code â€¢/

/â€¢ buffer area for strings â€¢I

/â€¢ size: 16 bytes (minimum) â€¢I

/â€¢ offset plus null byte

#define IVALUE(nsPtr) (nsPtr->ns_Ivalue)

/â€¢ String attribute flag bit definitions

#define NSB_KEEP

/â€¢ permanent string?

#define NSB_STRIRG

/â€¢ string form valid?

#define NSB_NOTNUM

/â€¢ non-numeric?

#define HSB_RUMBER

/â€¢ a valid number?

#define NSB_BINARY

/â€¢ integer value saved?

#define RSB_FLOAT

/â€¢ floating point format?

#define NSB_EXT

/â€¢ an external string?

#define NSB_SOURCE

/â€¢ part of the program source?

Iâ€¢ The flag form of the string attributes

#define RSF_KEEP

(1 Â« NSB_KEEP **)**

#define NSF_STRING

(1 Â« NSB_STRING)

#define NSF_NOTNUM

{1 Â« NSB_NOTNUM)

#define RSF_NUHBER

(1 Â« NSB_IUMBER)

#define NSF_BINARY

(1 Â« NSB_BIRARY)

#define NSF_FLOAT

(1 Â« NSB_FLOAT )

#define NSF_EXT

(1 Â« IISB_EXT **)**

#define RSF_SOURCE

(1 Â« NSB_SOURCE)

#define IISF_INTNUM (NSF_NUHBER #define NSF_DPNUM (NSF_NUMBER

NSF_BINARY I NSF_STRING) NSF_FLOAT)

#define IISF_ALPHA #define NSF_OWIIED #define KEEPSTR

(NSF_IOTNUM (RSF_SOURCE (NSF_STRING

NSF_STRING)

NSF_EXT I NSF_KEEP) NSF_SOURCE I NSF_NOTNUH)

#define KEEPNUM (NSF_STRING NSF_SOURCE I NSF_IUMBER I NSF_BIIARY)

storage.h (cont.)

/â€¢ The RexxArg structure is identical to the NexxStr structure, but

is allocated from system memory rather than from internal storage.

This structure is used for passing arguments to external programs.

It is usually passed as an "argstring", a pointer to the string buffer.

struct RexxAr **g**{

LONG ra_Size;

Iâ€¢ total allocated length

UWORD ra_Length;

Iâ€¢ length of string

UBYTE ra_Flags;

Iâ€¢ attribute flags

UBYTE ra_Hash;

Iâ€¢ hash code

BYTE ra_Buff[8];

Iâ€¢ buffer area

};

/â€¢ The RexxMsg structure is used for all communications with Rexx programs.

It is an EXEC message with a parameter block appended.

struct RexxMsg {

struct

Message rrn_Node;

/â€¢ EXEC message structure

rm_TaskBlock;

/â€¢ pointer to global structure

rm_LibBase;

/â€¢ library base

rrn_Action;

Iâ€¢ command (action) code

rm_Result1;

/â€¢ primary result (return code)

rm_Result2;

rrn_Args [16];

Iâ€¢ secondary result

/â€¢ argument block (ARGO-ARG15)

struct

MsgPort â€¢rm_PassPort;

Iâ€¢ forwarding port

rrn_CommAddr;

rrn_FileExt;

/â€¢ host address (port name)

/â€¢ file extension

rm_Stdin;

/â€¢ input stream (filehandle)

rm_Stdout;

Iâ€¢ output stream (filehandle)

rrn_avail;

Iâ€¢ future expansion

};

/â€¢ Field definitions

#define ARGO(rmp) (rrnp->rm_Args[O]) #define ARG1(rrnp) (rmp->rrn_Args[1]) #define ARG2(rmp) (rmp->rrn_Args[2])

#define MAXRMARG 15

/â€¢ size: 128 bytes â€¢/

/â€¢ start of argblock

Iâ€¢ first argument â€¢I

/â€¢ second argument â€¢/

/â€¢ maximum arguments

/â€¢ Command (action) codes for message packets â€¢I #define RXCOMM $01000000 /â€¢ a command-level invocation â€¢/

#define RXFUNC $02000000 #define RXCLOSE $03000000 #define RXQUERY $04000000 #define RXADDFH $07000000

a function call

Iâ€¢

Iâ€¢ close the port

Iâ€¢ query for information

Iâ€¢ add a function host

storage.h (cont.)

#define RXADDLIB $08000000 #define RXREMLIB $09000000 #define RXADDCDN $0AOOOOOO #define RXREMCON $0B000000

#define RXTCOPN $0COOOOOO #define RXTCCLS $0D000000

```rexx

I* Command modifier flag bits #define RXFB_NOIO 16
```

#define RXFB_RESULT 17

#define RXFB_STRING 18

#define RXFB_TOKEB 19

#define RXFB_NONRET 20

Iâ€¢ add a function library â€¢I Iâ€¢ remove a function library â€¢I Iâ€¢ add/update a ClipList string â€¢I I*remove a ClipList string â€¢I Iâ€¢ open the trace console*I Iâ€¢ close the trace console â€¢I

```rexx

I* suppress I/O inheritance?
```

/â€¢ result string expected?

```rexx

I* program is a "string file"?
I* tokenize the command line?
```

/â€¢ a "no-return" message?

/â€¢ Modifier flags #define RXFF_RESULT #define RXFF_STRING #define RXFF_TOKEN #define RXFF_BONRET #define RXCODEMASK #define RXARGMASK

(1 << RXFB_RESULT)

(1 << RXFB_STRING) (1 << RXFB_TOKEN ) (1 << RXFB_NONRET)

$FFOOOOOO

$OOOOOOOF

```rexx

I* The RexxRsrc structure is used to manage global resources.
```

., and the total size of the node is saved in the "rr_Size" field.

struct RexxRsrc { struct Node rr_lode;

```rexx

WORD rr_Func; *Iâ€¢*"auto-delete" offset *â€¢I*
APTR rr_Base; *Iâ€¢*"auto-delete" base *â€¢I*
```

. . .

```rexx

LONG rr_Size; *Iâ€¢* total size of node *â€¢I*
LONG rr_Arg1; *Iâ€¢* available *â€¢I*
```

LONG rr_Arg2; *Iâ€¢* available . . .

. . .

}; *Iâ€¢* size: 32 bytes **I Iâ€¢* Resource node types

```rexx

#define RRT_ABY 0 *Iâ€¢* any node type **I*
#define RRT_LIB 1 *I a function library I*
#define RRT_PORT 2 *Iâ€¢* a public port *â€¢I*
#define RRT_FILE 3 *I a file IoBuff I*
#define RRT_HOST 4*I a function host I*
#define RRT_CLIP 6I* a Clip List node*I
```

storage.h (cont.)

/â€¢ The RexxTask structure holds the fields used by REII to communicate with

external processes, including the client task. It includes the global

data structure (and the base environment). The structure is passed to

the newly-created task in its "wake-up" message.

#define GLDBALSZ 200 struct RexxTask {

BYTE rt_Global[GL0BALSZ]; struct MsgPort rt_MsgPort;

```rexx

I* total size of GlobalData
```

/â€¢ global data structure

```rexx

I* global message port
```

APTR APTR. APTR APTR.

rt_Flags; rt_SigBit;

rt_ClientID; rt_MsgPkt; rt_TaskID; rt_RexxPort;

rt_ErrTrap; rt_StackPtr;

```rexx

I* task flag bits
I* signal bit
I* the client's task ID
I* the packet being processed Iâ€¢ our task ID
I* the REIX public port
I* Error trap address
I* stack pointer for traps
```

struct List rt_Header1; struct List rt_Header2; struct List rt_Header3; struct List rt_Header4; struct List rt_Header5;

};

```rexx

I* Definitions for R.exxTask flag bits
I* Environment list Iâ€¢ Memory freelist
```

/â€¢ Memory allocation list

/* Files list

```rexx

I*  MessagePorts List
#define RTFB_TRACE 0 *I** external trace flag
```

#define RTFB_HALT 1 /* external halt flag

#define RTFB_SUSP 2

#define RTFB_TCUSE 3

#define RTFB_WAIT 6

#define RTFB_CL0SE 7

Iâ€¢ suspend task?

/â€¢ trace console in use?

```rexx

I* waiting for reply?
```

/â€¢ task completed?

```rexx

I* Definitions for memory allocation constants
```

#define MEMQUANT 16 #define MEMMASK $FFFFFFF0

#define MEMQUICK (1 << 0)

#define MEMCLEAR (1 << 16)

```rexx

I* quantum of memory space
```

/â€¢ mask for rounding the size

/* EXEC flags: MEMF_PUBLIC

```rexx

I* EXEC flags: MEMF_CLEAR
```

storage.h (cont.)

Iâ€¢ The Srclode is a temporary structure used to hold values destined for a

segment array. It is also used to maintain the memory freelist.

struct Srclode {

```rexx

struct Srclode â€¢sn_Succ; *Iâ€¢* next node *â€¢I*
```

struct Srclode â€¢sn_Pred;

sn_Ptr;

Iâ€¢

pointer value

};

sn_Size;

Iâ€¢ Iâ€¢

size of object

size: 16 bytes

#endif

rxslib.h

This file defines the library base for the ARexx Systems Library.

Iâ€¢ === rexx/rxslib.h ===================================================

Copyright (c) 1986, 1987 by William S. Hawes (All Rights Reserved)

The header file for the REXX Systems Library

#ifndef REXX_RXSLIB_H #define REXX_RXSLIB_H

#ifndef REXX_STORAGE_H #include "rexx/storage.h" #endif

/â€¢ Some macro definitions

#define RXSNAME #define RXSID #define RXSDIR

"rexxsyslib.library" "rexxsyslib 1.0 (23 AUG 87)" "REXX"

#define RXSTNAME "ARexx"

/â€¢ The REXX systems library structure. This should be considered as *I

/â€¢ semi-private and read-only, except for documented exceptions. *I

struct RxsLib {

```rexx

struct Library rl_Node; I*EXEC library node*I
UBYTE rl_Flags; *Iâ€¢* global flags *â€¢I*
```

UBYTE rl_pad;

```rexx

APTR rl_SysBase; *I EXEC library base I*
```

LONG rl_MaxAlloc; *Iâ€¢* maximum memory allocation

```rexx

LONG rl_Chunk; *Iâ€¢* allocation quantum *â€¢I*
I*
```

Iâ€¢

```rexx

I*
```

LONG rl_Maxlest; *Iâ€¢* maximUlll expression nesting *â€¢I* struct NexxStr â€¢rl_NULL; *Iâ€¢* static string: NULL *â€¢I* struct NexxStr â€¢rl_FALSE; *I** static string: FALSE **I* struct NexxStr *rl_TRUE;*Iâ€¢ * static string: TRUE *â€¢I * struct RexxStr *rl_REXX; *Iâ€¢* static string: REXX *â€¢I* struct NexxStr *rl_COMMAND;*Iâ€¢ * static string: COMMAND

struct NexxStr *rl_STDIN; struct NexxStr* rl_STDOUT; struct NexxStr â€¢rl_STDERR;

static string: STDIN static string: STDOUT static string: STDERR

rxslib.h (cont.)

rl_Version; rl_TaskName; rl_TaskPri; rl_TaskSeg; rl_StackSize; rl_RexxDir; rl_CTABLE;

Iâ€¢ version/configuration stringâ€¢/

Iâ€¢ name string for tasks â€¢I

Iâ€¢ starting priority â€¢I

Iâ€¢ startup seglist â€¢I

Iâ€¢ stack size â€¢I

Iâ€¢ REXX directory â€¢I Iâ€¢ character attribute table â€¢I

Iâ€¢

struct NexxStr â€¢rl_Notice;

Iâ€¢ copyright notice â€¢I

struct

MsgPort rl_RexxPort;

rl_ReadLock; rl_TraceFH;

/â€¢

Iâ€¢

Iâ€¢

REXX public port lock count

global trace console

struct

List rl_TaskList;

Iâ€¢

REXX task list

rl_llumTask;

Iâ€¢

task count

struct

List rl_LibList;

Iâ€¢

Library List header

rl_llumLib;

Iâ€¢

library count

struct

List rl_ClipList;

Iâ€¢

ClipList header

rl_NumClip;

clip node count

struct

List rl_MsgList:

Iâ€¢

pending messages

rl_lumMsg;

Iâ€¢

pending count

};

```rexx

Iâ€¢ Global flag bit definitions for RexxMaster *â€¢I*
```

#define RLFB_TRACE RTFB_TRACE

Iâ€¢

interactive tracing?

#define RLFB_HALT RTFB_HALT

/â€¢

halt execution?

#define RLFB_SUSP RTFB_SUSP

Iâ€¢

suspend execution?

#define RLFB_TCUSE RTFB_TCUSE

Iâ€¢

```rexx

trace console in use?
```

#define RLFB_TCOPI 4

Iâ€¢

```rexx

trace console open?
```

#define RLFB_STOP 6

Iâ€¢

deny further invocations

#define RLFB_CLOSE 7

Iâ€¢

close the master

#define RLFMASK Ox07

; Initialization constants #define RXSVERS 2

#define RXSREV 1

#define RXSALLOC Ox800000 #define RXSCHUNK 1024

#define RXSNEST 32

#define RXSTPRI 0

#define RXSSTACK 4096

#define RXSLISTH 4

Iâ€¢ passed flags â€¢I

Iâ€¢

Iâ€¢ main version â€¢I Iâ€¢ revision

```rexx

maximUJII allocation *â€¢I*
Iâ€¢ allocation quantum â€¢I Iâ€¢ expression nesting limit *â€¢I*Iâ€¢ task priority â€¢I
Iâ€¢ stack size *â€¢I*
```

Iâ€¢ number of list headers â€¢I

rxslib.h (cont.)

#define CTB_SPACE

Iâ€¢ white space characters

#define CTB_DIGIT

/â€¢ decimal digits 0-9

#define CTB_ALPHA

/â€¢ alphabetic characters

#define CTB_REXXSYM

Iâ€¢ REXX symbol characters

#define CTB_REXX0PR

/â€¢ REXX operator characters

#define CTB_REXXSPC

Iâ€¢ REXX special symbols

#define CTB_UPPER

/â€¢ UPPERCASE alphabetic

#define CTB_L0WER

/â€¢ lowercase alphabetic

/* Attribute flags #define CTF_SPACE

(1

<<

CTB_SPACE)

#define CTF_DIGIT

(1

CTB_DIGIT)

#define CTF_ALPHA

(1

CTB_ALPHA)

#define CTF_REXXSYM

(1

<<

CTB_REXXSYM)

#define CTF_REXX0PR

(1

<<

CTB_REXX0PR)

/â€¢ Character attribute flag bits used in REXX. Defined only for â€¢I Iâ€¢ ASCII characters (range 0-127).

<<

<<

#define CTF_REXXSPC **(1**<< CTB_REXXSPC)

(1

#define CTF_UPPER << CTB_UPPER)

#define CTF_L0WER **(1**<< CTB_L0WER)

#endif

rexxio.h

This file defines the data structures used for buffered I/O. ARexx uses linked lists of

IoBuff structures to keep track of the files it opens. Each IoBuff node is allocated as an "auto-delete" structure and can be closed and released by a call to either CloseF() or RemRsrcNode(). An entire list of files can be closed with a call to RemRsrcList().

```rexx

I*=== rexx/rexxio . h ====================================================
```

Copyright (c) 1986, 1987 by William S. Hawes (All Rights Reserved)

---=------------------==----==-----=-----=------------------== ===-

Header file for ARexx Input/Output related structures

#ifndef REXX_REXXIO_H #define REXX_REXXIO_H

#ifndef REXX_STORAGE_H #include "rexx/storage.h" #endif

```rexx

#define RXBUFFSZ 204 I* buffer length
I* The IoBuff is a resource node used to maintain the File List. Nodes are
```

allocated and linked into the list whenever a file is opened.

struct IoBuff {

struct RexxRsrc ioblode;

Iâ€¢ structure for files/strings

APTR iobRpt;

Iâ€¢ read/write pointer

iobRct;

```rexx

I*
```

character count

iobDFH;

```rexx

I*
```

DOS filehandle

iobLock;

Iâ€¢

DOS lock

iobBct;

```rexx

I*
```

buffer length

iobArea[RXBUFFSZ];

Iâ€¢

buffer area

};

```rexx

I*
```

size: 256 bytes

Iâ€¢ Access mode definitions

#define RXIO_EXIST **-1**

Iâ€¢

an external filehandle

#define RXIO_STRF 0

Iâ€¢

a "string file"

#define RXIO_READ **1**

Iâ€¢

read-only access

#define RXIO_WRITE **2**

Iâ€¢

write mode

#define RXIO_APPEND **3**

Iâ€¢

append mode (existing file)

rexxio.h (cont.)

/â€¢ Offset anchors for SeekF() #define RXIO_BEGIN -1

#define RXIO_CURR 0

#define RXIO_END 1

Iâ€¢ relative to start â€¢I Iâ€¢ relative to current position â€¢I Iâ€¢ relative to end â€¢I

/â€¢ The Library List contains just plain resource nodes.

#define LLOFFSET(rrp) (rrp->rr_Arg1) #define LLVERS(rrp) (rrp->rr_Arg2)

Iâ€¢ "Query" offset Iâ€¢ library version

I* The RexxClipNode structure is used to maintain the Clip List. The value string is stored as an argstring in the rr_Arg1 field.

#define CLVALUE(rrp) ((STRPTR) rrp->rr_Arg1)

/â€¢ A message port structure, maintained as a resource node.

struct RexxMsgPort {

struct RexxRsrc rmp_Node; struct MsgPort rmp_Port; struct List rmp_ReplyList;

};

Iâ€¢ DOS Device types #define DT_DEV 0

#define DT_DIR 1

#define DT_VOL **2**

/â€¢ Private DOS packet types #define ACTION_STACK 2002

#define ACTION_QUEUE 2003 #endif

/â€¢ linkage node

/â€¢ the message port

/â€¢ messages awaiting reply

/â€¢ a device

```rexx

/* an ASSIGNed directory I* a volume
```

/â€¢ stack a line

/â€¢ queue a line

errors.h

This file contains the definitions for all of the error messages issued by the ARexx inter-preter.

Iâ€¢â€¢ == errors.h =========================================================

Definitions for ARexx error codes

/+

#define ERRC_MSG #define ERR10_001 #define ERR10_002

#define ERR10_003

0 (ERRC_MSG+l) (ERRC_MSG+2)

(ERRC_MSG+3)

Iâ€¢ Iâ€¢

/+

Iâ€¢

error code offset program not found execution halted

no memory available

#define ERR10_004

(ERRC_MSG+4)

invalid character in

programâ€¢/

#define ERR10_006 #define ERR10_006

#define ERR10_007

(ERRC_MSG+6) (ERRC_MSG+6)

(ERRC_MSG+7)

/+

Iâ€¢ Iâ€¢

unmatched quote unterminated col!llnent

clause too long

+/

#define ERR10_008

(ERRC_MSG+8)

Iâ€¢

unrecognized token

#define ERR10_009

(ERRC_MSG+9)

Iâ€¢

symbol or string too

long +/

+/

#define ERR10_010 (ERRC_MSG+lO)

```rexx

invalid message packet *â€¢I*
```

/+

Iâ€¢

#define ERR10_011 (ERRC_MSG+ll) *Iâ€¢* command string error

#define ERR10_012 (ERRC_MSG+12)

```rexx

e=or return from function *â€¢I*
```

+/

+/

#define ERR10_013 (ERRC_MSG+13) *Iâ€¢* host environment not found #define ERR10_014 (ERRC_MSG+14) *Iâ€¢* required library not found #define ERR10_015 (ERRC_MSG+16) *Iâ€¢* function not found +/ #define ERR10_016 (ERRC_MSG+16) *Iâ€¢* no return value +/ #define ERR10_017 (ERRC_MSG+17) /+ wrong number of arguments #define ERR10_018 (ERRC_MSG+18) *Iâ€¢* invalid argument to function+/ #define ERR10_019 (ERRC_MSG+19) *Iâ€¢* invalid PROCEDURE *â€¢I*

Iâ€¢

#define ERR10_020 (ERRC_MSG+20) unexpected THEN/ELSE

Iâ€¢

#define ERR10_021 (ERRC_MSG+21) *Iâ€¢* unexpected WHEN/OTHERWISE +/ #define ERR10_022 (ERRC_MSG+22) *Iâ€¢* unexpected LEAVE or ITERATE +/ #define ERR10_023 (ERRC_MSG+23) *Iâ€¢* invalid statement in SELECT *â€¢I*#define ERR10_024 (ERRC_MSG+24) *Iâ€¢* missing THEN clauses *â€¢I*

#define ERR10_025 (ERRC_MSG+26)

```rexx

missing OTHERWISE *â€¢I*
```

#define ERR10_026 (ERRC_MSG+26) Iâ€¢ missing or unexpected END â€¢I #define ERR10_027 (ERRC_MSG+27) Iâ€¢ symbol mismatch on END â€¢I #define ERR10_028 (ERRC_MSG+28) Iâ€¢ invalid DO syntax *+f*#define ERR10_029 (ERRC_MSG+29) Iâ€¢ incomplete DO/IF/SELECT â€¢I

Iâ€¢

```rexx

I*
```

Iâ€¢

errors.h (cont.)

#define ERR10_030 (ERRC_MSG+30) #define ERR10_031 (ERRC_MSG+31) #define ERR10_032 (ERRC_MSG+32)

#define ERR10_033 (ERRC_MSG+33)

Iâ€¢

```rexx

I*
```

label not found symbol expected

string or symbol expected

invalid sub-keyword

#define ERR10_034 (ERRC_MSG+34)

Iâ€¢

required keyword missing

#define ERR10_035 (ERRC_MSG+35)

Iâ€¢

extraneous characters

#define ERR10_036 (ERRC_MSG+36)

```rexx

I*
```

sub-keyword conflict

#define ERR10_037 (ERRC_MSG+37)

Iâ€¢

invalid template

#define ERR10_038 (ERRC_MSG+38)

Iâ€¢

invalid TRACE request

#define ERR10_039 (ERRC_MSG+39)

```rexx

I*
```

uninitialized variable

#define ERR10_040 (ERRC_MSG+40)

Iâ€¢

invalid variable name

#define ERR10_041 (ERRC_MSG+41)

Iâ€¢

invalid expression

#define ERR10_042 (ERRC_MSG+42)

#define ERR10_043 (ERRC_MSG+43) #define ERR10_044 (ERRC_MSG+44)

Iâ€¢

Iâ€¢

unbalanced parentheses

nesting level exceeded invalid expression result

#define ERR10_046 (ERRC_MSG+46)

Iâ€¢

expression required

#define ERR10_046 (ERRC_MSG+46)

Iâ€¢

boolean value not 0 or 1

#define ERR10_047 (ERRC_MSG+47)

Iâ€¢

arithmetic conversion error

#define ERR10_048 (ERRC_MSG+48)

Iâ€¢

invalid operand

```rexx

I* Return Codes for general use
```

#define RC_FAIL -1

```rexx

I*
```

something's wrong

#define RC_0K 0

Iâ€¢

success

#define RC_WARN **5**

Iâ€¢

warning only

#define RC_ERR0R 10

```rexx

I*
```

something's wrong

#define RC_FATAL 20

Iâ€¢

complete or severe failure

Allocation. A grant of a system resource, such as memory space. Programs designed to run in a multitasking environment generally use dynamic allocation to avoid tying up system resources.

AmigaDOS. The higher-level part of the Amiga operating system that supports the filing system and input/output operations.

Argstring. An "argument string" structure used to pass data to an ARex:x program. The structure is passed as a pointer to the buffer area containing the string data, and can be treated as a pointer to a null-terminated string.

Argument. A data item passed to a function, sometimes called a parameter.

Clause. A group of one or more tokens forming a "sentence" in a language. The clause is the smallest executable language fragment.

Command Line Interface (CLI). A program that accepts input from the user and runs programs based on the entered command. The CLI generally refers to the command interpreter supplied with the Amiga, but other command "shells" may be used instead.

Concatenation. An operation in which two strings are joined or "chained together." ARex:x provides two concatenation operators, one of which joins strings directly and the other of which embeds a blank between the operands.

EXEC. The multitasking kernel of the Amiga's operating system. EXEC provides the task scheduling, interrupt handling, and message-passing primitives used to support ARex:x.

Function Host. A program that manages a public message port for receiving function invocation messages. The message port may be the same one used for command messages.

Function Library. A collection of functions callable from ARex:x and managed as an Amiga shared library. Each function library includes an entry point to associate a function name with the code to be called.

the system message ports list. Within an ARex:x program the host address identifies the external host to which commands will be sent.

Host Application. An executable program that provides a suitable command interface to receive ARexx commands. Most host applications will also provide a means to invokde macro programs from within the application.

Interrupt. An event that alters the normal flow of control in a program. Interrupts in ARexx refer to events within the program execution and are distinct from the hardware-level interrupts managed by the Amiga EXEC system.

Macro Program. A program that implements a complex "macro" operation from a series of "micro" commands.

Message Port. A data structure used as the rendezvous point for message passing. A message port provides the anchor for a list of message packets and identifies the task to be signalled when a message arrives.

Multitasking. The ability to run more than one program at a time. More precisely, multitasking permits the resources of the computer to be shared among many tasks without forcing any task to be aware of the others.

Process. An extension to an EXEC task structure that provides the data fields required to use AmigaDOS functions. All ARexx programs run as AmigaDOS processes.

Replyport. A message port designated to receive a returning message packet. Each message packet includes a field that specifies its reply port.

Resident Process. The program responsible for launching ARexx programs and for man-aging various resources used by ARexx. It is structured as a host application and opens a public message port named "REXX."

Shared Library. A collection of executable code and data managed as a resource by the EXEC operating system. As the name "shared" implies, the code and data in a library can be used by more than one task.

Storage Environment. The collection of data values forming the current state of an ARexx program. Storage environments are strictly nested and only one environment is current at any time.

Task. An entity consisting of executable code and a data structure managed by the EXEC operating system. The task is the smallest program unit that can be scheduled and run separately.

Token. The elementary words or atoms of a language. A token can be considered as a string of one or more characters forming the smallest unit of the language.

Typeless. Data items having no assumed structure or usage. ARexx treats all data as typeless character strings and checks for specific characteristics only when required by an operation.

ABBREV() Built-In function, 51 ABS() Built-In function, 51 absolute marker, 77

action codes, 93, 97-98 in message packet, 93 RXADDCON, 97

RXADDFH, 98 RXADDLIB,98

AddClipNode() Library function, 113 ADDLIB() Built-In function, 51 ADDRESS instruction, 25, 93 ADDRESS() Built-In function, 52 AddRsrcNode() Library function, 113 ALL trace option, 71

ALLOCMEM() Support function, 127 alphabetic option, 40, 71

```rexx

ARG instruction, 8,26, 106
```

in parsing, 77

as PARSE keyword, 33 ARG() Built-In function, 52 argstring, 90

arguments, 8, 22, 26

at invocation, 22, 26

of functions, 8

with CALL instruction, 26

B2C() Built-In function, 52 binary tree, 23

binding of ELSE instructions, 28 BITAND() Built-In function, 52 BITCHG() Built-In function, 53 BITCLR() Built-In function, 53 BITCOMP() Built-In function, 53 BITOR() Built-In function, 53 BITSET() Built-In function, 53 BITTST() Built-In function, 53 BITXOR() Built-In function, 54 boolean value, 107

```rexx

BREAK instruction, 26, 109
```

BREAK_C interrupt, 74

BREAK__D interrupt, 75

BREAK__E interrupt, 75 BREAK..F interrupt,75 Built-In functions, 51-69

for I/O, 23

BY expression, with DO, 27

C2B() Built-In function, 54 C2D() Built-In function, 54 C2XO Built-In function, 54 CALL instruction, 26

CENTER() Built-In function, 55 clauses, 14-15

assignment, 14

classification of, 14-15

command,15

continuation of, 14

instruction, 15 label,14

null, 14

ClearMemO Library function, 114 ClearRexxMsg() Library function, 114 Clip List, 83-84, 86, 97-98

adding entries, 84, 97

removing entry, 98

close parenthesis, as token, 13 CLOSE() Built-In function, 55 CloseF() Library function, 114 CLOSEPORT() Support function, 127

ClosePublicPort() Library function, 114 CmpStringO Library function,114

colon, as token, 13 comma, as token, 13

in templates, 78

command clauses, 43

command inhibition, 40, 73

in testing, 46

command interface, 3,43, 89

design of,91

error handling, 91

command invocation, 94 Command Line Interface (CLI), 5 **COMMANDS** trace option, 71 comment tokens, 11

COMPARE() Built-In function, 5,5 COMPRESS() Built In function, 55 COPIES() Built-In function, 55 CreateArgstring() Library function,114 CreateDOSPkt() Library function, 115 CreateRexxMsg(), 90,115

Library function, 115 CurrentEnv() Library function, 117 CV2i2argO Library function, 116 CVa2i() Library function, 115 CVc2x() Library function, 116 CVi2aO Library function, 116 CVi2az() Library function, 116 CVs2iO Library function, 116 CVx2c() Library function, 116

D2C() Built-In function, 56

DATATYPE() Built-In function, 56 DeleteArgstring() Library function, 117 DeleteDOSPkt() Library function, 117 **DeleteRexxMs****g**(), 90, 117

Library function, 117

DELSTR() Built-In function, 56 DELWORD() Built-In function, 57 display formatting, during tracing, 72 DO instruction, 7, 27

DOSRead() Library function, 117 DOSWriteO Library function, 118 DROP instruction; 28

```rexx

ECHO instruction, 28, 109
ELSE instruction, 28, 105
```

EID instruction, 8, 29

engineering notation, 17 enlightenment

EOF() Built-In function, 57 ERROR Interrupt, 75

error processing, during tracing, 73 ErrorMsg() Library function, 118 ERRORS trace option, 71 ERR0RTEXT() Built-In function, 57 ExistF() Library function, 118 EXISTS() Built-In function, 57 EXIT instruction, 29

exponential notation, 17 EXPORT() Built-In function, 57

EXPOSE keyword, with PROCEDURE, 35 expressions, 15, 16, 17

symbol resolution, 16

operators in, 17

extensions to REXX standard, 109 external tracing flag, 74

EXTERIAL keyword, with PARSE, 33

FillRexxMsg() Library function, 119 FindDevice() Library function, 119 FindRsrcNode() Library function, 119 FDR expression, with DO, 27

Forbid () function, 93 FOREVER, with DO, 27

FREEMEM() Support function, 128 FreePort() Library function, 119 FREESPACE() Built-In function, 58 FreeSpace() Library function, 119 function, 8, 15

argument list, 15

function hosts, 85, 89 in Library List, 85

function libraries, 4, 85 86, 89, 101

as bridge, 4

as test driver, 4 calling convention, 101 in Library List, 85 query function, 86

parameter conversion, 101

returned values, 101

GETARG() Support function, 128 GETCLIP() Built-In function, 58 GETPKT() Support function, 128 GETSPACE() Built-In function, 58 GetSpaceO Library function, 120

halt, external flag, 83 HALT interrupt, 75, 103

HASH() Built-In function, 58 HI command, 83

host address, 25,43-44 C0MMAND,44

with ADDRESS, 43

inspecting, 43

in command interface, 44 host application, 43

input/output facilities, 23

output stream, 23

input stream, 23

IF instruction, 8,29

IMPORT() Built-In function, 59 UDEX() Built-In function, 59

in

initializer expression, with DD, 27

InitListO Library function, 120 InitPortO Library function, 120 input stream, 96

IÂ»SERTO Built-In function, 59 installation procedure, 5

instruction clauses, 25-41

interactive tracing, 40, 73 INTERMEDIATES trace option, 71 INTERPRET instruction, 30

with interactive tracing, 73 interrupts, 3, 24, 74

EXEC supported, 74

with SIGNAL, 39

IoBuff structure, 122-123, 125

IOERR Interrupt, 75

IsRexxMsgO Library function, 120 IsSymbolO Library function, 121 ITERATE instruction, 30

Label, 14, 106

missing, 106

language features, 3

LASTPOS() Built-In function, 59 LEAVE instruction, 31

LEFT() Built-In function, 60 LENGTH() Built-In function, 60 Library List, 83, 85, 98, 104

adding entries, 85, 98

adding library, 98

adding host, 98

deleting entries, 85, 98 ListNames() Library function, 121 LockRexxBase(), 102

Library function, 121

logical name, 23

macro programs, 45

markers, in templates, 77, 80

absolute, 77

pattern, 77

positional, 80

mathieeedoubbas library, 5 MAX() Built-In function, 60 message port, 83

REXX, 83

MIN() Built-In function, 60 multiple templates, 80-81

in parsing, 80

naming conventions, 6

nesting, subexpression limit, 107, 109

no-pause instructions, 73

```rexx

NOP instruction, 31 lfORMAL trace option, 71 NOVALUE Interrupt, 75
```

NUMERIC instruction, 31

NUMERIC keyword, with PARSE, 33

omissions, from REXX standard, 109 open parenthesis, as token, 13 OPEN() Built-In function, 60

OpenFO Library function, 122 OPENPORT() Support function, 128 OpenPublicPort() Library function, 122 operators, 12, 16-17, 20-21, 78

boolean, 21

comparison, 20

in templates, 78

order of evaluation, 16 tokens, 12, 17

types of, 17

OPTIONS instruction, 32

OTHERWISE instruction, 32, 38, 105 in SELECT range, 38

missing, 105

output stream, 96

tracing, 72

OVERLAY() Built-In function, 61

parentheses, in templates, 78 PARSE instruction, 33, 106

in parsing, 77

pattern marker, 77

patterns, 34, 77, 80

in parsing, 34, 80

marker, 77

Permit() function, 93 POS() Built-In function, 61 positional markers, 80

PRAGMA() Built-In function, 61 precision, numeric, 17

prefix characters, 40, 73

```rexx

PROCEDURE instruction, 35, 105
```

program examples, 7

program execution environment, 22 program format, 11

public message port, 43

```rexx

PULL instruction, 35, 106
```

in parsing, 77

as PARSE keyword, 33 PUSH instruction, 36

PutMsgO function, 93

```rexx

QUEUE instruction, 37
```

QueueFO Library function, 122 quoting convention, for commands, 94

RA!IDOM() Built-In function, 62 RAHDU() Built-In function, 62 RC special variable, 39, 73, 75

with interrupts, 75

with command inhibition, 73 with interrupts, 39

READCH() Built-In function, 62 READLN{) Built-In function, 62 ReadStr() Library function, 122 reentrancy, requirement for, 100 relative marker, 77

RemClipNode() Library function, 123

REMLIB() Built-In function, 63 RemRsrcListO Library function, 123 RemRsrcNode() Library function, 123 REPLY() Support function, 129 ReplyMsg() function, 92

resident process, 6, 83-84, 89

resources managed, 83

capabilities, 83

closing, 84

starting, 6

resource tracking, 23

result fields, 92,97

setting values, 92

interpretation of, 97 RESULT special variable, 26 result string, 29, 37

from RETURN, 37

from EXIT, 29 RESULTS trace option, 71 return code, 44

```rexx

RETURN instruction, 8, 37 REVERSE() Built-In function, 63 REXX: directory, 6
```

RexxArg structure, 89-90

RexxMsg structure, 89

RexxRsrc structure, 90

RXADDC0N action code, 97 RXADDFH action code, 98 RXADDLIB action code, 98 RXC command, 84 RXCOMM action code, 98 RXFBJIOIO modifier, 99

RXFB.JIONRET modifier, 99

RXFB..RESULT modifier, 99

RXFB...STRING modifier, 99

RXFB_TOKEN modifier, 99 RXFUNC action code, 98 RXREMC0N action code, 98 RXREMLIB action code, 98 RXSET command, 84 RXTCCLS action code, 99 RXTCOPN action code, 99

```rexx

SAY instruction, 7, 38 SCAN trace option, 71 scientific notation, 17
```

search order, 26, 47

for function calls, 26, 47

search path, 95

search priority, 85

SEEK() Built-In function, 63 SeekFO Library function, 123 SELECT instruction, 38 semicolon, as token, 13 SETCLIP() Built-In function, 63

severity level, with error code, 103 shared library, 89

```rexx

SHELL instruction, 38, 109 SHOW() Built-In function, 64 SHOWDIR() Support function, 129
```

SHOWLIST() Support function, 129 SIGL special variable, 39, 75

with interrupts, 39, 75 SIGN() Built-In function, 64

SIGNAL instruction, 39, 103, 109 with interactive tracing, 74

single-drive systems, 6

SOURCE keyword, with PARSE, 33 SPACE() Built-In function, 64 special character tokens, 13 StackFO Library function, 123

STATEF() Support function, 130 StcToken() Library function, 124 STDIII stream, 23, 36-37

with **PUSH ** instruction, 36 with**QUEUE** instruction, 37

storage environments, 22 **STORAGE()** Built-In function, 65**Strcmpll()** Library function, 125**StrcpyA()** Library function, 124**Strcpyli()** Library function, 124**StrcpyU()** Library function, 124**STDERR** stream, 72

STDOUT stream, 23, 72 StrflipN() Library function, 124 string file, 94

string tokens, 12, 78

binary, 12

hex, 12

in templates, 78

STRIP() Built-In function, 65 Strlen() Library function, 125 SUBSTR() Built-In function, 65

in parsing, 77

SUBWORD() Built-In function, 65 Support Library, 127-130 symbol table organization, 23 SYMBOL() Built-In function, 66 symbol tokens, 11, 21, 106

stern, 21

compound, 21

in ternplates, 78

SYNTAX Interrupt, 75

error processing, 103

Systems Library, 111-126

target, 77

TCC command, 72, 84, 85

TCO command, 72, 84

TE command, 74, 84

template, 33, 77

structure, 77

in parsing, 77

with **PARSE,**33

THEli instruction, 39, 105

missing, 105

TIME() Built-In function, 66 TO expression, with DO, 27 tokenization 34, 79

tokens, 11

tombstone, TEX artifact, 151-155

ToUpperO Library function, 125

```rexx

TRACE instruction, 9, 40
```

prefix characters, 40

```rexx

TRACE() Built-In function, 66, 71
```

tracing, 3, 71-73, 84-85

alphabetic options, 71 closing trace console, 84 external flag, 84

global console, 72

interactive, 73

opening trace console, 85 **TRANSLATE()** Built-In function, 67**TRIM()** Built-In function, 67

TS command, 74, 84

typeless, 3

uninitialized variable, 38, 40, 75

with **UPPER,**40

UnlockRexxBase(), 102

Library function, 125

UNTIL expression, with DO, 27

```rexx

UPPER instruction, 40
UPPER() Built-In function,67
UPPER keyword, with PARSE, 33
```

VALUE() Built-In function, 67 VALUE keyword, with PARSE, 33 VAR keyword, with PARSE, 33 VERIFY() Built-In function, 68 VERSIOli keyword, with PARSE, 34

WAITPKT() Support function, 130

```rexx

WHEN instruction, 41, 105 in SELECT range, 38
```

WHILE expression, with DO, 27 WORD() Built-In function, 68 WORDiliDEX() Built-In function, 68 WORDLENGTH() Built-In function, 68 WORDS() Built-In function, 68 WorkBench, with ARexx, 5 WRITECH() Built-In function, 69 WriteF() Library function, 125 WRITELN() Built-In function, 69

X2C() Built-In function, 69

XRANGE() Built-In function, 69

ceptional

Compact, Reentrant Code - Only 32K

ARexx macro programs can interact with other software products that include an ARexx command interface, allowing you to extend and cus-tomize your software and to build integrated applications. The growing list of software products supporting the ARexx command interface in-cludes TxEd-Plus from MicroSmiths, C.A.P.E.68K from Inovatronics, and Amiga'I'_E.-"X from Radical Eye Software.

Look also for WShell, our companion Amiga software product. WShell is a CLI-compatible command shell with the features you've always wanted in a command environment - command aliases, resident and built-in commands, prompt string/window titlebar variables, concur-rent piping, and many more. With its ARexx command interface, WShell provides transparent support for REXX macros as well as the standard "execute" scripts (including support for the new "script bit".)

Developed and supported by: William S. Hawes

P.O. Box 308

Maynard, MA 01754

System requirements: Amiga 500/1000/2000 with Vl.2 OS Amiga is a trademark of Commodore-Amiga, Inc.

