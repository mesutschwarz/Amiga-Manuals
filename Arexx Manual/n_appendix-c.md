# Appendix C The ARexx Systems Library 
The ARexx interpreter is supplied as a shared library named **rexxsyslib.library** and should reside in the system LIBS: directory. While many of the library routines are highly specific to the interpreter, some of the functions will be useful to applications that use ARexx. The library is opened when the ARexx resident process is first loaded and will always be available while it remains active.

The system library routines were designed to be called from assembly-language pro-grams and, unless otherwise noted, save all registers except for AO/Al and DO/Dl. Many routines return values in more than one register to help reduce code size. In addition, the routines will set the condition-code register (CCR) wherever appropriate. In most cases the CCR reflects the value returned in DO.

The library offsets are defined in the file **rxslib. i,** which should be INCLUDEd in the program source code. Calls may be made from "C" programs if suitable binding routines are provided when the program is linked. The definitions for the constants and data structures used in ARexx are provided as INCLUDE files on the program distribution disk. These should be reviewed carefully before attempting to use the library functions.

Some of the library functions are not documented here. These private entry points are reserved for the internal use of the interpreter and should not be called from external programs.

The library functions can be grouped into *Conversion, Input/Output, Resource Manage-ment,* and *String Manipulation* functions.

Data Conversion. These functions provide many of the common data-conversion require-ments.

Resource. These functions allocate, release, or otherwise manage the data structures used with ARexx.

String Functions. All data in ARexx are managed as strings. These functions provide some of the more common string-manipulation operations.

Name AddClipNode ClearMem ClearRexxMsg CloseF ClosePublicPort CmpString CreateArgstring CreateDOSPkt CreateRexxMsg CurrentEnv CVa2i

ExistF FillRexxMsg FindDevice FindRsrcNode FreePort FreeSpace GetSpace InitList

Table C.1 ARexx Systems Library Functions **Functional Group Description** Resource Allocate a Clip node

Resource Clear a block of memory

Resource Release argstrings from message

Input/Output Close a file buffer

Resource Close a port resource node

String Compare string structures for equality

Resource Create an argstring structure Input/Output Create a DOS StandardPacket Resource Create a message packet

Resource Get current storage environment

Conversion ASCII to integer

Conversion Character to Hex or Binary digits

Conversion Integer to ASCII

Conversion Integer to ASCII argstring

Conversion Integer to ASCII, leading zeroes

Conversion String structure to integer

Conversion Hex or binary digits to binary

Resource Release an argstring structure Input/Output Release a DOS StandardPacket Resource Release a message packet

Input/Output Read from a DOS filehandle

Input/Output Write to a DOS filehandle

Conversion Get error message from error code Input/Output Check whether a DOS file exists Resource Convert and install argstrings

Input/Output Locate a DOS device node

Resource Locate a resource node

Resource Close a message port

Resource Release internal memory

Resource Allocate internal memory

Resource Initialize a list header

Resource Resource Resource Input/Output Resource Input/Output Input/Output Input/Output Resource Resource Resource

Initialize a message port

Test a message packet Get length of argstring

Copy node names to an argstring Open a file buffer

Allocate and open a port resource node Queue a line in a file buffer

Read from a file buffer

Read a string from a file buffer Release a Clip node

Release a resource list Release a resource node

Name SeekF StackF StcToken StrcmpN StrcpyA StrcpyN StrcpyU StrflipN Strlen ToUpper WriteF

Table C.1 Library Functions (cont.) **Functional Group Description**Input/Output Reposition a file buffer

Input/Output Stack a line in a file buffer

String Break out a token

String Compare strings

String Copy a string, converting to ASCII

String Copy a string

String Copy a string, converting to uppercase

String Reverse characters in a string

String Find length of a string

Conversion ASCII to uppercase

Input/Output Write to a file buffer

The following descriptions of the ARexx Systems Library functions are listed alphabetically. The required arguments and register assignments are shown in parentheses after the function name. Multiple returns are shown in parentheses on the left-hand side of the call.

AddClipNode()- allocate and link a Clip node

(CCR)

Allocates and links a Clip node into the specified list. Clip nodes are resource nodes contain-ing a name and value string, and include an "auto-delete" function for simple maintenance. The *list * argument must point to a properly-initialized EXEC list header. The *name * argu-ment points to a null-terminated name string, the *value * argument is a pointer to a storage area, and the *length* argument is its length in bytes. The returned value is a pointer to the allocated node, or O if the allocation failed.

The **RemClipNode()** function is installed as the "auto-delete" function for each node. Clip nodes can be intermixed with other resource nodes in a list and then released with a single call to **RemRsrcList().**

