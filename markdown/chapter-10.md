# Chapter 10 Interfacing to ARexx 
This chapter discusses the issues involved in designing and implementing an interface be-tween ARexx and an external applications program. The material presented here is directed to software developers, so a high degree of familiarity with programming the Amiga in either "C" or assembly-language is assumed.

ARexx can interact with external programs in several ways. The ***command interface*** is used to communicate with an external program running as a separate task in the Amiga's multitasking environment. The interaction takes place by passing messages between public message ports, and is in many ways similar to the interaction of a program with Intuition, the Amiga's window and menu manager. The command interface provides both a means of sharing data and a method of controlling an applications program.

Function libraries provide a mechanism for calling external code as part of an ARexx program's task context. The linkages for such calls are established dynamically at run time rather than when the program is linked, so each function library must include an entry point to match function names with the address of the function to be called.

Function hosts are external tasks that manage a public message port for communicating with ARexx or other programs. Both function hosts and function libraries are managed by the Library List, which provides a prioritized search mechanism for resolving function names. Function hosts may be used as a gateway into a network to provide a remote procedure call facility. ARexx imposes no constraints on the internal operations of a function host, except to require that message packets be returned with an appropriate code.

The ***resident process*** acts as the hub for communications between ARexx and external entities. It opens and manages a public message port named "REXX," and provides a num-ber of support services. Note that the resident process is itself a "host application" whose function it is to launch ARexx programs and maintain global resources. The activation structures for all ARexx programs are linked into a list maintained by the resident process, and in principle their complete internal states are accessible to external programs.

The ARexx interpreter is structured as an Amiga shared library and includes entry points specifically designed to help implement an interface to ARexx. Functions are available to create and delete message packets, argument strings, and other resources. Software developers are urged to use these library routines whenever possible, as they provide "safe" access to the internal structures. The ARexx Systems Library functions are documented in Appendix C. The distribution disk contains the INCLUDE files required to work with the library and data structures.

Most developers will need to work with only two of the data structures used by ARexx. The **RexxArg ** structure is used for all of the strings manipulated by the interpreter. It is usually passed as an*argstring, * a pointer offset from the structure base that may be treated like an ordinary string pointer. The **RexxMsg** structure is an extension of an EXEC Message, and is the message packet used for all communications with external programs.

Table 10.1 The **RexxArg** Structure

STRUCTURE RexxArg,O

LONG ra_Size

UW0RD ra_Length

UBYTE ra_Flags

UBYTE ra_Hash STRUCT ra_Buff,8

allocated length length of string attribute flags hash code

buffer (argstring points here)

Library functions are available to create and delete argstrings, and for converting in-tegers into argstring format. The function CreateArgstringO allocates a structure and copies a string into it, and returns an argstring pointer to the structure. The function DeleteArgstringO can be used to release an argstring when it is no longer needed.

Message Packets. All communications between ARexx and external programs are medi-ated with message packets, whose structure is diagrammed in Table 10.2 below. Functions are provided in the ARexx Systems Library to create, initialize, and delete these message packets. Each packet sent from ARexx to an external program is marked with a special pointer in its name field. This can be used to distinguish the message packets from those belonging to other programs, in case a message port is being shared.

Message packets are created using the CreateRexxMsgO function, and can be released using the DeleteRexxMsg() function. Note that the message packets passed by ARexx to a host application (as a command, for instance) are identical to the packets the host would use to invoke an ARexx program. This commonality of design means that only one set of functions is needed to create and delete message packets, and that external programs can use the same routines that the interpreter uses to handle the packets.

Resource Nodes. A somewhat higher-level data structure called a "resource node" (a RexxRsrc structure) is used extensively within ARexx to maintain resource lists. These nodes are variable-length structures that include the total allocated length as a field within the node, and that also provide for an "auto-delete" function. This latter capability allows

the address of a clean-up function to be associated with the node so that an entire (possibly inhomogeneous) list of resource nodes can be deallocated with a single function call.

