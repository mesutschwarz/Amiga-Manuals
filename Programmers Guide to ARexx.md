# AMIGA® Programmer's Guide to ARexx™

Commodore-Amiga, Inc.

AMIGA TECHNICAL REFERENCE SERIES

**Commodore-Amiga, Inc.**
West Chester, Pennsylvania

**Written and designed by:** 
Eric Giguère
**Contributors:**
William Hawes, Willy Langeveld, Mike Sinz, and Tom Rokicki
**Editor: **
Dan Baker

Copyright © 1991 by Commodore Electronics Limited.

Many of the designations used by manufacturers and sellers to distinguish their products are claimed as trademarks. Where those designations appear in this book and Commodore-Amiga was aware of a trademark claim, the designations have been printed in initial caps. Amiga is a registered trademark of Commodore-Amiga, Inc., Amiga 500,Amiga 1000, Amiga 2030, Amiga 3000, AmigaDOS, Workbench, and Kickstart are trademarks of Commodore-Amiga, Inc. Commodore and the Commodore logo are registered trademarks of Commodore Electronics Limited. AUTOCONFIG is a trademark of Commodore Electronics Limited. 68000, 68010, 68020, 68030, 68040, and Motorola are trademarks of Motorola, Inc. ARexx is a trademark of Wishful Thinking Development Corp. Aztec C and Manx are trademarks of Manx Software Systems. CAPE and Inovatronic sare trademarks of Inovatronics, Inc. Centronics is a registered trademark of Centronics Data Computer Corp. Hisoft and Devpac Amiga are trademarks of HiSoft. IBM is a registered trademark of International Business Machines Corp. Macintosh is a registered trademark of Apple Computer, Inc. Lattice is a registered trademark of Lattice, Inc. SAS/C is a registered trademark of SAS Institute, Inc. UNIX is a registered trademark of AT&T. |

All rights reserved. No part of this publication may be reproduced, stored in a retrieval system, or transmitted, in any form or by any means, electronic, mechanical, photocopying, recording, or otherwise, without the prior written permission of the publisher. Printed in the United States of America.

First printing, July 1991          

WARNING: The information described in this manual may contain errors or bugs, and may not function as described. All information is subject to enhancement or upgrade for any reason including to fix bugs, add features, or change performance. As with all software upgrades, full compatibility, although a goal, cannot be guaranteed, and is in fact unlikely.