AddRsrcNode()- allocate and link a resource node Usage: node= AddRsrcNode(list,name,length)

(CCR)

Allocates and links a resource node (a **RexxRsrc ** structure) to the specified*list. * The *name * argument is a pointer to a null-terminated string, a copy of which is installed in the node structure. The length argument is the total length for the node; this length is saved within

the node so that it may be released later. The returned value is a pointer to the allocated node, or 0 if the allocation failed.

ClearMem()- clear a block of memory Usage: ClearMem(address,length)

Clears a block of memory beginning at the given *address * for the specified *length* in bytes. The address must be word-aligned and the length must be a multiple of 4 bytes; all structures allocated by ARexx meet these restrictions. Register AO is preserved.

ClearRexxMsg()- release argument strings Usage: ClearRexxMsg(msgptr,count)

Releases one or more argstrings from a message packet and clears the corresponding slots. The *count* argument specifies the number of argument slots to clear, and can be set to less than 16 to reserve some to the slots for private use. No action is taken if the slot already contains a zero value.

CloseF()- close a file buffer

Releases the **IoBuff ** structure and closes the associated DOS file. CloseF() is the "auto-delete" function for the**IoBuff** structure, so an entire list of file buffers can be closed with a single call to RernRsrcList O.

ClosePublicPort() close a port resource node Usage: ClosePublicPort(node)

Unlinks and closes the message port and releases the resource node structure. The node must have been allocated by the OpenPublicPort() function.

CmpString()- compare string structures for equality Usage: test = CmpString(ss1,ss2)

(CCR)

The arguments ssl and ss2 must be pointers to ARexx string structures and are compared for equality. String structures include the length and hash code of the string, so the actual strings are not compared unless the lengths and hash codes match. The return value sets the CCR and will be -1 (True) if the strings match and O (False) otherwise.

CreateArgstring()- create an argument string structure Usage: argstring = CreateArgstring(string,length)

AO (CCR.)

Allocates a **RexxArg ** structure and copies the supplied string into it. The*argstring * return is a pointer to the string buffer of the structure, and can be treated like an ordinary string pointer. The **RexxArg** structure stores the structure size and string length at negative offsets to the string pointer. The string pointer can be set to NULL if only an uninitialized structure is required.

CreateDOSPkt()- allocate and initialize a DOS standardPacket. Usage: packet= CreateD0SPkt()

```rexx

DO AO (CCR.)
```

Allocates a DOS **StandardPacket** structure and initializes it by interlinking the EXEC message and the DOS packet substructures. No replyport is installed in either the message or the packet, as these fields are generally filled in just before the message is sent.

CreateRexxMsg()- allocate an ARexx message packet

(CCR.)

This functions allocates an ARexx message packet from the system free memory list. The message packet consists of a standard EXEC message structure extended to include space for function arguments, returned results, and internal defaults. The *replyport * argument points to a public or private message port and must be supplied, as it is required to return the message packet to the sender. The *extension * and *host* arguments are pointers to null-terminated strings that provide values for the default file extension and the initial host address, respectively. Additional override fields in the extended packet may be filled in after the packet has been allocated.

The interpreter preserves all of the fields in the message packet except for the primary and secondary result fields rm..Result1 and rm..Result2.

CVa2i()- convert from ASCII to integer Usage: (digits.value)= CVa2i(buffer)

Converts the *buffer* of ASCII characters to a signed long

value. The scan proceeds

until a non-digit character is found or until an overflow is detected. The function returns both the number of digits scanned and the converted value.

CVc2x()- convert (unpack) from character string to hex or binary digits. Usage: error = CVc2x(outbuff,string,length,mode)

Converts the *string* argument to a string of hex (0-9, A-F) or binary (0,1) digits.

CVi2a()- convert from integer to ASCII

Converts the signed integer *value * argument to ASCII characters using the supplied *buffer * pointer. The *digits * argument specifies the maximum number of characters that will be copied to the buffer. The returned *length * is the actual number of characters copied. The *pointer* return is the new buffer pointer.

AO (CCR)

Converts the signed long integer *value * argument to ASCII characters, and installs them in an argstring (a **RexxArg** structure). The returned value is an argstring pointer or O if the allocation failed. The allocated structure can be released using DeleteArgstring().

Converts the signed long integer *value * argument to ASCII characters in the supplied *buffer,* with leading zeroes to fill out the requested number of *digits.* This function is identical to CVi2a except that leading zeroes are supplied.