Table 10.2 The **RexxMsg** Structures

STRUCTURE RexxMsg,MN_SIZE

APTR rm_TaskBlock global pointer APTR rm_LibBase library pointer LONG rm_Action command code LONG rm_Result1 primary result LONG rm_Result2 secondary result

STRUCT rm_Args,16*4 arguments (ARGO-ARG15)

the extension area APTR rm_PassPort forwarding port APTR rm_CommAddr host address APTR rm_FileExt file extension LONG rm_Stdin input stream LONG rm_Stdout output stream LONG rm_avail reserved

LABEL rm_SIZEOF 128 bytes

Designing a Command Interface

The minimal command interface between ARexx and an applications program requires only a public message port and a routine to process the commands received. For most host applications this will require little extra machinery, as the program will probably already have several message ports for key and menu events, timer messages, and so on. Processing the command strings should be relatively straightforward for command-oriented applications. Hosts that are entirely menu-driven will require somewhat more additional programming, unless commands are supported only as simulated menu events. The specific choice of which commands to support is a1ways left up to the applications designer, as ARexx imposes no restrictions on the structure of the commands that can be issued.

The basic sequence of events in the command interface begins when the host sends a command invocation message to the ARexx resident process. This is usua1ly in response to a direct input from the user, such as a command that was not recognized as one of the primitives supported by the host. When the resident process receives the message packet , it spawns a new DOS process the run the macro program. The command line is parsed to extract the command token (the first word), and the interpreter searches for a file that matches the command name.

Once a macro program file has been found, it is executed by the interpreter and (usu-ally) results in one or more commands being issued back to the host application's public port. The macro program waits while each command is processed by the host, and takes appropriate actions if the return code indicates that an error occurred. Eventually the macro program finishes and returns the invocation message packet back to the host.

Error handling is an important consideration in the interface design. Macro programs must receive meaningful return codes so that processing actions can be altered when errors

Interfacing to A Rexx 91

occur. Normally, the host application should not return a message packet until the command has been processed and its error status is known. Hosts that support two streams of commands (from the user and from the command interface) will need a flag to indicate the source of each command. Errors in user commands might normally be reported on the screen, but errors in ARexx commands must be reported by setting the result field in the message packet.

Return codes should generally be chosen to follow the model of an *error severity level,* with small integers representing relatively harmless conditions and larger values indicating progressively more severe errors. This will allow a characteristic failure level to be estab-lished within a macro program, so that insignificant errors can be ignored. The choice of the specific return code values is left to the applications designer.

Each host application must open a public message port to support the command interface. When a macro program issues a command to the host, a message packet containing the command is sent to this public port. The structure of these message packets is shown in Table 10.2. The rm..Action field will be set to RXCOMM, and the ARGO parameter slot will contain the command as an argstring pointer. Parameter slots ARG1-ARG15 are not used for command messages. Two other fields are potentially of interest: the rmJtexxTask field contains a pointer to the global data structure for the program that issued the command, and the rm..LibBase field has the ARexx library base address. The fields in the extension area may also be of interest to the host program; these are described later on. Except for setting the result fields rmJtesult1 and rmJtesult2, the host application should not alter the message packet.

When the host program finishes processing the command, it must set the primary result field rmJtesult1 to an *error severity level* or zero if no errors occurred. This is the field which will be assigned to the special variable RC in the macro program. The secondary result field rmJtesult2 should be set to zero unless a result string (as described below) is being returned. The packet can then be returned to the sender using the EXEC function

ReplyMsg().

In some cases a macro program may request a result string by setting the RXFB.JtESULT modifier bit in the command code. If possible, the host application should then return the result as an argstring pointer in the secondary result field rmJtesult2. A result string should only be returned if *explicitly requested * and if *no errors occurred* during the call (rmJtesult1 set to zero.) Failure to observe these rules will result either in memory loss or in corruption of the system free-memory list.