DISCLAIMER: COMMODORE-AMIGA, INC., ("COMMODORE') MAKES NO WARRANTIES, EITHER EXPRESSED OR IMPLIED, OR REPRESENTATIONS WITH RESPECT TO THE INFORMATION DESCRIBED HEREIN. SUCH INFORMATION IS PROVIDED ON AN "AS IS' BASIS AND IS EXPRESSLY SUBJECT TO CHANGE WITHOUT NOTICE. IN NO EVENT WILL COMMODORE BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, OR CONSEQUENTIAL DAMAGES RESULTING FROM ANY CLAIM ARISING OUT OF THE INFORMATION PRESENTED HEREIN, EVEN IF IT HAS BEEN ADVISED OF THE POSSIBILITY OF SUCH DAMAGES. SOME STATES DO NOT ALLOW THE EXCLUSION OR LIMITATION OF IMPLIED WARRANTIES OR LIABILITIES FOR INCIDENTAL OR CONSEQUENTIAL DAMAGES, SO THE ABOVE LIMITATION OR EXCLUSION MAY NOT APPLY.

# **Preface**

## **The ARexx Bandwagon**

No one could have predicted the success of William Hawes' ARexx when he first released it in 1987. His implementation of the REXX programming language fits naturally on top of the Amiga's operating system and is arguably the cleanest and most elegant implementation available for any system. Developers were quick to see the potential of ARexx, just as users were quick to exploit the benefits of a standard macro language. The words "includes ARexx support" grew from a being a simple marketing slogan to a necessary feature in commercial products. The bandwagon grew so large and so loud that Commodore had to take notice.

ARexx is now an official part of the Amiga system software. With the release of Workbench 2.0, Commodore has made the power of ARexx available to all Amiga users. ARexx is also available in its original form for those present Amiga users who have yet to upgrade to 2.0. Join the bandwagon now!

## **Production of this Book**

This book was produced entirely on an Amiga 2000 system running both Workbench 1.3 and 2.0, with an A2630 accelerator card to help speed things up. The text was written and edited using ASDG's *CygnusEd Professional* text editor. Formatting and previewing of the text was done using Radical Eye Software's *AmigaTEX,* an implementation of the *makeindex* system. C program examples were compiled and tested with both the SAS/C *Amiga C Compiler,* version 5.10, and the Manx *Aztec C Compiler,* version 5.0e.

The complete system, of course, was tied together through the use of ARexx programs and macros. Only Amiga!

## **Acknowledgements**

A lot of work and sleepless nights go into the writing of a book, especially when there is both programming and writing involved. At this point I would like to take some time to acknowledge and thank those without whose help this book could not have been written:

- First and foremost, **Bill Hawes,** the Father of ARexx and patient answerer of questions
- **Tom Rokicki,** of Radical Eye Software, both for his wonderful implementation of TEX and his help with ARexx questions
- And of course the many proofreaders who pored over this book looking for those niggling mistakes that I inevitably made, including Willy Langeveld, Michael Sinz, Andy Finkel and Dan Baker, my editor at Commodore-Amiga, Inc.

Finally, I would like to dedicate this book to my parents Jean-Claude and Marie-Joelle, my grandparents Yvette and Auguste, and my sister Anik.

Eric Giguère

## Contents

Table of Contents

# CHAPTER 1 **Introduction**

This chapter explains the purpose of this book, the assumptions that are made about you, the reader, the conventions used throughout the book, and the book's organization.

## Purpose Of This Book

The  *Amiga Programmer's Guide* to ARexx is designed to allow the Amiga programmer easy access to the power of ARexx. This includes how to make effective use of ARexx, how to conform to development standards, and how to interface Applications to the ARexx environment. Both casual and advanced users will find topics of interest in this book.

## ARexx vs. REXX

ARexx is an implementation of the REXX programming language, but it's also much more. ARexx is also a macro language that can be used to extend an application's capabilities and integrate it with other applications. (A *macro* is a small program that can be started from within an application. Macros allow users to extend an application's capabilities beyond what the software developer has implemented.) ARexx also defines a set of inter-process communication standards.

REXX was first developed and used on mainframe computers running the VM/CMS operating system. It is still in widespread use and, like ARexx on the Amiga, ties together applications like text editors and C compilers. REXX has since migrated to other microcomputer and minicomputer platforms, but has gained its strongest foothold on the Amiga, where it fits naturally into the Amiga's multitasking environment.

REXX is not a "toy" language. Though it is used mostly for macro processing and "quick 'n dirty" programs, it has also been used to write large applications such as spreadsheets and bulletin board systems. REXX programs aren't as fast as compiled programs, but the interpreted nature of REXX (along with powerful tracing facilities) shortens the programming cycle. REXX is also a much more "user friendly" language than many others, notably the C programming language, and can serve as a good introduction to programming concepts in general.

ARexx implements the REXX language as described in the first edition of *The REXX Language: A Practical Approach* to *Programming* by M. F. Cowlishaw. Most of the ARexx built-in functions are identical to the REXX built-in functions described in that book, with some additions specific to the Amiga environment.

## **Audience**

Every book is written with a certain audience in mind, and this book is no exception. The following assumptions are made about the typical reader of the *Amiga Programmer's Guide to ARexx:* 

### **ARexx Skills**

This book is *not* a tutorial on the REXX language, nor does it show you how to install and activate ARexx. This information can be found in *Using The System* Software for Workbench 2.0 users. If you have yet to upgrade to 2.0, ARexx must be purchased separately from your dealer and the information can be found in the *ARexx User's Reference* Manual that accompanies the software.

A few books on general REXX programming are also listed in the bibliography. Please remember, though, that most of these books are not Amiga-specific and may not accurately describe ARexx's capabilities. When in doubt, always consult the official ARexx documentation.

If you are not using Workbench 2.0, please ensure that you've upgraded to at least version 1.15 of ARexx. There are very few differences between this version of ARexx and the version that is distributed with Workbench 2.0.

#### **C Skills**

Program examples in the C programming language are used extensively throughout this book. If you don't feel comfortable with the C language, there are many introductory books available on the market today. You will also need to purchase a C compiler and learn how to use it. The C compiler you use should support the major ANSI C features, as the examples in this book make extensive use of features such as function prototypes.

Why are (non-ARexx) programming examples written in C? C is, for better or for worse, the programming language used the most for serious program development on the Amiga. The Amiga operating system is easily accessible from C, and the commercial C compilers available include the necessary support for creating ARexx-compatible programs.

### **Amiga Skills**

Portions of this book also assume a certain familiarity with Amiga programming in general. For example, functions from the Exec operating system layer are used extensively in C programming examples. At the very least you should have access to the following Amiga reference books from Commodore:

* *Amiga ROM Kernel Reference Manual: Libraries*
* *The AmigaDOS Manual*
* *Amiga User Interface Style Guide* 

Remember: part of a programmer's skill-set is knowing *when* and *where* to look things up.

Other books of interest to the Amiga programmer are listed in the bibliography.

## **Conventions**

### **Programming Style**

Programming styles differ greatly from person to person. The examples in this manual have been formatted with an emphasis on clarity of presentation. All examples are set in a `typewriter` (fixed-width) font. Long examples are marked off using horizontal rules and given a listing number.

Some of the ARexx examples make use of the ARexx support library, as described in Chapter 3. Rather than always checking for the library's existence, you should load it into memory at the start of your programming session. See the directions on page 17 for details on how to do this.

> **— The arexx.h header file**
>
> To save space and simplify program examples, C listings in this book always start by including the **arexx.h** header file, shown in Listing 1 on page 5.

### **C Compilers**

C program examples in this book have been compiled with the following compilers:

* *SAS/C Amiga C Compiler,* version 5.10
* *Manx Aztec C Compiler,* version 5.0e

These compilers include most of the features of ANSI C and support Workbench 2.0, including the necessary header files. Other compilers are available but may not have the necessary features required for some of the more advanced program examples. In some cases the necessary 2.0 header files must also be licensed directly from Commodore.

## **Organization Of This Book**

The *Amiga Programmer's Guide* to ARexx is about programming with ARexx on the Amiga. The material in this book splits naturally into two parts.

### **Part 1: Using ARexx**

The first part deals with concerns specific to ARexx programming on the Amiga. An alternate title for this section could be *Navigating in the* ARexx *Environment.* The chapters are organized as follows:

* **An ARexx Roadmap** describes the components of the ARexx environment and shows how everything fits together: the resident process, ARexx ports, function libraries, resources and more.
* **Standard ARexx Functions** lists *all* the standard ARexx functions with examples of their use.
* **Commands and Macros** explains the tricks of writing useful and effective ARexx command macros.
* **Console Input/Output** discusses console input and output as used by ARexx programs.

### **Part 2: The ARexx Interface**

The second part of this book deals with interfacing to the ARexx environment from external programs or libraries. The chapters are organized as follows:

* **The ARexx System Library** describes the special support routines and data structures needed to interface your own programs with ARexx.
* **The Basic ARexx Port** describes how to setup your own ARexx port to receive command messages.
* **Advanced Port Handling** looks at the more advanced use of ARexx ports, including starting ARexx programs and the REXX Variables Interface.
* **SimpleRexx: A Simple ARexx Interface** presents an elegant ARexx interface to easily add ARexx support to a C program.
* **ARexx Standards** summarizes the ARexx programming standards defined in *Amiga User Interface Style Guide.*
* **Function Hosts** describes the implementation and use of ARexx function hosts.
- **Function Libraries** describes the implementation and use of ARexx function libraries.

### **Appendices**

The appendices summarize some useful information for the ARexx programmer:

* **ARexx Language Quick Reference** is a quick glance at the features of the ARexx language and its differences from other REXX implementations.
* **ARexx Error** Messages lists the complete set of ARexx error messages.
* **Header Files** lists the standard ARexx header files.

***Listing 1: The arexx.h header file***

```c
/* 
 * arexx.h -- Standard header file to be included by all C programs 
              in the Amiga Programmer's Guide to ARexx. 
*/ 

#ifndef AREXX_H_INCLUDED
#define AREXX_H_INCLUDED

#include <exec/types.h> 
#include <exec/memory.h> 
#include <exec/nodes.h> 
#include <exec/libraries.h> 
#include <exec/ports.h> 

/* 
 * Note: INCLUDES_2 should be DEFINEd by users who wish to use 
 * Commodore's official header files for 2.0 
*/ 

#if defined( INCLUDES_2 ) /* Use 2.0 includes */ 
    #include <clib/exec_protos.h>
    #include <clib/dos_protos.h>

    extern struct MsgPort *CreatePort(UBYTE *name, ULONG pri );

    /* Here you have to insert the pragma files you've built 
       for your compiler from Commodore's 2.0 .fd files */ 

#elif defined(AZTEC_C) /* Aztec C */ 
    #include <clib/exec_protos.h> 
    #include <clib/dos_protos.h> 

    extern struct MsgPort *CreatePort(UBYTE *name, ULONG pri); 

    #ifndef __N0_PRAGMAS 
        #include <pragma/exec_lib.h> 
        #include <pragma/dos_lib.h> 
    #endif 

#elif defined(LATTICE) || defined( __SASC ) /* SAS/C */ 
    #include <proto/exec.h> 
    #include <proto/dos.h> 
#endif 

#ifndef NULLCHAR 
#define NULLCHAR '\0 ' 
#endif 

#endif /* AREXX_H_INCLUDED */
```

# PART 1 **Using ARexx**

# CHAPTER 2 **An ARexx Roadmap**

This chapter provides an overview of the ARexx programming environment and describes the individual pieces that give ARexx its power and flexibility.

## The Amiga Environment

As was mentioned in the introduction, this manual assumes that you have a certain level of experience in programming the Amiga. It's hard to be an expert at everything, though, so this section is intended to serve as a refresher on the Amiga environment. The emphasis is on *Exec,* the foundation of the operating system. For more information on the topics discussed in this section, please refer to the following books:

* *Amiga ROM Kernel Reference Manual: Libraries*
* *The AmigaDOS Manual, 3rd Edition*

### Tasks and Processes

A *task* is a program in execution. The Amiga is a *multitasking* system, capable of keeping multiple tasks in memory and scheduling the processor between them literally hundreds of times a second. It's this scheduling that allows programs to run seemingly simultaneously. Only one task is actually running at any given moment. This task is known as the *active*  or *running* task. All other tasks are either ready to be executed (*ready*) or waiting for an external event (*waiting* or *blocked*). 

A *process* is a special kind of task. While they share all the usual properties of tasks, processes are the only tasks that can communicate with AmigaDOS. The functions described in *The AmigaDOS Manual* can only be accessed from a process. Because of this, most programs are run as processes and not as simple tasks. ARexx programs are all run as processes. (Note that in many operating system textbooks the words task and *process* are often used as synonyms. Remember that on the Amiga there *is* a difference.)

Each task or process has a *priority* associated with it. Generally, the higher the priority, the more often the task or process gets executed in any given time interval.

There are times when a task or process needs to be notified of an event, or to synchronize itself with another task. A *signal* can be sent to a task in such cases to notify it.

### Inter-Process Communication

Tasks and processes communicate through the Amiga's *inter-process communication* (IPC) facilities (actually, the term inter-task *communication* is more accurate, but IPC is the term in common use). Exec provides IPC support through the use of ports and messages.

A *message* is an arbitrary piece of data to which a special header is attached. The header contains the information that Exec needs to deliver the message to another task.

A *port* is a queue to which messages are delivered. Any task that wishes to receive a message must create a port. Ports can be given names. When a message arrives at a port, the task that owns the port (a task may create more than one port) is usually notified by a signal. It is then up to the task to retrieve the message from the queue and interpret its contents.

Ports can be *public* or *private*. A public port is known to (and accessible by) all tasks on the system.

The task that sends a message to a port is known as the *sender*. The task that receives the message is the *receiver*. In many cases the receiver will send an answer or acknowledgement back to the sender as a *reply* message.

### Shared Libraries

A *shared library* is a collection of routines that can be accessed by several tasks. The library is usually stored on disk and is only loaded into memory when a task requests it, and can be flushed from memory when no tasks require it. The main advantage of shared libraries is that only one copy of the library needs to be in memory even if several tasks are using the library. All Amiga system routines, including those of Intuition and AmigaDOS, are accessed through shared libraries. The ARexx interpreter is itself a shared library.

> A shared library differs from a compiler (or link) library. A compiler library is a set of routines to which you link your object files to create an executable file. Shared libraries are accessed dynamically, at run-time. Unless otherwise noted, the term *library* is used throughout this book to refer to shared libraries, not compiler libraries.

## **The Resident Process**

The heart of ARexx is the *resident process,* the master ARexx control program. The resident process runs as a background process and manages the ARexx environment; it must be active before any ARexx programs can be executed.

### **Duties of the Resident Process**

The resident process has two main duties:

* **Program launching**. All ARexx programs are started by the resident process. The resident process creates a new process, loads the ARexx program into the new process, and invokes the ARexx interpreter.
* **Resource management**. Besides keeping track of all currently-executing programs, the resident process also manages ARexx resources, including the Clip List and the Library List, both described in a later section. When an ARexx program terminates, the resident process ensures that the program's resources are returned to the system.

Note that the resident process is also an ARexx *host application*, a program that can send and receive ARexx messages.

### Finding the Resident Process

On the typical Amiga system the ARexx resident process is always active, launched from within the system startup file using the rexxmast command. Sometimes this isn't the case. Your application programs should always ensure that the resident process is active before using or accessing the ARexx environment. The check is simple: the resident process is active if the "REXX" port can be found by Exec's FindPort() function.

If the resident process cannot be found, your application should disable its ARexx features. You may also wish to inform the user that ARexx is not available.

## ARexx Ports

An ARexx port is a named, public port to which ARexx *messages* can be sent. An ARexx message is a message protocol (described later in the book) used by programs in the ARexx environment. It's an extension of the Exec message format.

ARexx ports are defined using the Exec function CreatePort(). Note that a port name *must* be supplied. More details on ARexx port creation and naming can be found in Chapter 7.

An ARexx port is typically used by a host application to send a command to the resident process. An ARexx macro program may be started in this fashion, and the results of the macro will be returned to the application via a reply message to its ARexx port.

ARexx programs can also send commands to an application using the `ADDRESS` instruction. Commands will be sent to the ARexx port matching the `ADDRESS` name string. (The exception to this is the `ADDRESS COMMAND` instruction, which will send commands to AmigaDOS instead of an ARexx port. Details can be found in Chapter 4.)

## Function Hosts and Libraries

ARexx's functionality can be easily expanded through the use of function hosts and function libraries. These are mostly used from within an ARexx program, but are also available to any application with an ARexx port.

### Function Libraries

An ARexx *function library* is a shared library containing one or more functions that can be accessed from ARexx. The function library includes a special *dispatch* entry point that is used to match a function name with a function in the library. Note that a function library is not an ARexx program, but a special Amiga shared library following the format described in *Amiga ROM Kernel Reference Manual: Libraries.* It is typically written in C or assembler (normally used only by ARexx. You cannot use a normal Exec library in this fasion). Function library creation is described in Chapter 12.

To access the functions in a function library, the library is first added to the Library List (described below) using the ADDLIB() built-in function. See Chapter 3 for more information. The Library List entry for a function library includes its name, a search priority, the dispatch point offset and a version number. Note that the library itself must be stored as a file in the LIBS: directory, and the library name must match the filename.

The ARexx support library is an example of a function library. Other libraries are available from third-party sources.

### Function Hosts

A *function host* is an application which will accept ARexx function calls. The function call is sent as a special ARexx message to the application's ARexx port. The application then processes the message to extract the function name and any arguments to that function. The result of the function call is returned as an ARexx message.

Unlike a function library, the internals of a function host are unknown to the resident process or any program that wishes to use it. A function host could conceivably link to another computer across a network in order to complete a request. Also, a function host does not have a dispatch point. It alone processes the messages at its port and decides whether or not it supports the requested function. Function host creation is discussed in Chapter 11.

As with function libraries, a function host is added to the Library List (described below) using the ADDLIB() built-in function. See Chapter 3 for more information.

> The ARexx resident process is itself a function host, and is installed in the Library List with a priority of -60. It has two names: "REXX" and "AREXX". The use of these ports is discussed in Chapter 8.

## Public Resources

The resident process maintains public resources for use by all ARexx programs and application hosts.

### The Library List

The Library List is the list of function libraries and function hosts that are currently accessible. Entries in this list are ordered by priority. When a function call cannot be resolved within an ARexx program or with a built-in function (see page 18 for the search rules), the entries in the Library List are tried in order, starting with the highest priority entry. (Entries at the same priority level are searched in the order they were added to the Library List.) Function libraries are checked at their dispatch point and function hosts are sent a message. If the library or host has no function that matches the given name, the search continues with the next library or host in the list.

Libraries and hosts are added to the Library List with the ARexx `ADDLIB()` function and removed using the `REMLIB()` function. The Library List can be examined using the `SHOW()` function. See Chapter 3 for more details.

### The Clip List

The Clip List maintains a list of pairs of strings for data sharing between applications and ARexx programs. Each entry in the list consists of a name and a value, both of which are strings. The name is used to identify and search for the entry (searching is case-sensitive).

The Clip List is a public list. Entries are changed using the ARexx `SETCLIP()` function. The `GETCLIP()` function will search for an entry by name and retrieve its value string. See Chapter 3 for more details on these functions.

> **Sharing Data**
>
> There are no restrictions as to what the value string of a name-value pair in the Clip List can hold. One potential application is to use the Clip List for loading predefined constants into an ARexx program. For example, say the following string was stored under the name constants:
> ```rexx
> pi=3.14159; e=2718; sqrt2=1.414
> ```
> Any ARexx program could then use the `GETCLIP()` function to retrieve this string and use the `INTERPRET` command to execute the assignments:
>
> ```rexx
> numbers = getclip( 'constants' )
> interpret numbers
> ```
> Be creative!


## Putting It All Together

To help clear things up, let's consider a typical ARexx scenario: the user has started an application program that supports ARexx and wishes to invoke an ARexx macro from within that application. The application might be a text editor; the macro might save the current file and compile it. We'll use the short ARexx program in Listing 2 as our sample macro program. It just displays the contents of the `RAM:` directory twice, but it's enough for our purposes.

***Listing 2: A Simple ARexx Program***

```rexx
/* Load in support library if not already installed */ 

if( ~show('1', 'rexxsupport.library')) then do 
    if( ~addlib('rexxsupport.library',0,-30,0)) then do 
        say "Could not open ARexx support library." 
        exit 10 
    end 
end 

/* Send a CLI command */ 

address command 'dir ram:' 

/* Call a support library function */ 

say showdir('ram:','a') 

exit 0
```

Let's assume that the application has created an ARexx port. The first step in starting an ARexx macro is to search for the resident process. If the resident process does not exist, the application must cancel the macro invocation.

Once the resident process has been located, the application sends it a message asking it to start the ARexx macro. The resident process searches for the program (using the rules listed in Chapter 8) and starts it as a new process. The reply message will be returned to the application only when the ARexx program exits. 

> This is the usual behaviour. You may instead request that the reply message be sent back immediately as discussed in Chapter 8.

The application should, in most cases, wait for the reply message before continuing with other tasks.

The ARexx macro has now begun execution. It first uses the built-in function `SHOW()` to determine if the ARexx support library is installed; if not, it installs it using `ADDLIB()`, another built-in function. (See Chapter 3.) If the library could not be installed, the macro exits with an error code, which will be passed back to the application.

Assuming that the library was installed, the ARexx program proceeds to use the `ADDRESS` instruction to send a command string to the AmigaDOS Shell (CLI). (We are assuming here that a Shell is available, as is console output.) The `ADDRESS` command will send the string `"dir ram:"` to AmigaDOS and wait for AmigaDOS to finish executing the command.

When the ARexx macro continues execution, it encounters a call to the `SHOWDIR()` function. `SHOWDIR()` is not a built-in function, so (using the rules described in Chapter 3) the ARexx program searches the Library List for a function library or function host that has a `SHOWDIR()` function. `SHOWDIR()` is a support library function, so the ARexx program calls that function and then displays the result string.

At this point the ARexx program terminates and returns an error code of 0 (no error) back to the application. The application then continues with its normal processing.

This example was necessarily quite simple. ARexx macro invocation can be tricky, since an ARexx macro may send commands to other programs, including the application that started it. Error-handling can be non-trivial in such cases. See Chapters 7 and 8 for details.

# CHAPTER 3 **Standard ARexx Functions**

Function calls form the core of any non-trivial ARexx program. This chapter describes the standard ARexx functions — almost a hundred of them!

## Built-In Functions

The ARexx interpreter itself includes a large list of useful functions, known as built-in functions. The descriptions for these functions form the bulk of this chapter. Most of the built-in functions are dedicated to input/output and string handling. They are based for the most part on the REXX built-in functions described in M. F. Cowlishaw's *The REXX Language: A Practical Approach to Programming*.

Because they are part of the interpreter, the built-in functions are always available for use by ARexx programs. The built-in functions have also been optimized to work with ARexx's internal data structures and in general execute much more quickly than any equivalent interpreted or external function, so their use is highly recommended.

## Support Functions

A set of useful Amiga-specific functions is also available to ARexx programs through the ARexx support library. The support library is a function library that is supplied with the ARexx interpreter. It can be found in your `LIBS:` directory as the file rexxsupport.library.

> **Installing the Support Library**
> 
> To use the support library functions, the support library itself must first be added to the ARexx Library List. This is done using the `ADDLIB()` built-in function:
> ```rexx
> call addlib 'rexxsupport.library',0,-30,0
> ```
> The dispatch offset for the support library is -30.
> 

If several of your ARexx programs use the support library, you may wish to add the following Shell (CLI) command to your Amiga's startup sequence:

```rexx
rx "call addlib 'rexxsupport.library', 0, -30, 0"
```

The support library will be added automatically to the Library List when you boot your machine. For your convenience, the **rxlib** command will perform the same operation:

```
rxlib rexxsupport.library 0 -30 0
```

ARexx programs that use the support library should always ensure that the library is installed before calling any of its functions. The `SHOW()` built-in function can be used for this purpose:

```rexx
/* Check to see if the support library is installed. If it isn't, 
   add it to the library list. */ 

if(~show('L','rexxsupport.library')) then do 
    if(~addlib('rexxsupport.library',0,-30,0)) then do
        say "Could not open ARexx support library."
        exit 10
    end
end
```

The current support library functions are: `ALLOCMEM()`, `BADDR()`, `CLOSEPORT()`, `DELAY()`, `DELETE()`, `FORBID()`, `FREEMEM()`, `GETARG()`, `GETPKT()`, `MAKEDIR()`, `NEXT()`, `NULL()`, `OFFSET()`, `OPENPORT()`, `PERMIT()`, `RENAME()`, `REPLY()`, `SHOWDIR()`, `SHOWLIST()`, `STATEF()` and `WAITPKT()`. In the function descriptions that follow, support library functions are marked with a dagger (+). All other functions are built-in functions.

## **Search Order**

When a function call is encountered, the ARexx interpreter searches for a function definition that matches the function name (symbol or string). That search follows a very strict order:

**1. Internal functions** are matched first. The ARexx program source is examined for a label that matches the function name. If a match is found, a new storage environment is created and control is transferred to the label. See the note below about strings as function names.

**2. Built-in functions** are searched next. All of these functions are defined by uppercase names and the built-in library has been organized to make the search as efficient as possible.

**3. Function libraries and functions hosts** are then searched. The available libraries and hosts are listed in the Library List, sorted by priority. The search starts at the highest-priority library or host and continues until the function is found or the end of the Library List is reached. (See the preceding chapter for a description of how function libraries and function hosts work.)

**4. External ARexx programs** are searched last. A message is sent to the ARexx resident process, which then searches for an ARexx program whose name matches the function name. The search begins at the current directory and follows the same search path as the original ARexx program invocation. Name matching is not case-sensitive.

If the function is not found, an error is generated and the evaluation of the current expression is terminated.

Note that the name matching may be case-sensitive for some of the search steps but not for others. In particular, the matching procedure used in a function library or function host is left to the discretion of the library/host designer.

Important: Functions defined with mixed-case names must be called using a string for the function name, since symbol names are always translated to uppercase before the function search begins.

Internal functions can only be defined using symbol names. If a string is used as a function name, the first step in the search order will be skipped. This allows internal functions to use the names of external or built-in functions while still being able to access those functions, as in the following example:

```rexx
CENTER:
    parse arg string, length
    return 'CENTER'(string,min(length,60))
```

Remember that the case of a function name is important when using strings to call a function.

## **Function Definitions**

The rest of this chapter lists the various ARexx built-in and support functions. Some general conventions:

Arguments are shown with emphasis within the text and the syntax description:

```rexx
ABS(number)
```

Some arguments are optional and are shown within square brackets:

```rexx
COMPRESS(string,[list])
```

If an optional argument is omitted in a function call, a default value (described in the text) is supplied. Legal (and mutually exclusive) values are separated using the  $\Leftrightarrow$  symbol:

```rexx
ARG(number,'Exists'⇔'Omitted')
```

While internal functions can be called with any number of arguments, other functions are limited to a maximum of 15 arguments.

**Pad character arguments** only use the first character of the argument string. If a null string is supplied, the default character (usually a blank) will be used.

**Keyword arguments**, as shown above in the `ARG()` function, also only use the first character of the argument string. Case is ignored. For example, the `Exists` keyword shown above may be passed as `E`, `e`, `Exists`, or even `enter`.

**I/O support functions** use a "logical name" or handle to reference files. See the `OPEN()` function for details.

**Bit-manipulation functions** implement extended bit-testing on character strings. Bits are defined such that bit 0 is the low-order (rightmost) bit of the rightmost byte of the string.

## ABBREV
```rexx
ABBREV(full,abbrev,[length])
```

Returns `1` if `abbrev` is an abbreviation of `full` and `abbrev` is at least `length` characters long. If `length` is not specified, it defaults to `0`.

```rexx
abbrev('fullname', 'ful')         returns 1
abbrev('almost', 'alm', 4)        returns 0
abbrev('any', '')                 returns 1
```

#### ABS

#### ABS( number )

#### Summary

Returns the absolute value of number, which must be numeric.

#### Examples

```
abs(-5.35) returns 5.35
abs(10) returns 10
```

See Also: MAX(), MIN(), SIGN()

## **ADDLIB**

```
ADDLIB( name, priority ) 
                     or 
ADDLIB( name, priority, offset, version )
```

#### Summary

Adds a function library or a function host to the Library List maintained by the resident process. The name argument is case-sensitive and specifies the name of a function library or the name of the public message port associated with a function host. Libraries must be located in the LIBS: directory to be found by the system. The library or host will be added to the Library List with the search priority specified by *priority,* which must be an integer between -100 and 100 inclusive.

Function hosts only require that *name* and *priority* be specified.

Function libraries must be added using the second form of ADDLIB(). The *offset* is the integer offset to the library's dispatch entry point and *version* is an integer specifying the minimum acceptable release level of the library.

ADDLIB() returns 1 if the operation was successful. If a library is specified, the library is not actually opened until it is required. Similarly, function hosts are not accessed until required.

#### Examples

```
addlib( "rexxsupport.library", 0, -30, 0 ) returns 1 
call addlib "EtherNet", -20
```

#### Notes

The correct *offset* value for a function library is not necessarily -30, as it is for the ARexx support library. Use the value supplied in the library documentation.

See Also: REMLIB(), SHOW(), SHOWLIST()

## **ADDRESS**

## ADDRESS()

#### Summary

Returns the current host address string. The host address is the message port to which commands will be sent. ADDRESS() does not check the validity of the host address — use SHOW() to list known hosts.

#### Examples

address() *returns '*REXX *'* 

#### Notes

The resident process' host addresses are "REXX" and **"AREXX".** 

**See Also: SHOW(), SHOWLIST()** 

## **ALLOCMEM+**

```
ALLOCMEM( length, [ attribute ] )
```

#### **Summary**

Allocates a block of memory of the specified *length* from the system's memory pool and returns its address as a 4-byte string. The optional *attribute* must be a standard Exec memory allocation flag, supplied as a 4-byte string:

> PUBLIC **'0000 0001'x CHIP '0000 0002'x**  FAST '0000 **0004'x CLEAR '0001 0000'x**

The default attribute is for PUBLIC memory (not cleared). **ALLOCMEM()** returns '00'x if the allocation request failed.

This function should be used whenever memory is allocated for use by external programs. It is the programmer's responsibility to release the memory space when it is no longer needed.

#### **Examples**

```
mem = allocmem( 1000 ) 
chip = allocmem( 50, '0000 0003'x )
```

#### **Notes**

**+ALLOCMEM() is** a support library function. See page 17.

**Use caution with this function!** Unless you need CHIP or PUBLIC memory, it is best to use **GETSPACE()** to allocate memory for use by your ARexx program, as this memory will be freed automatically when your program FFREEMEM(), s. If your program calls **ALLOCMEM()**  and terminates before calling **FREEMEM(),** he memory that was allocated will be lost until the system is rebooted.

**See Also: GETSPACE(), FREEMEM(), FREESPACE(), STORAGE()** 

#### ARG

```
ARG()

or

ARG( number )

or

ARG( number, 'Exists' ⇔'Omitted')
```

#### Summary

The first form of ARG() simply returns the number of arguments supplied to the current environment. This number includes omitted arguments.

The second form of ARG() returns the string corresponding to argument number number. Argument numbering starts at 1.

The third form of ARG() checks for the existence or omission of a given argument. The "Exists" option will return 1 if a string for argument number was supplied. The "Omitted" option will return 1 if a string was not supplied.

#### Examples

```
n = arg()
say "Arguments:" n
do i = 1 to n
    if( arg( i, 'e' ) = 1 )then
        say "Argument" i "is: '" || arg( i ) || "'"
    else
        say "Argument" i "was omitted"\nend
```

#### Notes

A null string does not necessarily imply that an argument was omitted.

## **BADDR**†

```
BADDR( bptr )
```

#### Summary

Converts a BCPL-style pointer (BPTR) into a C-style pointer.

#### Notes

†BADDR() is a support library function. See page 17.

## **B2C**

*B2C( string )* 

#### **Summary**

Converts a string of binary digits (0,1) into the corresponding (packed) character representation. The conversion is the same as though the argument string had been specified as a literal binary string (e.g. '1010'B). Blanks are permitted in the string, but only at byte boundaries.

#### **Examples**

```
b2c( '00110011' ) 
b2c( '01100001' ) 
                                         returns 3 
                                         returns a
```

#### **Notes**

This function is particularly useful for creating strings that are to be used as bitmasks.

**See Also: C2B(), X2C()** 

## **BITAND**

```
BITAND( string1 , string2, [ pad ] )
```

#### **Summary**

Returns the bit-by-bit logical AND of *string1* and *string2,* with the result length being the longer of the two operand strings. The shorter string is padded on the right with pad, if present; otherwise the AND operation terminates at the end of the shorter string and the remainder of the longer string is appended to the result.

#### **Examples**

```
bitand( '0313'x, 'FFFO'x ) 
bitand( '13'x, '5555'x, '74'x ) 
bitand( 'abcd', ", 'DF'x ) 
                                       returns '0310'x 
                                       returns '1154'x 
                                       returns 'ABCD'
```

**See Also: BITCMP(), BITOR(), BITXOR()** 

## **BITCHG**

**BITCHG(** *string, bit )* 

Changes (flips) the state of the specified *bit* in the argument *string.* Bit numbers are defined such that bit 0 is the low-order bit of the rightmost byte of the string.

#### **Examples**

```
bitchg( '0313'x, 4 ) returns '00303'x 
See Also: BITCLR(), BITSET(), BITTST()
```

## **BITCLR**

```
BITCLR( string, bit )
```

#### Summary

Clears (sets to zero) the specified *bit* in the argument *string.* Bit numbers are defined such that bit 0 is the low-order bit of the rightmost byte of the string.

#### **Examples**

```
bitclr( '0313'x, 4 ) returns '0303'x
```

**See Also:** BITCHG(), BITSET(), BITTST()

## **BITCOMP**

```
BITCOMP ( string1 , string2, [ pad ] )
```

#### Summary

Compares *string1* to *string2* bit-by-bit, starting at bit number 0 (the low-order bit of the rightmost byte). The returned value is the bit number of the first bit in which the strings differ or -1 if the strings are identical.

#### **Examples**

```
bitcomp( '7F'x, 'FF'x ) returns 7
bitcomp( 'FF'x, 'FF'x ) returns -1
```

**See Also: BITAND(),BITOR(),BITXOR()** 

## **BITOR**

```
BITOR( string1 , string2, [ pad ] )
```

#### Summary

Returns the bit-by-bit logical OR of *string1* and *string2,* with the result length being the longer of the two operand strings. The shorter string is padded on the right with pad, if present; otherwise the OR operation terminates at the end of the shorter string and the remainder of the longer string is appended to the result.

#### Examples

```
bitand( '0313'x, '003F'x ) returns '033F'x
```

See Also: BITAND(),BITCMP(),BITXOR()

## **BITSET**

#### BITSET( *string, bit )*

#### Summary

Sets the specified *bit* in the argument *string.* Bit numbers are defined such that bit 0 is the low-order bit of the rightmost byte of the string.

#### Examples

```
bitset( '0313'x, 2 ) returns '0313'x
```

See Also: BITCHG(), BITCLR(), BITTST()

## **BITTST**

#### BITTST( *string, bit )*

#### Summary

Returns the state of the specified *bit* in the argument *string.* Bit numbers are defined such that bit 0 is the low-order bit of the rightmost byte of the string.

#### Examples

```
bittst( '0313'x, 4 ) returns 1
```

See Also: BITCHG(),BITCLR(),BITSET()

```
c2d('FFFF'x) returns -1
c2d('FF0100'x, 2') returns 256
```

See Also: C2B(), C2X(), D2C()

#### C2X

```
C2X( string )
```

#### Summary

Converts the string argument from its character representation to the corresponding hexadecimal number, expressed as the ASCII characters 0-9 and A-F.

#### Examples

```
c2x( 'abc' )
```

returns 616263

See Also: C2B(), C2D(), D2X(), X2C()

## CENTER/CENTRE

```
CENTER( string, length, [pad])
or
CENTRE( string, length, [pad])
```

#### Summary

Centers the string argument in a string with the specified length. If the length is longer than that of the string, pad characters (or blanks if pad is not supplied) are added as necessary.

#### Examples

```
center( 'abc', 6 )
```

See Also: COPIES(), OVERLAY()

#### CLOSE

```
CLOSE( handle )
```

Closes the file specified by *handle,* the logical name that was specified to the **OPEN()** function call that opened the file. If the file was not open then 0 is returned, otherwise it is closed and 1 is returned.

#### **Examples**

```
close( 'input' ) returns 1 or 0
```

**See Also: EOF() , OPEN() , READCH(), READLN(), SEEK() , WRITECH(), WRITELN()** 

## CLOSEPORT+

#### **CLOSEPORT(** *name )*

#### **Summary**

Closes the message port name, which must have been allocated by a call to **OPENPORT()** within the current ARexx program. Any messages received but not yet replied are automatically returned to their sender with the return code set to 10.

#### **Examples**

```
call closeport myport
```

#### **Notes**

**+CLOSEPORT()** is a support library function. See page 17.

**See Also: OPENPORT(), REPLY()** 

## **COMPARE**

```
COMPARE( string1 , string2 , [ pad ] )
```

#### **Summary**

Compares two index strings and returns the index of the first position in which they differ, or 0 if the strings are identical. The shorter string is padded on the right as required with pad or blanks if pad is not specified.

```
compare( 'abcde', 'abcce' ) returns 4 
compare( 'abcde', 'abcde' ) returns 0 
compare( 'abc+++', 'abc', '+' ) returns 0
```

## **COMPRESS**

```
COMPRESS( string, [ list ] )
```

#### Summary

If the *list* argument is omitted, all leading, trailing and embedded blanks are removed from *string. I*f list is specified, the characters in *list* are removed from *string* instead.

#### Examples

```
compress( 'why not ' ) returns 'whynot' 
compress( '+ + 12-34-+' , '+-' ) returns '1234 '
```

See Also: SPACE(), STRIP(), TRIM()

## **COPIES**

```
COPIES( string, number )
```

#### Summary

Creates a new string by concatenating *number* copies of *string.* If *number* is zero, the null string is returned.

#### Examples

```
copies( 'abc' , 3 ) returns ' abcabcabc' 
copies( 'yo', 0 ) returns ''
```

See Also: CENTER(), OVERLAY()

## **D2C**

```
D2C( number )
```

#### Summary

Returns a character string that is the ASCII representation of the decimal *number,* which should be an integer.

```
d2c( 65 ) 
d2c( 31 ) 
                                         returns ' A' 
                                    x returns '1F'
```

See Also: C2D()

#### D2X

#### D2X( number )

#### Summary

Returns the string that is the hexadecimal representation of the given decimal number.

#### Examples

d2x( 256 )

returns '100'

See Also: C2X(), X2C(), X2D()

### DATATYPE

#### Summary

If option is not specified, DATATYPE() tests whether string is a valid number and returns 'NUM' if it is, 'CHAR' if it isn't.

If option is specified, DATATYPE() returns a boolean value indicating whether string is of the given type. Valid keywords for option are:

| Keyword        | Characters Accepted         |
|----------------|-----------------------------|
| 'Alphanumeric' | Alphabetics (A-Z, a-Z)      |
|                | or Numeric (0-9)            |
| 'Binary'       | Binary digits only          |
| 'Lowercase'    | Lowercase alphabetics (a-z) |
| 'Mixed'        | Alphabetics (A-Z, a-z)      |
| 'Numeric'      | Valid number                |
| 'Symbol'       | Valid ARexx symbol          |
| 'Upper'        | Uppercase alphabetics (A-Z) |
| 'Whole'        | Integer number              |
| ,χ,            | Hexadecimal digits only     |

```
datatype('123') returns 'NUM'
datatype('1a f2', 'x') returns 1
datatype('aBcde', 'L') returns 0
```

#### DATE

```
DATE([option], [date], [format])
```

#### Summary

In its simplest form, DATE() returns the current date in the format specified by option. Recognized options are:

| Keyword    | Date format                                           |
|------------|-------------------------------------------------------|
| 'Basedate' | number of days since January 1, 0001                  |
| 'Century'  | number of days since January 1 of the current century |
| 'Days'     | number of days since January 1 of the current year    |
| 'European' | current date in form DD/MM/YY                         |
| 'Internal' | internal system days                                  |
| 'Julian'   | current date in form YYDDD                            |
| 'Month'    | current month (mixed case)                            |
| 'Normal'   | current date in form DD MMM YYYY                      |
| 'Ordered'  | current date in form YY/MM/DD                         |
| 'Sorted'   | current date in form YYYYMMDD                         |
| 'USA'      | current date in form MM/DD/YY                         |
| 'Weekday'  | current day of the week (mixed case)                  |

If option is omitted it defaults to 'Normal'.

If date is specified, DATE() will use that date instead of the computer's current date in its calculations. If format is not specified, then date is assumed to be in system (internal) days. If specified, format can be either 'I' if date is in internal format, or 'S' if date is in sorted (YYYYMMDD) format.

#### Examples

```
date()
date('M')
date('M')
date('s')
date('s', date('i') + 21)
date('w', 19901117, 's')
returns '17 Oct 1990'
returns '0ctober'
returns 19880420
returns 19880609
returns 'Saturday'
```

See Also: TIME()

## **DELAY**†

DELAY( ticks )

Waits for the specified number of *ticks,* units of 1/50th of a second. Use this function when you need to suspend the execution of an ARexx program for some amount of time.

#### Notes

**+DELAY()** is a support library function. See page 17.

## **DELETE+**

#### **DELETE(** path )

#### **Summary**

Delete the file or directory given by path.

#### Notes

**+DELETE()** is a support library function. See page 17.

See Also: **MAKEDIR(), RENAME()** 

## **DELSTR**

DELSTR( *string, n, [ length ] )* 

#### **Summary**

Deletes the substring of *string* beginning with the nth character for the specified *length in*  characters. The default value for *length* is the remaining length of the string.

#### Examples

```
delstr( '123456', 2, 3 ) returns '156'
```

See Also: **INSERT() , LENGTH() , SUBSTR()** 

## **DELWORD**

**DELWORD(** *string , n, [ length ] )* 

Deletes the substring of *string* beginning with the nth word for the specified *length* in words. The default length is the remaining words of the string. The deleted string includes any trailing blanks following the last word.

#### Examples

```
delword( 'Tell me a story', 2, 2 ) returns 'Tell story' 
delword( 'one two three', 3 ) returns 'one two '
```

**See Also: INSERT(), WORDS(), SUBWORD()** 

## **DIGITS**

#### **DIGITS()**

#### **Summary**

Returns the current NUMERIC DIGITS setting.

#### Examples

```
numeric digits 6 
say digits() returns 6
```

See Also: **FORM(), FUZZ()** 

## **EOF**

#### *EOF( handle )*

#### **Summary**

Checks to see if end-of-file has been reached for the file specified by *handle,* the logical name that was specified to the **OPEN()** function call that opened the file. If the end-of-file has been reached, 1 is returned, otherwise 0 is returned.

#### Examples

```
eof ( 'input' ) returns 1 or 0
```

**See** Also: CLOSE(), **OPEN(), READCH(), READLN(), SEEK()** 

## **ERRORTEXT**

#### **ERRORTEXT(** *n )*

#### Summary

Returns the error message associated with the specified ARexx error code *n.* The null string is returned if the number is not a valid error code.

#### Examples

errortext( 41 ) *returns 'Invalid* expression'

## **EXISTS**

#### EXISTS( *filename )*

#### Summary

Tests whether an external file of the given *filename* exists. The *filename* may include all normal Amiga device and directory specifications.

#### Examples

exists( 'c:cd' ) *returns 1* 

#### Notes

EXISTS() can also check for the existence of a device or directory, not just a file.

See Also: OPEN(), SHOWDIR(), SHOWLIST()

## **EXPORT**

EXPORT( *address, [ string ] , [ length ] , [ pad ] )* 

#### Summary

Copies data from the optional *string* into a previously-allocated memory area, which must be specified as a 4-byte address. The *length* specifies the number of characters to be copied. The default is the length of *string.* If *string* is not supplied, then a value for *length* must be provided. If *length* is longer than the string, the remaining area is filled with the *pad*  character, or nulls ('00'x) if *pad* is omitted. The returned value is the number of characters copied.

#### **Examples**

```
export( '0004 0000'x, 'The answer' ) returns 10
```

#### **Notes**

**Use extreme caution** with this function! Any area of memory can be overwritten using **EXPORT(),** possibly causing a system crash or failure of other applications. Task switching is forbidden while the copy is being done, so system performance may be degraded if long strings are copied.

**See Also: FREESPACE(), GETSPACE(), IMPORT(), STORAGE()** 

## **FIND**

```
FIND( string, phrase )
```

#### **Summary**

Locates a phrase of words *(phrase)* in a larger string *(string)* of words and returns the word number of the matched position.

#### **Examples**

```
find( 'Now is the time', 'is the' ) returns 2
```

## **FORBID+**

#### **FORBID()**

#### **Summary**

Forbids task switching until a call to **PERMIT()** is encountered. Calls to **FORBID()** and **PERMIT()**  can be nested — task switching will only be re-enabled when the outermost **PERMIT()** is executed. Task switching is automatically re-enabled when an ARexx program terminates, regardless of nesting level.

The return value is the current nesting count, or -1 if task switching is enabled.

#### **Notes**

Disabling task switching is very unfriendly in the Amiga's multitasking environment. If you must disable task switching, do it for the shortest possible amount of time.

**+FORBID()** is a support library function. See page **17.** 

**See Also: PERMIT()** 

## **FORM**

#### **FORM()**

#### Summary

Returns the current NUMERIC FORM setting.

#### Examples

```
numeric form scientific 
say form() returns 'SCIENTIFIC'
```

See Also: **DIGITS(), FUZZ()** 

## **FREEMEM+**

#### **FREEMEM(** *address, length )*

#### Summary

Returns a block of memory to the system memory pool. Note that *address* should be the address of a block that was allocated by a prior call to **ALLOCMEM().** The *length* of the block must agree with the length that was passed to **ALLOCMEM(). FREEMEM()** returns 1 if the memory block was freed successfully.

#### Examples

```
mem = allocmem( 50 ) 
freemem( mem, 50 )
```

#### **Notes**

**+FREEMEM()** is a support library function. See page 17.

**FREEMEM()** cannot be used to release memory allocated using **GETSPACE().** Use **FREESPACE()**  instead. See the notes under **ALLOCMEM()** for important information on memory use.

See **Also: ALLOCMEM() , FREESPACE(), GETSPACE(), STORAGE()** 

## **FREESPACE**

**FREESPACE(** *address, length )* 

Frees a block of memory that was obtained from the interpreter's internal memory pool using a call to GETSPACE(). The address must be the 4-byte string that was returned by GETSPACE() for that particular block of length bytes. The return value is 1 if the block was freed successfully.

#### Examples

```
block = getspace( 32 )
say freespace( block, 32 )
```

#### Notes

It isn't always necessary to release internally-allocated memory, since it will be released to the system when the program terminates. If a very large block has been allocated, however, returning it to the interpreter's pool as soon as possible may avoid memory space problems.

See Also: EXPORT(), FREEMEM(), GETSPACE(), IMPORT(), STORAGE()

## **FUZZ**

#### FUZZ()

#### Summary

Returns the current NUMERIC FUZZ setting.

#### Examples

numeric fuzz 3
say fuzz()

returns 3

See Also: DIGITS(), FORM()

## **GETARG**†

#### GETARG( packet, [n])

#### Summary

Extracts a command, function name, or argument string from a message packet. The packet must be a 4-byte address obtained from a prior call to GETPKT(). Each packet has 16 slots, numbered 0 to 15. If n is specified, the string will be extracted from the nth slot. The default value for n is 0, and n must always be less than or equal to the actual argument count for the packet.

Commands and function names are always found in slot 0. Function packets may also have argument strings in slots 1 to 15.

#### Examples

```
/* Get a command */ 
command = getarg( packet ) 
/* Get function name */ 
function = getarg( packet, 0 ) 
/* Get first argument */
```

#### Notes

The message packet passed to GETARG() is expected to be a RexxMsg message structure as described in Chapter 6.

+GETARG() is a support library function. See page 17.

See Also: GETPKT(), WAITPKT()

## GETCLIP

#### GETCLIP( name )

#### Summary

Searches the Clip List for an entry matching name and returns the associated value string. The name matching is case-sensitive and the null string is returned if *name* is not in the Clip List.

#### Examples

```
say setclip( 'numbers', 'pi=3.14159' ) returns 1
say getclip( 'numbers' ) returns 'pi=3.14159'
```

See Also: SETCLIP()

## GETPKT+

```
GETPKT( name )
```

#### Summary

Returns the next message packet queued at the port *name,* which must have been opened by a prior call to OPENPORT() within the current ARexx program. The returned value is the

4-byte address of the message packet or '0000 0000'x if no packets are available.

The function returns immediately whether or not a packet is enqueued at the message port. If there is no useful work to be done until the next message packet arrives, the program should call WAITPKT() instead to allow other tasks to proceed.

#### Examples

```
packet = getpkt( 'MyPort ' )
```

#### Notes

+GETPKT() is a support library function. See page 17.

See Also: GETARG(), OPENPORT(), REPLY(), WAITPKT()

## **GETSPACE**

#### GETSPACE( *length )*

#### Summary

Allocates a block of memory of the specified *length* from the interpreter's internal memory pool. The returned value is the 4-byte address of the allocated block, which is not cleared or otherwise initialized.

#### Examples

```
say c2x( getspace( 32 ) ) returns '0003BF40'x
```

#### Notes

Internal memory allocated with GETSPACE() is automatically returned to the system when the ARexx program terminates, so this function shouldn't be used to allocate memory for use by external programs - use ALLOCMEM() instead.

See Also: ALLOCMEM(), EXPORT(), FREESPACE(), IMPORT(), STORAGE()

## **HASH**

#### HASH( *string )*

#### Summary

Returns the hash attribute of a string as a decimal number and updates the internal hash value of the string.

#### Examples

```
hash( '1' )
```

returns 49

#### **IMPORT**

```
IMPORT( address, [length])
```

#### Summary

Creates a string by copying data from the specified 4-byte address address. If length is not supplied, the copy terminates when a null byte is found.

#### Examples

```
extval = import( '0004 0000'x, 8 )
```

See Also: EXPORT(), FREESPACE(), GETSPACE(), STORAGE()

#### INDEX

```
INDEX( string, pattern, [start])
```

#### Summary

Searches for the first occurrence of pattern in string, beginning at the specified start position. If start is not specified, the default start position is 1. The returned value is the index of the matched pattern or 0 if the pattern was not found.

#### Examples

```
index('123456', '23') returns 2
index('123456', '77') returns 0
index('123123', '23', 3) returns 5
```

See Also: LASTPOS(), POS(), VERIFY()

#### INSERT

```
INSERT( new, old, [start], [length], [pad] )
```

Inserts the new string into the old string after the specified start position. The default starting position is 0, which inserts new in front of old. The new string is truncated or padded to the specified length as required, using the supplied pad character or blanks. If start is beyond the end of the old string, the old string is padded on the right.

#### Examples

```
insert( 'ab', '12345' ) returns 'ab12345' insert( '123', '++', 3, 5, '-' ) returns '++-123--'
```

See Also: DELSTR(), DELWORD(), OVERLAY()

#### LASTPOS

```
LASTPOS( pattern, string, [start])
```

#### Summary

Searches backwards for the first occurrence of pattern in string, beginning at the specified start position. The default starting position is the end of the string. The returned value is the index of the matched pattern, or 0 if the pattern was not found.

#### Examples

```
lastpos('2', '1234') returns 2
lastpos('2', '1234234') returns 5
lastpos('2', '1234234', 4) returns 2
lastpos('5', '1234') returns 0
```

See Also: INDEX(), LENGTH(), POS(), VERIFY()

#### LEFT

```
LEFT( string, length, [pad])
```

#### Summary

Returns the leftmost substring of string with the specified length. If the substring is shorter than length, it is padded on the left with the supplied pad character or with blanks.

#### Examples

```
left('123456', 3) returns '123'
left('123456', 8, '+') returns '123456++'
```

See Also: RIGHT(), SUBSTR()

## **LENGTH**

#### **LENGTH(** *string )*

#### **Summary**

Returns the length (in characters) of *string.* 

#### **Examples**

```
length( 'three' ) returns 5
```

## **LINES**

#### **LINES(** *handle )*

#### **Summary**

Returns the number of lines queued or typed ahead for the logical file referenced by *handle,*  which must be an interactive stream.

#### **Examples**

```
push 'a line' 
push 'another one' 
say lines( 'stdin' )
```

*returns* **2** 

#### **Notes**

The number of lines is returned as a secondary result of the AmigaDOS call **WaitForChar().** 

## **MAKEDIR+**

#### **MAKEDIR(** *path )*

#### **Summary**

Creates the new directory specified by path and returns a boolean result. The function will only fail if the directory could not be created, and not if it already exists.

#### **Notes**

**+MAKEDIR()** is a support library function. See page 17.

**See Also: DELETE(), RENAME()** 

## **MAX**

**MAX(** *number, number, [ number, ... ] )* 

#### **Summary**

Returns the maximum of the supplied arguments, all of which must be numeric. At least two arguments must be supplied.

#### **Examples**

```
max( 2.1, 3, -1 )
```

returns 3

**See Also: ABS(), MIN(), SIGN()** 

## **MIN**

```
MIN( number, number, [ number,
```

#### **Summary**

Returns the minimum of the supplied arguments, all must be numeric. At least two arguments must be supplied.

#### *Examples*

**Examples min( 2.1, 3, -1 )** *returns -1* 

**See Also: ABS(), MAX(), SIGN()** 

## NEXT+

**NEXT** ( *address, [ offset ] )* 

#### **Summary**

Returns the four-byte value at the *address (which is expected* to be a four-byte string) plus offset if specified. It can be used to follow an Exec linked list forward or backward.

```
nextaddr = Next( addr ) /* go forward */ 
prevaddr = Next( addr, 4 ) /* go backward */
```

#### **Notes**

**+NEXT()** is a support library function. See page 17.

## NULL+

#### **NULL** ()

#### **Summary**

Returns a null pointer as a four-byte string '0000 0000'x.

#### **Notes**

**+NULL()** is a support library function. See page 17.

## OFFSET+

**OFFSET** ( *address, displacement )* 

#### **Summary**

Computes a new address as the signed *displacement* from a base *address.* The *address* must be a four-byte string, and the displacement argument is a decimal integer. This function provides a convenient way to compute the address of a field in a data structure without requiring calls to C2D() and D2C().

#### **Notes**

**+OFFSET()** is a support library function. See page 17.

## OPEN

**OPEN** ( *handle, filename, [ 'Append' <=>'Read' <=>'Write' ] )* 

#### **Summary**

Opens an external file for the specified operation. The *handle* argument defines the logical name by which the file will be referenced in subsequent calls to ARexx functions. The *filename* is the external name of the file and may include all normal Amiga device and directory specifications. The three modes are:

• "**Read**" opens the file for reading only. If the file does not exist then the open will fail.

- "**Write**" opens the file for writing only. If the file does not exist, it will be created if possible. If the file exists, its previous contents will be deleted.
- "**Append**" opens the file for writing only, but if the file exists the previous contents will be preserved and any new data will be appended to the file.

If no mode is specified, **OPEN()** defaults to "**Read**".

**OPEN()** returns a boolean value that indicates whether the operation was successful. There is no limit to the number of files that can be open simultaneously and all open files are closed automatically when the program exits.

#### **Examples**

```
open( 'MyCon', 'CON: 160/50/320/100/MyCon' ) returns 1 
open( 'outfile', 'ram:temp', 'w' ) returns 1
```

**See Also: CLOSE(), EOF(), READCH(), READLN(), SEEK(), WRITECH(), WRITELN()** 

## **OPENPORT+**

#### **OPENPORT** ( *name )*

#### **Summary**

Creates a public message port with the given *name.* The returned value is the 4-byte address of the ARexx port resource structure or '0000 0000'x if the port could not be opened or initialized. An initialization failure will occur if another port of the same name (names are case-sensitive) already exists or if a signal bit couldn't be allocated for the port.

The message port is allocated as a port resource node and is linked into the program's global data structures. Ports are automatically closed when the program exits and any pending messages are returned to the sender with the return code set to 10.

#### **Examples**

```
myport = openport ( 'MyPort ' )
```

#### **Notes**

**+OPENPORT()** is a support library function. See page 17.

**See Also: CLOSEPORT(), GETPKT(), REPLY(), SHOW(), WAITPKT()** 

## **OVERLAY**

```
OVERLAY ( new , old , [ start ], [ length ] , [ pad ] )
```

Overlays the *new* string onto the *old* string beginning at the specified start position, which must be positive. The default starting position is 1. The new string is truncated or padded to the specified *length* as required, using the supplied *pad* character or blanks. If the start position is beyond the end of the old string, the old string is padded on the right as well.

#### Examples

```
overlay( 'bb', 'abcd' ) returns 'bbcd' 
overlay( '4', '123', 5, 5, ) returns '123-4----'
```

See Also: CENTER(), COPIES(), INSERT()

## **PERMIT+**

#### PERMIT()

#### Summary

Enables task switching when disabled by a previous call to FORBID(). Calls to FORBID() and PERMIT() can be nested — task switching will only be re-enabled when the outermost PERMIT() is executed. Task switching is automatically re-enabled when an ARexx program terminates, regardless of nesting level.

The return value is the current nesting count, or -1 if task switching is enabled.

#### Notes

Disabling task switching is very unfriendly in the Amiga's multitasking environment. If you must disable task switching, do it for the shortest possible amount of time.

17. is a support library function. See page +PERMIT°

See Also: FORBID()

## **POS**

```
POS( pattern, string, [start] ] )
```

#### Summary

Searches for the first occurrence of pattern in *string,* beginning at the position specified by *start.* The default starting position is 1. The returned value is the index of the matched string or 0 if the pattern wasn't found.

#### Examples

```
pos('23', '123234') returns 2
pos('77', '123234') returns 0
pos('23', '123234', 3) returns 4
```

See Also: INDEX(), LASTPOS(), VERIFY()

#### PRAGMA

```
PRAGMA( option, [value])
```

#### Summary

This function allows an ARexx program to change various attributes relating to the system environment within which it executes. An environmental attribute must be specified as the option. The value is the new attribute value to be installed, if any. Valid options are:

- "Directory" specifies a new current directory. The current directory is used as the
  root for filenames that do not explicitly include a device or path specification. If value\nis omitted or a null string, the current directory is unchanged. The return value is the
  previous value of the attribute.
- "Id" returns the task ID (the address of the task block) as an 8-byte hex string. This value cannot be modified. The task ID uniquely identifies the particular invocation of an ARexx program and may be used to create a unique name for it.
- "Priority" specifies a new task priority for the ARexx program. The priority value must be an integer in the range -128 to 127, but the practical range is much more limited: ARexx programs should never be run at a priority higher than that of the resident process, which currently runs at priority level 4. The return value is the previous priority level.
- "Stacksize" sets the stack size to be used for commands run via the ADDRESS COMMAND instruction.
- "WindowPtr" controls the task's WindowPtr field, which enables or disables AmigaDOS requesters. If value is set to 'Null', requesters are disabled. To re-enable requesters set value to 'Workbench'. The return value is 1 if the operation was successful.
- "\*" defines the specified logical name to be the current console handler, thereby
  allowing the user to open two streams on one window. If value is omitted, the console
  handler is set to that of the program's process. The return value is 1 if the operation
  was successful.

```
/* Set a new priority */
pragma( 'priority', -5 )
```

```
currdir = pragma( 'd' ) 
/* Change to a new directory, then switch back */ 
old = pragma( 'd', 'ram:' ) 
call pragma 'd', old 
/* Turn off AmigaDOS requesters */ 
call pragma( 'w', 'Null' ) 
/* Redefine console handler */ 
call pragma '*', 'stdout'
```

#### Notes

AmigaDOS will display a requester when a device cannot be found, for example when calling the **OPEN()** or EXISTS() functions. The "WindowPtr" option is useful disabling those requesters.

## **RANDOM**

```
RANDOM( [min ] , [ max ] , [seed )
```

#### **Summary**

Returns a pseudo-random integer in the interval specified by *min* and max. The default minimum value is 0 and the default maximum value is 999. The interval *max — min* must be less than or equal to 1000. The random number generator can be re-seeded by supplying a *seed* value.

#### **Examples**

```
thisroll = random( 1, 6 ) 
nextroll = random( 1, 6 ) 
call random ,, 875
```

#### **Notes**

If a greater range of random integers is required, the values from the **RANDU()** function can be suitably scaled and translated.

**See Also: RANDU()** 

## **RANDU**

```
RANDU( [ seed ] )
```

Returns a uniformly-distributed pseudo-random number between 0 and 1. The number of digits of precision in the result is always equal to the current NUMERIC DIGITS setting. The random number generator can be re-seeded by specifying a seed value.

#### Examples

```
firsttry = randu()
numeric digits 3
tryagain = randu()
```

#### Notes

With the choice of suitable scaling and translation values, RANDU() can be used to generate pseudo-random numbers on an arbitrary interval.

See Also: RANDOM()

#### READCH

```
READCH( handle, length )
```

#### Summary

Reads the specified number of characters from the given logical file specified by handle and returns them as a string. The length of the returned string is the actual number of characters read and may be less than length if the end-of-file was reached.

#### Examples

```
instring = readch( 'input', 10 )
```

See Also: CLOSE(), EOF(), OPEN(), READLN(), SEEK(), WRITECH(), WRITELN()

#### READLN

#### READLN( handle )

#### Summary

Reads characters from the logical file specified by handle into a string until a "newline" character is found. The returned string does not include the "newline".

```
instring = readln('input')
```

#### **Notes**

Before a call to **READLN(),** call **EOF(**) to see if the end-of-file has been reached.

See Also: **CLOSE()** , **EOF(), OPEN(), READCH(), SEEK(), WRITECH(), WRITELN()** 

## **REMLIB**

#### **REMLIB(** *name )*

#### **Summary**

Removes an entry with the given name from the Library List maintained by the resident process. The boolean return is 1 if the entry was found and successfully removed. Note that this function does not make a distinction between function libraries and function hosts, but simply removes a named entry.

#### **Examples**

```
remlib( 'rexxsupport.library' ) returns 1 or 0
```

#### **Notes**

**REMLIB()** does not remove an entry immediately if other programs are using it.

**See Also: ADDLIB(), SHOW(), SHOWLIB()** 

## **RENAME+**

#### **RENAME(** *oldpath, newpath )*

#### **Summary**

Renames the file or directory specified by *oldpath as newpath* and returns a boolean result.

#### **Notes**

**+RENAME()** is a support library function. See page 17.

**See Also: DELETE(), MAKEDIR()** 

## **REPLY+**

#### **REPLY(** *packet, rc )*

Returns a message packet to its sender, with the primary result field set to the value given by rc, the return code. The secondary result field of the packet is cleared. Note that packet must be a 4-byte address returned by **GETPKT()** and that *rc* must be a whole number. The function returns **1** if the packet was returned successfully.

#### **Examples**

```
packet = getpkt( 'MyPort' ) 
call reply packet, 10
```

#### **Notes**

**+REPLY()** is a support library function. See page 17.

**See Also: GETPKT(),OPENPORT(),WAITPKT()** 

## **REVERSE**

#### **REVERSE(** *string )*

#### **Summary**

Reverses the sequence of characters in the string.

#### **Examples**

```
reverse( '?ton yhw' ) returns 'why not?'
```

## **RIGHT**

```
RIGHT( string, length, [ pad ] )
```

#### **Summary**

Returns the rightmost substring in *string* with the specified *length.* **If** the substring is shorter than the requested length, it is padded on the left with the supplied pad character or blanks.

#### **Examples**

```
right( '123456', 4 ) returns '3456' 
right( '123456', 8, '+' ) returns '++123456'
```

**See Also: LEFT(),LENGTH(),SUBSTR()** 

## SEEK

```
SEEK ( handle, offset, [ 'Begin' <=> 'Current' <=>'End' ] )
```

#### **Summary**

Moves to a new position in the file identified by the logical file name *handle.* The position if specified as an *offset* from an anchor position. The default anchor position is **"Current".**  The returned value is the new position relative to the start of the file.

#### **Examples**

```
/* Move to the beginning of the file */ 
call seek 'input', 0, 'b' 
/* Move 24 ahead of the current position */ 
new_pos = seek( 'input', 24 ) 
/* Figure out the file length */ 
file_length = seek( 'input', 0, 'e' )
```

**See Also: CLOSE(), EOF(), OPEN(), READCH(), READLN()** 

## SETCLIP

```
SETCLIP( name, [ value ] )
```

#### **Summary**

Adds a name-value pair to the Clip List maintained by the resident process. If an entry of the same name already exists (names are case-sensitive), its value is updated to the supplied *value.* If *value* is omitted, the entry for *name* is removed from the Clip List. **SETCLIP()**  returns 1 if the operation was successful.

#### **Examples**

```
/* Set a value */ 
setclip( 'path', 'df0:s' ) returns 1 
/* Remove an entry */ 
setclip( 'path' ) returns 1
```

**See Also: GETCLIP()** 

## **SHOW**

```
SHOW( option, [ name ], [ pad ] )
```

#### **Summary**

Returns the names in the resource list specified by *option,* or tests to see whether an entry with the specified *name is* available. Valid options are:

- **• "Clip"** examines the names in the Clip List.
- **• "Files"** examines the names in the list of currently open logical file names.
- **• "Internal"** examines the names in the internal Ports List.
- **• "Libraries"** examines the names in the Library List, which are either function libraries or function hosts.
- **• "Ports"** examines the names in the system Ports List.

If *name* is omitted, the function returns a string with the resource names separated by a blank space or, if it was supplied, the pad character. If *name* is supplied, **SHOW()** returns a boolean value indicating whether the name exists in the resource list. Name entries are case-sensitive.

#### **Examples**

```
/* Get the current list of installed libraries */ 
liblist = show( 'l' ) 
/* Is the resident process up and running? */ 
ok = show( 'p', 'REXX' )
```

**See Also: ADDLIB() , ADDRESS() , OPENPORT() , REMLIB() , SHOWLIST()** 

## **SHOWDIR+**

```
SHOWDIR( directory, [ 'All' <=> 'File' <=> 'Dir' ] , [ sep ] )
```

#### **Summary**

Returns the contents of the specified directory as a string of names separated by blanks, or by the *sep* separator character if specified. The second parameter is an option keyword that selects whether the list will include all entries, only files, or only subdirectories.

```
showdir( 'df1:c' ) 
showdir( 'df1:c',,';' ) 
                                      returns 'rx is to hi tco tcc' 
                                      returns 'rx;is;to;hi;tco;tcc'
```

#### **Notes**

**+SHOWDIR()** is a support library function. See page **17.** 

**See Also: EXISTS()** 

## **SHOWLIST+**

```
SHOWLIST( list, [ name ], [ sep ] , [ 'Address' ] )
```

#### **Summary**

If *name* is not supplied, **SHOWLIST()** returns the node names in the selected system list in a string, with the names separated by the *sep* character, or blanks if *sep* is not specified. If *name* is specified, the function returns 1 if the specified system list contains a node of that name. Name matching is case-sensitive.

Valid system lists are **"Assign"** (directories), **"Devices", "Handlers"** (devices), **"IntrList", "Libraries", "MemList", "Ports", "Ready", "ResourceList", "SemaphoreList", "Volumes", "Waiting".** The *list* is scanned with task switching forbidden.

Note that *list* can also be the absolute (4-byte) address of a list header. **SHOWLIST()** will check to ensure that the given address is indeed a list header and then return the names in the list.

If the fourth argument is given, SHOWLIST() will return the *address* of the node matching *name,* which must be specified. **All** addresses are returned as machine addresses, not BPTRs. Note that DOS node names are always uppercase.

#### **Examples**

```
showlist( 'p' ) returns 'REXX MyCon' showlist( 'p', 'REXX' ) returns 1 showlist( 'handlers' ) returns DF0 DF1 CON RAW CNC showlist( 'M' ,, '; ' ) returns showlist( 'a', 'FONTS' ) returns 1 showlist( 'l', 'exec.library' ,, 'a') returns '0000 0676'x' expansion ram;Chip Memory
```

#### **Notes**

**See Also: ADDLIB(),EXISTS(), SHOW(), REMLIB()** 

## **SIGN**

Returns 1 if number is non-negative (positive or zero) and -1 if number is negative. The argument must be numeric.

#### Examples

```
sign( 12 ) returns 1
sign( -33 ) returns -1
```

See Also: ABS(), MAX(), MIN()

#### SOURCELINE

```
SOURCELINE([line])
```

#### Summary

Returns the text for the specified line of the currently executing ARexx program. If line is omitted, the function returns the total number of lines in the program file.

#### Examples

```
/* A simple test program */
say sourceline()
```

#### Notes

This function is often used to embed "help" information in a program.

#### SPACE

```
SPACE( string, n, [pad])
```

#### Summary

Reformats string so that there are n blank characters between each pair of words. If pad is specified, it is used instead of blanks as the separator character. Specifying a value of 0 for n will remove all blanks from the string.

#### Examples

```
space('Now is the time', 3)

space('Now is the time', 0)

space('1 2 3', 1, '+')

returns 'Now is the time'

returns 'Nowisthetime'

returns '1+2+3'
```

See Also: COMPRESS(), STRIP(), TRIM()

## **STATEF+**

#### **STATEF(** *filename )*

#### **Summary**

Returns a string containing information about an external file. The string is formatted as:

*type length blocks protection days minutes ticks comment* 

The type is either ' **DIR** ' or ' **FILE** ', *length* is the file length in bytes, *blocks* is the file length in blocks, *protection* is the list of AmigaDOS protection flags for the file, *days* is the number of days since January 1, 1978 in the file's timestamp, *minutes is* the number of minutes since midnight, *ticks is* the number of ticks (1/50th of a second) in the minutes, and *comment* is the AmigaDOS comment for the file, if any. The protection flags are always in the order **HSPARWED** with a dash ('-') if the attribute isn't present.

#### **Examples**

```
statef ( 'libs: ' ) returns 'FILE 1880 4 ----RWED 3456 1234 12'
```

#### **Notes**

**+STATEF()** is a support library function. See page 17.

## **STORAGE**

**STORAGE()**  *Or*  **STORAGE(** *address, [ string ] , [ length ] , [ pad ] )* 

#### **Summary**

The first form of **STORAGE()** returns the available system memory.

The second form of **STORAGE()** is used much like the **EXPORT()** function. **STORAGE()** copies data from *string* into the memory area indicated by *address,* a 4-byte string. The number of bytes to be copied is specified by *length,* which defaults to the length of *string.* **If** *string*  is omitted, or *length* is longer than the string, the remaining area is filled with the pad character (if pad is omitted, null characters — '00'x — are used instead). The returned value is the previous contents of the memory area. The returned string can be used in a subsequent call to restore the area's original contents.

```
/* Figure out how much memory is free */ 
freemem = storage()
```

```
/* Do some copying */
oldval = storage( '0004 0000'x, 'The answer')
call storage '0004 0000'x,, 32, '+'
```

#### Notes

Use extreme caution with this function! Any area of memory can be overwritten using STORAGE(), possibly causing a system crash or failure of other applications. Task switching is forbidden while the copy is being done, so system performance may be degraded if long strings are copied.

See Also: EXPORT(), IMPORT()

#### STRIP

```
STRIP( string, ['Both' \(\phi\)'Leading' \(\phi\)'Trailing'], [pad])
```

#### Summary

Removes blanks (or pad characters, if specified) from string. STRIP() can remove leading, trailing or both leading and trailing characters. The default option is "Both".

#### Examples

```
strip( ' say what? ' )
```

See Also: COMPRESS(), SPACE(), TRIM()

#### SUBSTR

```
SUBSTR( string, start, [length], [pad])
```

#### Summary

Returns the substring of string beginning at the specified start position for the specified length. If length is omitted, it defaults to the remaining length of string. The start position must be positive. If the substring is shorter than the requested length then it is padded on the right with blanks or with the specified pad character.

```
substr('123456', 4, 2) returns '45' substr('myname', 3, 6, '=') returns 'name=='
```

See Also: DELSTR(), LEFT(), LENGTH(), RIGHT()

#### SUBWORD

```
SUBWORD( string, n, [length])
```

#### Summary

Returns the substring of string beginning with the nth word for the specified length in words. The default length is the remaining length in words of the string. The returned string is stripped of leading and trailing blanks.

#### Examples

```
subword('Now is the time', 2, 2) returns 'is the'
```

See Also: DELWORD(), WORDS()

#### **SYMBOL**

#### SYMBOL( name )

#### Summary

Tests whether name is a valid ARexx symbol. If name is not a valid symbol, the function returns the string 'BAD'. Otherwise the returned string is 'LIT' if the symbol is uninitialized or 'VAR' if it has been assigned a value.

#### Examples

```
j = 5
drop x
symbol('J')
```

See Also: VALUE()

#### TIME

```
TIME([option])
```

If *option* is not specified, returns the current system time in the form HH:MM:SS. Valid options are:

| Keyword     | Description                            |
|-------------|----------------------------------------|
| 'Elapsed'   | Elapsed time in seconds on timer clock |
| 'Hours'     | Current time in hours since midnight   |
| 'Minutes'   | Current time in minutes since midnight |
| 'Reset<br>' | Resets the timer clock to zero         |
| 'Seconds'   | Current time in seconds since midnight |

#### **Examples**

```
/* Suppose that the time is 1:02 AM 
say time( 'Hours' ) 
say time( 'm' ) 
say time( 'S' ) 
/* Reset timer clock */ 
call time 'R' 
say time( 'e' ) 
                                        */ 
                                        returns 1 
                                        returns 62 
                                        returns 3720 
                                        returns .020
```

#### **Notes**

The timer clock is separate from the system clock and is unique for every ARexx program.

See Also: **DATE()** 

## TRACE

```
TRACE( option )
```

#### **Summary**

Sets the tracing mode to that specified by *option.* Valid options are:

| Keyword         |  |
|-----------------|--|
| 'All'           |  |
| 'Commands'      |  |
| 'Errors'        |  |
| 'Intermediates' |  |
| 'Labels'        |  |
| 'Normal'        |  |
| 'Results'       |  |
| 'Scan'          |  |

These options are identical to those used by the TRACE keyword. Consult your ARexx language reference for details. **TRACE()** will also accept the '?' and '!' prefixes used by the

#### TRACE keyword.

The returned value is the mode in effect before the call to TRACE(). This allows the previous trace mode to be restored later.

#### Examples

```
/* Assume tracing mode is ?ALL */
say trace( 'Results' ) returns '?A'
```

#### Notes

The TRACE() function will alter the tracing mode even during interactive tracing, when TRACE instructions in the source program are ignored.

#### TRANSLATE

```
TRANSLATE( string, [output], [input], [pad])
```

#### Summary

This function constructs a translation table and uses it to replace selected characters in string. If only string is given, it is translated to uppercase. If an input table is supplied, it modifies the translation table so that characters in string that occur in the input table are replaced with the corresponding character in the output table. Characters beyond the end of the output table are replaced with the specified pad character or a blank.

The result string is always the same length as the original string. The input and output tables may be of any length.

#### Examples

```
translate('abcde', '123', 'cbade', '+') returns '321++'
translate('low') returns 'LOW'
translate('0110', '10', '01') returns '1001'
```

#### Notes

TRANSLATE() can be used to reorder characters in a string by supplying constant strings for string and input and by specifying the string to be reordered as output. For example

```
translate( '45123', 'abcAB', '12345')
```

will return the string 'ABabc'.

See Also: UPPER()

## TRIM

**TRIM** ( *string )* 

#### **Summary**

Removes trailing blanks from *string.* 

#### **Examples**

```
trim( 'a phrase ' ) returns 'a phrase'
```

**See Also: COMPRESS(), SPACE(), STRIP()** 

## TRUNC

```
TRUNC ( number, [ places ] )
```

#### **Summary**

Returns the integer part of f decimal places. The *number* followed by the specified number o default for *places* is 0 and the number is padded with zeroes as necessary.

#### **Examples**

```
trunc( 123.456 ) returns 123 
trunc( 123.456, 4 ) returns 123.4560
```

## UPPER

**UPPER** ( string )

#### **Summary**

Tran ates string to uppercase. This function is slightly faster for shorter strings than **Translate()** . sl

#### **Examples**

```
upper( ' One fine day' ) returns 'ONE FINE DAY'
```

**See Also: TRANSLATE()** 

## **VALUE**

#### **VALUE(** *name )*

#### **Summary**

Returns the value of the symbol name, which must be a valid ARexx symbol name.

#### **Examples**

```
j = 12 
say value( 'j' ) returns 12
```

#### **Notes**

Any valid expression which evaluates to a valid ARexx symbol can be used as the argument to VALUE().

**See Also: SYMBOL()** 

## **VERIFY**

```
VERIFY( string, list, [ 'Match' ] )
```

#### **Summary**

**If "Match"** is omitted, the function returns the index of the first character in *string* which is **not** contained in *list* or 0 if all characters are in the list. If **"Match"** is supplied then the function returns the index of the first character of *string* which **is** in *list* or 0 if none of the characters are in *list.* 

#### **Examples**

```
verify( '123456', '0123456789' ) 
verify( '123a56', '0123456789' ) 
verify( '123a45', 'abcdefghij', 'm' ) 
                                               returns 0 
                                               returns 4 
                                               returns 4
```

**See Also: INDEX(), LASTPOS(), POS()** 

## WAITPKT+

**WAITPKT(** name )

Waits for a message to be received at the port name, which must have been opened by a prior call to **OPENPORT()** within the current ARexx program. The returned boolean value indicates whether a message packet is available at the port. Normally the returned value is 1, since the function waits until an event occurs at the message port.

Once a packet arrives, it should be removed from the port by a call to **GETPKT()** and should be returned eventually using **REPLY** () . Any message packets received but not returned when an ARexx program exits are automatically returned to the sender with the return code set to 10.

#### **Examples**

```
call waitpkt 'MyPort'
```

#### **Notes**

**+WAITPKT()** is a support library function. See page 17.

**See Also: GETPKT(), OPENPORT(), REPLY()** 

## **WORD**

#### *WORD ( string, n )*

#### **Summary**

Returns the nth word in *string* or the null string if there are fewer than *n* words.

#### **Examples**

```
word( 'Now is the time', 2 ) returns 'is'
```

**See Also: WORDINDEX(), WORDLENGTH(), WORDS()** 

## **WORDINDEX**

#### **WORDINDEX(** *string, n )*

#### **Summary**

Returns the starting position (in characters) of the nth word in *string* or 0 if there are fewer than *n* words.

```
wordindex( 'Now is the time', 3 ) returns 8
```

See Also: WORD(), WORDLENGTH(), WORDS()

## **WORDLENGTH**

#### WORDLENGTH( *string, n )*

#### Summary

Returns the length (in characters) of the nth word in *string.* 

#### Examples

```
wordlength( 'one two three', 3 ) returns 5
```

See Also: WORD(), WORDINDEX(), WORDS()

## **WORDS**

#### WORDS( *string )*

#### Summary

Returns the number of words in *string.* 

#### Examples

```
word( 'You don't say!' ) returns 3
```

See Also: DELWORD(), LENGTH(), SUBWORD(), WORD()

## **WRITECH**

```
WRITECH( handle, string )
```

#### Summary

Writes *string* to the logical file specified by *handle.* The returned value is the actual number of characters written.

#### Examples

```
writech( 'output', 'Testing' ) returns 7
```

See Also: CLOSE(), OPEN(), READCH(), READLN(), WRITELN()

#### WRITELN

#### WRITELN( handle, string )

#### Summary

Writes string, with a "newline" appended, to the logical file specified by handle. The returned value is the actual number of characters written.

#### Examples

```
writeln('output', 'Testing') returns 8
```

See Also: CLOSE(), OPEN(), READCH(), READLN(), WRITECH()

#### X2C

#### X2C( string )

#### Summary

Converts a string of hex digits into the (packed) character representation. Blank characters are permitted in *string*, but only at byte boundaries.

#### Examples

```
      x2c('12ab')
      returns '12ab'x

      x2c('12 ab')
      returns '12ab'x

      x2c(61)
      returns 'a'
```

See Also: B2C(), C2X()

#### X2D

```
X2D( hex, [digits])
```

#### Summary

Converts a hexadecimal number hex to decimal. If digits is specified, the number is padded on the left with zeroes or truncated on the left to fit into the specified number of digits.

#### Examples

x2d( '1f' )

returns 31

See Also: D2X()

### **XRANGE**

#### XRANGE([start], [end])

#### Summary

Generates a string consisting of all characters numerically between the specified start and end values. The default for start is '00'x and the default for end is 'FF'x. Only the first bytes of start and end are significant.

```
xrange()
```

## **CHAPTER 4**

# Commands and Macros

This section describes how ARexx commands work and how to create and use ARexx macro programs.

## **Definitions**

An ARexx *command* is, quite simply, an ARexx expression that the ARexx interpreter doesn't understand. Others languages would consider this a syntax error of some kind, but ARexx simply passes the expression to an external host application for processing. The host application is responsible for interpreting and acting on the expression.

A *host application* is a program can accept commands from an ARexx program. It does this by creating an ARexx port to which ARexx programs direct commands using the ADDRESS instruction. Execution of the calling ARexx program is suspended while the host application processes a command. When the host finishes the command processing, it sets a return code (and possibly a result string) and allows the ARexx program to continue. The program can then check the return code for errors.

A macro program is an ARexx program that is started by a host application. Macros are typically short programs, and they often use the ARexx command facility to communicate with one or more host applications. It is usual for a macro program to send commands to the application that started it and to exchange data with that application. In this way a user can extend an application's capabilities.

## **Host Addressing**

Before a command string can be processed, a host application must be specified. The host application is known by a *host* name or host *address.* 

#### Case-Sensitivity of Host Names

Host names are *case-sensitive* in ARexx. Consider a fictional application with **FooPort** as the name of its ARexx port. The instruction:

**address 'FooPort'** 

is correct, but the form:

#### **address FooPort**

will not work because the *symbol* name **FooPort** will first be transformed to **FOOPORT**  and its literal value will be used instead.

To avoid the problem of case-sensitivity, application developers should follow the ARexx standards discussed in Chapter 10 and use only uppercase letters when naming their ARexx ports.

#### **The Default Host**

For most ARexx programs, the default host application on program startup is the resident process ("REXX"), *not* AmigaDOS. Shell (CLI) commands must be sent to AmigaDOS using the ADDRESS COMMAND instruction, described below.

Macro programs launched from an application will typically use the host application's own ARexx port as the default host address. (The default address is set by the host when it starts a macro.)

## **Switching Hosts**

The ADDRESS instruction is used to specify a new host application. The most common form of the ADDRESS instruction is:

#### **ADDRESS** name

where name is the name (a string or symbol) of a host application's ARexx port. If name is specified as a symbol, it will first be translated to uppercase and the resulting string used as the port name. Note that the symbol *literal* is used, not its *value.* An alternate form of the ADDRESS instruction uses the VALUE keyword followed by an expression:

#### **ADDRESS VALUE** *expression*

The *expression* will be evaluated and the resulting string will be used as the host address. The difference between these two forms can be seen in the following example:

hostname = 'FooPort'

```
address hostname /* Sets host to 'HOSTNAME' */ 
address value hostname /* Sets host to 'FooPort' */
```

The second form is useful with host addresses obtained using the built-in **ADDRESS()** function.

Once a host has been specified, commands from that point on will be sent to that host, the *current host,* until the host address is overriden with another ADDRESS instruction.

A third form of the ADDRESS instruction is available to send isolated commands to an application host:

#### ADDRESS name *expression*

where *name* is a symbol or string and *expression* is a valid ARexx expression. The *expression*  will be evaluated and the resulting string sent immediately to the host specified by *name.*  The current host address remains unchanged.

### AmigaDOS Commands

A special form of the ADDRESS instruction can be used to send Shell (CLI) commands to AmigaDOS. The form is:

#### ADDRESS COMMAND

which sets AmigaDOS as the current host, or alternatively:

#### ADDRESS COMMAND *expression*

which sends the *expression* to AmigaDOS immediately.

Note that AmigaDOS is not really a host application, but ARexx knows how to execute Shell (CLI) commands.

### **Host Validity**

ARexx will not check for the validity of a host address until it must send a command. This is because a host application may remove (close) its ARexx port at any time while an ARexx program is running. If ARexx cannot find a host address, it will generate a syntax error:

#### Error 13: Host environment not found

If the error is not caught, the ARexx program will be terminated.

The simplest way to check the validity of a host address is to use the built-in function SHOW() to verify the existence of the application's ARexx port:

```
/* Is 'Foo' up and running? */ 
if( "show( 'p', 'FOOPORT' ) )then do 
    say "Please start Foo first!" 
    exit 1 
end
```

If the ARexx port could not be found, the application probably isn't running, or isn't ready to accept commands. The ARexx program should exit or start the application itself.

Checking for the ARexx port's existence at the start of your program isn't enough, however, since the port may disappear at any time. ARexx has a SIGNAL facility to trap syntax errors, including host environment errors. The skeleton ARexx program in Listing 3 demonstrates how to trap invalid host addresses. When an error occurs, control will be transferred to the **SYNTAX** : label and RC will hold the ARexx error number. A host environment error is error 13 (the full list of ARexx error values can be found in the appendices). The text of the error can be retrieved using the built-in function **ERRORTEXT(** ). Note that the SIGL symbol's value will be set to the line number on which the error occurred; the built-in function **SOURCELINE()** can be used to retrieve the source text for that line.

## **Sending Commands**

Once the host address has been assigned, you're now ready to send commands to the host application and to interpret the results.

## Command Format

ARexx imposes no restrictions on the format of a command other that it must be a valid ARexx expression. ARexx will simply evaluate the expression and send the resulting string to the host application. While the host processes the command, the ARexx program sleeps, waking only when the host replies with a return code.

A typical command format is a keyword followed by one or more argument strings. For example, a text editor might support a command to move its window to the front of the screen:

```
address 'editor' 
'windowtofront'
```

A more complicated command would include parameters to be evaluated. For example, in Foo when an error occurs the location of the error can be stored in the Clip List for retrieval by a macro:

```
/* Tell Foo to put the error location in the 
   Clip variable "Foo.ErrorLoc" */ 
address FOOPORT "ErrorLoc" 
/* Get the value and parse it into file, line and 
   column values */ 
error = getclip( "Foo.ErrorLoc" ) 
parse var error file line column 
/* Now tell the editor to jump to that 
   location in the file */ 
address "editor" 
"load" file 
"jumpto" line column
```

Notice how this macro manages to communicate with two host applications and act as a kind of "glue" linking them together. It's easy to integrate applications using ARexx! (Don't forget to have your macros check the validity of any host addresses they use and to exit gracefully if a host can't be found.)

The exact commands a host application supports are described in the documentation for that application. The *Amiga User Interface Style Guide* lists a suggested minimal command set for applications, but older applications will support different commands. See Chapter 10.

### Command Results

When a host application finishes the processing of a command, the ARexx program that sent the command is allowed to proceed. The host application always returns a special *return code* that indicates whether the command succeeded, and an optional *result string*  for returning results.

The return code, an integer, will be placed in the special ARexx variable RC. A zero value is assumed to mean that no error occurred, while a positive value indicates an error condition:

```
/* Tell Foo to move to a non-existent directory */ 
address FOOPORT "cd ram:no_dir_here" 
if( rc ~= 0 )then do 
    say "Directory not found" 
    exit rc 
end
```

These aren't rigid rules, only suggestions for developers to follow. Some applications use RC to return integer results which aren't necessarily error codes.

If a command has succeeded, it may return a result string to the ARexx program. The result string will be stored in special ARexx variable RESULT. Result strings are optional, however, and not all commands will return them. Also, results will only be returned if the OPTIONS RESULTS' instruction has been executed before the command was sent to the host:

```
/* Request that result strings be sent */ 
options results 
/* Send a command and check the result */ 
address "editor" "status" 
if( result = "dormant" )then /* check result string */
```

If a command can fail, always check for a zero value in RC before checking the value of RESULT. A result string will probably not be set if an error occurred.

<sup>1</sup>The instruction is OPTIONS RESULTS, but the variable is **RESULT** singular, not plural.

Multiple result strings can be passed to an ARexx macro using either the Clip List or the REXX Variables Interface (RVI) facility. The command can store its results as a series of entries in the Clip List, which the ARexx program can then access using the built-in **GETCLIP()** function. Or a command can use the RVI facility to directly set the values of one or more ARexx variables in the ARexx program. Both methods are discussed in more detail in Chapter 8.

## **Command Debugging**

A special tracing mode, the *command inhibition* mode, is useful for debugging commands. When this mode is active, commands are evaluated but not sent to the current host application. The return code is set to 0. This mode is useful for testing programs that use potentially dangerous or time-consuming commands. Command inhibition mode is toggled using the instruction:

#### **TRACE !**

See your ARexx language reference manual for more details.

#### **— Debugging Hint**

The **SAY** instruction is one of ARexx's most powerful debugging features. Use it to check the command string that is actually being passed to a host application. You might be surprised at what's being sent!

#### **Pitfalls**

Potential command pitfalls include:

**Quoting of strings.** If a command parameter contains embedded spaces, it should be passed as a quoted string, since the host application usually considers spaces to be parameter separators. But in evaluating the command, ARexx strips the outer set of quotation marks from all strings. For example, the command:

**newwindow "My new window"** 

will be seen by the host application as:

**NEWWINDOW My new window** 

The solution is to use an extra set of quotation marks, so that:

**newwindow '"My new window"'** 

will be passed as:

**NEWWINDOW "My new window"** 

Recall that either apostrophes (') or double quotes (") can be used to delimit a string.

**Variables with embedded spaces.** This is a variation of the string quotation problem. Recall that an expression is fully evaluated before being passed to the host application. Variables whose string value includes embedded spaces face the same problem as strings with embedded spaces, so that:

```
title = "My new window" 
newwindow title
```

will pass the string:

```
NEWWINDOW My new window
```

to the host application. The solution is to concatenate the string values with quotation marks on each side, as follows:

```
title = "My new window" 
newwindow '"' | | title | | '"'
```

to result in:

```
NEWWINDOW "My new window"
```

Note that the quotation marks must themselves be quoted. The concatenation bars can be dropped if the quotation marks are moved alongside the variable:

```
newwindow '"'title'"'
```

which can be confusing if there are several variables on a line. Again, the SAY instruction can be used to debug such confusing command expressions.

**Command case-sensitivity. A** well-written host application should accept mixed-case commands, since the following commands:

```
tofront 
"tofront" 
"ToFront"
```

all send different strings.

**Variable substitution.** Beware of using variables or keywords in a command string. If a variable has been assigned a value, that value will be substituted in the command string. A variable's value defaults to its name in uppercase, and most command names correspond to unassigned variables. To be safe, either enclose the command name in quotation marks or use the **DROP** instruction to restore a variable to its default state.

```
Listing 3: Skeleton for handling host environment errors 
/* 
 * Skeleton ARexx program for trapping host environment errors 
 */ 
signal on syntax /* Enable syntax error trapping */ 
/* Put ARexx program here... for example purposes 
   we'll use a bogus ADDRESS statement to trap a 
   host environment error */ 
address 'bogushost' 'a command' 
exit 0 
/* 
 * This is where syntax errors will be trapped. 
 */ 
syntax: 
  if( rc = 13 )then do 
      say "Host environment could not be found." 
  end 
  /* Other ARexx errors should be trapped here as well, or ignored. */ 
  exit 0
```

# Console Input/Output

This section describes the console input and output methods used by ARexx programs.

## **Definitions**

A *console* is a window which emulates a simple ASCII terminal, including display and movement of a cursor. Consoles use a special Amiga device, the console *device,* to perform this emulation. Consoles are used for line-oriented keyboard input and text output.

AmigaDOS makes extensive use of consoles. The Shell (CLI) window at which you type AmigaDOS commands is a console. The AmigaDOS CON: and NEWCON: devices open console windows for interactive input and/or output.

More detailed information on consoles can be found in *Amiga ROM Kernel Reference Manual: Devices* (the console device in general) and in *The AmigaDOS* Manual (the CON: and NEWCON: devices).

## **Consoles and ARexx**

ARexx programs are by nature console-oriented: the PULL instruction reads a string from a console; the SAY instruction writes a string to a console; and tracing information is displayed to a console. ARexx seems to have been designed for interactive usage.

Actually, ARexx is *stream-oriented:* input comes from a "standard input stream" and output goes to a "standard output stream". An input or output stream can be any valid AmigaDOS device; it's just that in most cases an ARexx program's standard input and output streams are attached to a console. The input and output streams can be easily redirected using the usual AmigaDOS redirection facilities:

rx >ram:ports "say show('l')"

The streams can also be redirected from within an ARexx program, as shown below. An ARexx program *inherits* (uses) the standard input and output streams of the program that started it, unless specifically redirected as shown above.

## **Standard ARexx Streams**

When an ARexx program is started, the standard input and output streams are assigned the logical names **STDIN** and **STDOUT,** respectively. The logical names are assigned as if they were files opened by calling the **OPEN()** function. The **STDIN** and **STDOUT** streams are used by the ECHO, PULL, PUSH, QUEUE and SAY instructions. Thus these two statements are in fact identical:

```
/* Equivalent statements! */ 
call writeln 'STDOUT', "Hello." 
say "Hello."
```

The streams can easily be redirected by calling **CLOSE()** and then **OPEN():** 

```
/* Redirect output to a new console window */ 
call close 'STDOUT' 
call open 'STDOUT', 'CON:160/50/320/100/MyConsole', 'W'
```

When redirecting, be sure to open the new stream with the correct mode.

## **Tracing Output**

Tracing output can also be redirected. If global tracing is not enabled, tracing output is by default directed to the **STDOUT** stream. If you wish to redirect the tracing output to a different stream without redirecting **STDOUT,** simply open a **STDERR** stream for writing. This is in fact how global tracing is implemented: when global tracing is enabled, ARexx opens a global tracing console, and each active ARexx program without a **STDERR** stream defined is assigned a **STDERR** stream attached to this console.

Tracing input shares the tracing output stream, so the tracing output stream should always be a console whenever interactive tracing is enabled.

## **PART 2**

## The ARexx Interface

# The ARexx System Library

This chapter explains how to use the ARexx system library, information you'll need in the chapters that follow. On the first reading you should concentrate on the interface details — how to invoke the functions in the system library. Examples in later chapters will clarify the use of the data structures that are described below.

## **Description**

The ARexx system library is a shared library of routines used by the ARexx interpreter to convert between data types, perform AmigaDOS input/output, manage resources and manipulate strings. This library, found in the **LIBS:** directory as the file **rexxsyslib.library,**  can be used by your own programs as well. In particular, the system library can be used to prepare and to decode ARexx messages, as will be demonstrated in the chapters that follow.

You don't *have* to use the ARexx system library when writing a program that interfaces with ARexx, but using it gives you the benefits of a shared library and ensures that your interface is correct.

## **Accessing the Library**

Like any shared library, the ARexx system library must be accessed using a call to the Exec **OpenLibrary()** function. This call loads the library into memory (if necessary only one copy is kept in memory, even if several programs access the library) and returns a pointer to its location. This pointer is then used to call the functions in the shared library. This indirect method allows the library to be loaded on demand only, and wherever space is available.

Listing 4 demonstrates the opening of the ARexx system library. If the library cannot be opened **(OpenLibrary()** returns NULL), no ARexx communication should be attempted.

Listing 4: Accessing the System Library

```
#include "arexx.h" 
struct Library *RexxSysLib = NULL; 
/* Open the library. Always check for NULL after the call! */ 
RexxSysLib = OpenLibrary( "rexxsyslib.library", 0 ); 
/* Close the library. Do this only when done accessing 
   the functions in the library. */ 
if( RexxSysLib ) 
    CloseLibrary( RexxSysLib );
```

In the listing, the pointer returned by **OpenLibrary()** is stored in a global variable **RexxSys-Base.** The name is important because of its use by the **#pragma** statements described below. Storing it as a global, however, presents problems when trying to create reentrant programs (programs that share the same code and data spaces), so Chapter 8 demonstrates an alternate method for storing the library pointer.

#### **struct RxsLib vs. struct Library**

When you open the ARexx system library, the pointer returned by **OpenLibrary()**  is actually a pointer to an **RxsLib** structure instead of a **Library** structure. The **RxsLib** structure is an extension of the **Library** structure and is defined in the header file **rexx/rxslib.h.** None of the examples in this book access the data in the structure (which is private) so for simplicity **RexxSysBase** is treated as a pointer to **a Library** structure.

When your program is finished with the library, it should notify Exec by calling the **CloseLibrary()** function.

## **Calling Library Functions**

#### **Header Files**

The data structures and constants used by the ARexx resident process and the ARexx interpreter can be found in four header files. These header files are provided by Commodore or your compiler vendor and should be installed in the **rexx** subdirectory of your main header file directory:

- **errors.h** Constants for the various error messages described in Appendix B.
- **rexxio.h** Data structures and constants for ARexx input/output.
- **rxslib.h** The structure of the ARexx system library.
- **storage.h** Data structures for communicating with ARexx programs and the resident process.

The actual header files are listed in **Appendix C** for reference purposes.

Of the four header files, only **storage.h** is of interest to most programmers. Two of its important data structures are described below and will be used in examples in later chapters.

#### **Stubs and Pragmas**

Shared libraries were designed for direct assembly language access, not for access as C functions. Before calling the ARexx system library, then, your C program must create a compatible environment. There are two ways of doing so.

The first way is to create a set of special *stub functions,* in C or assembly language, that are then linked to the program executable. The stub functions ensure that function parameters are stored in the correct assembly language registers and then execute the shared library function by using the library pointer to jump to the correct location within the library. When done executing the shared library function, a stub function restores the C program's environment and allows execution to continue as before.

The second method, used throughout this book, is to use special **#pragma** statements' to tell the C compiler how to call a given shared library function. These **#pragma** statements are unfortunately non-portable and may have to be customized for each compiler. Listing 5, on page 90, presents pragmas for Manx C and SAS/C in the form of the **arexxsyslib.h** 

#### **Pragmas and the Library Pointer**

The **#pragma** statements used in both the Manx and SAS compilers explicitly reference a global variable, **RexxSysBase** , which is assumed to hold the library pointer for the system library. If you use a different variable, be sure to alter the **#pragma**  statements in Listing 5 appropriately.

Once pragmas and function prototypes have been declared, and the library has been opened, the functions can be called like any other C function.

## Data Structures

<sup>1</sup>A *pragma is* a way of passing information to the C compiler by using special preprocessor commands that start with #pragma.

### Argument Strings: RexxArg

The fundamental data type in ARexx is the string. As you can imagine, a great deal of effort has been devoted to making string operations as efficient as possible. All ARexx strings are stored in a special **RexxArg** structure, defined in rexx/storage.h:

```
struct RexxArg 
 { 
  LONG ra_Size; /* total allocated length */ 
  UWORD ra_Length; /* length of string */ 
  UBYTE ra_Flags; /* attribute flags */ 
  UBYTE ra_Hash; /* hash code */ 
  BYTE ra_Buff[8]; /* buffer area */ 
 };
```

This structure is actually a variable-length structure. For strings longer than 8 characters (including the terminating null byte), the size of the **ra\_Buff** character buffer is increased. The **ra\_Size** field always holds the actual length (in bytes) of the complete structure.

Your application should not allocate a **RexxArg** structure directly, but rather call the **CreateArgstring()** function described below. This is because the **ra\_Flags** and **ra\_Hash ARexx** fields of the structure must be set to special values for proper handling by the

The return value from **CreateArgstring()** will be a pointer to the buffer area **ra\_Buff** of the **RexxArg** structure instead of the start of the structure that was allocated. This pointer is known as an *argstring.* Since strings are stored in the **RexxArg** structure as C-style nullterminated character arrays, you can simply treat the argstring as a normal C string pointer. Note that the **LengthArgstring()** and **DeleteArgstring()** functions expect to be passed an argstring parameter — they will access the other fields in the **RexxArg** structure by using negative offsets from the argstring.

Remember to release argstrings with **DeleteArgstring()** when they're no longer needed.

## **ARexx Messages: RexxMsg**

Messages are used to pass data between the resident process, ARexx programs and your own applications. All messages are described by the **RexxMsg** structure, an extension of the Exec Message structure, also defined in **rexx/storage.h**:

```
struct RexxMsg 
 { 
  struct Message rm_Node; /* EXEC message structure */ 
  APTR rm_TaskBlock; /* global structure (private) */ 
  APTR rm_LibBase; /* library base (private) */ 
  LONG rm_Action; /* command (action) code */ 
  LONG rm_result1; /* primary result (return code) */ 
  LONG rm_Result2; /* secondary result */ 
  STRPTR rm_Args[16]; /* argument block (ARG0-ARG15) */
```

```
/* Extension fields (not modified by ARexx) */ 
struct MsgPort *rm_PassPort; /* forwarding port */ 
STRPTR rm_CommAddr; /* host address (port name) */ 
STRPTR rm_FileExt; /* file extension */ 
LONG rm_Stdin; /* input stream (filehandle) */ 
LONG rm_Stdout; /* output stream (filehandle) */ 
LONG rm_avail; /* future expansion */ 
};
```

Like **RexxArg,** the **RexxMsg** is a complex structure that should only be allocated by the **CreateRexxMsg** function and released by the **DeleteRexxMsg** function. The first three fields are private and will be set by **CreateRexxMsg** to the appropriate values. The use of the remaining fields will be discussed in the following chapters, but here are brief summaries:

- **rm\_Action** Specifies whether the message is to be interpreted as a *command* or as a *function call,* along with several modifier flags. Other interpretations are available when sending messages to the resident process, including adding items to the Clip List and manipulating function libraries and hosts.
- **rm\_Result1** Corresponds to the **RC** variable, holds the return code (an integer) from a function call or command invocation. If zero, the next field is assumed to hold an argstring.
- **rm\_Result2** Corresponds to the **RESULT** variable, holds the result string (if any) of a function call or command invocation. If there is no result, it will be set to zero, otherwise it will point to an argstring if the primary return code is zero.
- **rm\_Args** Specifies the command/function name and arguments, stored as an array of argstring pointers. For functions, the first slot (referred to as **ARGO),** holds the function name and the remaining fifteen slots the arguments. For commands, only the first slot is used —- it holds the complete command string, of which the first word is assumed to be the command name (the interpretation, however, if left to the program that receives the command).

The following fields are *extension fields,* used when asking the resident process to start an ARexx program. They override system defaults. ARexx itself will never modify these fields:

- **rm\_PassPort** Specifies a message port (by *address,* not by name) to which the message can be forwarded if the search by the resident process for a command or function fails.
- **rm\_CommAddr** Sets the initial host address of the program. This will usually be the name of the sender's own ARexx port.
- **rm\_FileExt** Sets the default file extension to use when search for ARexx programs. If not specified, it defaults to **"rexx".**
- **rm\_Stdin** Sets the input stream for the program, and must be a valid AmigaDOS file handle. If not specified, the program will inherit the sender's input stream, if any.

**rm\_Stdout** Sets the output stream for the program, and must be a valid AmigaDOS file

handle. If not specified, the program will inherit the sender's output stream,

if any.

**rm\_avail** Reserved for future expansion.

**— Argument Slot Names** 

The arguments in the **rm\_Args** slot are often referred to by the names **ARG0 (rm\_Args[0]), ARG1 (rm\_Args[1]),** and so on.

## **ARexx System Library Functions**

The ARexx system library is composed of over fifty functions, of which only eight are useful to the average programmer, the rest being intended for use by the resident process and the ARexx interpreter. This section describes those eight functions, for which prototypes and pragma declarations can be found on page 90. These functions will be used in later chapters.

**A note for assembly language programmers:** the library offsets and register conventions you'll need to interface to these functions can be obtained from the pragmas for the Aztec C compiler in the **arexxsyslib.h** header file. All values are returned in the **D0**  register.

## **ClearRexxMsg**

**void ClearRexxMsg( struct RexxMsg** \*msg, **ULONG** *numargs )* 

#### **Summary**

Releases one or more argstrings from the **rm\_Args** field of a **RexxMsg** structure. Each argstring will be cleared using the **DeleteArgstring()** function and replaced with a null pointer. No action is taken if the argument slot already holds a null pointer. Set *numargs*  to the number of argstrings to clear — a value of 16 will clear all slots.

This function is usually called to free the contents of a message that were set using **Fill-RexxMsg().** 

**See Also: FillRexxMsg()** 

## **CreateArgstring**

**char \*CreateArgstring( char** *\*str,* **ULONG** *length )* 

Allocates a **RexxArg** structure and copies the string *str* into it.

**CreateArgstring()** returns an *argstring,* a pointer to the string buffer in the **RexxArg**  structure that is allocated. The argstring can be treated like a normal C string pointer and is the pointer passed to the **DeleteArgstring()** and **LengthArgstring()** functions.

**See Also: DeleteArgstring(), LengthArgstring()** 

## **CreateRexxMsg**

```
struct RexxMsg *CreateRexxMsg( struct MsgPort *replyport, 
           char *extension, char *hostaddress )
```

#### **Summary**

Allocates a **RexxMsg** for use in communicating with the resident process, ARexx programs and other host applications. The *replyport* argument must point to a valid Exec message port, which will be used by a receiving process to return the message to the sender. The default file extension can be overridden by supplying a non-null *extension,* and the default host address overridden by supplying a non-null *hostaddress.* Other fields in the **RexxMsg**  structure, including the argument strings, may be set as required once the structure has been allocated.

**See Also: DeleteRexxMsg(), FillRexxMsg(), IsRexxMsg()** 

## **DeleteArgst ring**

```
void DeleteArgstring( char *argstr )
```

#### **Summary**

Releases a **RexxArg** structure previously allocated by the **CreateArgstring** function.

**Note:** argstr must point to an argstring, not to the beginning of a **RexxArg** structure.

**See Also: CreateArgstring(), LengthArgstring()** 

## **DeleteRexxMsg**

**void DeleteRexxMsg( struct RexxMsg** *\*msg )* 

Releases a **RexxMsg** structure previously allocated by the **CreateRexxMsg** function. Any argument strings in the message must be released before calling this function.

**See Also: ClearRexxMsg(), CreateRexxMsg(), IsRexxMsg()** 

## **FillRexxMsg**

**long FillRexxMsg( struct RexxMsg** *\*msg,* **ULONG** *numargs,* **ULONG** *mask )* 

#### **Summary**

Converts and installs up to 16 argument strings into a previously-allocated **RexxMsg** structure. The *numargs* argument specifies how many of the argument slots — starting with the **rm\_Args [0]** field — are to be converted. Each slot to be converted should hold an integer value or a pointer to a character string. Bits 0-15 of the *mask* argument specify whether the corresponding argument is a string pointer or an integer value — if cleared, it is a string, if set, an integer. **FillRexxMsg()** will then convert each of the specified arguments into argstrings and store the pointers in the **RexxMsg** structure. These argstrings must later be released by calling **ClearRexxMsg()** or **DeleteArgstring()** .

**FillRexxMsg()** returns -1 if all the arguments were successfully converted and installed. Otherwise 0 is returned and no argstrings are allocated.

**See Also: ClearRexxMsg(), CreateRexxMsg()** 

## **IsRexxMsg**

**long IsRexxMsg( struct RexxMsg** *\*msg )* 

#### **Summary**

Tests whether the message *msg* came from an ARexx pointer. ARexx marks its messages with a pointer to the static string **"REXX"** in the **rm\_Node.ln\_Name** field. The function returns -1 if the message came from ARexx, 0 otherwise.

**See Also: CreateRexxMsg(), DeleteRexxMsg()** 

## **LengthArgstring**

**ULONG LengthArgstring( char** *\*argstr )* 

Returns the length of the argstring *argstr.* Note that argstr must point to the buffer of a **RexxArg** structure, as returned by **CreateArgstring().** 

**See Also: CreateArgstring(), DeleteArgstring()** 

```
Listing 5: Pragmas for the System Library 
/* 
       * arexxsyslib.h -- Header file to use when accessing the public 
              * functions in the ARexx system library (rexxsyslib). 
#ifndef AREXXSYSLIB_H_INCLUDED 
#define AREXXSYSLIB_H_INCLUDED 
#ifndef EXEC_TYPES_H 
#include <exec/types.h> 
#include <exec/nodes.h> 
#include <exec/lists.h> 
#include <exec/ports.h> 
#include <exec/memory.h> 
#endif 
#ifndef REXX_STORAGE_H 
#include <rexx/storage.h> 
#include <rexx/rxslib.h> 
#include <rexx/errors.h> 
#endif 
/* 
 * When you open the rexxsyslib library, store the library pointer in 
 * this variable. If you use another variable, be sure to change the 
 * pragma statements below. Don't forget to actually define the variable 
 * in one of your source files... 
 */ 
extern struct Library *RexxSysBase; 
/* 
 * Prototypes for the public functions. 
 * These differ from the official Commodore prototypes on the Includes and 
 * Autodocs distribution disks. People using V36 and later versions of the 
 * OS should consider using #include "clib/rexxsyslib_protos.h" instead of 
 * these protos but example code will have to be adjusted for this to work. 
 */ 
extern char *CreateArgstring( char *str, ULONG length ); 
extern void DeleteArgstring( char *argstr ); 
extern ULONG LengthArgstring( char *argstr ); 
extern struct RexxMsg *CreateRexxMsg( struct MsgPort *replyport, 
                                     char *extension, char *hostaddress ); 
extern void DeleteRexxMsg( struct RexxMsg *msg ); 
extern void ClearRexxMsg( struct RexxMsg *msg, ULONG numargs ); 
extern long FillRexxMsg( struct RexxMsg *msg, ULONG numargs, 
                                   ULONG mask ); 
extern long IsRexxMsg( struct RexxMsg *msg );
```

```
/* 
 * This section defines the pragmas required to access the functions 
 * in the shared library. Note that Manx and SAS use different syntax. 
 * 
 * Pragmas should be generated from Commodore's FD files found on the 
 * Includes and Autodocs distributions disks. The pragma syntax differs 
 * depending on which compiler is used. 
 */ 
#if defined( AZTEC_C ) 
    #pragma amicall( RexxSysBase, 0x9c, ClearRexxMsg(a0,d0) ) 
    #pragma amicall( RexxSysBase, 0x7e, CreateArgstring(a0,d0) ) 
    #pragma amicall( RexxSysBase, 0x90, CreateRexxMsg(a0,a1,d0) ) 
    #pragma amicall( RexxSysBase, 0x84, DeleteArgstring(a0) ) 
    #pragma amicall( RexxSysBase, 0x96, DeleteRexxMsg(a0) ) 
    #pragma amicall( RexxSysBase, 0xa2, FillRexxMsg(a0,d0,d1) ) 
    #pragma amicall( RexxSysBase, 0xa8, IsRexxMsg(a0) ) 
    #pragma amicall( RexxSysBase, 0x8a, LengthArgstring(a0) ) 
#elif defined( LATTICE ) 
    #pragma libcall RexxSysBase ClearRexxMsg 9c 0802 
    #pragma libcall RexxSysBase CreateArgstring 7e 0802 
    #pragma libcall RexxSysBase CreateRexxMsg 90 09803 
    #pragma libcall RexxSysBase DeleteArgstring 84 801 
    #pragma libcall RexxSysBase DeleteRexxMsg 96 801 
    #pragma libcall RexxSysBase FillRexxMsg a2 10803 
    #pragma libcall RexxSysBase IsRexxMsg a8 801 
    #pragma libcall RexxSysBase LengthArgstring 8a 801 
#endif 
#endif /* AREXXSYSLIB_H_INCLUDED */
```

# The Basic ARexx Port

At this point you're ready to add an ARexx interface to your own programs. This chapter shows you how to create and use a *passive* ARexx port, the most basic interface, while the next chapter shows you how to communicate with the ARexx resident process.

## **Naming and Creating a Port**

An ARexx port is a named Exec message port, created with the **CreatePort()** function:

```
struct MsgPort *port; 
port = CreatePort( "My_Port", 0 );
```

The first parameter to **CreatePort()** is the name of the port, and the second parameter is its priority in the list of public ports. The port must be named so that other processes can find it. Note that **CreatePort()** does not allocate storage for the name, so be careful when using statically-allocated buffers:

```
/* Don't do this! */ 
static char name[80]; 
strcpy( name, "portname" ); 
port = CreatePort( name, 0 ); 
/* And then, later on... */ 
strcpy( name, "other data" ); /* changes name! */
```

The priority field determines the priority at which the port will be added to the public port list. When searching for public ports using the FindPort() function, higher priority ports are always found first. In most cases you should set the priority to zero.

Perhaps the hardest decision to make when creating an ARexx port is what name to give it. You must choose a name that is unique and that identifies its purpose or owner. The simplest scheme is to use the application name, stripped of spaces and transformed to uppercase (this is to make life simpler for the user — see Chapter 4). If several copies of an application can be run simultaneously, each program should open its own ARexx port. Names are resolved in this case by adding a number to the end of the application name — two copies of the "MyEditor" program would open ARexx ports named "MyEditor.01" and "MyEditor.02".

ARexx ports can also be used to ensure that only one copy of an application is running, by calling **FindPort()** when the application starts execution. The example function **Register-Port()** in Listing 6 can be used for this purpose. **RegisterPort()** uses the Exec **Forbid() Permit()** functions to ensure that no other process creates a port of the same name and between the calls to **FindPort()** and **CreatePort()** .

As always, be sure to call **DeletePort()** to remove any ARexx ports your program allocates.

```
Listing 6: Registering a unique ARexx port 
/* 
 * RegisterPort -- Like CreatePort, but will not 
                    register a port if the name is already 
                    in use. Returns NULL or a pointer to the port. 
 */ 
struct MsgPort *RegisterPort( UBYTE *name, LONG pri ) 
  { 
    struct MsgPort *port; 
    port = NULL; 
    Forbid(); 
    if( FindPort( name ) == NULL ) 
        port = CreatePort( name, pri ); 
    Permit(); 
    return( port ); 
  }
```

## **Using an ARexx Port**

Once an ARexx port has been created, you can use it to create your ARexx interface. Whether you're sending or receiving messages, the steps to follow are very precise and outlined below.

#### -- Send-Receive-Reply

All normal ARexx messaging follows the *send-receive-reply* model, in which the receiver of a message is expected to return the message to the sender. Resources allocated by the sender are in general released by the sender (exceptions will be noted).

#### **Receiving ARexx Messages**

- 1. Wait for a message to arrive at the program's ARexx port using **Wait()** or **Wait-Port 0.**
- 2. Retrieve the **RexxMsg** structure using **GetMsg().**
- 3. If the **rm\_Node.mn\_Node.ln Type** field is set to **NT\_REPLYMSG,** the message is a reply to a message that was sent previously. (This is true only for active ports.) Process as described in the section below on sending messages.
- 4. Otherwise a command or function call must be processed, as specified in the **rm\_Action**  field of the structure with the arguments in the **rm\_Args** fields.
- 5. When finished processing, store any requested results in the structure and send it back using **ReplyMsg().**

## **Sending ARexx Messages**

- 1. Allocate a **RexxMsg** structure with a call to the system library function **CreateRexxMsg().**
- 2. Set the **rm\_Act ion** field of the structure to the appropriate action code and modifier flags.
- 3. Create any needed argstrings and set the **rm\_Args** array to point to the argstrings.
- 4. Locate the destination port using **FindPort 0** and send the message using **PutMsg().**
- 5. Wait for the reply message. Release any argstrings that were allocated. Release the **RexxMsg** structure.

## **The Passive Interface**

A host application's ARexx interface can be one of two types:

- *• passive* the application processes messages that are sent to it, but does not send any of its own
- *• active* the application not only receives messages, it also sends messages

A passive interface receives messages from ARexx programs and perhaps other applications; an active interface also sends messages to the resident process and perhaps other applications.

All interfacing is done using ARexx ports and the RexxMsg structure discussed in the previous chapter. One ARexx port can be used for both sending and receiving messages the distinction between passive and active ports lies in how they are used, not how they are created. For now we'll restrict ourselves to the passive interface.

## What to Expect

Once your port has been created, you can use it to receive and process commands from ARexx programs. Say your application's ARexx port is named "PASSIVE" and you then start an ARexx program that executes the following statements:

```
address passive 
"yo!"
```

When the ARexx interpreter encounters the second statement, it does the following:

- Evaluates the expression to form a string.
- Allocates a RexxMsg structure, setting the rm\_Action field to RXCOMM (a flag defined in rexx/storage.h) and storing a pointer to the string in the ARG0 field.
- Sends the RexxMsg structure to the current host address, in this case the "PASSIVE" port. If the port doesn't exist an error occurs.
- Waits for the message reply the ARexx program's execution is suspended until the reply arrives.
- After retrieving the reply message, the interpreter sets the RC variable and optionally the RESULT variable and then continues execution of the ARexx program.

As you can see, it's important for you to process command messages from an ARexx program as quickly as possible in order to let the program continue.

#### — Private Data

When an ARexx program sends a command message, most of the fields in the RexxMsg structure are either private or undefined. It's important that you not modify any of these fields, or free the argstring in ARG0. The only fields you can freely modify are rm\_Result1 and rm\_Result2, for sending results (discussed below) back to the ARexx program.

Note that other host applications can also send commands to your ARexx port. If they're careful to follow the same steps as the ARexx interpreter -- and your program only looks at the rm\_Action and ARG0 fields of a message -- their messages will be indistinguishable from an ARexx program's.

## Command Interpretation

The concept of a "command" in ARexx is really a very fuzzy thing. The interpreter evaluates an expression and then passes the resulting string to the current host application: "Here, you deal with it." It's up to the host to interpret the string, perform whatever actions are appropriate, and then return a result.

Since an application host has total control over the command requests it receives, you can be creative in deciding what commands to support. The typical command format is a command word followed by one or more arguments:

```
"open main. c"
```

Be prepared to handle uppercase and lowercase command names; what you do with the arguments is up to you.

Suggestions for basic commands every host application should support can be found in Chapter 10 and in the Amiga *User Interface Style Guide.* 

### Sending Results

Once you've processed a command you must set a return code before replying to the command message. The return code is an integer value (not a string) which you store in the rm\_Result1 field of the RexxMsg structure. The return code will be converted into a string and assigned to the RC variable when the reply message is received by the ARexx interpreter. The return code should be zero if the command executed without error, otherwise it should be a positive *error severity level.* The most common return codes are defined in rexx/errors.h:

```
#define RC_OK 0 /* success */ 
#define RC_WARN 5 /* warning only */ 
#define RC_ERROR 10 /* error */ 
#define RC_FATAL 20 /* severe error */
```

The OPTIONS FAILAT statement can be used within an ARexx program to trap — or ignore — non-zero command return codes.'

In many cases a simple return code is not sufficient. You can return a result string by converting it into an argstring and storing the pointer to the argstring in the rm\_Result2 field. There are two important caveats, however:

- 1. The command sender must have *requested* a result string. If this is true, the RXFF\_RESULT flag in the rm\_Action field will be set. (An ARexx program will set this flag if the OPTIONS RESULTS statement has been encountered.)
- 2. The return code in rm\_Result1 must be zero.

In all other cases you should set the rm\_Result2 field to NULL.

If you do reply with a result string, the ARexx interpreter will store that string in the RESULT variable. *The sender of* a *command is responsible for freeing any result string it receives in reply.* 

<sup>1</sup>Some applications return error codes that aren't really error codes, but result values. This behaviour is discouraged.

Here are some code fragments that outline the steps involved in receiving and processing ARexx commands:

1. When a message arrives, retrieve it from the ARexx port.

```
msg = (struct RexxMsg *) GetMsg( port );
```

2. Make sure it's a command message by checking for the **RXCOMM** action code.(A bitwise AND with the **RXCODEMASK** value masks out any modifier flags.)

```
if( ( msg->rm_Action & RXCODEMASK ) == RXCOMM ) 
    /* process the command message */
```

3. Interpret and process the command string stored in ARG0.

```
ProcessCommand( (char *) msg->rm_Args[0] );
```

4. Set the return code.

```
msg->rm_Result1 = (LONG) RC_OK;
```

5. If a result string was requested and the return code is zero, set the result string. (Set it to NULL if no result string is available.)

```
if( ( msg->rm_Action & RXFF_RESULT ) != 0 && 
   msg->rm_Result1 == RC_OK ) 
   msg->rm_Result2 = (LONG) CreateArgstring(...);
```

6. Reply to the message.

```
ReplyMsg( (struct Message *) msg );
```

That's all there is to it!

## **A Simple Passive Host**

Listing 7 presents a simple application which opens a passive ARexx port and displays any command messages it receives. The program can be stopped by sending it a break signal (either by pressing control-c or by using the AmigaDOS **break** command). You can use the ARexx program in Listing 8 to send the program command strings.

The example presented here shows you how to build an ARexx interface from scratch. The examples in subsequent chapters will be using the SimpleRexx routines (described in Chapter 9) to streamline the interface.

```
/* 
 * passive.c -- Demonstrates the "passive" ARexx port. This program 
                is NOT reentrant and expects to be started from a CLI. 
 * 
 * This is a very simple example, but it shows the basics of setting 
 * up an ARexx port: 
 * 
   * -- Setting up 
   * -- Waiting for messages to arrive 
   * -- Interpreting the commands 
   * -- Setting result values and replying 
   * -- Cleaning up 
 * 
 */ 
#include "arexx.h" 
#include "arexxsyslib.h" 
#define DEFAULT_NAME "PASSIVE" 
#define REPLY_STR "Passive says hello." 
#define REPLY_LEN 19 
/* 
 * Globals for the library base and our port 
 */ 
struct Library *RexxSysBase = NULL; 
struct MsgPort *ARexxPort = NULL; 
/* 
 * Forward references 
 */ 
struct MsgPort *RegisterPort( UBYTE *name, LONG pri ); 
static void Usage( void ); 
static void Quit( char *str ); 
static void Process( void ); 
static void ShowRexxMsg( struct RexxMsg *msg ); 
/* 
 * Main -- Open the system support library, setup our ARexx port 
           and then loop to process messages. 
 */ 
int main( int argc, char *argv[] ) 
    char *name; 
    /* Get the port name to use */ 
    name = DEFAULT_NAME;
```

```
if( argc == 2 ) 
        name = argv[1]; 
    else if( argc != 1 ) 
        Usage(); 
    puts( "Passive starting..." ); 
                /* Open the system library, abort if we can't. */ 
    RexxSysBase = OpenLibrary( (UBYTE *) "rexxsyslib.library", 0L ); 
    if( !RexxSysBase ) 
        Quit( "Could not open ARexx system library (rexxsyslib.library)." ); 
    /* Create a port. */ 
    ARexxPort = RegisterPort( (UBYTE *) name, 0 ); 
    if( !ARexxPort ) 
        Quit( "Could not open port." ); 
    /* Process messages. */ 
    Process(); 
    /* Cleanup and exit. */ 
    Quit( "Passive exiting." ); 
  } 
/* 
 * Process -- Wait on the ARexx port for messages to arrive, print 
              their contents and reply with no error. Also aborts 
              if a break is sent. 
 */ 
static void Process( void ) 
  { 
    ULONG port_mask, signals; 
    struct RexxMsg *msg; 
    port_mask = ( 1L << ARexxPort->mp_SigBit ); 
    while( 1 ){ 
        /* Here we wait for a message to arrive or for the user to 
           send a break. If your application has one or more Intuition 
           windows open, this is where you would wait for Intuition 
           messages as well. You check the return value from Wait() 
           to see which ports have messages waiting. */ 
        signals = Wait( port_mask | SIGBREAKF_CTRL_C );
```

```
/* Quit if user hits CTRL-C or sends an AmigaDOS BREAK */ 
        if( signals & SIGBREAKF_CTRL_C ) 
            Quit( "Passive aborting --- break detected." ); 
        /* Otherwise check for messages and reply... */ 
        if( signals & port_mask ){ 
            while( ( msg = (struct RexxMsg *) GetMsg( ARexxPort ) ) != NULL ){ 
                ShowRexxMsg( msg ); 
                ReplyMsg( (struct Message *) msg ); 
            } 
        } 
/* 
 * ShowRexxMsg -- Print out the contents of the RexxMsg structure 
                  we've received, then set the result fields. 
 */ 
static void ShowRexxMsg( struct RexxMsg *msg ) 
  { 
    ULONG action_code; 
    /* Get the action code using the mask defined in rexx/storage.h */ 
    action_code = msg->rm_Action & RXCODEMASK; 
    /* It should be RXCOMM -- if it isn't, ignore the message */ 
    if( action_code == RXCOMM ){ 
        printf( "RXCOMM: '%s'\n", msg->rm_Args[0] ); 
        msg->rm_Result1 = RC_OK; /* defined in rexx/errors.h */ 
        if( msg->rm_Action & RXFF_RESULT 
            puts( " [a result string was requested]" ); 
            /* Don't forget to allocate space for the null byte! */ 
            msg->rm_Result2 = (LONG) CreateArgstring( REPLY_STR, REPLY_LEN ); 
        } } } 
* RegisterPort -- Like CreatePort, but will not 
                   register a port if the name is already 
                   in use. Returns NULL or a pointer to the port. 
*/ 
struct MsgPort *RegisterPort( UBYTE *name, LONG pri ) 
  { 
    struct MsgPort *port;
```

```
port = NULL; 
    Forbid(); 
    if( FindPort( name ) == NULL ) 
        port = CreatePort( name, pri ); 
    Permit(); 
    return( port ); 
  } 
/* 
 * Usage -- Print out usage info. 
 */ 
static void Usage( void ) 
  { 
    puts( "Usage: passive [name]" ); 
    puts( "\n Starts a passive ARexx port to which messages can be sent" ); 
    puts( " from within an ARexx program. If the port name isn't given" ); 
    puts( " it defaults to 'PASSIVE'." ); 
    exit( 0 ); 
  } 
/* 
 * Quit -- Clean things up before quitting. Prints optional string. 
 */ 
static void Quit( char *str ) 
  { 
    struct RexxMsg *msg; 
    if( str ) 
        puts( str ); 
    if( ARexxPort ){ 
        Forbid(); 
        /* Get rid of any waiting messages then delete the port */ 
        while( ( msg = (struct RexxMsg *) GetMsg( ARexxPort ) ) != NULL ){ 
                            msg->rm_Result1 = RC_FATAL; 
            msg->rm_Result2 = NULL; 
            ReplyMsg( (struct Message *) msg ); 
        } 
        DeletePort( ARexxPort ); 
        Permit(); }
```

```
if( RexxSysBase ) 
      CloseLibrary( RexxSysBase ); 
  exit( 0 ); /* should really be non-zero if error occurs */ 
}
```

Listing 8: Sending commands to the passive port

```
/* 
 * sendcommand.rexx -- Get commands from the user and send them 
                        to PASSIVE. 
 */ 
port_name = "PASSIVE" 
if( arg() >= 1 )then 
    port_name = arg(1) 
if( "show( 'p', port_name ) )then do 
    say "Please start the host application first." 
    exit 
end 
address value port_name 
do forever 
    say "Please enter your command: ('quit' to exit)" 
    parse pull command 
    if( command = 'quit' )then 
        break 
    else if( command = 'results' )then 
        do 
            options results 
            say "Requesting results..." 
        end 
    else 
        do 
            command 
            say name "replied: RC =" rc || ", RESULT =" result 
        end 
end 
exit
```

# Advanced Port Handling

In the last chapter we discussed how to implement a passive ARexx interface. A more interesting interface is one that not only receives command messages, but sends messages to the resident process. This chapter tells you how to implement such an active interface. The example program found at the end of this chapter also demonstrates the use of the SimpleRexx ARexx interface routines discussed in Chapter 9.

## **Talking to the Resident Process**

Almost every host application will have reason to talk to the ARexx resident process, whether to start an ARexx macro program or to add entries to the Clip List. Only those programs with a "passive" ARexx port (a program that receives and replies to ARexx messages, but doesn't send any of its own) will not be communicating with the resident process.

The resident process has two ARexx ports ("REXX" and "AREXX") to which host applications can send their requests. Requests can be made to start an ARexx program, call an ARexx function, add or delete a function host or library, modify the Clip List, or change the global tracing console's status.

## Action Codes and Modifier Flags

Requests to the resident process are made by storing an *action code* in the **rm\_Action** field of the **RexxMsg** structure. The action codes can be modified by a series of *modifier flags.*  The bitwise OR operator is used to combine the action code with any modifier flags before the message is sent. All codes and flags are defined in rexx/storage.h.

Actions codes are described in the sections that follow. (We've already encountered the **RXCOMM** action code.) The modifier flags are:

**RXFF\_NOIO** Used with the **RXCOMM** and **RXFUNC** action codes, this flag suppresses inheritence of the host's input and output streams (as set in the **rm\_Stdin** and **rm\_Stdout** fields of the **RexxMsg** structure) by an ARexx program.

- **RXFF\_NONRET** Used with any action code except **RXCOMM** and **RXFUNC,** this flag tells the resident process not to reply to the message and return it to the sender. The resident process will release it instead. This mode of communication is unusual, as the sender has no way of knowing if a particular request succeeded.
- **RXFF\_RESULT** Used with the **RXCOMM** and **RXFUNC** action codes, this flag requests that the called program return a result string. If the program **EXITs** or **RETURNs** with an expression, the expression result is converted to an argstring and returned in the reply message's **rm\_Result2** field. *It is* the *caller's responsibility* to release *this argstring.*
- **RXFF\_STRING** Used with the **RXCOMM** and **RXFUNC** action codes, this flag requests that the the command or function name in slot **ARG0** be executed as a *string file* rather than being interpreted as a filename. A string file is an ARexx program stored as a string. This feature can be used to build ARexx programs in memory and have then executed without storing them on disk.
- **RXFF\_TOKEN** Used with the **RXCOMM** action code, this flag requests that the argstring in slot **ARG0** before being passed to an ARexx program; see below for details.

## **Programs and Functions**

An ARexx program can be invoked from a host application in two ways: as a command or as an external function call. The difference in the two methods lies mostly in how the arguments to the program, if any, are passed.

## **Starting ARexx Programs**

In the command mode of program invocation (action code RXCOMM), a single argstring is stored in **ARG0.** If the **RXFF\_TOKEN** and **RXFF.STRING** flags are not set, the resident process parses the string to extract the name of the ARexx program to start and passes the remainder of the string as the (only) argument to that program. For example, if **ARG0** is set to the string:

**showargs a b "c d" 'e f' "'g'" '"h"'** 

and the action code set **to RXCOMM,** then ARexx will search for and start **showargs.rexx**  are given below). The latter will then (see Listing 9 — rules for program search order display its argument strings:

**Argument 1: [a b "c d" 'e f' "'g'" '"h"']** 

As you can see, the remainder of the string was passed to **showargs**, unchanged, as the program's only argument. The name of the ARexx program to invoke is the first *token*  (a sequence of characters other than blanks, tabs or newlines) of the string. It must be unquoted, because quote characters around the first token imply that the **RXFF.STRING** flag is set and that the argstring is to be interpreted as a string file.

If you wish, the resident process can also parse the remainder of the **ARG0** string by setting the **RXFF\_TOKEN** flag. ARexx will then tokenize the complete string, using *white space* 

```
Listing 9: ShowArgs 
/* showargs -- print the args */ 
n = arg() 
do i = 1 to n 
    say "Argument" i || ": C" || arg(i) || "]" 
end
```

(blanks, tabs, newlines) to separate arguments to the program. Setting the **RXCOMM** action code and the **RXFF\_TOKEN** flag and passing ARexx the same string as before:

```
showargs a b "c d" 'e f' "'g'" '"h"'
```

will start showargs and display the following sequence:

**Argument 1: [a] Argument 2: [b] Argument 3: [c d] Argument 4: [e f] Argument 5: ['g '] Argument 6: ["h"]** 

Notice how quoting can be used to change argument tokenization. The items delimited by a set of single (') or double (") quotes are considered to be one argument, though the quotes are removed before the argument is passed to the program. Double quotes can be used within single quotes, and vice-versa. An implicit quote at the end of the string is assumed if the string ends in the middle of a quoted argument. There is no limit to the number of arguments passed to an ARexx program using the **RXFF\_TOKEN** flag.

A command can be executed as a string file by setting the **RXFF\_STRING** flag (in which case no parsing is done at all) or by starting the command with a quoted string. In this case the first token is assumed to be a series of one or more REXX clauses and the remaining tokens are its arguments. For example, sending the command:

```
"do i = 1 to arg(); say arg(i); end" "a string" also 
will print:
```

```
"a string" also
```

and sending the same string with the **RXFF\_TOKEN** flag set will print:

```
a string 
also
```

Whenever possible, use string files in place of temporary disk files.

Once the command string is in **ARG0** and the action code and desired modifier flags are set, the **RexxMsg** structure is sent to the resident process using the Exec **PutMsg()** function. It's always safest to first do a **FindPort()** before the **PutMsg()** (within a **Forbid()/Permit** () pair) to ensure that the resident process is still active. A function like the one in Listing 10 demonstrates the method.

Listing 10: Safely sending a message

```
#include "arexx.h" 
/* 
 * SafePutMsg -- Make sure that the port we want to send to 
                  exists before sending the message. Returns 
                  FALSE if the port was not found. 
 */ 
BOOL SafePutMsg( char *port_name, struct RexxMsg *msg ) 
  { 
    struct MsgPort *port; 
    Forbid(); 
    port = FindPort( (UBYTE *) port_name ); 
    if( port ) 
        PutMsg( port, (struct Message *) msg ); 
    Permit(); 
    return( port != NULL ) ; 
  }
```

Command messages can be sent to one of two message ports owned by the resident process. A command message received at the "REXX" port is returned only after the ARexx program it starts has exited. Upon exit, the ARexx program will set the return code and optionally the result string (if the **RXFF\_RESULT** modifier flag was set). If the resident process could not start the program, the message is returned immediately with an error code, unless the **rm\_PassPort** field is set (see below). A command message received at the " **AREXX**" port is returned immediately with no indication of success or failure — the ARexx program will be executed (if possible) but no message is sent (and hence no return code or result string) when it exits. Any program that is started by a message sent to the "AREXX" port will inherit the resident process' input and output streams, extension name and default port, not the ones set by the host application (unless the **RXFF\_NOIO** flag is set to disable stream inheritance).

Most command messages will be sent to the " **REXX**" port. Typical behavior for an application is to have only one outstanding command message at any given time. For example, a text editor may send a command message to invoke an ARexx macro program. The text editor will then wait for this macro to finish execution before starting a second macro program. The text editor isn't idle while it waits for the reply message — it should still respond to user input (though perhaps only offering limited functionality), and it should respond to command strings sent from the ARexx program itself. Running multiple ARexx program simultaneously is unusual and requires careful bookeeping on your part.

## **— Steps For Sending Commands**

#### To summarize:

- 1. Create a message with **CreateRexxMsg().** Set the reply port and any extension fields.
- 2. Transform the command string into an argstring with **CreateArgstring()**  and store it in **ARG0.**
- 3. Set the action code to **RXCOMM** and set any modifier flags.
- 4. Send the message to the "REXX" or "AREXX" port.
- 5. Wait for the reply message, interpret the results (see below). Free the command string (and any result string) and then free the message.

With the SimpleRexx interface (described in Chapter 9) these steps are accomplished using the **SendARexxMsg(), GetARexxMsg()** and **FreeARexxMsg()**  functions.

## **Calling ARexx Programs as Functions**

An ARexx program can also be invoked as an external function by using the **RXFUNC** action code. The function (program) name is stored as an argstring in **ARG0.** The arguments are not parsed from this string, but must be stored by the host application as argstrings in **ARG1, ARG2,** and so on. Because there are only sixteen elements in the **rm\_Args** array, a maximum of fifteen argument strings can be passed to an external program using an **RXFUNC** message.

Once the argument strings have been stored, the number of of arguments must also be stored in the **rm\_Action** field as the lowest four bits:

```
msg->rm_Action |= ( nargs & RXARGMASK );
```

**RXARGMASK** is a macro defined in **rexx/storage.h.** 

Modifier flags may also be set in the **rm\_Action** field. If **RXFF\_STRING** is set, the string in **ARG0** is assumed to be a string file, and the strings in **AR11 to ARG15** its arguments.

When all the fields have been filled in, the **RXFUNC** message is sent to the resident process as described above. Like command messages, **RXFUNC** messages can be sent to either the "REXX" or "AREXX" ports, however since functions are meant to return results (discussed below) it rarely makes sense to send such a message to the "AREXX" port.

## **— Steps For Calling External Functions**

#### To summarize:

- 1. Create a message with **CreateRexxMsg().** Set the reply port and any extension fields.
- 2. Transform the function name into an argstring with **CreateArgstring()** and store it in **ARG0.**
- 3. Set the action code to **RXFUNC** and set any modifier flags.
- 4. Transform any argument strings into argstrings and store them in **ARG1, ARG2,**  and so on up to at most **ARG15.**
- 5. Store the number of arguments in the lower four bits of the **rm\_Action** field. Be careful to use the **RXARGMASK** mask to preserve the action code and modifier flags.
- 6. Send the message to the "REXX" or "AREXX" port.
- 7. Wait for the reply message, interpret the results (see below). Free the command string (and any result string) and then free the message.

With the SimpleRexx interface (described in Chapter 9) these steps are accomplished using the **CallARexxFunc(), GetARexxMsg()** and **FreeARexxMsg()**  functions.

### **Getting Results**

When you start an ARexx program by sending **an RXCOMM or RXFUNC** message to the "**REXX**" port, you have the option of receiving a result string when that program finishes execution. This will happen only if you set the **RXFF\_RESULT** modifier flag in the action field of the message. In this case the result string will be the expression in the **EXIT** or **RETURN** 

If an ARexx program does return a result string, two things will be true: **rm\_Result1** will be zero, and **rm\_result2** will be non-NULL. The result string will be stored as an argstring in **rm\_Result2.** *You are responsible for freeing this argstring.* Result strings become the property of the host application.

If an error occurs then the return code in **rm\_Result1** will be non-zero. In this case the value in **rm\_Result2** is the integer error code, not an argstring. You will corrupt memory and perhaps crash your system if you blindly assume any non-zero value in **rm\_Result2** is an argstring.

Note that if you invoke an ARexx program *without* setting the **RXFF\_RESULT** modifier flag, ARexx will convert the EXIT or RETURN expression into an integer and use that as the return code for the program. in this case the **rm\_Result2** field will be zero.

#### Search Order and the rm\_PassPort Field

When the resident process receives a command or function invocation message, it follows a very specific search order to find the program file:

- The command or function name is separated into path, filename and extension components.
- If an explicit path (device and/or directory) is specified, only that directory is searched.
   Otherwise the current directory will be searched, followed by the system REXX: directory.
- For each directory in the search, first the filename with the current extension appended will be searched for, then the unmodified filename by itself. If an extension was supplied, then only that specific file will be searched for.

The search stops when the first file is found, or if no matching file is found. If a file is found, it must start with an ARexx comment to be executed as an ARexx program.

Some examples:

```
s:sargs searches for s:sargs.rexx, s:sargs
ced:fa.ced searches for ced:fa.ced
sargs searches for sargs.rexx, sargs, rexx:sargs.rexx, rexx:sargs
fa.ced searches for fa.ced, rexx:fa.ced
```

If a program could not be found and the rm\_PassPort field is NULL, the message is returned with an RC\_WARN return code and an integer error code of 1. If the rm\_PassPort field is non-NULL, it is assumed to be a pointer to a message port (not the name of a port) and the message is forwarded to that port instead. The process that owns that port can then perform other searches as necessary.

## Other Messages to the Resident Process

Host applications can also send messages other than RXCOMM and RXFUNC to the resident process. These other messages modify system resources. Note that the argument slots in the RexxMsg structure hold integer values in many cases, not pointers to argstrings.

## Modifying the Library List

To add a function host to the Library List, set the action code to RXADDFH, place a pointer to the null-terminated host name string in ARGO and store the search priority (an integer between -100 and 100) in ARG1. A new function host node will be added to the Library List, though no check is made to determine if the host port exists. If a library or host of the same name already exists in the Library List, the return code will be non-zero.

To add a function library to the Library List, set the action code to RXADDLIB, place a pointer to the null-terminated library name string in ARGO, store the search priority (an integer between -100 and 100) in ARG1, store the library entry point offset in ARG2, and store the library version number in ARG3. A new function library node will be added to the

Library List, though no check is made to determine if the library exists and can be opened. If a library or host of the same name already exists in the Library List, the return code will be non-zero.

To remove a function host or function library from the Library List, set the action code to **RXREMLIB** and place a pointer to a name string in **ARG0.** The Library List will be searched for a node matching the name. If found, the node is removed and released, unless currently in use by an ARexx program. If no match was found, the return code will be non-zero.

### **Modifying the Clip List**

To add an entry to the Clip List, set the action code to **RXADDCON,** store a pointer to the null-terminated name string in **ARG0,** store a pointer to the value string in **ARG1,** and store the length of the value string in **ARG2** (the length is required because the value string may hold one or more null bytes). The name will be added to the Clip List if not already there, and its value set to the new value string (a copy will be made).

To remove an entry from the Clip List, set the action code to **RXREMCON** and store a pointer to the null-terminated name string in **ARG0.** If the name could not be found in the Clip List, the return code will be non-zero.

### **Modifying the Global Tracing Console**

To open the global tracing console, set the action code to **RXTCOPN.** Once the console is open, all active ARexx programs will divert their tracing output (and any tracing input) to the global console. Only one console can be open at any given time; in subsequent requests the return code will be non-zero.

To close the global tracing console, set the action code to **RXTCCLS.** The console window will closed immediately unless one or more ARexx programs are waiting for input from the console, in which case the window will be closed as soon as the active programs are no longer using it.

## **Host-to-Host Communication**

An ARexx interface can also send commands directly to other host applications instead of the resident process. Messages that are sent this way should look like command messages sent from an ARexx program, as described in Chapter 7:

- The action code is set to **RXCOMM.**
- The **RXFF\_RESULT** modifier flag is set if a result string is expected.
- The command string is stored in **ARG0.**

When the destination host receives the message, it will process it as a normal ARexx command and set the return code (and result string) before replying to the message.

## **The REXX Variables Interface**

The REXX Variables Interface (RVI) is a set of functions written by Bill Hawes, ARexx's creator, to allow a host application to manipulate an ARexx program's symbol table. The functions allow an application to retrieve the values of existing variables, to change symbol values, and to create new symbols. The variables interface is a convenient way to pass complex information to an ARexx program.

RVI functions can only be used when a host application has received a command (RXCOMM) message from a running ARexx program. 1While the ARexx program waits for a reply, its symbol table is in a stable state. All RVI calls for a given ARexx program must be complete before the reply message is sent.

For RVI, it's important to distinguish command messages that are sent from an ARexx program and command messages that are sent from an application. The RVI facility only works on commands from ARexx programs. The ARexx interpreter sets certain private data fields in the RexxMsg structure, which the RVI routines then use to manipulate the ARexx program's symbol table. The interface includes a routine for ensuring that a given message was sent from an ARexx program.

#### Using RVI

RVI is typically used whenever two or more result strings are needed. An ARexx program issues a command to an application and passes the names of one or more ARexx symbols, or perhaps the stem of a compound symbol. The application uses RVI to store the results of the command request in those symbols, which the ARexx program then checks as soon as it receives the command reply. Examples on how to use and specify variables from a command environment can be found in Chapter 10. User documentation is very important, especially if your program modifies specific symbols outside of the user's control.

When calling an RVI routine from within your application, all ARexx variable names must be null-terminated strings and proper REXX symbols, and *all alphabetic characters must be in uppercase.* A variable is treated as a literal string, and no substitution for compound symbols is performed.

To call any of the RVI functions listed below, you must link your application with the rexxvars.o file supplied by Commodore and available through a number of sources. It isn't necessary to define the ARexx system library base pointer (RexxSysBase) before calling the functions, as each function opens the library when needed.

## Checking Message Validity

The first function has the following prototype:

BOOL CheckRexxMsg( struct RexxMsg *\*message )* 

**<sup>1</sup>RVI can** also be used by function hosts when processing an **RXFUNC** message, though such behaviour is **unusual.** 

CheckRexxMsg() returns TRUE if *message* is a valid **RexxMsg** structure from a running ARexx program. This check should be performed on a message before calling the other **RVI**  functions.

#### Examples

```
/* Get an ARexx message... */ 
struct RexxMsg *msg; 
msg = 
if( CheckRexxMsg( msg ) ) 
    /* can set/get variables */
```

### **Getting A Symbol's Value**

To next function has the following definition:

```
LONG GetRexxVar( struct RexxMsg *message, char *symbol, char **value )
```

**GetRexxVar()** retrieves a symbol value from the ARexx program that sent the given *message.* The symbol name should be passed as the second parameter *(symbol),* and a pointer to a pointer as the third parameter (value). The value of the symbol will be retrieved as an argstring, but can be treated as an ordinary string in most cases. The return string is read-only — it shouldn't be modified or freed under any circumstances.

The function returns zero if the value was successfully retrieved and non-zero otherwise the return code will be 10 if *message* is an invalid ARexx message.

```
struct RexxMsg *msg; 
char *value; 
long err; 
/* Get the current value of 'myport' */ 
err = GetRexxVar( msg, "MYPORT", &value ); 
/* Get the current value of 'list.fred.phone' */ 
err = GetRexxVar( msg, "LIST.FRED.PHONE", &value );
```

### **Setting A Symbol's Value**

The final function is:

```
LONG SetRexxVar( struct RexxMsg *message, char *symbol, 
               char *value, LONG length )
```

**SetRexxVar()** sets *symbol's* value to *value* in the ARexx program that sent *message.*  Since *value* can hold arbitrary data, including null characters, the length of the data to be stored should be specified in the *length* parameter. Storage will be allocated by the ARexx interpreter and the data copied into the new buffer area. The interpreter will also create a new symbol entry if necessary.

The function returns zero if it was successful, and non-zero if it failed: 3 if memory could not be allocated, 9 if the string is too long, and 10 if message is invalid.

#### Examples

```
struct RexxMsg *msg; 
/* Set several stem values (ignore errors) */ 
SetRexxVar( msg, "LIST.JOE.PHONE", "555-5555", 9 ); 
SetRexxVar( msg, "LIST.JOE.FAX", "555-5555", 9 ); 
SetRexxVar( msg, "LIST.JOE.BIRTHDAY", "June 3", 7 );
```

## **A Sample Active Host**

The listings at the end of this chapter demonstrate how to set up and use an active ARexx interface. For simplicity, the interface is implemented using the SimpleRexx set of interface routines, which are described in Chapter 9 (page 127).

The active host is called **active** and consists of three C files. Listing 11, **active.c,** sets up the interface and does cleanup on exit. Listing 12, send.c, prompts the user for a message to send to the resident process and waits for any replies. Listing 14 gets user input from the console.

When you start **active,** it opens an ARexx port ("ACTIVE" is the default name, but you can specify another name as an argument to the program) and prompts you:

```
Command, Function, or Quit: (c/f/q)
```

At this point type c to send an **RXCOMM** message, **f** to send an **RXFUNC** message, or q to quit. When sending an **RXCOMM** message, **active** will prompt you for the command string and ask whether you want the **RXFF\_RESULT, RXFF\_STRING** and **RXFF\_TOKEN** flags set. **For RXFUNC** messages, **active** will prompt you for the function name, the number of arguments, the argument strings, and whether you want the **RXFF\_RESULT** and **RXFF\_STRING** flags set. Both message types can be sent to either the "REXX" or "AREXX" ports of the resident process. After each message is sent, **active** waits for the reply message and prints the return

code and any result string or error code.

The following makefile for Aztec C will compile the **active program:** 

```
# Manx Aztec C makefile for 'active'. 
CC = cc 
LN = 1n 
CCOPTS = 
LNOPTS = 
LNLIBS = -lc 
H = arexx.h arexxsyslib.h simplerexx.h 
EXE = active 
OBJS = active.o scan.o send.o simplerexx.o 
# Target 
all: $(EXE) 
    *echo "Done" 
# active 
active: $(OBJS) 
    $(LN) $(LNOPTS) -o active $(OBJS) $(LNLIBS) 
active.o: active.c CH) 
    $(CC) $(CCOPTS) active.c 
scan.o: scan.c scan.h 
    $(CC) $(CCOPTS) scan.c 
send.o: send.c $(H) 
    $(CC) $(CCOPTS) send.c 
simplerexx.o: simplerexx.c $(H) 
    $(CC) $(CCOPTS) simplerexx.c
```

The equivalent **lmkfile** for SAS/C is:

```
# SAS/C lmkfile for 'active'. 
CC = lc 
CCOPTS =
```

```
H = arexx.h arexxsyslib.h simplerexx.h 
EXE = active 
OBJS = active.o scan.o send.o simplerexx.o 
# Target 
all: $(EXE) 
     echo "Done" 
# active 
active: $(OBJS) 
    blink lib:c.o, $(OBJS) to active lib lib:lc.lib 
active.o: active.c $(H) 
    $(CC) $(CCOPTS) active.c 
scan.o: scan.c scan.h 
    $(CC) $(CCOPTS) scan.c 
send.o: send.c $(H) 
    $(CC) $(CCOPTS) send.c 
simplerexx.o: simplerexx.c $(H) 
    $(CC) $(CCOPTS) simplerexx.c
```

Both files assume that all files are in the same directory.

```
Listing 11: active.c 
/* 
 * active.c -- Demonstrates the "active" ARexx port. This program 
               is NOT reentrant and expects to be started from a CLI. 
 */ 
#include <stdio.h> 
#ifdef LATTICE 
#include <dos.h> 
#endif 
#include "arexx.h" 
#include "arexxsyslib.h" 
#include "simplerexx.h" 
#include "scan.h" 
#define DEFAULT_NAME "ACTIVE"
```

```
ARexxContext Context = NULL; 
extern void Process( void ); 
extern void _abort( void ); 
 */ 
static void Usage( void ); 
void Quit( char *str ); 
/* 
 * Main -- Open the system support library, setup our ARexx port 
           and then handle user input. 
 */ 
int main( int argc, char *argv[] ) 
  { 
    char *name; 
    #if defined( LATTICE ) || defined( __SASC ) 
    onbreak( (int (*)(void)) _abort ); 
    #endif 
    /* Get the port name to use */ 
    name = DEFAULT_NAME; 
    if( argc == 2 ) 
        name = argv[1]; 
    else if( argc != 1 ) 
        Usage(); 
    puts( "Active starting..." ); 
    ScanInit(); 
    Context = ARexxInit( name, "REXX", TRUE ); 
    if( !Context ) 
        Quit( "Could not open an ARexx context." ); 
    printf( "Port name = "%s'\n", ARexxName( Context ) ); 
    /* Process messages. */ 
    Process(); 
    /* Cleanup and exit.
```

```
Quit( "Active exiting." ); 
  } 
/* 
 * Usage -- Print out usage info. 
 */ 
static void Usage( void ) 
  { 
    puts( "Usage: active [name]" ); 
    puts( "\n Starts an active ARexx port from which messages can be" ); 
    puts( " sent to the resident process." ); 
    exit( 0 ); 
  } 
/* 
 * Quit -- Clean things up before quitting. Prints optional string. 
 */ 
void Quit( char *str ) 
  { 
    if( str ) 
        puts( str ); 
    if( Context ) 
        ARexxFree( Context ); 
    ScanFini(); 
    exit( 0 ); /* should really be non-zero if error occurs */ 
  } 
/* 
 * _abort -- Called when the user presses CTRL-C. 
 */ 
void _abort( void ) 
  { 
    Quit( "Caught break signal --- aborting!" ); 
  } 
                                 Listing 12: send.c 
/* 
 * send.c -- Demonstrates the use of an active ARexx port to send commands 
 * to the resident process. 
 */ 
#include <stdio.h>
```

```
#include "arexx.h" 
#include "arexxsyslib.h" 
#include "simplerexx.h" 
#include "scan.h" 
#define BUFFERSIZE 161 
#define NULLCHAR '\0' 
extern ARexxContext Context; 
/* 
 * Forward references 
 */ 
static int Ask( char *prompt ); 
static char *Prompt( char *prompt ); 
static void SendCommand( void ); 
static void SendFunction( void ); 
static struct RexxMsg *WaitForReply( void ); 
/* 
 * Process -- Prompt the user for input and form a message to send 
              to the resident process, then wait for the reply. 
 */ 
void Process( void ) 
  { 
    BOOL ok; 
    char *str; 
    ok = TRUE; 
    while( ok ){ 
        str = Prompt( "Command, Function, or Quit: (c/f/q) " ); 
        if( *str == 'c' || *str == 'C' ) 
            SendCommand(); 
        else if( *str == 'f' || *str == 'F' ) 
            SendFunction(); 
        else if( *str == 'q' || *str == ) 
            ok = FALSE; 
        else 
            puts( "Unrecognized option!" ); 
    } 
  } 
/* 
 * SendCommand -- Send an RXCOMM message to the resident process. 
 */ 
static void SendCommand( void )
```

```
{ 
    char *str, *port_name; 
    BOOL result; 
    ULONG flags; 
    struct RexxMsg *msg; 
    static char command[ BUFFER_SIZE ]; 
    flags = 0; 
    result = FALSE; 
    str = Prompt( "Please enter the command string to send: " ); 
    strncpy( command, str, BUFFER_SIZE - 1 ); 
    command[ BUFFER_SIZE - 1 ] = NULLCHAR; 
    if( Ask( "Do you want a result string? (y/n) " ) == 'y' ){ 
        flags |= RXFF_RESULT; 
        result = TRUE; 
    } 
    if( Ask( "Is this a string file? (y/n) " ) == 'y' ) 
        flags |= RXFF_STRING; 
    if( Ask( "Do you want tokenization? (y/n) " ) == 'y' ) 
        flags |= RXFF_TOKEN; 
    if( Ask( "'REXX' or 'AREXX' port? (r/a) " ) == 'a' ) 
        port_name = "AREXX"; 
    else 
        port_name = "REXX"; 
    puts( "Sending command message..." ); 
    if( SendARexxMsg( Context, port name, command, flags ) ){ 
       msg = WaitForReply(); 
        printf( "-- Reply code %d\n", msg->rm_Result1 ); 
        if( result && msg->rm_Result1 == 0 && msg->rm_Result2 != NULL ) 
            printf( " Result string '%s'\n", (char *) msg->rm_Result2 ); 
        else 
            printf( " Error code %d\n", (int) msg->rm_Result2 ); 
        FreeARexxMsg( Context, msg ); 
    } else { 
       puts( "Error sending message! Is the resident process running?" ); 
    } 
  } 
/* 
 * SendFunction -- Send an RXFUNC message to the resident process. */
```

```
static void SendFunction( void ) 
  { 
    char *str, *port_name; 
    BOOL result; 
    LONG i, nargs; 
    ULONG flags; 
    struct RexxMsg *msg; 
    static char args[ 16 ] [ BUFFER_SIZE ]; 
    flags = 0; 
    result = FALSE; 
    str = Prompt( "Please enter the external function to invoke: " ); 
    strncpy( args[0], str, BUFFER_SIZE - 1 ); 
    args[0][ BUFFER_SIZE - 1 ] = NULLCHAR; 
    do 
        nargs = atoi( Prompt( "How many arguments? (0 to 15) " ) ); 
    while( nargs < 0 || nargs > 15 ); 
    for( i = 1; i <= nargs; ++i ){ 
        str = Prompt( "Argument: " ); 
        strncpy( args[i], str, BUFFER_SIZE - 1 ); 
        args[i] [ BUFFERSIZE - 1 ] = NULLCHAR; 
    } 
    if( Ask( "Do you want a result string? (y/n) " ) == 'y' ){ 
        flags |= RXFF_RESULT; 
        result = TRUE; 
    } 
    if( Ask( "Is this a string file? (y/n) " ) == 'y' ) 
        flags |= RXFF_STRING; 
    if( Ask( "REXX' or 'AREXX' port? (r/a) " ) == 'a' ) 
        port_name = "AREXX"; 
    else 
        port_name = "REXX"; 
    puts( "Sending function invocation message..." ); 
    if( CallARexxFunc( Context, port_name, args[0], flags, nargs, 
                       args[1], args[2], args[3], args[4], args[5], 
                       args[6], args[7], args[8], args[9], args[10], 
                        args [11] , args[12], args[13] , args[14], args[15] ) ) { 
        msg = WaitForReply(); 
        printf( "-- Reply code %d\n", msg->rm_Result1 ); 
        if( result && msg->rm_Result1 == 0 && msg->rm_Result2 != NULL ) 
            printf( " Result string '%s'\n", (char *) msg->rm_Result2 ); 
        else
```

```
printf( " Error code %d\n", (int) msg->rm_Result2 ); 
        FreeARexxMsg( Context, msg ); 
    } else { 
        puts( "Error sending message! Is the resident process running?" ); 
    } 
  } 
/* 
* WaitForReply -- Wait for our reply message to arrive. Replies 
* to all other messages. 
*/ 
static struct RexxMsg *WaitForReply( void ) 
  { 
    struct RexxMsg *msg, *reply; 
    reply = NULL; 
    while( reply == NULL ){ 
        Wait( ARexxSignal( Context ) ); 
        while( !reply && ( msg = GetARexxMsg( Context ) ) != NULL ){ 
            if( !IsARexxReply( msg ) ){ 
                printf( "** Got a message: '%s'\n", msg->rm_Args[0] ); 
                printf( "** Action code %x\n", msg->rm_Action ); 
                ReplyARexxMsg( Context, msg, RC_OK, "A reply string", 0 ); 
            } else { 
                reply = msg; 
            } 
        } 
    } 
    return( reply ); 
  } 
/* 
 * Ask -- Ask a question, return the first character of the answer. 
 */ 
static int Ask( char *prompt ) 
  { 
    char *str; 
    str = Prompt( prompt ); 
    while( isspace( *str ) ) 
        ++str; 
    return( isupper( *str ) ? tolower( *str ) : *str ); 
  }
```

```
/* 
 * Prompt -- Ask the user a question and get the reply string. 
 */ 
static char *Prompt( char *prompt ) 
  { 
    unsigned len; 
    char *str; 
    fputs( prompt, stdout ); 
    fflush( stdout ); 
    str = GetScanLine( stdin, &len ); 
    return( str != NULL ? str : "" ); 
  } 
                               Listing 13: scan.h 
/* 
 * scan.h -- Header file for scan.c 
 */ 
#ifndef SCAN_H_INCLUDED 
#define SCAN_H_INCLUDED 
extern void ScanInit( void ); 
extern char *GetScanLine( FILE *fp, unsigned *len ); 
extern void ScanFini( void ); 
#endif /* SCAN_H_INCLUDED */ 
                               Listing 14: scan.c 
/* 
 * scan.c -- Get a line of text from a file. Handles any length of line. 
 */ 
#include <stdio.h> 
#include <string.h> 
#include "scan.h" 
#define SCAN_LENGTH 257 
#define NULLCHAR '\0' 
#define NLCHAR '\n' 
static int ScanLength; 
static char *ScanBuffer = NULL; 
/* 
 * ScanInit -- Get ready for scanning.
```

```
*/ 
void ScanInit( void ) 
  { 
    ScanLength = SCAN_LENGTH; 
    ScanBuffer = (char *) malloc( ScanLength ); 
  } 
/* 
 * GetScanLine -- Gets a new scan line from the input file. 
                  Returns NULL when the end-of-file is reached, 
                  otherwise returns a pointer to an internal buffer 
                  holding the line and stores the length of the string 
                  in the second parm. Strips the newline. 
 */ 
char *GetScanLine( FILE *scan_file, unsigned *len ) 
  { 
    register int templen; 
    register char *tempbuf; 
    /* Some initialization */ 
    if( scan_file == NULL || len == NULL ) return( NULL ); 
    ScanBuffer[ 0 ] = NULLCHAR; 
    *len = 0; 
    /* EOF means that fgets returns NULL */ 
    if( !fgets( ScanBuffer, ScanLength, scan_file ) ) return( NULL ); 
    /* Now get the length */ 
    *len = strlen( ScanBuffer ); 
   /* Is buffer too small? Read a whole line in, not just part of one. */ 
   while( ScanBuffer[ *len - 1 ] != NLCHAR ){ 
        templen = ScanLength; 
        ScanLength += ScanLength; 
        tempbuf = ScanBuffer; 
        ScanBuffer = (char *) malloc( ScanLength ); 
        strcpy( ScanBuffer, tempbuf ); 
       free( tempbuf ); 
        if( !fgets( &ScanBuffer[ *len ], templen, scan_file ) ) break; 
        *len = strlen( ScanBuffer ); 
   } 
   ScanBuffer[ *len - 1 ] = NULLCHAR;
```

```
--(*len); 
    return( ScanBuffer ); 
  } 
/* 
 * ScanFini Clean things up. 
 */ 
void ScanFini( void ) 
  { 
    if( ScanBuffer != NULL ) 
        free( ScanBuffer ); 
    ScanBuffer = NULL; 
    ScanLength = 0; 
  }
```

# SimpleRexx: A Simple ARexx Interface

This chapter presents an adaptation of *SimpleRexx,* a set of C routines by Michael Sinz of Commodore-Amiga, Inc. for creating and maintaining an ARexx port in a safe, reentrant fashion.

## **Using SimpleRexx**

SimpleRexx does much of the gruntwork associated with the creation and use of an ARexx port. To use it, you simply link your program to the SimpleRexx module (a listing is found at the end of this chapter) and call SimpleRexx routines to create an ARexx port, retrieve ARexx messages, send ARexx messages and reply to ARexx messages.

In general you follow these steps:

- 1. When your application starts, call **ARexxInit()** at some point in its initialization. This will create your ARexx port and return an ARexx context. The ARexx context is a pointer to private data that other SimpleRexx routines need. Keep the pointer around, but don't modify it or its contents. You may call **ARexxInit()** more than once to allocate two or more ARexx ports, with each call returning a different context.
- 2. Wait for messages to arrive at your ARexx port(s). When one arrives, use **Get-ARexxMsg()** to retrieve it. When done processing, call **ReplyARexxMsg()** or to reply to or free the message. (You free the message if it was a **FreeARexxMsg()**  reply to a message you sent out.)
- 3. Send messages to the resident process whenever you want to by calling **SendARexx-Msg() or CallARexxFunc().** SimpleRexx keeps track of the number of outstanding messages and will decrement the count whenever a reply message is retrieved using **GetARexxMsg().**
- 4. When your application exits, call **ARexxFree()** for each context that was obtained by calling **ARexxInit(). ARexxFree()** will wait for any outstanding reply messages before returning.

One useful feature about the SimpleRexx routines is that they can be used even when the ARexx resident process is not running-- you don't need special code to enable or disable your ARexx interface. If the system library couldn't be found, no ARexx ports will be allocated by **ARexxInit()** and the other functions will simply return without performing any actions. If the destination port isn't found, no messages will be sent by **SendARexxMsg() CallARexxFunc()** . or

SimpleRexx is also safe for use in resident programs since it doesn't use global variables.

#### **Pragma Trick**

As you scan through the SimpleRexx code, you'll often see lines like this:

**RexxSysBase = context->rexx\_base;** 

This is a trick used whenever a call to the ARexx system library must be made, since the **#pragma** statements in the **arexxsyslib.h** header file reference the variable **RexxSysBase** . In most cases **RexxSysBase** is a global variable assigned the result of the **OpenLibrary()** call that opens the ARexx system library, but SimpleRexx is designed to be reentrant, so no modifiable global variables can be used. Instead, the library pointer from the current ARexx context is assigned to the *local* variable **RexxSysBase** . Lattice C users can **#define RexxSysBase context->rexxbase;** to accomplish the same end.

## **SimpleRexx Functions**

This section describes the SimpleRexx functions in detail. Most of the functions reference a datatype called **ARexxContext** , which is defined in **simplerexx.h** and should be treated as a private data type.

## **AddFuncHost**

BOOL **AddFuncHost** ( **ARexxContext** *context,* **LONG** *priority )* 

#### **Summary**

Adds the ARexx context's port name to the Library List as a function host with the given *priority.* This function is meant for use by function hosts only.

**See Also: RemFuncHost()** 

## **ARexxBase**

struct Library \*ARexxBase( ARexxContext *context )* 

#### Summary

Returns the ARexx context's library pointer, which will be NULL if the call to ARexxInit() that created the context failed.

This function should be used to assign a value to the RexxSysBase variable before calling any ARexx system library function directly.

See Also: ARexxInit()

## **ARexxFree**

void ARexxFree( ARexxContext *context )* 

#### Summary

Frees an ARexx context that was allocated with the ARexxInit() function and closes the ARexx port associated with that context.

See Also: ARexxlnit()

## **ARexxlnit**

ARexxContext ARexxInit( char *\*name,* char *\*extension,* char *\*multiple )* 

#### Summary

Creates a new ARexx context for use in sending and receiving ARexx messages. The name must be supplied and will be used to form the name of an ARexx port, and *extension* will be used as the filename extension on any message sent to the resident process (if NULL, the extension defaults to "REXX"). Returns an ARexx context to be used with other SimpleRexx routines. The contents of the context are private and should not be modified.

The name you supply will be translated to uppercase and truncated to 16 characters, and any extension will be truncated to 8 characters. If *multiple* is FALSE, ARexxInit() will try to open the port name you supply without any further translation, otherwise it will append a period and numbers from 01 to 99 to the name until it can open a port. The name of the port that was actually opened can be had using the ARexxName() function, and the signal mask for the port can be had using the ARexxSignal() function.

See Also: ARexxFree(), ARexxName(), ARexxSignal()

## **ARexxName**

**char \*ARexxName( ARexxContext** *context )* 

#### **Summary**

Returns a pointer to the name of the *context's* ARexx port. The name string must not be modified. Returns NULL if no ARexx port exists.

**See Also: ARexxInit()** 

## **ARexxSignal**

**ULONG ARexxSignal( ARexxContext** *context )* 

#### **Summary**

Returns the signal bitmask for the context's ARexx port. Use this mask in the call to **Wait()** to be signalled when a message arrives at the port.

**See Also: ARexxInit(), GetARexxMsg()** 

## **CallARexxFunc**

**struct RexxMsg \*CallARexxFunc( ARexxContext** *context,* **char** *\*port\_name,*  **char** *\*function,* **ULONG** *flags,* **int** *num\_args, )* 

#### **Summary**

Sends an ARexx function invocation message ( **RXFUNC**) to the given port with *function*  as the function name. If *port\_name* is NULL, the message will be sent to the resident process' "REXX" port. The flags can be any combination of **RXFF\_NOIO, RXFF\_RESULT** and **RXFF\_STRING,** or zero if no modifier flags are to be set. Set *num\_args* to the number of argument strings. If *num\_args* is non-zero, it should be followed by a list of *num\_args*  pointers to strings, which are the argument strings themselves.

The **CallARexxFunc()** allocates a **RexxMsg** structure, an argstring for the function name, and argstrings for any arguments, all of which must be freed (along with any result string) when the reply message is received.

**CallARexxFunc()** returns a pointer to the message that was sent if the destination port was found and the message was sent successfully, NULL otherwise. This pointer should be considered read-only. A count of all outstanding messages is automatically kept for each ARexx context.

**See Also: FreeARexxMsg(), SendARexxMsg()** 

## **FreeARexxMsg**

BOOL **FreeARexxMsg( ARexxContext** context, **struct RexxMsg** *\*msg )* 

#### **Summary**

Frees an ARexx message received with **GetARexxMsg() as a reply to a m** essage sent by **SendARexxMsg(). FreeARexxMsg()** will free any argument and result strings before freeing the message itself. If the message is not a reply message, **FreeARexxMsg() will**  fail and return FALSE.

**See Also: GetARexxMsg(), SendARexxMsg()** 

## **GetARexxMsg**

struct **RexxMsg \*GetARexxMsg( ARexxContext** context )

#### **Summary**

Retrieves the next ARexx message from the *context's* port, or NULL if no message is available. **IsARexxReply()** should be used to distinguish between a reply to a message that was sent with **SendARexxMsg() and** a new message from another program.

After processing an ARexx message, reply messages should be freed using **FreeARexx-Msg()** and other messages should be replied to using **ReplyARexxMsg().** 

Any reply messages received via **GetARexxMsg() decrements the outstanding messages counter for** that ARexx context.

**See Also: FreeARexxMsg(), IsARexxReply(), ReplyARexxMsg(), SendARexx-Msg()** 

## **IsARexxReply**

BOOL **IsARexxReply( struct RexxMsg** *\*msg )* 

#### **Summary**

Returns TRUE if the given message is a reply message to a message that was sent using FALSE otherwise. **SendARexxMsg(),**  **See Also: GetARexxMsg(), SendARexxMsg()** 

## **RemFuncHost**

#### BOOL **RemFuncHost( ARexxContext** *context )*

#### **Summary**

Removes the ARexx context's port name to the Library List. The port name should have been previously added to the list with the **AddFuncHost()** function. This function is meant for use by function hosts only.

**See Also: AddFuncHost()** 

## **ReplyARexxMsg**

BOOL **ReplyARexxMsg( ARexxContext** *context,* **struct RexxMsg** *\*msg ,*  **LONG** *return\_code,* **char** *\*result\_string,* **LONG** *error\_code )* 

#### **Summary**

Replies to an ARexx message that was received using the **GetARexxMsg()** function. The *return\_code* must be supplied, but the *result\_string* may be NULL and the *error\_code* may be zero.

The secondary result field **(rm\_Result2)** will be set to either a result string or an integer error code. A result string will be set only if the following conditions are met:

- *• return\_code* is zero,
- *• result\_string* is non-NULL, and
- the sender of the message requested a result string by setting the **RXFF\_RESULT** flag in the **rm\_Action** field.

If set, the result string is converted into an argstring. **If** *return\_code* is non-zero, the integer **error\_code** will be stored as the secondary result instead.

**ReplyARexxMsg()** returns TRUE if the message was successfully replied to.

Reply messages received in response to a previous **SendARexxMsg()** call should not be passed to **ReplyARexxMsg(),** but should be freed using **FreeARexxMsg()** instead.

**See Also: FreeARexxMsg(), GetARexxMsg(), SendARexxMsg()** 

## **SendARexxMsg**

```
struct RexxMsg *SendARexxMsg( ARexxContext context, char *port_name, 
                      char *string, BOOL flags )
```

#### **Summary**

Sends an ARexx command message ( **RXCOMM** ) to the given port with *string* as the command string. If *port\_name* is NULL, the message is sent to the resident process' "REXX" port. The *flags* can be any combination of **RXFF\_NOIO, RXFF\_RESULT, RXFF\_STRING** and **RXFF\_TOKEN,** or zero if no modifier flags are to be set. It allocates a **RexxMsg** structure and an argstring for the command, both of which must be freed (along with any result string) when the reply message is received.

**SendARexxMsg()** returns a pointer to the message that was sent if the destination port was found and the message was sent successfully, NULL otherwise. This pointer should be considered read-only. A count of all outstanding messages is automatically kept for each ARexx context.

**See Also: CallARexxFunc(), FreeARexxMsg(), Get ARexxMsg(), ReplyARexx-Msg()** 

## **The SimpleRexx Header**

```
/* 
 * SimpleRexx.h -- Header file for the SimpleRexx ARexx interface 
 * routines. 
 * 
 * SimpleRexx orginally created by Michael Sinz. This version 
 * adapted by Eric Giguere. 
 */ 
#ifndef SIMPLEREXX_H_INCLUDED 
#define SIMPLEREXX_H_INCLUDED 
#include <stdarg.h> 
#ifndef AREXXSYSLIB_H_INCLUDED 
#include "arexxsyslib.h" 
#endif 
/* ARexxContext is private to SimpleRexx.c... other files only need 
   to see it as a void pointer. */ 
#ifndef AREXXCONTEXT 
    #define AREXXCONTEXT 
    typedef void *ARexxContext;
```

```
#endif
```

```
/* Prototypes for the SimpleRexx functions. See the simplerexx.c 
  file for documentation. */ 
extern ARexxContext ARexxInit( char *name, char *extension, BOOL mult ); 
extern void ARexxFree( ARexxContext context ); 
extern char *ARexxName( ARexxContext context ); 
extern ULONG ARexxSignal( ARexxContext context ); 
extern struct Library *ARexxBase( ARexxContext context ); 
extern BOOL IsARexxReply( struct RexxMsg *msg ); 
extern struct RexxMsg *GetARexxMsg( ARexxContext context ); 
extern BOOL FreeARexxMsg( ARexxContext context, 
                                   struct RexxMsg *msg ); 
extern BOOL ReplyARexxMsg( ARexxContext context, 
                                   struct RexxMsg *msg, 
                                   LONG return_code, 
                                   char *result_string, 
                                   LONG error_code ); 
extern struct RexxMsg *SendARexxMsg( ARexxContext context, char *port, 
                                   char *string, ULONG flags ); 
extern struct RexxMsg *CallARexxFunc( ARexxContext context, char *port, 
                                   char *function, ULONG flags, 
                                   int num_args, ); 
extern BOOL AddFuncHost( ARexxContext context, LONG priority ); 
extern BOOL RemFuncHost( ARexxContext context ); 
extern BOOL SetARexxLastError( ARexxContext context, 
                                       struct RexxMsg *msg, char *error ); 
#endif /* SIMPLEREXX_H_INCLUDED */
```

## **The SimpleRexx Module**

```
/* 
 * SimpleRexx 2.0 -- A set of simple routines for adding a working ARexx 
                     port to any C program. These routines can be called 
                     without error even if ARexx itself is not running. 
                     The code is fully reentrant and self-contained. 
 * SimpleRexx orginally created by Michael Sinz. This version 
 * adapted by Eric Giguere. 
 */ 
/* 
 * Important include files. Prototypes and pragmas for the system 
 * library functions are found in arexxsyslib.h. Prototypes for 
 * Exec functions are found in arexx.h. 
 */
```

```
#include "arexx.h" 
#include "arexxsyslib.h" 
#ifdef RVI 
#include "rvi.h" 
#endif 
#include <ctype.h> 
#include <string.h> 
#define MAX_PORT_NAME 16 
#define MAX_PORT_LENGTH 24 
#define MAX_ERROR_NAME 28 
#define MAX_EXTENSION 8 
#define NULLCHAR '\0' 
/* 
 * The following structure is PRIVATE! Its contents are known only 
 * to the routines in this file. Outside functions that call the 
 * routines in this file only see (and pass back) a "void *". 
 */ 
struct ARexxContext 
  { 
    struct MsgPort *arexx_port; /* Program's ARexx port */ 
    struct Library *rexx_base; 
    long outstanding; 
    char port_name[ MAX_PORT_LENGTH + 1 ]; 
    char extension[ MAX_EXTENSION + 1 ]; 
#ifdef RVI 
    char error_name[ MAX_ERROR_NAME + 1 ]; 
#endif 
  }; 
/* This is important... we define ARexxContext to be a pointer to 
 * struct ARexxContext, and set AREXXCONTEXT so that the SimpleRexx.h 
 * header file won't try and set it to a "void *"... 
 */ 
#define AREXXCONTEXT 
typedef struct ARexxContext *ARexxContext; 
#include "SimpleRexx.h" 
static char *StrNUpper( char *dest, char *src, unsigned int len ); 
static char *UiToStr( unsigned num, char *buf ); 
/* 
 * ARexxInit -- Call this routine once at the start of your application 
                to prepare your ARexx port. ARexxInit will then return 
                a pointer to a private data type holding the information
```

```
it needs to satisfy ARexx requests. This pointer must 
                be passed to all the other routines in this file. Note 
                that ARexxInit will return a valid pointer even if ARexx 
                isn't running --- the other routines can still be called 
                in this situation. 
      Arguments: 
 * 
          name -- The name of the application, which will be used 
                       as the basis for creating a port name. It will 
                       be truncated to MAX_PORT_NAME characters and 
                       then upper-cased. Spaces will be changed to 
                       underscores. 
          extension -- The default file extension to use. If this pointer 
                       is NULL, "REXX" (the "." is automatic) is assumed. 
          multiple -- If FALSE, a suffix of the form ".NN" will be 
                       automatically appended to the port name, where 
                       NN will be replaced with a number from 01 to 99. 
 */ 
ARexxContext ARexxInit( char *name, char *extension, BOOL multiple ) 
  { 
    struct Library *RexxSysBase; 
    struct MsgPort *port; 
    ARexxContext context; 
    unsigned count; 
    char *ptr; 
    /* Allocate memory for the private data structure. */ 
    context = AllocMem( sizeof( struct ARexxContext ), 
                        MEMF_PUBLIC | MEMF_CLEAR ); 
    if( !context ) 
        return( NULL ); 
    /* Open the ARexx system library */ 
    RexxSysBase = OpenLibrary( (UBYTE *) "rexxsyslib.library", 0L ); 
    if( RexxSysBase ) 
      { 
                       context->rexx_base = RexxSysBase; 
        if( !extension ) 
            extension = "rexx"; 
        StrNUpper( context->extension, extension, MAX_EXTENSION ); 
        ptr = StrNUpper( context->port_name, name, MAX_PORT_NAME ); 
        #ifdef RVI 
            strcpy( context->error_name, context->port_name );
```

```
strcat( context->error_name, ".LASTERROR" ); 
        #endif 
        /* Make sure we have a unique port name... */ 
        Forbid(); 
        if( multiple ) 
          { 
            *ptr++ = '.'; /* null char inserted by UiToStr */ 
            for( count = 1; count < 100; ++count ) 
               { 
                 UiToStr( count, ptr ); 
                 port = FindPort((UBYTE *)context->port_name ); 
                 if( !port ) break; 
               } 
          } 
        else 
          { 
            port = FindPort( (UBYTE *) context->port_name ); 
          } 
        if( !port ) 
            context->arexx_port = CreatePort( (UBYTE *) context->port_name,0); 
        Permit(); 
      } 
    if( !context->rexx_base || !context->arexx_port ) 
      { 
        ARexxFree( context ); 
        context = NULL; 
      } 
    return( context ); 
  } 
/* 
 * ARexxFree -- Free an ARexxContext structure allocated by ARexxInit. 
                 Call this when your application is shutting down, or 
                 you are done with ARexx interfacing. 
 */ 
void ARexxFree( ARexxContext context ) 
  { 
    struct RexxMsg *msg; 
    struct Library *RexxSysBase; 
    if( !context ) 
        return;
```

```
/* Setup the RexxSysBase variable for the pragmas */ 
   if( context->rexx_base ) 
     { 
       RexxSysBase = context->rexx_base; 
       /* Change the port name so it can't be found. */ 
       context->port_name[0] = NULLCHAR; 
                /* Wait for any outstanding messages we sent out to come back. */ 
       while( context->outstanding > 0 && context->arexxport != NULL ) 
         { 
            WaitPort( context->arexx_port ); 
            while( ( msg = GetARexxMsg( context ) ) != NULL ) 
              { 
                if( !FreeARexxMsg( context, msg ) ) 
                    ReplyARexxMsg( context, msg, 100, NULL, 0 ); 
              } 
         } 
       /* Any other messages just get cleaned out... */ 
       if( context->arexx_port ) 
         { 
            Forbid(); 
            while( ( msg = GetARexxMsg( context ) ) != NULL ) 
                ReplyARexxMsg( context, msg, 100, NULL, 0 ); 
           DeletePort( context->arexx_port ); 
            Permit(); 
         } 
       CloseLibrary( RexxSysBase ); 
     } 
   FreeMem( context, sizeof( struct ARexxContext ) ); 
 } 
/* 
* ARexxName -- Returns the name of the ARexx port that was actually 
                allocated by ARexxInit. You can only look at this string. 
                Returns NULL if there is no ARexx port. 
*/
```

```
char *ARexxName( ARexxContext context )
    if( context )
        return( context->port_name );
    else
        return( NULL );
  }
 * ARexxSignal -- Returns the signal mask that the ARexx port is using.
                  This mask should be used in your Wait() loop to
                  know when an ARexx message arrives at your port.
ULONG ARexxSignal( ARexxContext context )
    if( context )
        return( 1UL << context->arexx_port->mp_SigBit );
        return(0);
  }
 * ARexxBase -- Returns the library pointer stored by the context.
                Don't close this library!
                                           Use it if you need to
                access some of the system library functions directly.
struct Library *ARexxBase( ARexxContext context )
    if( context )
       return( context->rexx_base );
    else
       return( NULL );
  }
 * IsARexxReply -- Returns TRUE if a RexxMsg is in fact a reply message
                  to a command we've sent.
BOOL IsARexxReply( struct RexxMsg *msg )
        return( msg->rm_Node.mn_Node.ln_Type == NT_REPLYMSG );
    else
       return( FALSE );
  }
 * GetARexxMsg -- Return the next message waiting at the given ARexx port,
                 NULL if there is no message.
                                                 Reply messages decrement
```

```
an internal count of outstanding messages. 
 * 
 * NOTE: After the message is received, it must either by replied to 
          or the message contents must be freed! 
 */ 
struct RexxMsg *GetARexxMsg( ARexxContext context ) 
  { 
    struct RexxMsg *msg; 
    if( !context ) 
        return( NULL ); 
    msg = (struct RexxMsg *) GetMsg( context->arexx_port ); 
    if( !msg ) 
        return( NULL ); 
    if( IsARexxReply( msg ) ) 
        --context->outstanding; 
    return( msg ); 
  } 
/* 
 * FreeARexxMsg -- Frees an ARexx message that was allocated by a 
                    call to SendARexxMsg, after its return as a reply message. 
                   Returns TRUE if everything went OK. 
 */ 
BOOL FreeARexxMsg( ARexxContext context, struct RexxMsg *msg ) 
  { 
    struct Library *RexxSysBase; 
    if( !context || !msg ) 
        return( FALSE ); 
    if( !IsARexxReply( msg ) ) 
        return( FALSE ); 
    /* Setup the library pointer for the pragmas */ 
    RexxSysBase = context->rexx_base; 
    /* Free the argstrings */ 
    ClearRexxMsg( msg, 16 ); 
    if( msg->rm_Result1 == 0 && msg->rm_Result2 != NULL ) 
        DeleteArgstring( (char *) msg->rm_Result2 ); 
    /* Free the message */
```

```
DeleteRexxMsg( msg ); 
    return( TRUE ); 
  } 
/* 
 * SendARexxMsg -- Prepares and sends an RXCOMM message to the 
                   given port ("REXX" if port_name is NULL). The fourth 
                   parm can be used to set the RXFF_NOIO, RXFF_STRING, 
                   RXFF_RESULT and RXFF_TOKEN flags if desired. 
 * 
                   If a message was sent successfully, returns a pointer 
                   to the message that was sent, or NULL if no message 
                   was sent. TREAT THIS POINTER AS READ-ONLY! A pointer 
                   is returned so you can keep track of several messages 
                   sent out simultaneously. 
 */ 
struct RexxMsg *SendARexxMsg( ARexxContext context, char *port_name, 
                               char *command, ULONG flags ) 
  { 
    struct MsgPort *port; 
    struct RexxMsg *msg; 
    struct Library *RexxSysBase; 
    if( !context || !command ) 
        return( NULL ); 
    if( !port_name ) 
        port_name = "REXX"; 
    /* Setup the library pointer */ 
   RexxSysBase = context->rexx_base; 
   /* Get a new message packet */ 
   msg = CreateRexxMsg( context->arexx_port, context->extension, 
                         context->port_name ); 
   if( !msg ) 
        return( NULL ); 
   /* Make sure any flags that are set are OK for use with RXCOMM... */ 
   flags &= ( RXFF_NOIO | RXFF_RESULT | RXFF_STRING | RXFF_TOKEN ); 
   /* Set the action code (+ flags) and the command string */ 
   msg->rm_Action = RXCOMM | flags; 
   msg->rm_Args[0] = (STRPTR) CreateArgstring( command,
```

```
strlen( command ) ); 
   msg->rm_Result1 = 0; 
   msg->rm_Result2 = (LONG) NULL; 
    if ( ! msg->rm_Args [0] ) 
      { 
        DeleteRexxMsg( msg ); 
        return( NULL ); 
      } 
    /* Find the port */ 
    Forbid(); 
    if( ( port = FindPort( (UBYTE *) port_name ) ) != NULL ) 
      { 
        PutMsg( port, (struct Message *) msg ); 
        ++context->outstanding; 
      } 
    else /* no port, clean up... */ 
      { 
        DeleteArgstring( (char *) msg->rm_Args[0] ); 
        DeleteRexxMsg( msg ); 
        msg = NULL; 
      } 
    Permit(); 
    return( msg ); 
  } 
/* 
 * CallARexxFunc -- Prepares and sends an RXFUNC message to the 
                    given port ("REXX" if port_name is NULL). The fourth 
                    parm can be used to set the RXFF_NOIO, RXFF_STRING, 
                    and RXFF_RESULT flags if desired. Set the fifth 
                    parm to the number of arguments you want to pass, 
                    and then pass the exact number of pointers to 
                    strings required. 
 * 
                    If a message was sent successfully, returns a pointer 
                    to the message that was sent, or NULL if no message 
                    was sent. TREAT THIS POINTER AS READ-ONLY! A pointer 
                    is returned so you can keep track of several messages 
                    sent out simultaneously. 
 */ 
struct RexxMsg *CallARexxFunc( ARexxContext context, char *port_name, 
                                char *function, ULONG flags, int num_args, . 
  { 
    va_list argptr;
```

```
struct MsgPort *port; 
struct RexxMsg *msg; 
struct Library *RexxSysBase; 
BOOL quit; 
int i; 
char *arg; 
if( !context || !function || num_args < 0 ) 
    return( NULL ); 
if( num_args > 15 ) 
    num_args = 15; 
if( !port_name ) 
    port_name = "REXX"; 
/* Setup the library pointer */ 
RexxSysBase = context->rexx_base; 
/* Get a new message packet */ 
msg = CreateRexxMsg( context->arexx_port, context->extension, 
                     context->port_name ); 
if( !msg ) 
    return( NULL ); 
/* Make sure any flags that are set are OK for use with RXFUNC... */ 
flags &= ( RXFF_NOIO | RXFF_RESULT | RXFF_STRING ); 
/* Set the action code (+ flags) and the command string */ 
msg->rm_Action = RXFUNC | flags; 
/* Now store the number of arguments... */ 
msg->rm_Action |= ( num_args & RXARGMASK ); 
/* Store the function name... */ 
msg->rm_Args[0] = (STRPTR) CreateArgstring( function, 
                                            strlen( function ) ); 
msg->rm_Result1 = 0; 
msg->rm_Result2 = (LONG) NULL; 
if( !msg->rm_Args[0] ) 
  { 
    DeleteRexxMsg( msg ); 
    return( NULL ); }
```

```
/* Get and store the argument strings */ 
    va_start( argptr, num_args ); 
    for( i = 1, quit = FALSE; i <= num_args && !quit; ++i ) 
      { 
        arg = (char *) va_arg( argptr, char * ); 
        if( !arg ) 
            arg = ""; 
        msg->rm_Args[i] = (STRPTR) CreateArgstring( arg, strlen( arg ) ); 
        if( !msg->rm_Args[i] ) 
            quit = TRUE; 
      } 
    va_end( argptr ); 
    if( quit ) 
      { 
        ClearRexxMsg( msg, 16 ); 
        DeleteRexxMsg( msg ); 
        return( NULL ); 
      } 
    /* Find the port */ 
    Forbid(); 
    if( ( port = FindPort( (UBYTE *) port_name ) ) != NULL ) 
      { 
        PutMsg( port, (struct Message *) msg ); 
        ++context->outstanding; 
      } 
    else /* no port, clean up... */ 
      { 
        ClearRexxMsg( msg, 16 ); 
        DeleteRexxMsg( msg ); 
        msg = NULL; 
      } 
    Permit(); 
    return( msg ); 
  } 
/* 
 * ReplyARexxMsg -- Reply to an ARexx message received with GetARexxMsg. 
                     Pass it the return code in the third parm. If the 
                     return code is 0 and the sender of the message
```

```
requested a reply string, pass that in the fourth 
                                           parm (NULL if no string). If the return code is 
                     non-zero, pass the error code in the fifth parm 
                     instead. 
 * Note: Always call IsARexxReply before this routine to make sure 
           you're not replying to a reply of one of your own messages. 
 */ 
BOOL ReplyARexxMsg( ARexxContext context, struct RexxMsg *msg, 
                     LONG return_code, char *result_string, 
                     LONG error_code ) 
  { 
    struct Library *RexxSysBase; 
    if( !context || !msg ) 
        return( FALSE ); 
    if( IsARexxReply( msg ) ) 
        return( FALSE ); 
    /* Setup the library pointer */ 
    RexxSysBase = context->rexx_base; 
    /* Set the results */ 
    msg->rm_Result1 = return_code; 
    msg->rm_Result2 = (LONG) NULL; 
    /* If no error and result was requested, set the result string */ 
    if( result_string != NULL && return_code == RC_OK 
        && ( msg->rm_Action & RXFF_RESULT ) != 0 ) 
      { 
        msg->rm_Result2 = (LONG) CreateArgstring( result_string, 
                                    strlen( result_string ) ); 
      } 
    else if( return_code != RC_OK ) 
      { 
        msg->rm_Result2 = error_code; 
      } 
    ReplyMsg( (struct Message *) msg ); 
    return( TRUE ); 
  } 
/* 
 * AddFuncHost -- Adds the context's port name to the Library List 
                   as a function host with the given priority. 
 */
```

/\*

```
BOOL AddFuncHost( ARexxContext context, LONG priority ) 
  { 
    struct RexxMsg *msg; 
    struct Library *RexxSysBase; 
    struct MsgPort *port; 
    if( !context ) 
        return( FALSE ); 
    /* Setup the library pointer */ 
    RexxSysBase = context->rexx_base; 
    /* Get a new message packet */ 
    msg = CreateRexxMsg( context->arexx_port, context->extension, 
                          context->port_name ); 
    if( !msg ) 
        return( FALSE ); 
    /* Tell the resident process to add the port name to the Library 
     * List... we don't expect a reply so we don't increase the count 
     * of outstanding messages. 
     */ 
    msg->rm_Action =RXADDFH | RXFF_NONRET; 
    msg->rm_Args[0] = (STRPTR) context->port_name; 
    msg->rm_Args[1] = (STRPTR) priority; 
    /* Find the port */ 
    Forbid(); 
    if( ( port = FindPort( (UBYTE *) "REXX" ) ) != NULL ) 
      { 
        PutMsg( port, (struct Message *) msg ); 
      } 
    else /* no port, clean up... */ 
      { 
        ClearRexxMsg( msg, 16 ); 
        DeleteRexxMsg( msg ); 
        msg = NULL; 
      } 
    Permit(); 
    return( msg != NULL ); 
  }
```

```
/* RemFuncHost -- Remove the context's port name from the Library List. 
 */ 
BOOL RemFuncHost( ARexxContext context ) 
  { 
    struct RexxMsg *msg; 
    struct Library *RexxSysBase; 
    struct MsgPort *port; 
    if( !context ) 
        return( FALSE ); 
    /* Setup the library pointer */ 
    RexxSysBase = context->rexx_base; 
    /* Get a new message packet */ 
    msg = CreateRexxMsg( context->arexxport, context->extension,
                          context->port_name ); 
    if( !msg ) 
        return( FALSE ); 
    /* Tell the resident process to remove the port name to the Library 
     * List... we don't expect a reply. 
     */ 
    msg->rm_Action = RXREMLIB | RXFF_NONRET; 
    msg->rm_Args[0] = (STRPTR) context->port_name; 
    /* Find the port */ 
    Forbid(); 
    if( ( port = FindPort( (UBYTE *) "REXX" ) ) != NULL ) 
      { 
        PutMsg( port, (struct Message *) msg ); 
      } 
    else /* no port, clean up... */ 
      { 
        ClearRexxMsg( msg, 16 ); 
        DeleteRexxMsg( msg ); 
        msg = NULL; 
      } 
    Permit(); 
    return( msg != NULL ); } /*
```

```
* SetARexxLastError -- Uses RVI to set an error string in a calling 
                         ARexx program. The string is stored in the 
                         variable <appname>.LASTERROR. Will only work 
                         if RVI is #defined -- you must also link to 
                         the rexxvars.o file. 
 */ 
BOOL SetARexxLastError( ARexxContext context, struct RexxMsg *msg, 
                         char *error ) 
  { 
    #ifndef RVI 
        return( FALSE ); 
    #else 
        if( !context || !msg || !error ) 
            return( FALSE ); 
        if( !CheckRexxMsg( msg ) ) 
            return( FALSE ); 
        return( SetRexxVar( msg, context->error_name, 
                             error, strlen( error ) ) == 0 ); 
    #endif 
  } 
/* 
 * StrNUpper -- Like strncpy, but also does a toupper and inserts 
                a NULLCHAR after the last character. 
 */ 
static char *StrNUpper( char *dest, char *src, unsigned int len ) 
  { 
    for( ; *src != NULLCHAR && len-- > 0; ++src ) 
      { 
        if( islower( *src ) ) 
            *dest++ = toupper( *src ); 
        else 
            *dest++ = *src; 
      } 
    *dest = NULLCHAR; 
    return( dest ); 
  } 
/* 
 * UiToStr -- Convert an integer less than 100 into a two-character 
              string. 
 */ 
static char *UiToStr( unsigned num, char *buf ) 
  { 
    num %= 100;
```

```
but [0] = ( num / 10 ) + '0' ; 
  buf [1] = ( num % 10 ) + '0' ; 
  buf [2] = NULLCHAR; 
  return( but ) ; 
}
```

## **CHAPTER 10**

# ARexx Standards

This chapter discusses the implementation of the ARexx standards outlined in the *Amiga User Interface Style Guide.* 

## **The Need For Standards**

ARexx allows the typical Amiga user to customize and integrate their application programs through its command facility. In effect, ARexx becomes the application's macro language. And the need for standards becomes even more apparent: integration is easier and less confusing if all applications support a common set of commands and a standard command syntax.

## Port Naming

The naming of ARexx ports was briefly discussed in Chapter 7. The rules are simple:

- 1. A port name should be based on the application's name.
- 2. A port name should not be too long, should include no spaces, and should be in uppercase.
- 3. Applications that can open two or more projects simultaneously can open a separate ARexx port for each project. Each port will then have a "slot number" appended to its name to distinguish it from the other ports belonging to the application.

Note that these criteria are satisfied if you use the SimpleRexx interface described in Chapter 9 to create your ports.

### Errors

When your application replies to a command message, it must always set an error code as an integer value in the rm\_Result1 field of the RexxMsg structure that held the command string. The error code will be converted into a string by the ARexx interpreter and stored in the calling program's RC variable. Use the following conventions:

• If no error occurs, return an error code of 0 (RC\_OK).

- If a minor error occurs, return an error code between 1 and 9. The usual warning code is 5 (RC\_WARN).
- If a major error occurs, return an error code of 10 (RC\_FAIL) or greater.

#### **Command Shells**

An alternative way of receiving commands is for your application to open a command shell into which the user types in the commands directly. The application processes the commands as if they had been received at one of its ports.

A command shell should either resemble Workbench 2.0's Execute Command window (for entering single commands) or a basic Shell (console) window (for entering multiple commands). Command errors should always be reported to the user.

### **Returning Data**

Some commands may return result strings if the following conditions hold:

- The O**PTIONS RESULTS** command was issued in the ARexx program that send the command. (This sets the **RXFF\_RESULT** flag in the **rm\_Action** field of the **RexxMsg**  structure.)
- The command returns an **RC\_OK** error code. **(rm\_Result1** is set to zero.)
- An argstring is created and returned as the secondary result in **rm\_Result2.**

If these conditions hold, the argstring that is returned will be assigned to the **RESULT** variable by the ARexx interpreter. In some cases it may be more convenient for the user to override this default assignment by specifying a variable in which to store the result string:

```
/* Get current line */ 
options results 
"getline var currline"
```

Commands that support the VAR switch should use the RVI facility described in Chapter 8 to set the given variable directly. (If the assignment fails, return the value as a normal result string.)

Multiple result strings can easily be returned by using the STEM switch to a command. For example, say you wished to return the following three strings:

```
Letter to John Doe 
Notes on Standards 
Addresses of the Stars
```

If the user had sent the command:

```
getattrs documents stem DocList.
```

then your application should assign the number of strings returned to the variable **DO-CLIST.COUNT** and assign each string in turn to **DOCLIST.0, DOCLIST.** 1, and **DOCLIST.2.**  These assignments are also done using RVI. If no STEM switch is specified, then you should return the single string:

"Letter to John Doe" "Notes on Standards" "Addresses of the Stars"

instead. Use quotation marks (or any other reasonable separator) to separate the individual strings. Don't use separators when assigning strings to individual stem variables.

## Suggested Command Standards

When adding ARexx support to an application, the hardest part is deciding which commands to support. The sections that follow briefly summarize the suggested commands an application should support. For detailed descriptions and syntax, please refer to the ARexx chapter in the *Amiga User Interface Style Guide.* 

## A Minimal Set of Commands

#### • Project-related commands

- NEW Creates a new project and work area.
- CLEAR Clears the current project and its work area.
- OPEN Opens the specified project (or prompts the user for one) into the current work area.
- SAVE Saves the current project to the current filename. If no current filename exists, prompts the user for one.
- SAVEAS Saves the current project to the specified filename.
- CLOSE Closes the current project and its window.
- PRINT Prints the currently specified object/project.
- QUIT Exits the program, allowing the user to save modified data if necessary.

#### • Block-related commands

- CUT Removes the currently selected block of information from the project and places it in the clipboard.
- COPY Places a duplicate of the currently selected block into the clipboard.
- PASTE Pastes the contents of the clipboard into the project at the currently active point.
- ERASE Clears the currently selected block from the project.

#### • Miscellaneous commands

- HELP Displays user help for your application.
- FAULT Returns the text message assigned to an error number.
- RX Allows the user to start an ARexx macro as if they were using the rx command from the Shell (CLI).

#### **Other Suggested Commands**

#### • Cursor positioning commands

GOTOLINE GOTOCOLUMN CURSOR Moves the cursor to the specified line. Moves the cursor to the specified column. Moves the cursor in the given direction.

LINE COLUMN Moves the cursor up or down from the current line. Moves the cursor left or right from the current column.

NEXT Moves the cursor to the next element (word, sentence, para-

graph or page).

PREVIOUS Moves the cursor to the previous element.

SETBOOKMARK Remembers a cursor location.

GOTOBOOKMARK Returns the cursor to a previous bookmark location.

POSITION Moves the cursor to the given location.

#### • Find and replace commands

FIND Searches for the text that matches the specified string.

FINDCHANGE Searches for and replaces text.

FINDNEXT Moves to the next occurrence of the current search string.

#### • Other text-related commands

TEXT Allows text to be entered from within a

macro.

LOWERCASE/UPPERCASE/SWAPCASE Swaps the case of a letter or letters.

FONT Changes fonts.

UNDO Undoes the last change.

REDO Undoes the UNDO command.

#### • Window-related commands

MOVEWINDOW Changes the position of a window.

SIZEWINDOW Changes the size of a window.

CHANGEWINDOW Changes both the size and position of a window.

WINDOWTOFRONT Moves a window to the front.

WINDOWTOBACK Moves a window behind all others.

ACTIVATEWINDOW Activates a window.

ZOOMWINDOW Shrinks a window if zoom gadgets are supported.

UNZOOMWINDOW Unshrinks a window.

#### • Telecommunications commands

BAUD Sets the baud rate.

PARITY Sets the parity.

STOPBITS Sets the number of stop bits.

DUPLEX Sets the duplex mode.

PROTOCOL Sets the upload/download protocol.

SENDFILE Sends a file.

CAPTURE Opens a capture buffer to receive a file.

DIAL Dials a phone number.

REDIAL Redials the last phone number.

SEND WAIT Sends a text string. Waits for a text string.

TIMEOUT Sets the timeout value for waits.

## Function Hosts and Libraries

**If** you plan on implementing a function host or a function library (as described in Chapters 11 and 12), please keep the following fact in mind:

*Once added* to the *Library List, the functions in a function host/library are immediately available to all other ARexx programs.* 

When implementing a host/library it's therefore important to be careful in choosing function names to minimize the chances of conflict. In particular, don't use names of built-in functions or functions in the ARexx support library.

## **CHAPTER 11**

## Function Hosts

This chapter discusses how to implement function hosts in C using the SimpleRexx interface.

## **Function Host Implementation**

A *function host* is an application which will accept ARexx function calls, and they are simple to implement. But first, let's summarize what *was* discussed in Chapters 2 and 3:

- When an ARexx program comes across a function call, it first searches for internal or built-in functions that match the function name.
- If no match is made, ARexx then searches each function host or function library in the Library List, starting with the library or host of highest priority.
- Each function library is called through a special *dispatch* point to see if it supports a given function. Each function host is sent a message to which it must reply.
- The search continues until a library or host is found with a matching function, or until the end of the Library List is reached.
- Then external ARexx programs are searched for.

As you might suspect by now, a function host is merely an application with an ARexx port that knows how to deal with function call messages!

Why use a function host as opposed to a function library? A function host can be used in situations when a shared library cannot. A function host is also another way of adding features to an application that already has an ARexx port: the application can then accept both commands *and* function calls. Unlike a function library, however, a function host must be explicitly started before it can process any messages.

SimpleRexx can be used to implement a function host, as the example at the end of this chapter demonstrates. Your function host can use the **AddFuncHost()** and **RemFunc-Host()** functions to add or remove itself from the Library List, or you can let ARexx programs do it themselves using ADDLIB() and REMLIB().

### What's My Call?

The message a function host receives is nothing mysterious: it's a **RexxMsg** structure with an **RXFUNC** action code and the **RXFF\_RESULT** modifier flag set. The function name is an

argstring in **ARG0,** and the parameters (if any) are found in **ARG1 to ARG15,** with the number of arguments passed stored in the the low order byte of the **rm\_Action** field.

Don't be surprised if this seems familiar — didn't we already state that the resident process was also a function host?

A function host has complete control over any function invocation request it receives. It must examine the string in **ARG0** to determine if it supports the requested function, and if it doesn't it should reply to the message immediately to allow the search through the Library List to continue.

#### **— Rejecting a request**

If your function host does not support the requested function, it should set the **rm\_Result1** field to **RC\_WARN** (5) and the **rm\_Result2 field to 1** before replying to the message. The search will then continue with the next function host or function library in the Library List.

It's important for your function host to process function requests — or at least any rejections — as quickly as possible to avoid delaying an ARexx program. Of course, the program that sent a request isn't necessarily an ARexx program (it might be a host application), but you should assume it is.

### **Function Implementation**

Once your host determines that it does in fact support the requested function (perhaps by comparing the string in ARG0 to a list of strings in a table), the host must then execute the code that implements the function. This code can do whatever you want it to. Eventually, however, the original message must be replied to and a result string returned. Set the **rm\_Result1** field to zero, convert the result string into an argstring and store it in **rm\_Result2 —** the same way a host application returns command results. The contents of the result string depend on the nature of the function, of course.

The name of the function to call will be stored in **ARG0.** Remember that in most cases the function name will be in uppercase because function calls in REXX are usually done with symbols and not strings, and symbol names are always converted to uppercase. To be safe, your matching routine should be case-insensitive.

The arguments to your function will be found in the fifteen argument fields after **ARG0.** The actual number of arguments passed can be had by checking the **rm\_Action** field:

```
nargs = ( msg->rm_Action & RXARGMASK );
```

You function code should ensure that the correct number and types of arguments have been passed to it. Note that one or more of the **rm\_Args** entries may be NULL, in which case you should use a default value for that argument.

If an error occurs while processing your function (this includes checking for the correct number of arguments), set **rm\_Result1 to RC\_ERROR** (10) and reply to the packet (the value in **rm\_Result2** is ignored). The ARexx program that made the function call will receive an **error return from function** error.

If the function terminates correctly, set **rm\_Result1 to RC\_OK** (0), store the result string in **rm\_Result2** and reply to the message.

#### **Summary**

Here are some code fragments that outline the steps involved in receiving and processing ARexx function invocation requests:

1. When a message arrives, retrieve it from the ARexx port.

```
msg = (struct RexxMsg *) GetMsg( port );
```

2. Make sure it's a function invocation message by checking for the **RXFUNC** action code.

```
if( ( msg->rm_Action & RXCODEMASK ) == RXFUNC ) 
  { 
    /* process the function invocation */ 
  }
```

- 3. Check the function name in **ARG0** against the list of functions you support. In most cases the comparisons should be case-insensitive. If you don't support the function, set **rm\_Result1 to RC\_WARN,** set **rm\_Result2 to** 1 and then immediately reply to the message.
- 4. Otherwise execute the code for the requested function. The number of parameters is given by:

```
nargs = ( msg->rm_Action & RXARGMASK ); 
and the arguments themselves are stored in ARG1, ARG2, and so on.
```

5. When done, set the return code to zero **(RC\_OK):** 

```
msg->rm_Result1 = (LONG) RC_OK;
```

and if a result was requested (you should always check for the **RXFF\_RESULT** flag first), create and store a result string:

```
if( ( msg->rm_Action & RXFF_RESULT ) != 0 && 
   msg->rm_Result1 == RC_OK ) 
  { 
   msg->rm_Result2 = (LONG) CreateArgstring( ); 
  }
```

6. Reply to the message.

```
ReplyMsg( (struct Message *) msg );
```

## **A Function Host Skeleton**

The listings that follow implement a simple function host, **RGB,** for setting and retrieving the values of the Amiga's colour registers. When started, the function host opens a port named "RGB" and accepts the following function calls from an ARexx program:

**• GETRGB(** *register )* returns the current value of the given colour register as a triplet of comma-separated RGB values.

- SETRGB( *register, r, g,* b ) store a new RGB value in the given register and returns a boolean result.
- RESETCOLOURS() or RESETCOLORS() will reset the colour register values to what they were when the function host was started and returns a boolean result.
- QUITRGB() terminates the function host and returns a boolean result.

Listing 16 is a set of general-purpose routines for implementing a function host using the SimpleRexx module described in Chapter 9, while Listing 17 is the actual implementation of the RGB host that demonstrates the use of those routines. The following makefile for Aztec C will compile the RGB host:

```
# Manx Aztec C makefile for 'active'. 
CC = cc 
LN = ln 
CCOPTS = 
LNOPTS = 
LNLIBS = -lc 
H = arexx.h arexxsyslib.h simplerexx.h funchost.h 
EXE = rgb 
OBJS = rgb.o funchost.o simplerexx.o 
# Target 
all: $(EXE) 
    @echo "Done" 
# rgb 
rgb: $(OBJS) 
    $(LN) $(LNOPTS) -o rgb $(OBJS) $(LNLIBS) 
rgb.o: rgb.c $(H) 
    $(CC) $(CCOPTS) rgb.c 
funchost.o: funchost.c $(H) 
    $(CC) $(CCOPTS) funchost.c 
simplerexx.o: simplerexx.c $(H) 
    $(CC) $(CCOPTS) simplerexx.c
```

The equivalent lmkfile for SAS/C is:

```
# SAS/C lmkfile for 'active'. 
CC = lc 
CCOPTS = 
H = arexx.h arexxsyslib.h simplerexx.h funchost.h 
EXE = rgb 
OBJS = rgb.o funchost.o simplerexx.o 
# Target 
all: $(EXE) 
    @echo "Done" 
# rgb 
rgb: $(OBJS) 
    blink lib:c.o, $(OBJS) to rgb lib lib:lc.lib 
rgb.o: rgb.c $(H) 
    $(CC) $(CCOPTS) rgb.c 
funchost.o: funchost.c $(H) 
    $(CC) $(CCOPTS) funchost.c 
simplerexx.o: simplerexx.c $(H) 
    $(CC) $(CCOPTS) simplerexx.c
```

Both files assume that all files, including the SimpleRexx files, are in the same directory.

Listing 15: funchost.h

```
#ifndef FUNCHOST_H_INCLUDED 
#define FUNCHOST_H_INCLUDED 
#define FH_ERR_PARMS 17 
typedef struct fh_entry{ 
    char *name; 
    int min_args; 
    int max_args; 
    void (*fp)( ARexxContext context, struct RexxMsg *msg ); 
} fh_entry; 
extern fh_entry *FH_Match( struct RexxMsg *msg, fh_entry *list, 
                           BOOL (*cmp)( char *, char * ) );
```

```
extern fh_entry *FH_MatchMixed( struct RexxMsg *msg, fh_entry *list ); 
extern fh_entry *FH_MatchExact( struct RexxMsg *msg, fh_entry *list ); 
extern BOOL FH_NotFound( ARexxContext context, struct RexxMsg *msg ); 
extern BOOL FH_OKReturn( ARexxContext context, struct RexxMsg *msg, 
                              char *result ); 
extern BOOL FH_ErrReturn( ARexxContext context, struct RexxMsg *msg ); 
#endif
```

#### Listing 16: funchost.c

```
/* 
 * Skeleton code for an ARexx function host. 
 * 
 * This file uses the SimpleRexx module for the ARexx interface, so 
 * you should link it with the simplerexx.c file. 
 */ 
#include <ctype.h> 
#include "arexx.h" 
#include "arexxsyslib.h" 
#include "simplerexx.h" 
#include "funchost.h" 
static BOOL StrEq( char *a, char *b ); 
static BOOL StrIEq( char *a, char *b ); 
         /* * FHMatch -- Given a message, search for the matching function. 
 */ 
fh_entry *FH_Match( struct RexxMsg *msg, fh_entry *list, 
                     BOOL (*cmp)( char *, char * ) ) 
  { 
    if( !mpg || !list || !cmp ) 
        return( NULL ); 
    if( IsARexxReply( msg ) ) 
        return( NULL ); 
    if( ( msg->rm_Action & RXCODEMASK ) != RXFUNC ) 
        return( NULL ); 
    /* Now search through the function list. Long tables should 
       use a binary search instead. */ 
    for( ; list->name != NULL; ++list ) 
        if( cmp( (char *) msg->rm_Args[0], list->name ) ) 
            return( list );
```

```
return( NULL ); 
  } 
/* 
 * FH_MatchMixed -- Match a function against a list using a 
                     case-insensitive matching function. 
 */ 
fh_entry *FH_MatchMixed( struct RexxMsg *msg, fh_entry *list ) 
  { 
    return( FH_Match( msg, list, StrIEq ) ); 
  } 
/* 
 * FH_MatchExact -- Match a function using an exact matching function. 
 */ 
fh_entry *FH_MatchExact( struct RexxMsg *msg, fh_entry *list ) 
  { 
    return( FH_Match( msg, list, StrEq ) ); 
  } 
/* 
 * FH_NotFound -- Reply to a message and set the codes so that the 
                   search can continue. 
 */ 
BOOL FH_NotFound( ARexxContext context, struct RexxMsg *msg ) 
  { 
    return( ReplyARexxMsg( context, msg, RC_WARN, NULL, 1 ) ); 
  } 
/* 
 * FH_OKReturn -- Reply to a message and set the result string. 
 */ 
BOOL FH_OKReturn( ARexxContext context, struct RexxMsg *msg, char *result ) 
  { 
    return( ReplyARexxMsg( context, msg, RC_OK, result, 0 ) ); 
  } 
/* 
 * FH_ErrReturn -- Reply to a message with an error so that the search 
                    does NOT continue. 
 */ 
BOOL FH_ErrReturn( ARexxContext context, struct RexxMsg *msg ) 
  { 
    return( ReplyARexxMsg( context, msg, RC_ERROR, NULL, 12 ) ); 
  }
```

```
/* 
 * StrEq -- Returns TRUE if two strings match. 
 */ 
static BOOL StrEq( char *a, char *b ) 
  { 
    return( strcmp( a, b ) == 0 ); 
  } /* 
          * StrIEq -- Like StrEq, but case-insensitive. 
 */ 
static BOOL StrIEq( char *a, char *b ) 
  { 
    #ifdef LATTICE 
        return( stricmp( a, b ) == 0 ); 
    #else 
        while( *a != NULLCHAR && *b != NULLCHAR ) 
           { 
             if( tolower( *a ) != tolower( *b ) ) 
                 return( FALSE ); 
             ++a;
             ++b;
           } 
        return( *a == *b ); 
    #endif 
  }
```

#### Listing 17: rgb.c

```
/* 
 * RGB -- Function host example. Link with funchost.c and simplerexx.c. 
 * 
           * This file implements a function host which can be used to get 
           * and set colour register values. It adds itself to the ARexx 
           * Library List when started and removes itself when it quits. 
 */ 
#include "arexx.h" 
#include "arexxsyslib.h" 
#include "simplerexx.h" 
#include "funchost.h" 
#include <graphics/gfx.h> 
#include <intuition/intuition.h> 
#if defined( INCLUDES_2 ) 
    #include <clib/intuition_protos.h> 
    #include <clib/graphics_protos.h>
```

```
#elif defined( AZTEC_C ) 
   #include <clib/intuition_protos.h> 
   #include <clib/graphics_protos.h> 
#elif defined( LATTICE ) || defined( __SASC ) 
   #include <proto/intuition.h> 
   #include <proto/graphics.h> 
#endif 
#define ArgValue(msg,arg) ((msg)->rm_Args[arg]==NULL?"0":(msg)->rm_Args[arg]) 
/* 
 * Setup the list of functions this host supports. 
 */ 
static void SetColour( ARexxContext context, struct RexxMsg *msg ); 
static void GetColour( ARexxContext context, struct RexxMsg *msg ); 
static void ResetColours( ARexxContext context, struct RexxMsg *msg ); 
static void QuitRGB( ARexxContext context, struct RexxMsg *msg ); 
static fh_entry FunctionList[] = 
  { 
    "SetRGB", 4, 4, SetColour, 
    "GetRGB", 1, 1, GetColour, 
    "ResetColours", 0, 0, ResetColours, 
    "ResetColors", 0, 0, ResetColours, 
    "QuitRGB", 0, 0, QuitRGB, 
    NULL 
  }; 
/* 
 * Variables. 
 */ 
struct GfxBase *GfxBase = NULL; 
struct IntuitionBase *IntuitionBase = NULL; 
ARexxContext Context = NULL; 
struct Window *DummyWin = NULL; 
struct ViewPort *WbVP = NULL; 
int NumColours = 0; 
/* We'll open a dummy window so we can locate the Workbench screen. 
 * This also forces the screen to stay open... 
 */ 
static struct NewWindow DummyNewWin = 
  { 
    0, 0, 1, 1, 0, 0, 0, 0, NULL, NULL, NULL, NULL, NULL, 0, 0, 0, 0, 
    WBENCHSCREEN 
  }; 
static UWORD SaveColours[32];
```

```
/* 
* Our exit function 
*/ 
static void Quit( char *str ); 
/* 
 * main -- Open an ARexx context, then wait for messages. 
 */ 
int main( int argc, char *argv[] ) 
  { 
   fh_entry *which; 
   ULONG signals; 
    struct RexxMsg *msg; 
   LONG nargs; 
    int i; 
    GfxBase = (void *) OpenLibrary( (UBYTE *) "graphics.library", 0 ); 
    if( !GfxBase ) 
       Quit( "RGB: Could not open graphics library." ); 
    IntuitionBase = (void *) OpenLibrary( (UBYTE *) "intuition.library", 0 ); 
    if( !IntuitionBase ) 
       Quit( "RGB: Could not open intuition library." ); 
   DummyWin = OpenWindow( &DummyNewWin ); 
    if( !DummyWin ) 
       Quit( "RGB: Could not open dummy window." ); 
    /* Get and save the current colourmap */ 
   WbVP = &DummyWin->WScreen->ViewPort; 
   NumColours = 4; 
    if( WbVP->ColorMap ) 
       NumColours = WbVP->ColorMap->Count; 
   for( i = 0; i < NumColours; ++i ) 
       SaveColours[i] = GetRGB4( WbVP->ColorMap, i ); 
    /* Note: only one function host should ever be running, so we 
       try to open our ARexx port in 'single' mode only. */ 
    Context = ARexxInit( "RGB", NULL, FALSE ); 
    if( !Context ) 
       Quit( "RGB: Could not open an ARexx port." );
```

```
AddFuncHost( Context, 0 ); 
    while( 1 ) 
      { 
         signals = Wait( ARexxSignal( Context ) | SIGBREAKF_CTRL_C ); 
         if( signals & SIGBREAKF_CTRL_C ) 
             Quit( "RGB: Break caught." ); 
        while( ( msg = GetARexxMsg( Context ) ) != NULL ) 
           { 
             which = FH_MatchMixed( msg, FunctionList ); 
             if( which ) 
               { 
                 nargs = ( msg->rm_Action & RXARGMASK ); 
                 if( nargs < which->min_args || nargs > which->max_args ) 
                      FH_ErrReturn( Context, msg ); 
                 else 
                      which->fp( Context, msg ); 
               } 
             else 
                 FH_NotFound( Context, msg ); 
           } 
      } 
    Quit( NULL ); 
  } 
/* 
 * Quit -- Clean up. 
 */ 
static void Quit( char *str ) 
  { 
    if( str ) 
        puts( str ); 
    puts( "RGB: Exiting." ); 
    if( Context ) 
      { 
        RemFuncHost( Context ); 
        Delay( 50 ); /* Wait a bit... */ 
        ARexxFree( Context ); 
      } 
    if( DummyWin ) 
      { 
        if( NumColours ) 
             LoadRGB4( WbVP, SaveColours, NumColours );
```

```
CloseWindow( DummyWin ); 
      } 
    if( IntuitionBase ) 
        CloseLibrary( (struct Library *) IntuitionBase ); 
    if( GfxBase ) 
        CloseLibrary( (struct Library *) GfxBase ); 
    exit( 0 ); 
  } 
/* 
 * GetColour -- Get a colour for an RGB register. Returns a 
                string of three digits separated by commas. 
 */ 
static void GetColour( ARexxContext context, struct RexxMsg *msg ) 
  { 
    long reg; 
    long rgb; 
    static char buf[] = "xxx,xxx,xxx"; 
    reg = (long) atoi( (char *) ArgValue( msg, 1 ) ); 
    if( reg >= NumColours ) 
        FH_OKReturn( context, msg, "0,0,0" ); 
    rgb = (long) GetRGB4( WbVP->ColorMap, reg ); 
    sprintf( buf, "%d,%d,%d", ( rgb & 0x0F00 ) >> 8, ( rgb & 0x00F0 ) >> 4, 
             rgb & 0x000F ); 
    FH_OKReturn( context, msg, buf ); 
  } 
/* 
 * SetColour -- Sets an RGB register. Returns a boolean value. 
 */ 
static void SetColour( ARexxContext context, struct RexxMsg *msg ) 
  { 
    long reg; 
    UWORD r, g, b; 
    reg = atoi( (char *) ArgValue( msg, 1 ) ); 
    if( reg >= NumColours ) 
        FH_OKReturn( context, msg, "0" ); 
    r = atoi( (char *) ArgValue( msg, 2 ) ) % 16;
```

```
g = atoi( (char *) ArgValue( msg, 3 ) ) % 16; 
    b = atoi( (char *) ArgValue( msg, 4 ) ) % 16; 
    SetRGB4( WbVP, reg, r, g, b ); 
    FH_OKReturn( context, msg, "1" ); 
  } 
/* 
   ResetColours -- Reset the colours to their original values. 
                   Returns a boolean result. 
 */ 
void ResetColours( ARexxContext context, struct RexxMsg *msg ) 
  { 
    if( NumColours ) 
        LoadRGB4( WbVP, SaveColours, NumColours ); 
    FH_OKReturn( context, msg, "1" ); 
  } 
/* 
   QuitRGB -- Quits. Returns a boolean value. 
 */ 
static void QuitRGB( ARexxContext context, struct RexxMsg *msg ) 
  { 
    FH_OKReturn( context, msg, "1" ); 
    Quit( NULL ); }
```

## **CHAPTER 12**

## Function Libraries

All that's left now are ARexx function libraries, and this chapter shows you how to create your own libraries using either Aztec C or SAS/C, with minimal assembly language coding required.

## **Function Library Implementation**

Like function hosts, *function libraries* add functionality to an ARexx program. Unlike function hosts, function libraries require much more care in their creation.

### Shared Libraries

An ARexx function library is a standard Amiga shared library that follows the conventions described in this chapter. Specifics on general library creation can be found in Amiga *ROM Kernel Reference Manual: Libraries,* but to summarize:

- All programs using a shared library are sharing the same code only one copy of a shared library is in memory.
- A program must call the OpenLibrary() function before calling any of the functions in the shared library. If the library is not already in memory, it will be loaded from the LIBS: directory.
- OpenLibrary() returns a pointer to a library base, which is used (via compiler #pragma statements) to call the functions in the library. A jump table is found at negative offsets from the library base. Each function in the shared library that is callable from an external program has a slot in the jump table (the offsets are given as part of the #pragma statements), and four of those slots are reserved for use by Exec. The first free slot is at offset -30.
- When done with the library, a program calls CloseLibrary(). If the system is low on memory and no programs are using a particular shared library, Exec will *expunge*  the library to free up more memory.

Setting up a shared library requires some assembly language coding, but both the Aztec and SAS compilers supply library entry and initialization files that do the dirty work for you, which includes setting up the offset slots that are required by Exec. All you have to do is write the library functions and define the library identification data (a name, a revision number, and a version string).

#### **Installing New Shared Libraries**

A program accesses a shared library by using the Exec **OpenLibrary()** function. If the library isn't already in memory, it will first be loaded from the **LIBS:** directory. Once in memory, a shared library will not be unloaded *(expunged)* until all the programs that have accessed the library call **CloseLibrary()** and memory is running low. So when you're developing a shared library, installing a new version of the library in **LIBS:** isn't enough - you must also expunge the in-memory copy if you want any changes you made to take effect.

Under 2.0, you can force an expunge of all non-open libraries by typing:

avail **flush** 

at the Shell (CLI) prompt. Earlier versions of AmigaDOS have no equivalent option, but the same effect can be achieved in one of two ways. The first way is to use the **stack** command to set your stack to a very large value and then immediately reset it to the normal value you use:

**stack 20000000 ; huge! !** 

**stack 10000 ; use your normal value here** 

The second way is to modify your **s:startup-sequence** file to load the Workbench in debugging mode:

**loadwb -debug** 

which adds two hidden menu items to the Workbench menubar, one of which ("flush libs" ) expunges any non-opened libraries.

#### **Reentrancy**

A shared library has its own dataspace, but can be called at any time by any number of programs. If possible, you should make your function library reentrant, with modifiable data allocated dynamically or off the stack. If you need to change global data, you should ensure that your function library has a lockout mechanism to allow only one program to access the library at a time, otherwise your data's integrity may be compromised. The example library in this chapter is reentrant.

#### **Accessing Other Libraries**

If you wish to access non-Exec functions (Intuition and AmigaDOS functions, for example) from within your library, you must first open the appropriate shared li brary. The function library skeleton at the end of this chapter shows you one way to do this, because it must access the ARexx system library functions. Another way to do this would be to modify the library startup code to open the required libraries when the function library is first opened and to store the library base pointers in the function library's base pointer structure. The latter method requires extensive modification of the library startup code and is not presented here.

**IMPORTANT:** Many of the C functions in your compiler's standard library are *not* reen trant!

### The Dispatch Function

As far as ARexx is concerned, a function library only has one entry point — the *dispatch*  function (sometimes called the *query* function). The offset of the dispatch function in the function library is passed to ARexx when the library is first installed in the Library List. The dispatch function will be called by ARexx when the latter is searching for a function. The dispatch function will then compare the data ARexx passes it against a list of functions it supports. If found, the dispatch function will then call that function directly. Otherwise an error code is passed back so that ARexx can continue searching the Library List.

The data passed to the dispatch function is a pointer to a RexxMsg structure following the same conventions as the messages passed to a function host. The difference in this case is that the message is passed to the function library directly instead of being sent to a message port. As with function hosts, the name of the function is found in ARG0 and any arguments in ARG1 to ARG15. (Remember to watch out for null pointers, which indicate an omitted argument — use a reasonable default value for these. Always check the action field for the actual number of arguments.) Unlike function hosts, however, the return code and result string are passed back to ARexx by storing them in assembly language registers.

### Register Conventions

The examples in this chapter take care of setting the assembly language registers properly for use by ARexx, but for those that are interested in the details:

- When the dispatch function is called, register A0 holds the RexxMsg pointer, and register A6 holds the library base pointer.
- When the dispatch function returns, register D0 must hold the integer return code. If D0 is zero, register A0 must hold a result string.

Result strings should always be created with the CreateArgstring() function, hence an ARexx function library must also access the ARexx system library.

## Setting Results

If an ARexx function library does not support a function, the dispatch function should set register D0 to 1 and return as quickly as possible to allow the function search to continue. No result string should be set in this case.

If an error occurs while executing a function, return an error code (greater than 1) in D0. Otherwise, supported functions should set D0 to zero and *always* return a result string in register A0. ARexx will return the result string as the result of the function.

## **Creating Function Libraries With SAS/C**

Note: The instructions in this section apply exclusively to the SAS/C compiler.

Here are the simple steps required to build an ARexx function library:

- 1. The SAS/C compiler includes two files for creating shared libraries, libent.a and libinit.c (they are found in the source directory of the 5.10 compiler). Copy these files into the directory where you are building your function library. (Don't change the original files.)
- 2. No modifications need to be made to either file except to adjust the MYREVISION macro whenever you create a new version of your library.
- 3. Create the file sasglue.a as shown in Listing 18. This is the dispatch function that ARexx will be calling. All it does is push parameters onto the stack and then call a C function we will be defining shortly.
- 4. Create the file arexxlib.fd with these five lines:

##base \_ARLibBase ##bias 30 ##public Dispatch(msg)(A0) ##end

- 5. Create the file arexxlib.c as shown in Listing 24, and the header file arexxlib.h as shown in Listing 23. This is a skeleton for you to modify. The dispatch function in sasglue.a will call the ARLibDispatch() function with the RexxMsg pointer as the first parameter and a pointer to a string pointer as the second parameter. ARLib-Dispatch() is described in detail below.
- 6. Create an linkfile as shown in Listing 19. Modify the ID macro to hold an appropriate identifer string.
- 7. Invoke link to create the function library, arexxlib.library. Copy it to the LIBS: directory before using it.

Adding functions to the function library is merely a matter of modifying the skeleton file, arexxlib.c. The FunctionList array holds the names of the functions the library supports, the minimum and maximum number of arguments to those functions, and a C function that implements the function. Modify this list to add your own functions. Each C function listed in this table should have the following prototype:

```
LONG MyFunc( struct Library *RexxSysBase, struct RexxMsg *msg, 
             char **result_string );
```

When ARLibDispatch() is called, it will search through the list of function names in FunctionList. If a match is found, it calls the entry's C function with the ARexx system library base pointer in the first parameter, the RexxMsg pointer in the second parameter, and a pointer to a string pointer as the last parameter. The C function must return an error code when it is done. If the error code is 0, then a result string should be set before leaving the function:

```
*result_string = (char *) CreateArgstring( ... );
```

The result string will be passed back to the dispatch function, which will in turn store it in the A0 register before returning to ARexx.

If no match is found, ARLibDispatch() returns 1 so that ARexx can continue searching other function libraries or function hosts.

## Creating Function Libraries With Aztec C

Note: The instructions in this section apply exclusively to the Manx Aztec C compiler.

Here are the simple steps required to build an ARexx function library:

- 1. The Manx Aztec C compiler includes two files for creating shared libraries, libstart.asm and libsup.c (they are found in the res.\_lib directory of the 5.0e compiler). Copy these files into the directory where you are building your function library. (Don't change the original files.)
- 2. Create the file aztecglue.asm as shown in Listing 20. This is the dispatch function that ARexx will be calling. All it does is push parameters onto the stack and then call a C function we will be defining shortly.
- 3. Modifications have to be made to libsup.c and the modified version is shown in Listing 21. Many of the changes are cosmetic: mylibbase becomes ARLibBase, and most of the functions are renamed. The important modification is to add our assembly language dispatch routine, Dispatch, to the LibFuncTab table. You should also modify the MYREVISION macro, and the myname and myid strings as appropriate.
- 4. Although it isn't necessary for creating the library itself, you should create the file arexxlib.fd with these five lines:

##base \_ARLibBase ##bias 30 ##public Dispatch(msg)(A0) ##end

- 5. Create the file arexxlib.c as shown in Listing 24, and the header file arexxlib.h as shown in Listing 23. This is a skeleton for you to modify. The dispatch function in aztecglue.a will call the ARLibDispatch() function with the RexxMsg pointer as the first parameter and a pointer to a string pointer as the second parameter. ARLibDispatch() is described in detail below.
- 6. Create a makefile as shown in Listing 22.
- 7. Invoke make to create the function library, arexxlib.library. Copy it to the LIBS: directory before using it.

Adding functions to the function library is merely a matter of modifying the skeleton file, arexxlib.c. The FunctionList array holds the names of the functions the library supports, the minimum and maximum number of arguments to those functions, and a C function that implements the function. Modify this list to add your own functions. Each C function listed in this table should have the following prototype:

```
LONG MyFunc( struct Library *RexxSysBase, struct RexxMsg *msg, 
             char **result_string );
```

When ARLibDispatch() is called, it will search through the list of function names in FunctionList. If a match is found, it calls the entry's C function with the ARexx system library base pointer in the first parameter, the RexxMsg pointer in the second parameter, and a pointer to a string pointer as the last parameter. The C function must return an error code when it is done. If the error code is 0, then a result string should be set before leaving the function:

```
*result_string = (char *) CreateArgstring( );
```

The result string will be passed back to the dispatch function, which will in turn store it in the A0 register before returning to ARexx.

If no match is found, **ARLibDispatch()** returns 1 so that ARexx can continue searching other function libraries or function hosts.

```
Listing 18: sasglue.a (SAS only) 
; sasglue.a 
• This is the actual dispatch routine that will be called. 
• It pushes arguments on the stack and then calls our C 
• dispatch function, storing the result string in A0. Link 
• this with libent.a and the C code for the library. 
   section code 
   xref ARLibDispatch 
LIBDispatch: 
   movem.l d2/d3/d4-d7/a2-a6,-(sp) 
   subq.l #4,sp ; Create temporary variable 
   move.l sp,-(sp) ; Push return pointer 
   move.l a0,-(sp) ; Push argument 
   jsr ARLibDispatch ; D0 = error code 
   addq.l #8,sp ; Restore stack 
   movea.l (sp)+,a0 ; Result string 
   movem.l (sp)+,d2/d3/d4-d7/a2-a6 
   rts 
   xdef LIBDispatch 
   end
```

#### Listing 19: lmkfile (SAS only)

```
# SAS/C lmkfile for creating an ARexx function library called 
# 'arexxlib.library' 
PREFIX= _LIB # prefix for library functions 
ID = "mylib 1.0 (May 91)\r\n" # ID string
```

```
FD = arexxlib.fd
                                   # FD file
LIBS = lib:lc.lib
                                  # libraries to link with, if any
ARLIB = arexxlib.library
                                   # name of library
# Add object files to this list...
OBJS = libent.o sasglue.o libinit.o arexxlib.o
# Create the library...
$(ARLIB): $(OBJS)
   blink LIBPREFIX $(PREFIX) LIBID $(ID) LIBFD $(FD) \
         TO $(ARLIB) FROM $(OBJS) LIB $(LIBS)
    copy $(ARLIB) libs:
# Customize arexxlib.c to add your functions
arexxlib.o: arexxlib.c
   lc -ml -v -d_USEOLDEXEC_ arexxlib.c
sasglue.o: sasglue.a
   asm -u sasglue.a
# Copy these files from the 'source' directory in your SAS volume
libinit.o: libinit.c
    lc -ml -v -d_USEOLDEXEC_ libinit.c
libent.o: libent.a
    asm -u -iinclude: libent.a
```

#### Listing 20: aztecglue.asm (Aztec only)

```
; aztecglue.asm
    This is the actual dispatch routine that will be called.
    It pushes arguments on the stack and then calls our C
    dispatch function, storing the result string in AO.
   public Dispatch
   public _ARLibDispatch
   public _geta4
```

Dispatch:

```
movem.l d2/d3/d4-d7/a2-a6,-(sp) 
jsr _geta4 
subq.l #4,sp 
move.l sp,-(sp) 
move.l a0,-(sp) 
jsr _ARLibDispatch 
addq.l #8,sp 
movea.l (sp)+,a0 
                         ; Create temporary variable 
                        ; Push return pointer 
                        ; Push argument 
                              ; D0 = error code 
                         ; Restore stack 
                        ; Result string 
movem.l (sp)+,d2/d3/d4-d7/a2-a6 
rts 
end
```

#### Listing 21: libsup.c (Aztec only)

```
/* 
 * libsup.c -- Support routines for setting up an ARexx function 
               library, based on the libsup. c file included with Aztec C. 
 * 
 * The changes that have been made to this file are actually quite 
 * minor, though we've renamed MyLibBase to ARLibBase... 
 */ 
#include "arexx.h" 
#include "arexxsyslib.h" 
#include "arexxlib.h" 
#include <exec/resident.h> 
extern void myInit( void ); /* if you change this name, change libstart.asm */ 
LONG ARLibOpen( void ); 
LONG ARLibClose( void ); 
LONG ARLibExpunge( void ); 
#pragma amicall( ARLibBase, 0x06, ARLibOpen() ) 
#pragma amicall( ARLibBase, 0x0c, ARLibClose() ) 
#pragma amicall( ARLibBase, 0x12, ARLibExpunge() ) 
/* library initialization table, used for AUTOINIT libraries */ 
struct InitTable { 
    unsigned long it_DataSize; 
    void **it_FuncTable; 
    void *it_DataInit; 
    void (*it_InitFunc)( 
void *LibFuncTab[] = { 
    ARLibOpen, 
    ARLibClose, 
                                          /* library data space size */ 
                                          /* table of entry points */ 
                                          /* table of data initializers */ 
                                  void ); /* initialization function to run */
```

```
ARLibExpunge, 
    NULL, 
    Dispatch, /* <==== Our dispatch routine */ 
    (void *) -1L 
}; 
struct InitTable myInitTab = { 
    sizeof( struct ARLibBase ), 
    LibFuncTab, 
    0, /* will initialize my data in funkymain() */ 
    myInit 
}; 
#define MYREVISION 1 /* would be nice to auto-increment this */ 
char myname[] = "arexxlib.library"; 
char myid[] = "My ARexx Library 1.0\r\n"; 
extern struct Resident myRomTag; 
 * _main -- Called from myInit when the library is first loaded into memory. 
 */ 
LONG _main( struct ARLibBase *ARLibBase, ULONG seglist ) 
  { 
    ARLibBase->ml_SegList = seglist; 
         ARLibBase->ml_Lib.lib_Node.ln_Type = NT_LIBRARY; 
         ARLibBase->ml_Lib.lib_Node.ln_Name = (char *) myname; 
    ARLibBase->ml_Lib.lib_Flags = LIBF_SUMUSED | LIBF_CHANGED; 
    ARLibBase->ml_Lib.lib_Version = myRomTag.rt_Version; 
         ARLibBase->ml_Lib.lib_Revision = MYREVISION; 
    ARLibBase->ml_Lib.lib_IdString = (APTR) myid; 
  } 
                     /* ARLibOpen -- Increment the library open count and get rid of any 
                delayed expunge flag. 
 */ 
LONG ARLibOpen( void ) 
  { 
    struct ARLibBase *ARLibBase; 
    ARLibBase->ml_Lib.lib_OpenCnt++; 
    ARLibBase->ml_Lib.lib_Flags & = ~BF_DELEXP; 
    return( (LONG) ARLibBase ); 
  }
```

```
* ARLibClose -- Decrement the library open count, and expunge if no 
                 one has it open and the delayed expunge flag is set. 
 */ 
LONG ARLibClose( void ) 
  { 
    struct ARLibBase *ARLibBase; 
    LONG retval = 0; 
    if( --ARLibBase->ml_Lib.lib_OpenCnt == 0 ){ 
        if( ARLibBase->ml_Lib.lib_Flags & LIBF_DELEXP ){ 
            retval = ARLibExpunge(); /* return segment list */ 
        } 
    } 
    return( retval ); 
  } 
/* 
 * ARLibExpunge -- Remove the library if no one is using it, otherwise 
                   mark it for a delayed expunge. 
 */ 
LONG ARLibExpunge( void ) 
  { 
    struct ARLibBase *ARLibBase; 
    unsigned long seglist = 0; 
    long libsize; 
    extern struct Library *DOSBase; 
    if( ARLibBase->ml_Lib.lib_OpenCnt == 0 ){ 
        seglist = ARLibBase->ml_SegList; 
        Remove( &ARLibBase->ml_Lib.lib_Node ); 
        libsize =ARLibBase->ml_Lib.lib_NegSize+ARLibBase->ml_Lib.lib_PosSize; 
       FreeMem( (char *)ARLibBase-ARLibBase->ml_Lib.lib_NegSize, libsize ); 
       CloseLibrary(DOSBase); /* keep the counts even */ 
    } else { 
       ARLibBase->ml_Lib.lib_Flags |= LIBF_DELEXP; } 
   return( (LONG) seglist );
```

#### } Listing 22: makefile (Aztec only)

```
# Sample Aztec C makefile for building an ARexx function library called 
# 'arexxlib.library'.
```

```
.c.o:
    cc $(CFLAGS) -o $@ $*.c
.asm.o:
    as -icc:asm -o $@ $*.asm
# Important: don't change these flags unless you know what you're doing!
# In particular, -sn and -so cause problems...
CFLAGS=-r6 -safmpr
# Add your object files here.
OBJ = libstart.o aztecglue.o libsup.o arexxlib.o
arexxlib.library: $(OBJ)
    ln -o arexxlib.library $(OBJ) -lc
install:
    copy arexxlib.library libs:
    delete arexxlib.library
                      Listing 23: arexxlib.h (SAS and Aztec)
 * arexxlib.h
#ifndef AREXXLIB_H_INCLUDED
#define AREXXLIB_H_INCLUDED
#include <exec/libraries.h>
#ifndef AREXXSYSLIB_H_INCLUDED
#include "arexxsyslib.h"
#endif
typedef struct fl_entry
    char *name;
    int
          min_args;
           max_args;
    LONG (*fp)( struct Library *, struct RexxMsg *, char **);
    fl_entry;
#if defined( AZTEC_C )
```

```
extern LONG ARLibDispatch( struct RexxMsg *msg, char **result_string ); 
    extern LONG Dispatch( struct RexxMsg *msg ); 
    #pragma amicall( ARLibBase, Ox1e, Dispatch( a0 ) ) 
    struct ARLibBase { 
        struct Library ml_Lib; 
        unsigned long ml_SegList; 
        long ml_value; 
    } ; 
#elif defined( LATTICE ) || defined( __SASC ) 
      extern LONG __saveds __stdargs ARLibDispatch( struct RexxMsg *msg, 
                                                      char **blart ); 
#endif 
#endif 
                      Listing 24: arexxlib.c (SAS and Aztec) 
/* 
 * arexxlib.c -- Skeleton code for creating an ARexx function library. 
                 This file is common to both SAS/C and Manx Aztec C. 
 */ 
#include <string.h> 
#include <ctype.h> 
#include "arexx.h" 
#include "arexxsyslib.h" 
#include "arexxlib.h" 
#if defined( LATTICE ) || defined( __SASC ) 
    #define AREXXDISPATCH LONG __saveds __stdargs 
#else 
    #define AREXXDISPATCH LONG 
#endif 
#define NULLCHAR '\0' 
#define PROG_NOT_FOUND ERR10_001 
#define BAD_NUM_ARGS ERR10_017 
#define FUNC_ERR ERR10_012 
static BOOL StrEq( char *a, char *b ); 
static BOOL StrIEq( char *a, char *b ); 
static LONG TestFunc( struct Library *RexxSysBase, struct RexxMsg *msg, 
                      char **result _string )
```

```
{ 
    *result_string = (char *) CreateArgstring( "blart", 5 ); 
    return( RC_OK ); 
  } 
static LONG Test2( struct Library *RexxSysBase, struct RexxMsg *msg, 
                      char **result_string ) 
  { 
    char *str; 
    str = (char *) msg->rm_Args[1]; 
    *result_string = (char *) CreateArgstring( str, strlen( str ) ); 
    return( RC_OK ); 
  } 
fl_entry FunctionList[] = 
  { 
    { "testf", 0, 0, TestFunc }, 
    { "testg", 1, 1, Test2 }, 
    { NULL } 
  }; 
/* 
 * ARLibDispatch -- This is the "query" function for the function library. 
                    It receives a function request in the form of an 
                    RXFUNC message. It returns the return code in D0 
                    and an argstring, if any, in A0. 
 */ 
AREXXDISPATCH ARLibDispatch( struct RexxMsg *msg, char **result_string ) 
  { 
    fl_entry *fl; 
    LONG retval; 
    int nargs; 
    struct Library *RexxSysBase; 
    *result_string = NULL; 
    if( !msg || msg->rm_Action & RXCODEMASK ) != RXFUNC ) 
        return( PROG_NOT_FOUND ); 
    RexxSysBase = (void *) OpenLibrary( (UBYTE *) "rexxsyslib.library", 0L ); 
    if( !RexxSysBase ) 
        return( PROG_NOT_FOUND ); 
   for( fl = FunctionList; fl->name != NULL; ++fl ) 
        if( StrIEq( (char *) msg->rm_Args[0], fl->name ) ) 
            break;
```

```
if( fl ){ 
        nargs = ( msg->rm_Action & RXARGMASK ); 
        if( nargs < fl->min_args || nargs > fl->max_args ) 
            retval = BAD_NUM_ARGS; 
        else 
            retval = fl->fp( RexxSysBase, msg, result_string ); 
    } else { 
        retval = PROG_NOT_FOUND; 
    } 
    /* A function call should always return an argstring if it returns 0 */ 
    if( retval == RC_OK && *result_string == NULL ) 
        *result_string = (char *) CreateArgstring( "", 0 ); 
    CloseLibrary( RexxSysBase ); 
    return( retval ); 
  } 
/* 
 * StrEq -- Returns TRUE if two strings match. 
 */ 
static BOOL StrEq( char *a, char *b ) 
  { 
    return( strcmp( a, b ) == 0 ); 
  } 
/* 
 * StrIEq -- Like StrEq, but case-insensitive. 
 */ 
static BOOL StrIEq( char *a, char *b ) 
  { 
    #ifdef LATTICE 
        return( stricmp( a, b ) == 0 ); 
    #else 
        while( *a != NULLCHAR && *b != NULLCHAR ){ 
            if( tolower( *a ) != tolower( *b ) ) 
                return( FALSE ); 
            ++a;
            ++b;
        } 
        return( *a == *b ); 
    #endif 
  }
```

## **P ART 3**

## Appendices

## **APPENDIX A**

# ARexx Language Quick Reference

ADDRESS [ [symbol | string] [expression] | [VALUE expression] ]

Specifies a host address for sending commands. Can also be used to send a command to a host without changing the current host address.

ARG [template [, template ... ] ]

A shorthand form of PARSE UPPER ARG.

#### BREAK

Exits from the current DO instruction (even if non-iterative) or from within an INTERPRETed string. Compare to LEAVE.

CALL name [ expression [, expression ... ] ]

Invokes an internal or external function. The function name may be a string or a literal symbol. Any expressions that follow are evaluated and passed to the function as its arguments. The value returned by the function is stored in the RESULT variable.

DO [var = expr [TO expr] [BY expr]] [FOR expr] [FOREVER] [WHILE expr | UNTIL expr]

Begins a block of instructions that are to be executed as a group. The block ends with an END instruction.

DROP variable [variable ...]

The specified symbols are reset to their uninitialized states.

ECHO [expression]

A synonym for the **SAY** instruction.

#### **ELSE [;] [conditional statement]**

The alternative conditional branch of an **IF** statement.

#### **END [variable]**

Terminates the range of a **DO** or **SELECT** instruction. The optional variable will be compared to the index variable of the iterative **DO** statement.

#### **EXIT [expression]**

Terminates the ARexx program and returns the result of the expression to the caller.

#### **IF expression THEN [;] [conditional statement]**

Test the given expression and executes the conditional statement if the expression returns 1.

#### **INTERPRET expression**

Evaluates the expression and then executes the resulting string.

#### **ITERATE [variable]**

Terminates the current iteration of a **DO** instruction and begins the next iteration.

#### **LEAVE [variable]**

Terminates the execution of the iterative **DO** instruction. The optional variable can be used to exit from within nested loops.

#### **NOP**

Does nothing. Provided as a placeholder for use with certain instructions.

```
NUMERIC [DIGITS | FUZZ] expression 
NUMERIC FORM [SCIENTIFIC | ENGINEERING]
```

Sets options relating to the current numeric precision and format.

```
OPTIONS CACHE [NO] 
OPTIONS FAILAT [expression | NO] 
OPTIONS PROMPT [expression | NO] 
OPTIONS RESULTS [expression | NO]
```

Sets various internal defaults. The **FAILAT** expression sets the limit at or above which command return codes will be signalled as errors. The **PROMPT** expression provides the prompt to be used with the **PULL** instruction. The **RESULTS** keyword requests result strings from host applications when sent a command. The **CACHE** keyword controls the state of the internal statement cache. The **NO** keyword can be used with all these options to reset the various defaults.

#### **OTHERWISE [;] [conditional statement]**

Specifies the statement to be executed when all the **WHEN** clauses of a **SELECT** instruction have failed.

```
PARSE [UPPER] inputsource [template [, template ... ]]
```

Used to extract one or more substrings from a string and assign them to a variable.

```
PROCEDURE [EXPOSE variable [variable ...]]
```

Used within an internal function to create a new symbol table. All variables altered by the function will not be altered in the caller's environment, except for those that are explictly **EXPOSEd.** 

```
PULL [template [, template ... ]]
```

Shorthand for **PARSE UPPER PULL.** 

#### **PUSH [expression]**

Stacks the expression onto the **STDIN** stream.

#### **QUEUE [expression]**

Like **PUSH,** but queues expressions in a FIFO (first-in, first-out) order.

#### **RETURN [expression]**

Exits a function (or the program if not in a function) and returns the given expression as a result.

#### **SAY [expression]**

The result of the expression is written to the output console with a newline character appended.

#### **SELECT**

Begins a group of **WHEN** instructions that are evaluated in turn until one succeeds. If none succeed, an options **OTHERWISE** instruction is evaluated.

```
SHELL [symbol | string] [expression]
```

A synonym for the **ADDRESS** instruction.

```
SIGNAL [ON | OFF] condition 
SIGNAL [VALUE] expression
```

Controls the state of internal interrupt flags or transfers control to the label given by the expression.

```
THEN [;] [conditional statement]
```

The conditional statement is evaluated if the preceding IF or **WHEN** expression evaluated to **1.** 

```
TRACE [symbol | string | [ [VALUE] expression] ]
```

Sets the internal tracing mode.

```
UPPER variable [variable ...]
```

Converts the given variable values into uppercase.

```
WHEN expression THEN [; ] [conditional statement]
```

Similar to **IF,** but only valid within a **SELECT** instruction. Each **WHEN** expression is evaluated in turn until one of them returns **1,** in which case the conditional statement is evaluated and all other **WHEN** statements are skipped.

## **APPENDIX B**

# ARexx Error Messages

When the ARexx interpreter detects an error in a program, it returns an error code to indicate the nature of the problem. Errors are normally handled by displaying the error code, the source line number where the error occurred, and a brief message explaining the error condition. Unless the SYNTAX interrupt has been previously enabled (using the SIGNAL instruction), the program then terminates and control returns to the caller. Most syntax and execution errors can be trapped by the SYNTAX interrupt, allowing the user to retain control and perform whatever special error processing is required. Certain errors are generated outside of the context of an ARexx program, and therefore cannot be trapped by this mechanism.

Associated with each error code is a *severity level* that is reported to the calling program as the primary result code. The error code itself is returned as the secondary result. The subsequent propagation or reporting of these codes is of course dependent on the external (calling) program.

The following pages list all of the currently-defined error codes, along with the associated severity level and message string.

#### Error: 1 Severity: 5 Message: Program not found

The named program could not be found, or was not an ARexx program. ARexx programs are expected to start with a "/\*" sequence. This error is detected by the external interface and cannot be trapped by the SYNTAX interrupt.

#### Error: 2 Severity: 10 Message: Execution halted

A control-C break or an external halt request was received and the program terminated. This error will be trapped if the HALT interrupt has been enabled.

#### Error: 3 Severity: 20 Message: Insufficient memory

The interpreter was unable to allocate enough memory for an operation. Since memory space is required for all parsing and execution operations, this error cannot usually be trapped by the SYNTAX interrupt.

#### Error: 4 Severity: 10 Message: Invalid character

A non-ASCII character was found in the program. Control codes and other non-ASCII characters may be used in a program by defining them as hex or binary strings. This is a scan phase error and cannot be trapped by the SYNTAX interrupt.

#### Error: 5 Severity: 10 Message: Unmatched quote

A closing single or double quote was missing. Check that each string is properly delimited. This is a scan phase error and cannot be trapped by the SYNTAX interrupt.

#### Error: 6 Severity: 10 Message: Unterminated comment

The closing "\*/" for a comment field was not found. Remember that comments may be nested, so each "/\*" must be matched by a "\*/." This is a scan phase error and cannot be trapped by the SYNTAX interrupt.

#### Error: 7 Severity: 10 Message: Clause too long

A clause was too long for the internal buffer used as temporary storage. The source line in question should be broken into smaller parts. This is a scan phase error and cannot be trapped by the SYNTAX interrupt.

#### Error: 8 Severity: 10 Message: Invalid token

An unrecognized lexical token was found, or a clause could not be properly classified. This is a scan phase error and cannot be trapped by the SYNTAX interrupt.

#### Error: 9 Severity: 10 Message: Symbol or string too long

An attempt was made to create a string longer than the maximum supported by the interpreter.

#### Error: 10 Severity: 10 Message: Invalid message packet

An invalid action code was found in a message packet sent to the ARexx resident process. The packet was returned without being processed. This error is detected by the external interface and cannot be trapped by the SYNTAX interrupt.

#### Error: 11 Severity: 10 Message: Command string error

A command string could not be processed. This error is detected by the external interface and cannot be trapped by the SYNTAX interrupt.

#### Error: 12 Severity: 10 Message: Error return from function

An external function returned a non-zero error code. Check that the correct parameters were supplied to the function.

#### Error: 13 Severity: 10 Message: Host environment not found

The message port corresponding to a host address string could not be found. Check that the required external host is active.

#### Error: 14 Severity: 10 Message: Requested library not found

An attempt was made to open a function library included in the Library List, but the library could not be opened. Check that the correct name and version of the library were specified when the library was added to the resource list.

#### Error: 15 Severity: 10 Message: Function not found

A function was called that could not be found in any of the currently accessible libraries, and could not be located as an external program. Check that the appropriate function libraries have been added to the Libraries List.

**Error: 16 Severity: 10 Message: Function did not return value** 

**A** function was called which failed to return a result string, but did not otherwise report an error. Check that the function was programmed correctly, or invoke it using the **CALL**  instruction.

**Error: 17 Severity: 10 Message: Wrong number of arguments** 

**A** call was made to a function which expected more (or fewer) arguments. This error will be generated if a Built-In or external function is called with more arguments than can be accomodated in the message packet used for external communications.

**Error: 18 Severity: 10 Message: Invalid argument to function** 

An inappropriate argument was supplied to a function, or a required argument was missing. Check the parameter requirements specified for the function.

**Error: 19 Severity: 10 Message: Invalid PROCEDURE** 

**A PROCEDURE** instruction was issued in an invalid context. Either no internal functions were active, or a **PROCEDURE** had already been issued in the current storage environment.

**Error: 20 Severity: 10 Message: Unexpected THEN or WHEN** 

**A WHEN** or **THEN** instruction was executed outside of a valid context. The **WHEN** instruction is valid only within a **SELECT** range, and **THEN** must be the next instruction following an **IF**  or **WHEN.** 

**Error: 21 Severity: 10 Message: Unexpected ELSE or OTHERWISE** 

**An ELSE or OTHERWISE** was found outside of a valid context. The **OTHERWISE** instruction is valid only within a **SELECT** range. **ELSE** is valid only following the **THEN** branch of an **IF**  range.

**Error: 22 Severity: 10 Message: Unexpected BREAK, LEAVE, or ITERATE**  The **BREAK** instruction is valid only within a **DO** range or inside an **INTERPRETed** string. The **LEAVE** and **ITERATE** instructions are valid only within an iterative **DO** range.

**Error: 23 Severity: 10 Message: Invalid statement in SELECT** 

**A** invalid statement was encountered within a **SELECT** range. Only **WHEN, THEN,** and **OTH-ERWISE** statements are valid within a **SELECT** range, except for the conditional statements following **THEN or OTHERWISE** clauses.

**Error: 24 Severity: 10 Message: Missing or multiple THEN** 

An expected **THEN** clause was not found, or another **THEN** was found after one had already been executed.

**Error: 25 Severity: 10** Message: **Missing OTHERWISE** 

None of the **WHEN** clauses in a **SELECT** succeeded, but no **OTHERWISE** clause was supplied.

**Error: 26 Severity: 10 Message: Missing or unexpected END** 

The program source ended before an **END** was found for a **DO** or **SELECT** instruction, or an **END** was encountered outside of a **DO** or **SELECT** range.

**Error: 27 Severity: 10** Message: **Symbol mismatch** 

The symbol specified on an **END, ITERATE,** or **LEAVE** instruction did not match the index variable for the associated **DO** range. Check that the active loops have been nested properly.

#### **Error: 28 Severity: 10 Message: Invalid DO syntax**

An invalid **DO** instruction was executed. An initializer expression must be given if **a TO** or **BY** expression is specified, and **a FOR** expression must yield a non-negative integer result.

#### **Error: 29 Severity: 10 Message: Incomplete IF or SELECT**

**An IF or SELECT** range ended before all of the required statements were found. Check whether the conditional statement following a **THEN, ELSE, or OTHERWISE** clause was omitted.

#### **Error: 30 Severity: 10 Message: Label not found**

**A** label specified by a **SIGNAL** instruction, or implicitly referenced by an enabled interrupt, could not be found in the program source. Labels defined dynamically by an **INTERPRET**  instruction or by interactive input are not included in the search.

#### **Error: 31 Severity: 10 Message: Symbol expected**

**A** non-symbol token was found where only a symbol token is valid. The **DROP, END, LEAVE, ITERATE,** and **UPPER** instructions may only be followed by a symbol token, and will generate this error if anything else is supplied. This message will also be issued if a required symbol is missing.

#### **Error: 32 Severity: 10 Message: Symbol or string expected**

An invalid token was found in a context where only a symbol or string is valid.

#### **Error: 33 Severity: 10 Message: Invalid keyword**

**A** symbol token in an instruction clause was identified as a keyword, but was invalid in the specific context.

#### **Error: 34 Severity: 10 Message: Required keyword missing**

An instruction clause required a specific keyword token to be present, but it was not supplied. For example, this message will be issued if a **SIGNAL ON** instruction is not followed by one of the interrupt keywords (e.g. **SYNTAX.)** 

#### **Error: 35 Severity: 10 Message: Extraneous characters**

A seemingly valid statement was executed, but extra characters were found at the end of the clause.

#### **Error: 36 Severity: 10 Message: Keyword conflict**

Two mutually exclusive keywords were included in an instruction clause, or a keyword was included twice in the same instruction.

#### **Error: 37 Severity: 10 Message: Invalid template**

The template provided with an **ARG, PARSE, or PULL** instruction was not properly constructed.

#### **Error: 38 Severity: 10 Message: Invalid TRACE request**

The alphabetic keyword supplied with **a TRACE** instruction or as the argument to the **TRACE ( )**  Built-In function was not valid.

#### **Error: 39 Severity: 10 Message: Uninitialized variable**

An attempt was made to use an uninitialized variable while the **NOVALUE** interrupt was enabled.

**Error: 40 Severity: 10 Message: Invalid variable name An** attempt was made to assign a value to a fixed symbol.

#### **Error: 41 Severity: 10** Message: **Invalid expression**

An error was detected during the evaluation an expression. Check that each operator has the correct number of operands, and that no extraneous tokens appear in the expression. This error will be detected only in expressions that are actually evaluated. No checking is performed on expressions in clauses that are being skipped.

#### **Error: 42 Severity: 10 Message: Unbalanced parentheses**

An expression was found with an unequal number of opening and closing parentheses.

#### **Error: 43 Severity: 43 Message: Nesting limit exceeded**

The number of subexpressions in an expression was greater than the maximum allowed. The expression should be simplified by breaking it into two or more intermediate expressions.

#### **Error: 44 Severity: 10 Message: Invalid expression result**

The result of an expression was not valid within its context. For example, this message will be issued if an increment or limit expression in a **DO** instruction yields a non-numeric result.

#### **Error: 45 Severity: 10 Message: Expression required**

An expression was omitted in a context where one is required. For example, the **SIGNAL**  instruction, if not followed by the keywords **ON** or **OFF,** must be followed by an expression.

#### **Error: 46 Severity: 10 Message: Boolean value not 0 or 1**

An expression result was expected to yield a Boolean result, but evaluated to something other than 0 or 1.

#### **Error: 47 Severity: 10 Message: Arithmetic conversion error**

A non-numeric operand was used in a operation requiring numeric operands. This message will also be generated by an invalid hex or binary string.

#### **Error: 48 Severity: 10 Message: Invalid operand**

An operand was not valid for the intended operation. This message will be generated if an attempt is made to divide by 0, or if a fractional exponent is used in an exponentiation operation.

## **APPENDIX C**

## Header Files

These are the standard ARexx header files. You'll find them in the rexx subdirectory where your compiler header files are stored. For programs in this book, see also Listing 5 on page 90.

## storage.h

```
#ifndef REXX_STORAGE_H 
#define REXX_STORAGE_H 
/* 
** $Filename: rexx/storage.h $ 
** $Release: 2.0 revision 2$ 
** $Revision: 1.2 $ 
** $Date: 90/07/12 $ 
** 
** Header file to define ARexx data structures. 
** 
** (C) Copyright 1986,1987,1988,1989,1990 William S. Hawes 
** All Rights Reserved 
*/ 
#ifndef EXEC_TYPES_H 
#include "exec/types.h" 
#endif 
#ifndef EXEC_NODES_H 
#include "exec/nodes.h" 
#endif 
#ifndef EXEC_LISTS_H 
#include "exec/lists.h" 
#endif 
#ifndef EXEC_PORTS_H 
#include "exec/ports.h" 
#endif 
#ifndef EXEC_LIBRARIES_H 
#include "exec/libraries.h" 
#endif
```

```
/* The NexxStr structure is used to maintain the internal strings in REXX. 
* It includes the buffer area for the string and associated attributes. 
* This is actually a variable-length structure; it is allocated for a 
* specific length string, and the length is never modified thereafter 
* (since its used for recycling). 
*/ 
struct NexxStr { 
  LONG ns_Ivalue; /* integer value */ 
  UWORD ns_Length; /* length in bytes (excl null) */ 
  UBYTE ns_Flags; /* attribute flags */ 
  UBYTE ns_Hash; /* hash code */ 
  BYTE ns_Buff[6]; /* buffer area for strings */ 
  J; /* size: 16 bytes (minimum) */ 
#define NXADDLEN 9 /* offset plus null byte */ 
#define IVALUE(nsPtr) (nsPtr->ns_Ivalue) 
/* String attribute flag bit definitions */ 
#define NSB_KEEP 0 /* permanent string? */ 
#define NSB_STRING 1 /* string form valid? */ 
#define NSB_NOTNUM 2 /* non-numeric? */ 
#define NSB_NUMBER 3 /* a valid number? */ 
#define NSB_BINARY 4 /* integer value saved? */ 
#define NSB_FLOAT 5 /* floating point format? */ 
#define NSB_EXT 6 /* an external string? */ 
#define NSB_SOURCE 7 /* part of the program source? */ 
/* The flag form of the string attributes */ 
#define NSF_KEEP (1 « NSB_KEEP ) 
#define NSF_STRING (1 « NSB_STRING) 
#define NSF_NOTNUM (1 « NSB_NOTNUM) 
#define NSF_NUMBER (1 « NSB_NUMBER) 
#define NSF_BINARY (1 « NSB_BINARY) 
#define NSF_FLOAT (1 « NSB_FLOAT ) 
#define NSF_EXT (1 « NSB_EXT ) 
#define NSF_SOURCE (1 « NSB_SOURCE) 
/* Combinations of flags */ 
#define NSF_INTNUM (NSF_NUMBER | NSF_BINARY | NSF_STRING) 
#define NSF_DPNUM (NSF_NUMBER | NSF_FLOAT) 
#define NSF_ALPHA (NSF_NOTNUM | NSF_STRING) 
#define NSF_OWNED (NSF_SOURCE | NSF_EXT | NSF_KEEP) 
#define KEEPSTR (NSF_STRING | NSF_SOURCE | NSF_NOTNUM) 
#define KEEPNUM (NSF_STRING | NSF_SOURCE | NSF_NUMBER | NSF_BINARY) 
/* The RexxArg structure is identical to the NexxStr structure, but 
* is allocated from system memory rather than from internal storage. 
* This structure is used for passing arguments to external programs. 
* It is usually passed as an "argstring", a pointer to the string buffer. 
*/
```

```
struct RexxArg {
                                 /* total allocated length
                                                                  */
  LONG ra_Size;
  UWORD ra_Length;
                                  /* length of string
                                                                  */
  UBYTE ra_Flags;
                                  /* attribute flags
                                                                  */
  UBYTE
          ra_Hash;
                                  /* hash code
          ra_Buff[8];
                                  /* buffer area
  BYTE
                                                                  */
  };
                                   /* size: 16 bytes (minimum)
                                                                   */
/* The RexxMsg structure is used for all communications with REXX
 * programs. It is an EXEC message with a parameter block appended.
struct RexxMsg {
  struct Message rm_Node;
                                  /* EXEC message structure
                                  /* global structure (private)
  APTR rm_TaskBlock;
                                                                  */
                                  /* library base (private)
  APTR rm_LibBase;
                                                                  */
                                 /* command (action) code
  LONG rm_Action;
                                                                  */
                                 /* primary result (return code)
  LONG
        rm_Result1;
                                /* secondary result
  LONG rm_Result2;
  STRPTR rm_Args[16];
                                  /* argument block (ARGO-ARG15)
                                                                  */
  struct MsgPort *rm_PassPort; /* forwarding port
  STRPTR rm_CommAddr;
STRPTR rm_FileExt;
                                 /* host address (port name)
                                                                  */
  STRPTR rm_FileExt;
                                 /* file extension
                                                                  */
                                  /* input stream (filehandle)
  LONG
         rm_Stdin;
                                /* output stream (filehandle)
  LONG
          rm_Stdout;
                                                                  */
                                  /* future expansion
          rm_avail;
  LONG
                                   /* size: 128 bytes
  };
/* Field definitions
#define ARGO(rmp) (rmp->rm_Args[0])
                                 /* start of argblock
#define ARG1(rmp) (rmp->rm_Args[1])
                                   /* first argument
                                                                  */
#define ARG2(rmp) (rmp->rm_Args[2])
                                   /* second argument
#define MAXRMARG 15
                                    /* maximum arguments
/* Command (action) codes for message packets
                                                                  */
#define RXCOMM 0x01000000
                                  /* a command-level invocation
                                  /* a function call
#define RXFUNC
                0x02000000
                                                                  */
#define RXCLOSE 0x03000000
                                  /* close the REXX server
                                                                  */
#define RXQUERY 0x04000000
                                  /* query for information
                                                                  */
#define RXADDFH 0x07000000
                                 /* add a function host
                                                                  */
#define RXADDLIB 0x08000000
                                  /* add a function library
                                                                  */
#define RXREMLIB 0x09000000
                                 /* remove a function library
#define RXADDCON OxOAO00000
                                  /* add/update a ClipList string */
                                 /* remove a ClipList string
#define RXREMCON OxOBO00000
                                                                  */
                                  /* open the trace console
#define RXTCOPN 0x0C000000
                                /* close the trace console
#define RXTCCLS 0x0D000000
                                                                  */
/* Command modifier flag bits
#define RXFB_NOIO 16
                                   /* suppress I/O inheritance?
```

```
#define RXFB_RESULT 17 /* result string expected? */ 
#define RXFB_STRING 18 /* program is a "string file"? */ 
#define RXFB_TOKEN 19 /* tokenize the command line? */ 
#define RXFB_NONRET 20 /* a "no-return" message? */ 
/* The flag form of the command modifiers */ 
#define RXFF_NOIO (1L << RXFB_NOIO ) 
#define RXFF_RESULT (1L << RXFB_RESULT) 
#define RXFF_STRING (1L << RXFB_STRING) 
#define RXFF_TOKEN (1L << RXFB_TOKEN ) 
#define RXFF_NONRET (1L << RXFB_NONRET) 
#define RXCODEMASK 0xFFO00000 
#define RXARGMASK 0x000000OF 
/* The RexxRsrc structure is used to manage global resources. Each node 
* has a name string created as a RexxArg structure, and the total size 
* of the node is saved in the "rr_Size" field. The REXX systems library 
* provides functions to allocate and release resource nodes. If special 
* deletion operations are required, an offset and base can be provided in 
* "rr_Func" and "rr_Base", respectively. This "autodelete" function will 
* be called with the base in register A6 and the node in A0. 
*/ 
struct RexxRsrc { 
  struct Node rr_Node; 
  WORD rr_Func; /* "auto-delete" offset */ 
  APTR rr_Base; /* "auto-delete" base */ 
  LONG rr_Size; /* total size of node */ 
  LONG rr_Arg1; /* available ... */ 
  LONG rr_Arg2; /* available ... */ 
  }; /* size: 32 bytes */ 
/* Resource node types */ 
#define RRT_ANY 0 /* any node type ... */ 
#define RRT_LIB 1 /* a function library */ 
#define RRT_PORT 2 /* a public port */ 
#define RRT_FILE 3 /* a file IoBuff */ 
#define RRT_HOST 4 /* a function host */ 
#define RRT_CLIP 5 /* a Clip List node */ 
/* The RexxTask structure holds the fields used by REXX to communicate with 
* external processes, including the client task. It includes the global 
* data structure (and the base environment). The structure is passed to 
* the newly-created task in its "wake-up" message. 
*/ 
#define GLOBALSZ 200 /* total size of GlobalData */ 
struct RexxTask { 
  BYTE rt_Global[GLOBALSZ]; /* global data structure */ 
  struct MsgPort rt_MsgPort; /* global message port */
```

```
UBYTE rt_Flags; It task flag bits */ 
 BYTE rt_SigBit; It signal bit */ 
 APTR rt_ClientID; /* the client's task ID */ 
 APTR rt_MsgPkt; It the packet being processed */ 
 APTR rt_TaskID; /* our task ID */ 
 APTR rt_RexxPort; /* the REXX public port */ 
 APTR rt_ErrTrap; It Error trap address */ 
 APTR rt_StackPtr; /* stack pointer for traps */ 
 struct List rt_Header1; /* Environment list */ 
  struct List rt_Header2; It Memory freelist */ 
  struct List rt_Header3; /* Memory allocation list */ 
  struct List rt_Header4; It Files list */ 
  struct List rt_Header5; It Message Ports List */ 
  }; 
/* Definitions for RexxTask flag bits */ 
#define RTFB_TRACE 0 /* external trace flag */ 
#define RTFB_HALT 1 /* external halt flag */ 
#define RTFB_SUSP 2 It suspend task? */ 
#define RTFB_TCUSE 3 It trace console in use? */ 
#define RTFB_WAIT 6 /* waiting for reply? */ 
#define RTFB_CLOSE 7 It task completed? */ 
/* Definitions for memory allocation constants */ 
#define MEMQUANT 16L It quantum of memory space */ 
#define MEMMASK OxFFFFFFF0 It mask for rounding the size */ 
#define MEMQUICK (1L << 0 ) It EXEC flags: MEMF_PUBLIC */ 
#define MEMCLEAR (1L << 16) It EXEC flags: MEMF_CLEAR */ 
It The SrcNode is a temporary structure used to hold values destined for 
* a segment array. It is also used to maintain the memory freelist. 
*/ 
struct SrcNode { 
 struct SrcNode *sn_Succ; /* next node */ 
 struct SrcNode *sn_Pred; It previous node */ 
 APTR sn_Ptr; /* pointer value */ 
 LONG sn_Size; It size of object */ 
 }; /* size: 16 bytes */
```

## **errors.h**

#endif

```
#ifndef REXX_ERRORS_H 
#define REXX_ERRORS_H /*
```

```
** $Filename: rexx/errors.h $ 
** $Release: 2.0 revision 2$ 
** $Revision: 1.2 $ 
** $Date: 90/07/12 $ 
** 
** Definitions for ARexx error codes 
** 
** (C) Copyright 1987,1988,1989,1990 William S. Hawes 
** All Rights Reserved 
*/ 
#define ERRC_MSG 0 /* error code offset */ 
#define ERR10_001 (ERRC_MSG+1) /* program not found */ 
#define ERR10_002 (ERRC_MSG+2) /* execution halted */ 
#define ERR10_003 (ERRC_MSG+3) /* no memory available */ 
#define ERR10_004 (ERRC_14SG+4) /* invalid character in program*/ 
#define ERR10_005 (ERRC_MSG+5) /* unmatched quote */ 
#define ERR10_006 (ERRC_MSG+6) /* unterminated comment */ 
#define ERR10_007 (ERRC_MSG+7) /* clause too long */ 
#define ERR10_008 (ERRC_MSG+8) /* unrecognized token */ 
#define ERR10_009 (ERRC_MSG+9) /* symbol or string too long */ 
#define ERR10_010 (ERRC_MSG+10) /* invalid message packet */ 
#define ERR10_011 (ERRC_MSG+11) /* command string error */ 
#define ERR10_012 (ERRC_MSG+12) /* error return from function */ 
#define ERR10_013 (ERRC_MSG+13) /* host environment not found */ 
#define ERR10_014 (ERRC_MSG+14) /* required library not found */ 
#define ERR10_015 (ERRC_MSG+15) /* function not found */ 
#define ERR10_016 (ERRC_MSG+16) /* no return value */ 
#define ERR10_017 (ERRC_MSG+17) /* wrong number of arguments */ 
#define ERR10_018 (ERRC_MSG+18) /* invalid argument to function*/ 
#define ERR10_019 (ERRC_MSG+19) /* invalid PROCEDURE */ 
#define ERR10_020 (ERRC_MSG+20) /* unexpected THEN/ELSE */ 
#define ERR10_021 (ERRC_MSG+21) /* unexpected WHEN/OTHERWISE */ 
#define ERR10_022 (ERRC_MSG+22) /* unexpected LEAVE or ITERATE */ 
#define ERR10_023 (ERRC_MSG+23) /* invalid statement in SELECT */ 
#define ERR10_024 (ERRC_MSG+24) /* missing THEN clauses */ 
#define ERR10_025 (ERRC_MSG+25) /* missing OTHERWISE */ 
#define ERR10_026 (ERRC_MSG+26) /* missing or unexpected END */ 
#define ERR10_027 (ERRC_MSG+27) /* symbol mismatch on END */ 
#define ERR10_028 (ERRC_MSG+28) /* invalid DO syntax */ 
#define ERR10_029 (ERRC_MSG+29) /* incomplete DO/IF/SELECT */ 
#define ERR10_030 (ERRC_MSG+30) /* label not found */ 
#define ERR10_031 (ERRC_MSG+31) /* symbol expected */ 
#define ERR10_032 (ERRC_MSG+32) /* string or symbol expected */ 
#define ERR10_033 (ERRC_MSG+33) /* invalid sub-keyword */ 
#define ERR10_034 (ERRC_MSG+34) /* required keyword missing */ 
#define ERR10_035 (ERRC_MSG+35) /* extraneous characters */ 
#define ERR10_036 (ERRC_MSG+36) /* sub-keyword conflict */ 
#define ERR10_037 (ERRC_MSG+37) /* invalid template */
```

```
#define ERR10_038 (ERRC_MSG+38) /* invalid TRACE request */ 
#define ERR10_039 (ERRC_MSG+39) /* uninitialized variable */ 
#define ERR10_040 (ERRC_MSG+40) /* invalid variable name */ 
#define ERR10_041 (ERRC_MSG+41) /* invalid expression */ 
#define ERR10_042 (ERRC_MSG+42) /* unbalanced parentheses */ 
#define ERR10_043 (ERRC_MSG+43) /* nesting level exceeded */ 
#define ERR10_044 (ERRC_MSG+44) /* invalid expression result */ 
#define ERR10_045 (ERRC_MSG+45) /* expression required */ 
#define ERR10_046 (ERRC_MSG+46) /* boolean value not 0 or 1 */ 
#define ERR10_047 (ERRC_(SG+47) /* arithmetic conversion error */ 
#define ERR10_048 (ERRC_MSG+48) /* invalid operand */ 
/* 
* Return Codes for general use 
*/ 
#define RC_OK 0L /* success */ 
#define RC_WARN 5L /* warning only */ 
#define RC_ERROR 10L /* something's wrong */ 
#define RC_FATAL 20L /* complete or severe failure */ 
#endif
```

## rxslib.h

```
#ifndef REXX_RXSLIB_H 
#define REXX_RXSLIB_H 
/* 
** $Filename: rexx/rxslib.h $ 
** $Release: 2.0 revision 2$ 
** $Revision: 1.3 $ 
** $Date: 90/07/12 $ 
** 
** The header file for the REXX Systems Library 
** 
** (C) Copyright 1987,1988,1989,1990 William S. Hawes 
** All Rights Reserved 
*/ 
#ifndef REXX_STORAGE_H 
#include "rexx/storage.h" 
#endif 
#define RXSNAME "rexxsyslib.library" 
#define RXSDIR "REXX" 
#define RXSTNAME "ARexx" 
/* The REXX systems library structure. This should be considered as */ 
/* semi-private and read-only, except for documented exceptions. */ 
struct RxsLib {
```

```
struct Library rl_Node; /* EXEC library node */ 
 UBYTE rl_Flags; /* global flags */ 
 UBYTE rl_Shadow; /* shadow flags */ 
 APTR rl_SysBase; /* EXEC library base */ 
 APTR rl_DOSBase; /* DOS library base */ 
 APTR rl_IeeeDPBase; /* IEEE DP math library base */ 
 LONG rl_SegList; /* library seglist */ 
 LONG rl_NIL; /* global NIL: filehandle */ 
 LONG rl_Chunk; /* allocation quantum */ 
 LONG rl_MaxNest; /* maximum expression nesting */ 
 struct NexxStr *rl_NULL; /* static string: NULL */ 
 struct NexxStr *rl_FALSE; /* static string: FALSE */ 
 struct NexxStr *rl_TRUE; /* static string: TRUE */ 
 struct NexxStr *rl_REXX; /* static string: REXX */ 
 struct NexxStr *rl_COMMAND; /* static string: COMMAND */ 
 struct NexxStr *rl_STDIN; /* static string: STDIN */ 
 struct NexxStr *rl_STDOUT; /* static string: STDOUT */ 
 struct NexxStr *rl_STDERR; /* static string: STDERR */ 
 STRPTR rl_Version; /* version string */ 
 STRPTR rl_TaskName; /* name string for tasks */ 
 LONG rl_TaskPri; /* starting priority */ 
 LONG rl_TaskSeg; /* startup seglist */ 
 LONG rl_StackSize; /* stack size */ 
 STRPTR rl_RexxDir; /* REXX directory */ 
 STRPTR rl_CTABLE; /* character attribute table */ 
 STRPTR rl_Notice; /* copyright notice */ 
 struct MsgPort rl_RexxPort; /* REXX public port */ 
 UWORD rl_ReadLock; /* lock count */ 
 LONG rl_TraceFH; /* global trace console */ 
 struct List rl_TaskList; /* REXX task list */ 
 WORD rl_NumTask; /* task count */ 
  struct List rl_LibList; /* Library List header */ 
 WORD rl_NumLib; /* library count */ 
 struct List rl_ClipList; /* ClipList header */ 
 WORD rl_NumClip; /* clip node count */ 
 struct List rl_MsgList; /* pending messages */ 
 WORD rl_NumMsg; /* pending count */ 
 struct List rl_PgmList; /* cached programs */ 
 WORD rl_NumPgm; /* program count */ 
 UWORD rl_TraceCnt; /* usage count for trace console */ 
 WORD rl_avail; 
 }; 
/* Global flag bit definitions for RexxMaster */ 
#define RLFB_TRACE RTFB_TRACE /* interactive tracing? */ 
#define RLFB_HALT RTFB_HALT /* halt execution? */ 
#define RLFB_SUSP RTFB_SUSP /* suspend execution? */ 
#define RLFB_STOP 6 /* deny further invocations */ 
#define RLFB_CLOSE 7 /* close the master */
```

```
#define RLFMASK (1<<RLFB_TRACE) | (1<<RLFB_HALT) | (1<<RLFB_SUSP) 
/* Initialization constants */ 
#define RXSCHUNK 1024 /* allocation quantum */ 
#define RXSNEST 32 /* expression nesting limit */ 
#define RXSTPRI 0 /* task priority */ 
#define RXSSTACK 4096 /* stack size */ 
/* Character attribute flag bits used in REXX. */ 
#define CTB_SPACE 0 /* white space characters */ 
#define CTB_DIGIT 1 /* decimal digits 0-9 */ 
#define CTB_ALPHA 2 /* alphabetic characters */ 
#define CTB_REXXSYM 3 /* REXX symbol characters */ 
#define CTB_REXXOPR 4 /* REXX operator characters */ 
#define CTB_REXXSPC 5 /* REXX special symbols */ 
#define CTB_UPPER 6 /* UPPERCASE alphabetic */ 
#define CTB_LOWER 7 /* lowercase alphabetic */ 
/* Attribute flags */ 
#define CTF_SPACE (1 << CTB_SPACE) 
#define CTF_DIGIT (1 << CTB_DIGIT) 
#define CTF_ALPHA (1 << CTB_ALPHA) 
#define CTF_REXXSYM (1 << CTB_REXXSYM) 
#define CTF_REXXOPR (1 << CTB_REXXOPR) 
#define CTF_REXXSPC (1 << CTB_REXXSPC) 
#define CTF_UPPER (1 << CTB_UPPER) 
#define CTF_LOWER (1 << CTB_LOWER) 
#endif
```

## rexxio.h

```
#ifndef REXX_REXXIO_H 
#define REXX_REXXIO_H 
/* 
** $Filename: rexx/rexxio.h $ 
** $Release: 2.0 revision 2$ 
** $Revision: 1.2 $ 
** $Date: 90/07/12 $ 
** 
** Header file for ARexx Input/Output related structures 
** 
** (C) Copyright 1986,1987,1988,1989,1990 William S. Hawes 
** All Rights Reserved 
*/ 
#ifndef REXX_STORAGE_H 
#include "rexx/storage.h" 
#endif
```

/\*

```
#define RXBUFFSZ 204
                                        /* buffer length
                                                                                */
 * The IoBuff is a resource node used to maintain the File List. Nodes
 * are allocated and linked into the list whenever a file is opened.
struct IoBuff {
  ruct IoBuff {
  struct RexxRsrc iobNode;                                    
                                                                               */
/* Access mode definitions
#define RXIO_EXIST -1
                                        /* an external filehandle
                                                                           */
                               /* a "string file" */
/* read-only access */
/* write mode */
/* append mode (existing file) */
#define RXIO_STRF 0
#define RXIO_READ 1
#define RXIO_WRITE 2
#define RXIO_APPEND 3
/*
* Offset anchors for SeekF()
                                   /* relative to start */
/* relative to current position */
/* relative to end */
#define RXIO_BEGIN -1L
#define RXIO_CURR OL
#define RXIO_END
                      1L
/* The Library List contains just plain resource nodes.
                                                                                                   */
#define LLOFFSET(rrp) (rrp->rr_Arg1) /* "Query" offset
#define LLVERS(rrp) (rrp->rr_Arg2) /* library version
                                                                                */
/*
 * The RexxClipNode structure is used to maintain the Clip List. The value
* string is stored as an argstring in the rr_Arg1 field.
#define CLVALUE(rrp) ((STRPTR) rrp->rr_Arg1)
 * A message port structure, maintained as a resource node. The ReplyList
* holds packets that have been received but haven't been replied.
struct RexxMsgPort {
   struct RexxRsrc rmp_Node; /* linkage node */
struct MsgPort rmp_Port; /* the message port */
struct List rmp_ReplyList; /* messages awaiting reply */
   };
```

```
* DOS Device types 
*/ 
#define DT_DEV 0L /* a device */ 
#define DT_DIR 1L /* an ASSIGNed directory */ 
#define DT_VOL 2L /* a volume */ 
/* 
* Private DOS packet types 
*/ 
#define ACTION_STACK 2002L /* stack a line */ 
#define ACTION_QUEUE 2003L /* queue a line */ 
#endif
```

## Bibliography

- [1] John Thomas Berry. *Inside the Amiga.* Howard W. Sams & Co., Indianapolis, IN, U.S.A., 1986.
- [2] Commodore-Amiga, Inc.. The *AmigaDOS* Manual. Bantam Books, New York, NY, U.S.A., 1987.
- [3] Commodore Business Machines, Inc.. *Amiga* ROM Kernel *Reference Manual: Libraries.*  Addison-Wesley, Reading, Massachusetts, U.S.A., 1991.
- [4] Commodore Business Machines, Inc.. Amiga *User Interface* Style *Guide.* Addison-Wesley, Reading, Massachusetts, U.S.A., 1991.
- [5] M. F. Cowlishaw. The REXX Language: A *Practical Approach to Programming.*  Prentice-Hall, Englewood Cliffs, New Jersey, U.S.A., 1985.
- [6] William S. Hawes. ARexx *User's* Reference Manual. Wishful Thinking Development Corporation, Maynard, MA, U.S.A., 1987.
- [7] Robert A. Peck. *Programmer's Guide* to the Amiga. SYBEX, San Francisco, CA, U.S.A., 1987.

## Index

| A                                        | use of, 11, 69, 70                         |  |
|------------------------------------------|--------------------------------------------|--|
| ABBREV() built-in function, 20           | validity, 71                               |  |
| ABS() built-in function, 20              | ADDRESS() built-in function, 21            |  |
| action code, see action flags            | ALLOCMEM() support function, 22            |  |
| action flags, see also RexxMsg structure | Amiga<br>reference books, 2                |  |
| RXADDCON, 112                            | AREXX                                      |  |
| RXADDFH, 111                             | port name, 12, 22, 105, 108, 109           |  |
| RXADDLIB, 111                            | ARexx                                      |  |
| RXARGMASK, 109, 110                      | support library, see support library       |  |
| RXCODEMASK, 98                           | ARexx context, see SimpleRexx              |  |
| RXCOMM, 96, 98, 106, 107, 109, 110,      | ARexx port, see also port                  |  |
| 112, 113, 133                            | creating, 93, 127, 129                     |  |
| RXFF_NOIO, 105, 130, 133                 | definition, 11                             |  |
| RXFF_NONRET, 106                         | example, 13                                |  |
| RXFF_RESULT, 97, 106, 108, 110, 112,     | naming, 93, 151                            |  |
| 130, 132, 133, 152, 157                  | removing, 94, 129                          |  |
| RXFF_STRING, 106, 107, 109, 130, 133     | ARexx system library, see system library   |  |
| RXFF_TOKEN, 106, 133                     | arexx.h header file, 3, 5                  |  |
| RXFUNC, 105, 109, 110, 130, 157          | ARexxBase() SimpleRexx function, 128       |  |
| RXFUNC, 113                              | ARexxFree(), 127                           |  |
| RXREMCON, 112                            | ARexxFree() SimpleRexx function, 129       |  |
| RXREMLIB, 112                            | ARexxInit(), 127                           |  |
| RXTCCLS, 112                             | ARexxInit() SimpleRexx function, 129       |  |
| RXTCOPN, 112                             | ARexxName() SimpleRexx function, 130       |  |
| active interface, 95, 105, 115           | ARexxSignal() SimpleRexx function, 130     |  |
| AddFuncHost<br>SimpleRexx function, 128  | arexxsyslib h header file, 83, 86, 90, 128 |  |
| ADDLIB                                   |                                            |  |
| use of, 12, 13, 17                       | ARG() built-in function, 23                |  |
| ADDLIB() built-in function, 21           | argstring, see RexxArg structure           |  |
| ADDRESS, see also commands, host ad      | argument parsing, 106                      |  |
| dress                                    |                                            |  |
| case-sensitivity, 70                     | B                                          |  |
| COMMAND, 70, 71                          |                                            |  |
| message structure, see RexxMsg struc     | B2C() built-in function, 24                |  |
| ture                                     | BADDR() support function, 23               |  |
| syntax, 70                               | BITAND() built-in function, 24             |  |
|                                          | BITCHG() built-in function, 24             |  |

| BITCLR() built-in function, 25          | COMPARE() built-in function, 29        |
|-----------------------------------------|----------------------------------------|
| BITCOMP() built-in function, 25         | compilers                              |
| BITOR() built-in function, 26           | supported, 3                           |
| BITSET() built-in function, 26          | COMPRESS() built-in function, 30       |
| BITTST() built-in function, 26          | CON:, see console                      |
| BITXOR() built-in function, 27          | console                                |
| built-in functions, see functions       | ARexx instructions, 77                 |
|                                         | definition, 77                         |
|                                         | inheritance, 78, 108                   |
| C                                       | redirection, 77                        |
|                                         | setting new handler, 48                |
| C programming language                  | STDERR, 78                             |
| required skills, 2                      | STDIN, 78                              |
| supported compilers, 3                  | STDOUT, 78                             |
| C2B () built-in function, 27            | streams, 77                            |
| C2D() built-in function, 27             | console device, see console            |
| C2X() built-in function, 28             | COPIES() built-in function, 30         |
| CallARexxFunc(), 127                    |                                        |
| CallARexxFunc() SimpleRexx function,    | Cowlishaw, 1, 17                       |
| 130                                     | CreateArgstring, see RexxArg structure |
| case-sensitivity                        | CreateArgstring() system library func  |
| of commands, 75                         | tion, 86                               |
| of host addresses, 70                   | CreateRexxMsg, see RexxMsg structure   |
| CENTER() built-in function, 28          | CreateRexxMsg() system library func    |
| CENTRE() built-in function, 28          | tion, 87                               |
| CheckRexxMsg() RVI function, 114        | current directory, 48                  |
| ClearRexxMsg() system library function, | current host, 71                       |
| 86                                      |                                        |
| Clip List                               | D                                      |
| definition, 13                          |                                        |
| GETCLIP function, 39                    | D2C() built-in function, 30            |
| modifying directly, 39, 112             | D2X() built-in function, 31            |
| SETCLIP function, 53                    | data structures                        |
|                                         | RexxArg, 84                            |
| sharing data, 13, 53, 74                |                                        |
| CLOSE () built-in function, 28          | RexxMsg, 84, 96, 113, 130, 131, 157    |
| CLOSEPORT() support function, 29        | DATATYPE() built-in function, 31       |
| commands                                | DATE() built-in function, 32           |
| address, see host address               | debugging                              |
| AmigaDOS, 71                            | an ARexx program, 74                   |
| case-sensitivity, 75                    | command inhibition, 74                 |
| dangers of variable substitution, 75    | with SAY instruction, 74               |
| definition, 69                          | DELAY() support function, 32           |
| embedded spaces, 75                     | DELETE() support function, 33          |
| inhibition, 74                          | DeleteArgstring, see RexxArg structure |
| interpretation, 96                      | DeleteArgstring() system library func  |
| results, 73, 97, 110                    | tion, 87                               |
| search order, 111                       | DeleteRexxMsg, see RexxMsg structure   |
| sending from ARexx, 72, 104             | DeleteRexxMsg() system library func    |
| standards, 151                          | tion, 87                               |
| starting a program, 106                 | DELSTR() built-in function, 33         |
| string quoting, 74                      | DELWORD() built-in function, 33        |
|                                         | DIGITS() built-in function, 34         |
| supported by an application, 73, 96,    |                                        |
| 151, 153                                | dispatch point, see function library   |

| DROP instruction, 75                    | calling conventions, 173        |
|-----------------------------------------|---------------------------------|
|                                         | definition, 12                  |
|                                         | dispatch point, 173             |
| E                                       | implementation, 171             |
|                                         | naming, 155                     |
| ECHO instruction, 78                    | removing from Library List, 112 |
| EOF() built-in function, 34             | search order, 18, 157           |
| error constants, 83                     | support library, 17             |
| error standards, 151                    | functions                       |
| errors .h header file, 83, 97           | built-in                        |
| ERRORTEXT() built-in function, 35       |                                 |
| Exec                                    | ABBREV(), 20                    |
| description, 9                          | ABS(), 20                       |
| reference book, 9                       | ADDLIB(), 21                    |
| EXISTS() built-in function, 35          | ADDRESS(), 21                   |
| EXPORT() built-in function, 35          | ARG(), 23                       |
| extension fields, see RexxMsg structure | B2C(), 24                       |
| external functions, see functions       | BITAND(), 24                    |
|                                         | BITCHG (), 24                   |
|                                         | BITCLR(), 25                    |
| F                                       | BITCOMP(), 25                   |
|                                         | BITOR(), 26                     |
| file manipulation                       | BITSET(), 26                    |
| closing, 28                             | BITTST(), 26                    |
| deleting, 33                            | BITXOR(), 27                    |
| directory creation, 43                  | C2B(), 27                       |
| end-of-file, 34                         | C2D(), 27                       |
| exists, 35                              | C2x(), 28                       |
| file information, 57                    | CENTER(), 28                    |
| opening, 45                             | CENTRE(), 28                    |
| reading, 50                             | CLOSE(), 28                     |
| renaming, 51                            | COMPARE(), 29                   |
| seeking, 53                             |                                 |
| writing, 65, 66                         | COMPRESS(), 30                  |
| FillRexxMsg() system library function,  | COPIES(), 30                    |
| 88                                      | D2C(), 30                       |
|                                         | D2X(), 31                       |
| FIND() built-in function, 36            | DATATYPE(), 31                  |
| FORBID() support function, 36           | DATE(), 32                      |
| FORM() built-in function, 37            | DELSTR(), 33                    |
| FreeARexxMsg(), 127                     | DELWORD(), 33                   |
| FreeARexxMsg() SimpleRexx function,     | DIGITS(), 34                    |
| 131                                     | 34<br>EOF(),                    |
| FREEMEM() support function, 37          | ERRORTEXT(), 35                 |
| FREESPACE() built-in function, 37       | EXISTS(), 35                    |
| function host                           | EXPORT(), 35                    |
| adding to Library List, 111             | FIND(), 36                      |
| definition, 12, 157                     | FORM(), 37                      |
| implementation, 157                     | FREESPACE(), 37                 |
| naming, 155                             | FUZZ (), 38                     |
| removing from Library List, 112         | GETCLIP(), 39                   |
| search order, 18, 157                   |                                 |
| skeleton, 159                           | GETSPACE(), 40                  |
| function library                        | HASH(), 40<br>IMPORT(),41       |
| adding to Library List, 111             |                                 |
|                                         |                                 |

| INDEX(), 41         | Set RexxVar (), 115                  |
|---------------------|--------------------------------------|
| INSERT(), 41        | search order, 18, 111, 157           |
| LASTPOS (), 42      | starting new programs, 109           |
| LEFT(), 42          | support                              |
| LENGTH(), 43        | ALLOCMEM(), 22                       |
| LINES(), 43         | BADDR(), 23                          |
| MAX(), 44           | CLOSEPORT(), 29                      |
| MIN(), 44           | DELAY(), 32                          |
| OPEN(), 45          | DELETE(), 33                         |
| OVERLAY(), 46       | FORBID(), 36                         |
| POS(), 47           | FREEMEM(), 37                        |
| PRAGMA(), 48        | GETARG(), 38                         |
| RANDOM(), 49        | GETPKT(), 39                         |
| RANDU(), 49         | MAKEDIR(), 43                        |
| READCH(), 50        |                                      |
| READLN(), 50        | NEXT(), 44                           |
| REMLIB(), 51        | NULL(), 45                           |
|                     | OFFSET(), 45                         |
| REVERSE(), 52       | OPENPORT(), 46                       |
| RIGHT(), 52         | PERMIT(), 47                         |
| SEEK(), 53          | RENAME(), 51                         |
| SETCLIP (), 53      | REPLY(), 51                          |
| SHOW(), 54          | SHOWDIR(), 54                        |
| SIGN(), 55          | SHOWLIST(), 55                       |
| SOURCELINE(), 56    | 57<br>STATEF() ,                     |
| SPACE(), 56         | WAITPKT(), 63                        |
| STORAGE(), 57       | FUZZ() built-in function, 38         |
| STRIP(), 58         |                                      |
| SUBSTR(), 58        |                                      |
| SUBWORD(), 59       | G                                    |
| SYMBOL(), 59        |                                      |
| TIME(), 59          | GetARexxMsg(), 127                   |
| TRACE(), 60         | GetARexxMsg() SimpleRexx function,   |
| TRANSLATE(), 61     | 131                                  |
| TRIM(), 62          | GETARG () support function, 38       |
| TRUNC (), 62        | GETCLIP                              |
| UPPER(), 62         | use of, 13, 74                       |
| VALUE(), 63         | GETCLIP() built-in function, 39      |
| VERIFY(), 63        | GETPKT() support function, 39        |
| WORD(), 64          | Get RexxVar () RVI function, 114     |
|                     | GETSPACE() built-in function, 40     |
| WORDINDEX(), 64     |                                      |
| WORDLENGTH(), 65    |                                      |
| WORDS(), 65         | H                                    |
| WRITECH(), 65       |                                      |
| WRITELN(), 66       | HASH() built-in function, 40         |
| X2C(), 66           | host address, 21, 69                 |
| X2D(), 66           | case-sensitivity, 70                 |
| XRANGE(), 67        | validity, 71                         |
| external, 109       | host application                     |
| matching, 19        | definition, 11, 69                   |
| RVI                 | host name, see ADDRESS, host address |
| CheckRexxMsg(), 114 | host-to-host communication, 112      |
| GetRexxVar(), 114   |                                      |

| I                                        | message, see also RexxMsg structure    |
|------------------------------------------|----------------------------------------|
|                                          | definition, 10                         |
| ID<br>of an ARexx program, 48            | private data, 96                       |
| IMPORT() built-in function, 41           | receiving, 95                          |
| index you're reading it                  | sending, 95, 104                       |
| , 105                                    | message port, see port                 |
| INDEX() built-in function, 41            | MIN() built-in function, 44            |
| inheritance                              | modifier flags, see action flags       |
| of console, see console                  | multiple result strings, see RVI       |
| input stream, see console                | multitasking, see task                 |
| input/output, see console, file manipula |                                        |
| tion                                     | N                                      |
| INSERT() built-in function, 41           |                                        |
| inter-process communication              | NEWCON:, see console                   |
| definition, 10                           | NEXT() support function, 44            |
| host-to-host, 112                        | NULL() support function, 45            |
| internal functions, see functions        |                                        |
| IPC, see inter-process communication     | 0                                      |
| IsARexxReply() SimpleRexx function,      |                                        |
| 131                                      | OFFSET() support function, 45          |
| IsRexxMsg() system library function, 88  | OPEN() built-in function, 45           |
|                                          | OPENPORT() support function, 46        |
|                                          | OPTIONS FAILAT, 97                     |
| L                                        | OPTIONS RESULTS, 73, 97, 152           |
|                                          | output stream, see console             |
| LASTPOS() built-in function, 42          | OVERLAY() built-in function, 46        |
| LEFT() built-in function, 42             |                                        |
| LENGTH() built-in function, 43           | P                                      |
| LengthArgstring, see RexxArg structure   |                                        |
| LengthArgstring() system library func    | passive interface, 95, 99, 105         |
| tion, 88                                 | PERMIT() support function, 47          |
| Library List                             | port, see also ARexx port              |
| ADDLIB function, 21                      | definition, 10                         |
| definition, 13                           | from ARexx                             |
| modifying directly, 111, 112             | closing, 29                            |
| REMLIB function, 51                      | getting message, 39                    |
| search order, 18, 155, 157               | opening, 46                            |
| Library structure, 82                    | replying, 51                           |
| LINES() built-in function, 43            | waiting for a message, 63              |
|                                          | message description, see RexxMsg struc |
| M                                        | ture                                   |
|                                          | POS() built-in function, 47            |
| macro                                    | pragma                                 |
| definition, 1, 69                        | definition, 83                         |
| example, 13                              | in SimpleRexx, 128                     |
| MAKEDIR() support function, 43           | use of, 83                             |
| MAX() built-in function, 44              | PRAGMA() built-in function, 48         |
| memory functions                         | priority                               |
| allocation, 22, 40                       | of a task, 9                           |
| available memory, 57                     | of an ARexx program, 48                |
| copying, 35, 41, 57                      | PULL instruction, 77, 78               |
| freeing, 37                              | PUSH instruction, 78                   |
|                                          |                                        |

| Q                                          | stored in RESULT, 73, 96, 97, 152        |
|--------------------------------------------|------------------------------------------|
|                                            | results, see commands                    |
| query function, see dispatch point         | return code, see also commands, see also |
| QUEUE instruction, 78                      | RexxMsg structure                        |
| quoting conventions, see commands          | definition, 73                           |
|                                            | from result string, 110                  |
| R                                          | meaning, 73, 97                          |
|                                            | setting, 97                              |
| RANDOM() built-in function, 49             | stored in RC, 73, 96, 97, 151            |
| RANDU() built-in function, 49              | REVERSE() built-in function, 52          |
| RC, see return code                        | REXX                                     |
| READCH() built-in function, 50             | port name, 12, 22, 105, 108, 109, 129,   |
| READLN() built-in function, 50             | 130, 133                                 |
| redirection                                | programming language, 1, 17              |
| of streams, see console                    | REXX Variables Interface                 |
| reentrancy                                 | definition, 113                          |
| definition, 82, 172                        | naming of variables, 113                 |
| in shared libraries, 172                   | rexxvars o file, 113                     |
| SimpleRexx, 128                            | use of, 74, 113, 152                     |
| register conventions, see function library | RexxArg structure                        |
| RemFuncHost() SimpleRexx function,         | allocating, 84                           |
|                                            | CreateArgString, 84                      |
| 132                                        | DeleteArgstring, 84                      |
| REMLIB                                     | description, 84                          |
| use of, 13                                 | freeing, 84                              |
| REMLIB() built-in function, 51             | LengthArgstring, 84                      |
| RENAME() support function, 51              | rexxio.h header file, 83                 |
| REPLY() support function, 51               | rexxmast command, 11                     |
| ReplyARexxMsg(), 127                       | RexxMsg structure                        |
| ReplyARexxMsg() SimpleRexx function,       | actions, 105                             |
| 132                                        | allocating, 85, 130                      |
| resident process                           | CreateRexxMsg, 85                        |
| as function host, 12                       | DeleteRexxMsg, 85                        |
| Clip List, 13                              | description, 84, 96, 157                 |
| definition, 10                             | extension fields, 85                     |
| finding, 11                                | freeing, 85, 131                         |
| Library List, 13                           | inheritance, 108                         |
| message structure, see RexxMsg struc       | needed for RVI, 113                      |
| ture                                       | result string, 85                        |
| RexxMsg structure, 85                      |                                          |
| search order, 111                          | return code, 85                          |
| using, 105                                 | rm_Action field, 85, 95-97, 105, 109,    |
| resources, 12                              | 132, 158                                 |
| Clip List, 13                              | rm_Args field, 85, 95, 109               |
| Library List, 13                           | rm_CommAddr field, 85                    |
| RESULT, see result string                  | rm_FileExt field, 85                     |
| result string, see also commands, see also | rm_PassPort field, 85, 108, 111          |
| OPTIONS RESULTS                            | rm_Result1 field, 85, 96, 97, 110, 151,  |
| definition, 73                             | 158                                      |
| multiple results, 113                      | rm_Result2 field, 85, 96, 97, 110, 132,  |
| requesting, 97, 110                        | 158                                      |
| setting, 97                                | rm_Stdin field, 85                       |
| setting via RVI, 113                       | rm_Stdout field, 86                      |

| rexxsupport.library, see support library | SimpleRexx                          |
|------------------------------------------|-------------------------------------|
| RexxSysBase, see system library          | AddFuncHost(), 128                  |
| rexxsyslib.library, see system library   | ARexxBase(), 128                    |
| rexxvars.o object file, see RVI          | ARexxContext, 128                   |
| RIGHT() built-in function, 52            | ARexxFree(), 127, 129               |
| RVI, see REXX Variables Interface        | <b>ARexxInit()</b> , 127, 129       |
| RXADDCON, 112                            | ARexxName(), 130                    |
| RXADDFH, see action flags                | ARexxSignal(), 130                  |
| RXADDLIB, see action flags               | CallARexxFunc(), 127, 130           |
| RXARGMASK, see action flags              | context, 129                        |
| RXCOMM, see action flags                 | FreeARexxMsg(), 127, 131            |
| RXFF_NOIO, see action flags              | GetARexxMsg(), 127, 131             |
| RXFF_NONRET, see action flags            | IsARexxReply(), 131                 |
| RXFF_RESULT, see action flags            | RemFuncHost(), 132                  |
| RXFF_STRING, see action flags            | ReplyARexxMsg(), 127, 132           |
| RXFF_TOKEN, see action flags             | SendARexxMsg(), 127, 133            |
| RXFUNC, see action flags                 | using, 127                          |
| rxlib command, 18                        | simplerexx.h header file, 128       |
| RXREMCON, see action flags               | SOURCELINE() built-in function, 56  |
| RXREMLIB, see action flags               | SPACE() built-in function, 56       |
| RxsLib structure, 82                     | standards                           |
| rxslib.h header file, 82, 83             | errors, 151                         |
| RXTCCLS, see action flags                | port naming, 151                    |
| RXTCOPN, see action flags                | setting results, 152                |
|                                          | suggested commands, 153             |
|                                          | starting an ARexx program, 106, 109 |
| <u>S</u>                                 | STATEF() support function, 57       |
| G1311                                    | STDERR, see console                 |
| SAY instruction, 74, 75, 77, 78          | STDIN, see console                  |
| search order, see functions              | STDOUT, see console                 |
| SEEK() built-in function, 53             | STORAGE() built-in function, 57     |
| send-receive-reply model, 95             | storage.h header file, 83, 84, 105  |
| SendARexxMsg(), 127                      | stream, see console                 |
| SendARexxMsg() SimpleRexx function,      | string, see RexxArg structure       |
| 133                                      | string file                         |
| SETCLIP                                  | description, 107                    |
| use of, 13                               | STRIP() built-in function, 58       |
| SETCLIP() built-in function, 53          | 50                                  |
| SetRexxVar() RVI function, 115           | stub functions, 83                  |
| shared library                           | SUBSTR() built-in function, 58      |
| definition, 10, 171                      | SUBWORD() built-in function, 59     |
| function library, 171                    | support library                     |
| installing, 172                          | definition, 17                      |
| other libraries, 10                      | installation, 17                    |
| SHOW                                     | SYMBOL() built-in function, 59      |
| use of, 18, 21, 71                       | system library                      |
| SHOW() built-in function, 54             | accessing, 81, 83                   |
| SHOWDIR() support function, 54           | base pointer, 82, 83                |
| SHOWLIST() support function, 55          | ClearRexxMsg(), 86                  |
| SIGN() built-in function, 55             | CreateArgstring(), 86               |
| signal                                   | CreateRexxMsg(), 87                 |
| definition, 9                            | DeleteArgstring(), 87               |
| SIGNAL instruction, 72                   | DeleteRexxMsg(), 87                 |
|                                          |                                     |

description, **81 FillRexxMsg(), 88 IsRexxMsg(), 88 LengthArgstring(), 88**  prototypes and pragmas, 86 RexxSysBase, **82, 128, 129** 

## **T**

task

ARexx program console handler, **48 ID, 48**  priority, **48**  requesters, **48**  definition, 9 forbid/permit, 36, 47 **TIME()** built-in function, 59 token, *see* argument parsing tokenization, see argument parsing TRACE() built-in function, 60 TRACE instruction, 74, 78 tracing output, 78 **TRANSLATE()** built-in function, **61 TRIM()** built-in function, 62 **TRUNC()** built-in function, 62

## **U**

**UPPER()** built-in function, 62

## V

**VALUE()** built-in function, 63 variables, see **REXX** Variables Interface **VERIFY()** built-in function, 63

## W

**WAITPKT()** support function, 63 **WORD()** built-in function, 64 **WORDINDEX ()** built-in function, 64 **WORDLENGTH()** built-in function, 65 **WORDS()** built-in function, 65 **WRITECH()** built-in function, 65 **WRITELN()** built-in function, 66

## X

X2C() built-in function, 66 **XRANGE()** built-in function, 67

Computer Systems Division 1200 Wilson Drive West Chester, PA 19380