CVs2i()- convert from string structure to integer Usage: (error,value) = CVs2i(ss)

The *ss * argument must be a pointer to a string structure. It is converted to a signed long integer *value * return. The *error* return code is 47 ("Arithmetic conversion error") if the string is not a valid number.

CVx2c()- convert from hex or binary digits to (packed) string Usage: error = CVx2c(outbuff,string,length,mode)

Converts the ***string *** argument of hex (0-9,A-F) or binary (0,1) digits to the packed binary representation. The***mode *** argument specifies the (hex or binary) conversion mode, and must be set to -1 for hex strings or 0 for binary strings. Blank characters may be embedded in the string for readability, but only at byte boundaries. The***error*** return code is 47 if the string is not a valid hex or binary string.

CurrentEnv()- return the current storage environment Usage: envptr = CurrentEnv(rxtptr)

Returns a pointer to the current storage environment associated with an executing ARexx program. The ***rxtptr *** argument is a pointer to the**RexxTask** structure, and may be obtained from the message packet sent to an external application.

DeleteArgstring()- delete (release) an argstring structure Usage: DeleteArgstring(argstring)

Releases an argstring (RexxArg) structure. The RexxArg structure contains the total allocated length at a negative offset from the ***argstring*** pointer.

DeleteDOSPkt()- release a DOS StandardPacket structure. Usage: DeleteD0SPkt(message)

Releases a DOS **StandardPacket** structure, typically obtained by a prior call to Create-D0SPktO.

DeleteRexxMsg()- delete (release) an ARexx message packet

Releases an ARexx message packet to the system free-memory list. The internal MN..LENGTH field is used as the total size of the memory block to be released, so this function can be used to release any message packet that contajns the total length in this field. Any embedded argument strings must be released before calling DeleteRexxMsg().

DOSRead()- read from a DOS file

Reads one or more characters from a DOS filehandle into the supplied buffer. The *length * argument specifies the maximum number of characters that **will ** be read. The returned*count * is the actual number of bytes transferred, or -1 if an error occurred.

DOSWrite()- write to a DOS file

Writes a buffer of the specified length to a DOS filehandle. The returned *count* is the actual number of bytes written, or -1 if an error occurred.

ErrorMsg()- find the message associated with an error code Usage: (boolean,ss) = ErrorMsg{code)

Returns the error message (as a pointer to a string structure) associated with the specified ARexx error code. The boolean return will be -1 if the supplied code was a valid ARexx error code, and O otherwise.

ExistF()- check whether an external file exists Usage: boolean= ExistF{filename)

(CCR)

Tests whether an external file currently exists by attempting to obtain a read lock on the file. The boolean return indicates whether the operation succeeded, and the lock is released.

FillRexxMsg()- convert and install arguments in message packet. Usage: boolean= FillRexxMsg(msgptr,count,mask)

(CCR)

This function can be used to convert and install up to 16 argument strings in a **RexxMsg ** structure. The message packet must be allocated and the argument fields of interest set to either a pointer to a null-terminated string or an integer value. The*count * argument specifies the number of fields, beginning with ARGO, to be converted into argstrings and installed into the argument slot. Bits 0-15 of the *mask * argument specify whether the corresponding argument is a string pointer (bit dear) or an integer value (bit set).

The *count* argument is normally set to the exact number of strings to be passed. By setting this count to less than 16, a number of the slots can be reserved for private uses.

The returned value is -1 **(True)** if all of the arguments were successfully converted. In the event of an allocation failure, all of the partial results are released and a value of O is returned.

FindDevice()- check whether a DOS device exists. Usage: device = FindDevice(devicename,type)

(CCR)

Scans the DOS DeviceList for a device node of the specified type matching the null-terminated name string. The acceptable values for the *type* argument are the constants DLT..DEVICE, DLT..DIRECT0RY, or DLLV0LUME defined in the DOS INCLUDE files. Device names are converted to uppercase before checking for a match. The returned value is a pointer to the matched device node, or 0 if the device was not found.

FindRsrcNode()- locate a resource node with the given name. Usage: node = FindRsrcNode(list,name,type)

(CCR)

Searchs the specified list for the first node of the selected type with the given name. The *list * argument must be a pointer to a properly-initialized EXEC list header. The *name * argument is a pointer to a null-terminated string. If the *type* argument is 0, all nodes are selected; otherwise, the supplied type must match the LN_TYP E field of the node. The returned value is a pointer to the node or 0 if no matching node was found.

FreePort()- release resources associated with a message port Usage: FreePort(port)