Many applications programs support concurrent activities on several sets of data. For example, most text editors allow several files to be edited at once. A command issued from a particular instance of the editor might invoke an ARexx macro program, so clearly any commands issued from that macro would have to be directed to the correct instance of the editor. ARexx provides for this by allowing the applications program to declare an initial

host address when a program is invoked. A separate message port would be opened for each instance of the host application, and this port would be named as the initial host address for all invocations from that instance. In the example above, if the editor opened two ports named "MyEditl" and "MyEdit2," then programs invoked by the "MyEditl" instance would send commands back to the "MyEditl" port.

Multiple Message Ports. Host applications are not limited to having a single message port for commands. If several different kinds of commands are to be received, it might be appropriate to set up more than one port. Macro programs would then use the ADDRESS instruction to direct commands to the appropriate port. The different ports could be used simultaneously, since ARexx programs execute as separate tasks.

ARexx programs are invoked by sending a message packet to the resident process. Programs may be invoked as either a command or as a function. The command mode of invocation is generally simpler, as it requires setting only a few fields in the message packet.

The structure of the message packet supported by ARexx is shown in Table 10.2. This structure provides fields for passing arguments and for specifying overrides to various in-ternal defaults. The packets are cleared ( set to 0) when allocated, and the client-supplied fields are never altered by ARexx. Message packets can be reused after being returned, and generally only one is required.

Command (Action) Code. The rm.Action field of the message packet determines the mode of invocation. It can be set to either RXC0MM or RXFUNC for command or function mode, respectively. Several modifier flags can be used with the command code; these are described later in this chapter.

Argument Strings. Command strings, function names, and argument strings must be supplied as argstrings. Strings can be conveniently packaged. into argstrings using the CreateArgstringO library function, which takes a string pointer and a length as its ar-guments. Argstrings point to a null-terminated string and may be treated like an ordinary string pointer in most cases. In principle, a host application could build the argstrings di-rectly, but since the strings must remain unchanged for the duration of an ARexx program, the host might need to maintain many such structures.

The argstring pointer returned by CreateArgstring() is installed in the appropriate parameter slot of the message packet: ARGO for the command string or function name, and ARG1-ARG15 for argument strings. Argstrings can be recycled after a packet has returned by calling the DeleteArgstringO function.

Sending the Packet. Once the required fields have been filled in, the host application can send the packet to the "REXX" public port using the EXEC function PutMsgO. The address of the "REXX" port can be obtained by a call to the FindPortO function, but this address should not be cached internally, since the port could close at any time. To be absolutely safe, the calls to FindPortO and PutMsgO should be bracketed by calls to the

EXEC routines Forbid() and Permit(). This will exclude the slight possibility that the message port could dose in the few microseconds before the message packet is actually sent to the port address.

After sending the packet the host can return to its normal processing, since the macro program will execute as a separate task. In most cases it will be advisable to "lock-out" further user commands while the ARexx program is running, to preserve the integrity of any shared data structures that may be accessed externally.

