# Appendix D The ARexx Support Library 
The ARexx language system is distributed with an external function library that provides a number of Amiga-specific functions. It is a standard Amiga shared library named rexxsup-port. library and should reside in the system **LIBS:** directory. Unlike the Systems Library described in the previous Appendix, the support library functions are callable from with ARexx programs.

The support library was designed to supplement the generic Built-In functions with functions specific to the Amiga. This library will be expanded in future releases, and users are encouraged to submit suggestions for additional functions.

The Support Library must be added to the global Library List before it can be accessed by ARexx programs. This can be done using the Built-In function **ADDLIB()** or by direct communication with the resident process. The library name must be specified as rexxsup-port. library, the query function offset is -30, and the version number is 0. The search priority can be set to 0 or whatever value is appropriate.

Allocates a block of memory of the specified length from the system free-memory pool and returns its address as a 4-byte string. The optional *attribute* parameter must be a standard EXEC memory allocation flag, supplied as a 4-byte string. The default attribute is for "PUBLIC" memory (not cleared).

This function should be used whenever memory is allocated for use by external pro-grams. It is the user's responsibility to release the memory space when it is no longer needed.

```rexx

say c2x(allocmem(1000))
==> 00050000
```

Closes the message port specified by the *name * argument, which must have been allocated by a call to **0PENP0RTO** within the current ARexx program. Any messages received but not yet REPLYed are automatically returned with the return code set to 10.

call closeport myport

FREEMEM{)

Releases a block of memory of the given length to the system freelist. The *address * parameter is a four-byte string, typically obtained by a prior call to **ALLOCMEM(). FREEMEM()** cannot be used to release memory allocated using **GETSPACE(),** the ARexx internal memory allocator. The returned value is a boolean success flag.

```rexx

say freemem('00042000'x,32) ==> 1
```

Extracts a command, function name, or argument string from a message packet. The *packet * argument must be a 4-byte address obtained from a prior call to **GETPKT().** The optional n argument specifies the slot containing the string to be extracted, and must be less than or equal to the actual argument count for the packet. Commands and function names are always in slot 0; function packets may have argument strings in slots 1-15.

```rexx

command = getarg(packet)
function = getarg(packet,0) f *name string*I
```

arg1 **=** getarg(packet,1) /*1st argument*I

Checks the message port specified by the *name * argument to see whether any messages are available. The named message port must have been opened by a prior call to **OPENPORT()** within the current ARexx program. The returned value is the 4-byte address of the first message packet, or '0000 0000' x **if** no packets were available.

The function returns immediately whether or not a packet is enqueued at the message port. Programs should never be designed to "busy-loop" on a message port. **If ** there is no useful work to be done until the next message packet arrives, the program should call**WAITPKT()** and allow other tasks to proceed.

```rexx

packet = getpkt('MyPort')
```

Creates a public message port with the given name. The returned value is the 4-byte address of the Port Resource structure or '0000 0000 'x if the port could not be opened or initialized. An initialization failure will occur **if** another port of the same name already exists, or if a signal bit couldn't be allocated.

The message port is allocated as a Port Resource node and is linked into the program's global data structure. Ports are automatically closed when the program exits, and any pend.ing messages are returned to the sender.

```rexx

myport = openport("MyPort")
```

Returns a message packet to the sender, with the primary result field set to the value given by the *re * argument. The secondary result is cleared. The *packet * argument must be supplied as a 4-byte address, and the *re* argument must be a whole number.

```rexx

call reply packet,10 I*error return*I
```

Returns the contents of the specified directory as a string of names separated by blanks. The second parameter is an option keyword that selects whether all entries, only files, or only subdirectories will be included.

```rexx

say showdir("df1:c") ==> rx ts te hi tco tee
```

The first argument is an option keyword to select a system list; the options currently sup-ported are Devices, Libraries, Ports, Ready, and Waiting. If only the first parameter is supplied, the function scans the selected list and returns the node names in a string sepa-rated by blanks. If the *name* parameter is supplied, the boolean return indicates whether the specified list contains a node of that name. The name matching is case-sensitive.

The list is scanned with task switching forbidden so as to provide an accurate snapshot of the list at that time.

```rexx

say showlist('P')
say showlist('P','REXX')
==> REXX MyCon
==> 1
```

Returns a string containing information about an external file. The string is formatted as "{DIR I FILE} ***length blocks protection comment."***

The ***length *** token gives the file length in bytes, and the***block*** token specifies the file length in blocks.

```rexx

say st atef("libs: rexxsupport. library")
I*vould give "FILE 1880 4 RWED "*I
```

waits for a message to be received at the specified (named) port, which must have been opened by a call to 0PENP0RTO within the current ARexx program. The returned boolean value indicates whether a message packet is available at the port. Normally the returned value will be **1 (True),** since the function waits until an event occurs at the message port.

The packet must then be removed by a call to GETPKTO, and should be returned eventually using the REPLY() function. Any message packets received but not returned when an ARexx program exits are automatically REPLYed with the return code set to 10. Example;

```rexx

call vaitpkt 'MyPort' I*vait awhile*I
```