This function deallocates the signal bit associated with a message port and marks the port as "closed." The task calling FreePort() must be the same one that initialized the port, since signal bit allocations are specific to a task. The memory space associated with the port is not released.

FreeSpace()- releases space to the internal memory allocator. Usage: FreeSpace(envptr,block,length)

Returns a block of memory to the internal allocator, which must have been. obtained from a call to GetSpace(). The *envptr* argument is a pointer to the base or current storage

environment.

GetSpace()- allocate memory using the internal allocator. Usage: block GetSpace(envptr,length)

(CCR)

Allocates a block of memory using the internal allocator. The memory is obtained from an internal pool managed by the interpreter and is returned to the operating system when the ARexx program terminates. The *envptr* argument is a pointer to the base or current storage environment for the program.

The internal allocator must be used to allocate strings for use as values for symbols, and is convenient for obtaining small blocks of memory whose lifetime will not exceed that of the ARexx program.

InitList()- initialize a list header Usage: InitList(list)

Initializes an EXEC list header structure.

InitPort()- initialize a previously-allocated message port. Usage: (signal,port) = InitPort(port,name)

Initializes a message port structure for which memory space has been previously allocated, typically as part of a larger structure or as static storage in a program. It installs the task ID (of the task calling the function) into the MP..SIGTASK field and allocates a signal bit. The *name * parameter must be a pointer to a null-terminated string. The *signal* return is the signal bit that was allocated for the port. In the event that a signal could not be assigned, a value of -1 is returned.

Note that the port is not linked into the system Ports List. If the port is to be made public, this can be done after the function returns. The port address is returned in the correct register (Al) for a subsequent call to the EXEC function AddPort O.

IsRexxMsg()- check whether a message came from ARexx. Usage: boolean= IsRexxMsg(msgptr)

Tests whether the message packet specified by the *msgptr* argument came from an ARexx program. ARexx marks its messages with a pointer to a static string "REXX" in the

LN....NAME field. The returned value is either -1 **(True)** if the message came from ARexx or

0 (False) otherwise.

IsSymbol()- check whether a string is a valid symbol. Usage: (code,length) = IsSymbol(string)

Scans the supplied string pointer for ARexx symbol characters. The *code * return is the symbol type if a symbol was found, or O if the string did not start with a symbol character. The *length* return is the total length of the symbol.

ListNames()- build a string of names from a list. Usage: argstring = ListNames(list,separator)

```rexx

DO AO D0[0:7]
```

(CCR)

Scans the specified list and copies the name strings into an argstring. The *list * argument must be a pointer to an initialized EXEC list header. The *separator* argument is the character, possibly a null, to be placed as a delimiter between the node names.

The list is traversed inside a Forbid() exclusion and so may be used with shared or system lists. The returned argstring can be released using DeleteArgstringO after the names are no longer needed.

LockRexxBase()- lock a shared resource. Usage: LockRexxBase(resource)

Secures the specified resource in the ARexx Systems Library base for read access. The *resource* argument is a manifest constant for the required resource, or zero to lock the entire structure.

Note that write access to shared resources is normally mediated by the ARexx resident process, which operates at an elevated priority, to gain exclusive access. Locking a resource should not be attempted from a process operating at a priority higher than the resident process.

OpenF()- open a file buffer

(CCR)

Attempts to open an external file in the specified mode, which should be one of the constants RXIO_READ, RXIO_\IRITE, or RXIO..APPEND defined in the ARexx INCLUDE files. If successful,

an ***IoBuff *** structure is allocated and linked into the specified list. The***list*** argument must be a pointer to a properly-initialized EXEC list header.

The optional ***logical*** argument is the logical name for the file, and must be either a pointer to a null-terminated string or zero (HULL) if a name is not required.

OpenPublicPort()- open a public message port Usage: node= OpenPublicPort(list,name)

(CCR)

Allocates a message port as an "auto-delete" resource node and links it into the specified list. The ***list*** argument must point to a properly initialized EXEC list header. The message port is initialized with the given name and linked into the system Ports List.

QueueF()- queue a line to a file buffer.

Queues a buffer of characters in the stream associated with the ***IoBuff *** structure. The stream must be managed by a**DOS** handler that supports the ACTION..QUEUE packet.

Queued lines are placed in "firtst-in, first-out" order and are immediately available to be read from the stream. The ***buffer *** argument is a pointer to a string of characters, and the***length*** specifies the number of characters to be queued. The return value is the actual count of characters or -1 if an error occurred.

ReadF()- read characters from a file buffer Usage: count= ReadF(IoBuff,buffer,length)

(CCR)