In the command mode of invocation the host supplies a command string consisting of a name token followed by an. argument string. ARexx parses the string to extract the command name, which is usually the name of a program file. The default action is to use the remainder of the command string as the (single) argument string for the program. This may be overridden by requesting *command tokenization,* which is done by setting the **RXFB_TOKEN** modifier flag in the action code of the message packet. In this case the entire command string will be parsed, and the program may have many argument strings. (There is no limit to the number of arguments that may be derived from the command string, since they don't have to fit into the parameter slots of the message packet.)

The parsing process uses "white space" (blanks, tabs, etc.) as the token separators, and has a several special features.

Quoting Convention. Either single (') or double (") quotes may be used to surround items that include "white space" and would otherwise be separated during parsing. Single quotes may appear within a double-quote-delimited token, and vice versa; however, double-delimiter sequences are not accepted. The quotes are removed from the parsed token. An "implicit" quote at the end of the string is also recognized. If the command string ends before the closing delimiter has been found, the null byte is accepted as the final delimiter. For example,

look.rexx **"Now** is the time" "can't you see

is a command with the two argument strings **"Now** is the time" and "can't you see" (but without the quotes.)

String Files. If the command name (the first token of the string) is quoted, it is assumed to be a "string file" an ARexx program in a string, rather than the name of a disk file. This is a convenient way to run very brief programs, although programs of any length may be stored this way. If command tokenization has not been specified, the remainder of the string is not scanned and no quote characters are removed. In this case the quoting convention is useful only for indicating "string file" programs. The entire command string can be declared as a "string file" by setting the RXFBJ3TRING modifier flag of the action code. When this flag is set, no parsing at all is applied to the command.

Result Strings. Command invocations do not usually request a result string, but can do so by setting the RXFB..RESULT modifier flag. The host application must be prepared to recycle the returned result string once it is no longer needed.

In a function invocation the host application supplies a function name string and from O to 15 argument strings. The name string is used to locate an external program file and may include directory specifiers and a file extension. The actual argument count (not including the name string) must be placed in the low-order byte of the command code.

This mode of invocation is normally used when a result string is expected and the ar-gument strings are conveniently available. Note that a result does not have to be requested, however.

Result Strings. Function invocations request a result string by setting the RXFB...RESULT modifier -flag bit. If no errors occurred and a result string was requested, the secondary result field in the returned packet will be a pointer to the result string. However, if the program exited without supplying a result, the secondary field will be zero.

String **Files.** The function name argument may specify a "string file" rather than the name of a filing system object. This is indicated by setting the RXFB..STRING modifier -flag.

The search for a program file matching a command or function name is normally a two-step process. For each directory to be checked, a search is made first with the current file extension appended to the name string. If thls search fails, the second search uses the unmodified name string. The first step is skipped if the command or function name includes an explicit file extension.

The default file extension is ".rexx," but this can be changed by supplying a file extension string in an extended message packet. Host applications will usually specify a file extension, since it provides a convenient way to distinguish the macro programs that are specific to that application. Refer to the section on Extension Fields for further details.

The search path for a program depends on the way the program name was specified. If an: explicit device or directory specification precedes the program name, only that di-rectory will be searched. For example, the command-level invocation of "rx df0:s/test" will search only the df0:s directory for a file named test.rexx or test. If the program name does not include a path, the search path begins with the current directory and pro-ceeds to the system REXX: directory. To further the above example, invoking the program as "rx test 1 2 3" would search for the files test.rexx, test, REXX:test.rexx, and REXX:test, in that order.

If an ARexx program cannot be found, one alternative action may be taken. If the rm_FassPort field of an extended packet was supplied, the message packet is passed along to that port, which might be the next process in a search chain. Otherwise the message is returned with a "Program not found" error indication (error code 1.)

The **RexxMsg** structure includes several "extension fields" that can be used to override various defaults when a program is invoked. These extension fields can be filled in selectively, and only the non-zero values will override the corresponding default. ARexx never modifies the extension area.

Host applications should supply values for the file extension and host address fields of the message packet. The file extension affects which program files will match a given command name, and allows macro programs specific to the host to be given distinctive names. The host address must refer to a public message port, and will usually indicate the host's own port. Any appropriate (but usually short) strings can be chosen for these values. Often, the name of the applications program itself can be used as its host address and file extension.

Note that the **rm..PassPort ** field must be the actual***address*** of a message port, rather than a name string. The PassPort therefore does not have to be a public port, but the port should be a secured resource, since the message is sent directly to this address without checking to see whether it is a valid message port.

The output stream is also used as the default tracing stream for the program. If interactive tracing is to be used in a program, the output stream should refer to a console device, since it will be used for input as well.

In the event that an ARexx program is invoked by an EXEC task, rather than by an DOS process, the extension field streams are the only way that the launched program can be given default I/O streams.

Interpreting the Result Fields

The message packet that invoked an ARexx program is returned to the client when the program finishes. The two result fields will contain error codes or possibly a result string. The interpretation of the result fields depends partly on the mode of invocation. If the primary result field **rm..Resultl ** is zero, the program executed normally and the secondary field**rm..Result2** will contain a pointer to a result string, assuming that one was requested (and available.)

If the primary result is non-zero, it represents either an error severity level or else the return code from a command invocation. The two cases can be distinguished by examining the secondary result. If the secondary field is also non-zero, an error occurred and the secondary field is an ARexx error code. If the secondary result is zero, then the primary result is the return code passed by an "EXIT re" or "RETURN re" instruction in the program. The application program can use thls return code either as an error indication or to initiate some particular processing action.

Result strings are always returned as an argstring and become the property (that is, responsibility) of the host. When the string is no longer needed, it can be released using the DeleteArgstring() function.

Errors occurring in macro programs should usually be reported to the user. Explana-tory messages are available for all ARexx error codes, and can be obtained by calling the ARexx Systems Library function ErrorMag().

Communicating with the Resident Process

All communications with the resident process a.re handled by passing message packets, which were previously diagrammed in Table 10.2. The packet has a command field that describes the action to be performed and parameter fields that a.re specific to the command. Message packets are processed as they are received, and are then either returned to the sender or passed along to another process (in the case of a program invocation.) The packet includes two result fields that are used to return error codes or result strings. The para.meter fields of the message packet may contain either (long) integer values or pointers to argument strings. String arguments are assumed to be argstring pointers unless otherwise specified.

Command (Action) Codes

The command codes that are currently implemented in the resident process are described below. Commands are listed by their mnemonic codes, followed by the valid modifier flags. The final code value is always the logical OR of the code value and all of the modifier flags selected. The command code is installed in the rm...Aetion field of the message packet.

This code specifies an entry to be added to the Clip List. Parameter slot ARGO points to the name string, slot ARG1 points to the value string, and slot ARG2 contains the length of

the value string. The name and value arguments do not need to be argstrings, but can be just pointers to storage areas. The name should be a null-terminated string, but the value can contain arbitrary data including nulls.

This action code specifies a function host to be added to the Library List. Parameter slot ARGO points to the (null-terminated) host name string, and slot ARG1 holds the search priority for the node. The search priority should be an integer between 100 and -100 inclusive; the remaining priority ranges are reserved for future extensions. If a node already exists with the same name, the packet is returned with a warning level error code. Note that no test is made at this time as to whether the host port exists.

This code specifies an entry to be added to the Library List. Parameter slot ARGO points to a null-terminated name string referring either to a function library or a function host. Slot ARG1 is the priority for the node and should be an integer between 100 and -100 inclusive; the remaining priority ranges are reserved for future extensions. Slot ARG2 contains the entry point offset and slot ARG3 is the library version number. If a node already exists with the same name, the packet is returned with a warning level error code. Otherwise, a new entry is added and the library or host becomes available to ARexx programs. Note that no test is made at this time as to whether the library exists and can be opened.

Specifies a command-mode invocation of an ARexx program. Parameter slot ARGO must contain an argstring pointer to the command string. The RXFB_TQKEN flag specifies that the command line is to be tokenized before being passed to the invoked program. The RXFB..STRING flag bit indicates that the command string is a "string file." Command invo-cations do not normally return result strings, but the RXFB..RESULT flag can be set if the caller is prepared to handle the cleanup associated with a returned string. The RXFB..NOIO modifier suppresses the inheritance of the host's input and output streams.

This command code specifies a function invocation. Parameter slot ARGO contains a pointer to the function name string, and slots ARG1 through ARG15 point to the argument strings, all of which m11st be passed as argstrings. The lower byte of the command code is the argument count; this count excludes the function name string itself. Function calls normally set the RXFB..RESULT flag, but this is not mandatory. The RXFB..STRING modifier indicates that the function name string is actually a "string file". The RXFB..NOIO modifier suppresses the inheritance of the host's input and output streams.

This code requests that an entry be removed from the Clip List. Parameter slot ARGO points to the null-terminated name to be removed. The Clip List is searched for a node matching the supplied name, and if a match is found the fot node is removed and recycled. If no match is found the packet is returned with a warning error code.

This command removes a Library List entry. Parameter slot ARGO points to the null-terminated string specifying the library to be removed. The Library List is searched for a

node matching the library name, and if a match is found the node is removed and released. If no match is found the packet is returned with a warning error code. The library node will not be removed if the library is currently being used by an ARexx program.

This code requests that the global tracing console be closed. The console window will be closed immediately unless one or more ARexx programs are waiting for input from the console. In this event, the window will be closed as soon as the active programs are no longer using it.

This command requests that the global tracing console be opened. Once the console is open, all active ARexx programs will divert their tracing output to this console. Tracing input (for interactive debugging) will also be diverted to the new console. Only one console can be opened; subsequent RXTC0PN requests will be returned with a warning error message.

Command codes may include modifier flags to select various processing options. Modifier flags are specific to certain commands, and are ignored otherwise.

RXFB..N0IO. This modifier is used with the RXC0MM and RXFUNC command codes to suppress the automatic inheritance of the host's input and output streams.

RXFB..N0NRET. Specifies that the message packet is to be recycled by the resident process rather than being returned to the sender. This implies that the sender doesn't care about whether the requested action succeeded, since the returned packet provides the only means of acknowledgement. Message packets are released using the library function DeleteRexxMsg ().

RXFB..RESULT. This modifer is valid with the RXC0MM and RXFUNC commands, and requests that the called program return a result string. If the program EXITs (or RETURNs) with an expression, the expression result is returned to the caller as an argstring. It is then the caller's responsibility to release the argstring when it is no longer needed; this can be done using the library function DeleteArgstringO.

RXFB..STRING. This modifer is valid with the RXC0MM and RXFUNC command codes. It indi-cates that the command or function argument (in slot ARGO) is a "string file" rather than a file name.

RXFB_TOKEN. This flag is used with the RXCOMM code to request that the command string be completely tokenized before being passed to the invoked program. Programs invoked as commands normally have only a single argument string. The tokenization process uses "white space" to separate the tokens, except within quoted strings. Quoted strings can use either single or double quotes, and the end of the command string (a null character) is considered as an implicit closing quote.

The resident process uses the standard command-level conventions for the primary return code installed in rm...Result1. Minor or warning errors are indicated by a value of 5, and more serious errors are returned as values of 10 or 20. The secondary result field rm...Result2 will either be zero or an ARexx error code if applicable.

Note that RXC0MM and RXFUNC messages are returned directly by the invoked macro program, rather than by the resident process.

ARexx supports external function libraries as a mechanism for user-defined extensions to the language. Function libraries may be written and maintained by users or applications developers.

There are several different purposes for which **a** function library might be designed. In the simplest case, a library could be used to extend the string manipulation or mathematical capabilities of the language by defining new functions. Such a library could be entirely self-contained or might call other system libraries to perform specific operations.

Another alternative would be to build a library that interacts closely with an external applications program. Thls could allow specific operations in the host application to be be performed as function calls rather than as commands. There are several advantages to this approach, as it avoids the need to parse command strings and does not require the multiple task context changes associated with message-passing. The library might include entry points for specific operations as well as functions to support special processing required by the applications program.

Function libraries can also serve as bridges to other system or applications libraries. For example, if a program needed to call the functions in a graphics library, a bridge library could be built to match the function names in the program with the appropriate entry point in the graphics library. A related possibility would be to use ARexx as a test driver for a program under development. Once the query table and parameter passing mechanisms for the function library have been built, new routines under development could be tested by just adding a table entry. Since building test programs is often very time-consuming, the flexibility and interactive debugging capabilities of ARexx make it an attractive alternative to compiled languages like "C."

Regardless of the intended application, all function libraries share a common structure. The initial design follows that of the standard EXEC shared library, with the three required entry points Open, Close, and Expunge, plus a reserved slot. The library must also have a "query" entry point, which serves to match the name supplied by ARexx with the intended function. Typically, this will consist of a table of function names and a routine to search for the specified one.

Reentrancy. Functions libraries should be designed to be fully reentrant, since any number of ARexx programs may be running at any time. If this is not feasible due to other design

constraints, the query function should include a lockout mechanism to prevent multiple calls to the library routines.

The library's query function will be called from the interpreter's context with the address of a message packet in register AO and the library base in A6. The structure of the message packet is the same as that in Table 10.2, but note that although a message packet is used to carry the arguments, it is not queued at a message port and does not need to be unlinked. The name of the function to be called is carried in the ARGO parameter slot. The query function must search for this function name and, if the name cannot be found, must return an error code of 1 ("Program not found") in register DO. The library will then be closed and the search continued in the next function library. The query function should not modify any fields within the message packet, as it must be passed along to the next library until the function is located.

Once the requested function has been found, the query function may need to transform the parameters passed by ARexx into the form expected by the function. Whether the parameter strings need to be converted depends on how they are to be used. In some cases it may be sufficient just to forward a pointer to the message packet to the called function, while in other cases the query function may need to load parameters into registers or to perform conversion operations. The parameters in ARG1-ARG15 are always passed as argstrings, and may be treated like a pointer to a null-terminated string. Further attributes are stored at negative offsets from the argstring pointer, and may be helpful in working with the string.

Numeric quantities are passed as strings of ASCII characters and will need to be con-verted to integer or floating-point format if arithmetic calculations are to be performed. The ARexx Systems Library includes a limited set of functions to do parameter conversions.

The actual parameter count can be obtained from the low-order byte of the **rm..Action** field in the message packet. The count never includes the function name itself (in ARGO), but does include arguments specified as "defaults." Such arguments will have a zero value in the corresponding parameter slot.

Note that the parameter block of the message packet, containing the fields ARGO-ARG15, is structured like the argument array expected by the **main(argc,argv)** function of a "C" program. This suggests a simple way that a function library could provide a bridge to a series of "C" programs. The query function would need only to determine the address of the called function, and then push the parameter block address and argument count onto the program stack.

Each library function must return an error code and a value string. The error code is returned in register DO, and should be O if no errors occurred. The value string must be returned as an argstring pointer in register Al, unless DO indicates that an error occurred during the call. The mechanisms for creating the proper return values can be made part of the query function, so that all functions in the library share a common return path.

Direct Manipulation of Data Structures

All of the data structures maintained by the resident process are built into the ARexx Systems Library base and are therefore accessible to external programs. The Task List in the **RexxBase ** structure links the global data structures for all currently active ARexx programs. This linkage uses the node contained in the message port of the**RexxTask ** structure, rather than at the head of the structure. The**RexxTask** structure is the global data structure and initial storage environment for the ARexx program, and all descendant storage environments are linked into the Environment List. The linkage of internal data structures is such that the complete internal state of all ARexx programs can be reached starting from the library base pointer.

Two library functions, **LockRexxBase()** and **UnlockRexxBase(),** are provided to me-diate access to the global structures. The structure base should be locked before reading any of the data items or traversing any of the lists. The present version of these functions provides only a global lock, but future extensions will allow individual resouces to be locked.

In general it should not be necessary to manipulate directly any of these data structures. Functions have been provided in the ARexx Systems Library to perform all of the operations required to interface external program to the ARexx system. It is therefore recommended that applications developers avoid using any of the internal structures except as provided through the library functions.