Reads one or more characters from the file specified by the ***IoBuff *** pointer. The***buffer *** argument is a pointer to a storage area, and the***length *** argument specifies the maxi.mum number of characters to be read. The return value is the actual number of characters read, or -1**if** an error occurred.

ReadStr()- read a string from a file

Reads characters from the file specified by the ***IoBuff*** pointer until a "newline" character is found. The "newline" is not included in the returned string. The return value is the actual number of characters read, or -1 if an error occurred.

RemClipNode()- unlink and deallocate a list Clip node. Usage: RemClipNode(node)

Unlinks and releases the specified Clip node. The function is the "auto-delete" function for Clip nodes, and will be called automatically by RemRsrcNode() or RemRsrcList O.

RemRsrcList()- unlink and deallocate a list of resource nodes

Scans the supplied list and releases any nodes found. The list must consist of resource nodes **(RexxRsrc** structures), which contain information to allow automatic cleanup and deletion.

RemRsrcNode()- unlink and deallocate a resource node Usage: RemRsrcNode(node)

Unlinks and releases the specified resource node, including the name string if one is present. If an "auto-delete" function has been specified in the node, it is called to perform any required resource deallocation before the node is released.

SeekF()- seek to the specified position in a file.

Seeks to a new position in the file is specified by the *IoBuff * pointer. The position is given by the *offset * argument, a byte offset relative to the supplied *anchor* argument. The anchor may specify the beginning (-1), the current position (0), or the end of the file (1). The return value is the new position relative to the beginning of the file.

StackF()- stack a line to a file buffer.

```rexx

DO AO ,A1 DO
```

Stacks a buffer of characters in the stream associated with the **IoBuff ** structure. The*buffer * argument is a pointer to a string of characters, and the *length * specifies the number of characters to be stacked. The return value is the actual count of characters or -1 if an error occurred.

Stacked lines are placed in "last-in, first-out" order and are immediately available to be read from the stream. The stream must be managed by a DOS handler that supports the ACTION..STACK packet.

StcToken()- break out the next token from a string

Scans a null-terminated string to select the next token delimited by "white space," and returns a pointer to the start of the token. The *quote * return will be an ASCII single or double quote if the token was quoted and O otherwise; white space characters are ignored within quoted strings. The *length * return is the total length of the token, including any quote characters. The *scan* return is advanced beyond the current token to prepare for the next call.

StrcpyA()- copy a string, converting to ASCII

Copies the *source * string to the *destination * area, converting the characters to ASCII by clearing the high-order bit of each byte. The *length * of the string (which may include embedded nulls) is considered as a 2-byte unsigned integer. so the string is limited in length to 65,535 bytes. The *hash* return is the internal hash byte for the copied string.

StrcpyN()- copy a string

Copies the *source * string to the *destination * area. The *length * of the string (which may include embedded nulls) is considered as a 2-byte unsigned integer. The *hash* return is the internal hash byte for the copied string.

StrcpyU()- copy a string, converting to uppercase Usage: hash= StrcpyU(destination,source,length)

Copies the *source * string to the *destination * area, converting to uppercase alphabetics. The *length * of the string (which may include embedded nulls) is considered as a 2-byte unsigned integer. The *hash* return is the internal hash byte for the copied string.

StrflipN()- reverse the characters in a string Usage: StrflipN(string,length)

Reverses the sequence of characters in a string. The conversion is performed in place.

Strlen()- :find the length of a null-terminated string Usage: length= Strlen(string)

(CCR)

Returns the number of characters in a null-terminated string. Register AO is preserved, and the CCR is set for the returned length.

StrcmpN()- compare the values of strings

(CCR)

The *stringl * and *string2* arguments are compared for the specified number of characters. The comparison proceeds character-by-character until a difference is found or the maximum number of characters have been examined. The returned value is -1 if the first string was less, 1 if the first string was greater, and O if the strings match exactly. The CCR register is set for the returned value.

ToUpper()- translate an ASCII character to uppercase Usage: upper= ToUpper(character)

Converts an ASCII character to uppercase. Only register DO is affected.

U **nlockRexxBase()-** unlock a shared resource. Usage: UnlockRexxBase(resource)

Releases the specified resource, or all resources if the argument is zero. Every call to LockRexxBaseO should be followed eventually by a call to UnlockRexxBaseO for the same resource.

WriteF()- write characters to a file buffer

(CCR)

Writes a buffer of characters of the specified length to the file associated with the **IoBuff**

pointer. The *buffer * argument is a pointer to a storage area, and the *length* argument

specifies the number of characters to be written. The returned value is the actual number of characters written or -1 if an error occurred.

