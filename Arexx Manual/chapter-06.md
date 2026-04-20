# Chapter 6 Functions 
The basic concept of a function is a program or group of statements that will be executed whenever the function name appears in a certain context. Functions are an important building block of most computer languages in that they allow ***modular programming-*** the ability to build a large program from a series of smaller, more easily developed modules. In ARexx a function may be defined as part of (internal to) a program, as part of a library, or as a separate external program.

Syntax and Search Order

Function calls in an expression are defined syntactically as a symbol or string followed immediately by an open parenthesis. The symbol or string (taken as a literal) specifies the ***function name,*** and the open parenthesis begins the ***argument list.*** Between the opening and

~/ eventual dosing parentheses are zero or more argument expressions, separated by commas, that supply the data being passed to the function. For example,

CENTER('title',20) ADDRESS()

'AllocMem'(256â€¢4,1)

are all valid function calls. Each argument expression is evaluated in turn and the resulting strings are passed as the argument list to the function. There is no limit to the number of arguments that may be passed to an internal function, but calls to Built-In or external functions are limited to a maximum of 15 arguments. Note that each argument expression, while often just a single literal value, can include arithmetic or string operations or even other function calls. Argument expressions are evaluated from left to right.

Functions can also be invoked using the **CALL ** instruction. The syntax of this form is slightly different, and is described in Chapter 4. The**CALL** instruction can be used to invoke a function that may not return a value.

Function linkages in ARexx are established dynamically at the time of the function call. A specific search order is followed until a function matching the name symbol or string is found. If the specified function cannot be located, an error is generated and the expression evaluation is terminated. The full search order is:

Internal Functions. The program source is examined for a label that matches the function name. If a match is found, a new storage environment is created and control is transferred to the label.

Built-In Functions. The Built-In function library is searched for the specified name. All of these functions are defined by uppercase names, and the library has been specially organized to make the search as efficient as possible.

External ARexx Programs. The final search step is to check for an external ARexx program file by sending an invocation message to the ARexx resident process. The search always begins in the current directory, and follows the same search path as the original ARexx program invocation. The name matching process is not case-sensitive.

Note that the function name-matching procedure may be case-sensitive for some of the search steps but not for others. The matching procedure used in a function library or function host is left to the discretion of the applications designer. Functions defined with mixed-case names must be called using a string token, since symbol names are always translated to uppercase.

The full search order is followed whenever the function name is defined by a symbol token. However, the search for internal functions is bypassed if the name is specified by a string token. This allows internal functions to usurp the names of external functions, as in the following example:

```rexx

arg string,length length= min(length,6O)
return 'CENTER'(string,length)
f *internal "CENTER"* f f *get arguments*I I* compute length
```

Here the Built-In function CENTER() has been replaced by an internal function of the same name, which calls the original function after modifying the length argument.

The interpreter creates a new storage environment when an internal function is called, so that the previous (caller's) environment is preserved. The new environment inherits the values from its predecessor, but subsequent changes to the environment variables do not affect the previous environment. The specific values that are preserved a.re:

The current and previous host addresses,

The NUMERIC DIGITS, FUZZ, and FORM settings,

The trace option, inhibit flag, and interactive flag,

The state of the interrupt flags defined by the SIGNAL instruction, and

The current prompt string as set by the OPTIONS PROMPT instruction.

The new environment does not automatically get a new symbol table, so initially all of the variables in the previous environment are available to the called function. The PROCEDURE

instruction can be used to create a new symbol table and thereby protect the ca.ller's symbol values.

Execution of the internal function proceeds until a RETURN instruction is executed. At this point the new environment is dismantled and control resumes at the point of the function ca.11. The expression supplied with the RETURN instruction is evaluated and passed back to the caller as the function result.

ARexx provides a substantial library of predefined functions as part of the language system. These functions are always available and have been optimized to work with the internal data structures. In general the Built-In functions execute much faster than an equivalent interpreted function, so their usage is strongly recommended.

The Built-In Function Library is not user-extensible, but additional functions will be included in later releases.

External function libraries provide a mechanism with which users and applications develop-ers can extend the functionality of ARexx. A function library is a collection of one or more functions together with a "query" entry point that serves to match a name string with the appropriate function. External function libraries are supported as standard Amiga shared libraries, and may be either memory or disk-resident. Disk-resident libraries are loaded and opened as needed.

The ARexx resident process maintains a list, called the *Library List,* of the currently available function libraries and function hosts. Applications programs can add or remove function libraries as required. The Library List is maintained as a priority-sorted queue, and entries can be added at an appropriate priority to control the function name resolution. Libraries with higher priorities are searched first; within a given priority level, those libraries added first are searched first.

During the search process the ARexx interpreter opens each library and calls its "query" entry point. The query function must then check to see whether the requested function name is in the library. ]f not, it returns a "function not found" error code and the search continues with the next library in the list. Function libraries are always dosed after being checked so that the operating system can reclaim the memory space if required. Once the requested function has been found, it is called with the arguments passed by the interpreter, and must return an error code and a result string.

The ARexx language system includes an external function library in a file called "rexxsupport. library." It contains a number of Amiga-specific functions and is described in Appendix D. Chapter 10 provides information on designing and implementing function libraries.

Function hosts are called by sending a function invocation message packet to the public message port identified by the host's name. No constraints are imposed on the internal design of the host except that it must eventually return the invocation message with an appropriate return code and result string. The function call may result in a new program being loaded and run, or might even be sent to a network handler as a remote procedure call.

The available function hosts, along with the function libraries, are contained in the Library List maintained by the resident process. This list provides a general mechanism for resolving function names in a priority-controlled manner.

The ARexx resident process is an example of a function host. It is added to the Library List at a nominal priority of -60 when the resident process is started, using the same name ("REXX") that is used for command invocations. When it receives a function invocation packet, it searches for an external file matching the function name, just as it would for a command invocation of the same name. In particular, the search begins with the current directory and proceeds to the system REXX: directory. Two names are used in the search: the function name with the current file extension appended, and the name by itself. The name matching process is not case-sensitive, but is affected by the presence of explicit directory specifications or file extensions in the name string. The rules governing the search for external programs are covered in Chapter 9.

External programs are always run as a separate process in the Amiga's multitasking system. The calling program "sleeps" until the called function finishes and the message packet returns. The result string and error code are returned in the packet.

This section of the chapter is devoted to descriptions of the individual Built-In functions, which are listed alphabetically. Many of the functions have optional as well as required arguments. The optional arguments are shown in brackets, and generally have a default value that is used if the argument is omitted.

Maximum Arguments. While internal functions can be called with any number of argu-ments, the Built-In functions ( and external functions as well) are limited to a maximum of 15 arguments.

Pad and Option Characters. For functions that accept a "pad" character argument, only the first character of the argument string is significant. If a null string is supplied, the default padding character (usually a blank) will be used. Similarly, where an option keyword is specified as an argument, only the first character is significant. Option keywords may be given in uppercase or lowercase.

1/0 Support Functions. ARexx provides functions for creating and manipulating exter-nal DOS files. The functions available at the present time are OPEN(), CLOSE(), READCH(), READLN(), WRITECH O, WRITELN(), EDF(), SEEK(), and EXISTS(). Files are referenced by a "logical name," a case-sensitive name that is assigned to a file when it is first opened.

There is no limit to the number of files that may be open simultaneously, and all open files are closed automatically when the program exits.

Bit-Manipulation Functions. The functions BITCHG(), BITCLR(), BITCOMP(), BIT-SET(), and BITTST() are provided to implement extended bit-testing on character strings. These functions differ from similar string-manipulation functions in that the elementary unit of comparison is the bit rather than the byte. Bit numbers are defined such that bit 0 is the low-order bit of the rightmost byte of the string.

Returns a boolean value that indicates whether *string2* is an abbreviation of *stringl * with length greater than or equal to the specified *length* argument. The default length is 0, so the null string is an acceptable abbreviation.

```rexx

say abbrev('fullname','ful') say abbrev('almost','alm',4) say abbrev('any','')
==> 1
==> 0
==> 1
```

Returns the absolute value of the *number* argument, which must be numeric. Examples:

```rexx

say abs(-5.35) say abs(10)
==> 5.35
==> 10
```

Adds a function library or a function host to the Library List maintained by the resident process. The *name * argument specifies either the name of a function library or the public message port associated with a function host. The name is case-sensitive, and any libraries thus declared should reside in the system LIBS: directory. The *priority * argument specifies the search priority and must be an integer between 100 and -100, inclusive. The *offset * and *version * arguments apply only to libraries. The *offset * is the integer offset to the library's "query" entry point, and the *version* is an integer specifying the minimum acceptable release level of the library.

The function returns a boolean result that indicates whether the operation was suc-cessful. Note that if a library is specified, it is not actually opened at this time; similarly, no check is performed as to whether a specified function host port has been opened yet. Example:

```rexx

say addlib("rexxsupport.library",0,-30,0) ==> 1 call addlib 11 EtherNet 11,-20 I* a gate.ray*I
```

Returns the current host address string. The host address is the message port to which commands will be sent. THe **SHOW()** function can be used to check whether the required external host is actually available.

```rexx

say address() ==> REXX
```

ARGO returns the number of arguments supplied to the current environment. If the *number * parameter alone is supplied, the corresponding argument string is returned. If a number and one of the keywords **Exists** or Omitted is given, the boolean return indicates the status of the corresponding argument. Note that the existence or omission test does not indicate whether the string has a null value, but only whether a string was supplied.

Converts a string of binary digits (0, 1) into the corresponding (packed) character repre-sentation. The conversion is the same as though the argument string had been specified as a literal binary string (e.g. '1010'B). Blanks are permitted in the string, but only at byte boundaries. This function is particularly useful for creating strings that are to be used as bit masks.

```rexx

==> a
say b2c('00110011') say b2c('01100001')
==> 3
```

The argument strings are logically ANDed together, with the length of the result being the longer of the two operand strings. If a pad character is supplied, the shorter string is padded on the right; otherwise, the operation terminates at the end of the shorter string and the remainder of the longer string is appended to the result.

```rexx

bitand('0313'x,'FFF0'x) ==> '0310'x
```

Changes the state of the specified bit in the argument string. Bit numbers are defined such that bit O is the low-order bit of the rightmost byte of the string.

```rexx

bitchg('0313'x,4) ==> '0303'x
```

Clears (sets to zero) the specified bit in the argument string. Bit numbers are defined such

that bit O is the low-order bit of the rightmost byte of the string. Example:

```rexx

bitclr('0313'x,4) ==> '0303'x
```

Compares the argument strings bit-by-bit, starting at bit number 0. The returned value is the bit number of the first bit in which the strings differ, or -1 if the strings are identical. Examples:

```rexx

==>
```

-1

```rexx

==> 7
```

bitcomp('7F'x,'FF'x)

bitcomp('FF'x,'FF'x)

The argument strings are logically ORed together, with the length of the result being the longer of the two operand strings. If a ***pad*** character is supplied, the shorter string is padded on the right; otherwise, the operation terminates at the end of the shorter string and the remainder of the longer string is appended to the result.

```rexx

bitor('0313'x,'003F'x) ==> '033F'x
```

Sets the specified bit in the argument string is 1. Bit numbers are defined such that bit 0

is the low-order bit of the rightmost byte of the string. Example:

```rexx

bitset('0313'x,2) ==> '0317'x
```

The boolean return indicates the state of the specified bit in the argument string. Bit

```rexx

==>
```

numbers are defined such that bit O is the low-order bit of the rightmost byte of the string. Example:

bittst('0313'x,4)

The argument strings are logically exclusively-ORed together, with the length of the result being the longer of the two operand strings. If a *pad* character is supplied, the shorter striI1g is padded on the right; otherwise, the operation terminates at the end of the shorter string and the remainder of the longer string is appended to the result.

```rexx

bitxor('0313'x,'001F'x) ==> '030C'x
```

Converts the character string into the equivalent string of binary digits. See Also: **C2X0**

```rexx

say c2b( 'abc') ==> 011000010110001001100011
```

Converts the *string * argument from its character representation to the corresponding decimal number, expressed as ASCII digits (0-9). If *n * is supplied, the character string is considered to be a number expressed in *n* bytes. The string is truncated or padded with nulls on the left as required, and the sign bit is extended for the conversion.

```rexx

==>
say c2d('FF0100'x,2)
```

Converts the *string* argument from its character representation to the corresponding hex-adecimal number, expressed as the ASCII characters 0 9 and A-F.

```rexx

say c2x('abc') ==> 616263
```

CENTER() or CENTRE()

Centers the *string * argument in a string with the specified *length.*If the length is longer than that of the string, * pad*characters or blanks are added as necessary.

```rexx

say center('abc',6)
say center('abc',6,'+')
say center('123456',3)
==> ' abc '
==> '+abc++'
==> '234'
```

Closes the file specified by the given logical name. The returned value is a boolean success flag, and will be 1 unless the specified file was not open.

```rexx

say close('input') ==> 1
```

If the *list * argument is omitted, the function removes leading, trailing, or embedded blank characters from the *string * argument. If the optional *list* is supplied, it specifies the characters to be removed from the string.

```rexx

say compress(' vhy  not ') ==>vhynot
say compress('++12-34-+','+-') ==> 1234
```

Compares two strings and returns the index of the first position in which they differ, or 0 if the strings are identical. The shorter string is padded as required using the supplied character or blanks.

```rexx

say compare('abcde','abcce')
say compare('abcde','abcde')
say compare('abc++','abc+-','+')
==> 4
==>
==> 5
```

Creates a new string by concatenating the specified number of copies of the original. The

number argument may be zero, in which case the null string is returned.

Creates a string whose value is the binary (packed) representation of the given decimal number.

d2c(31)

```rexx

==> '1F'x
```

If the *option * parameter is not specified, **DATATYPE()** tests whether the *string * parameter is a valid number and returns either NUM or CHAR. If an option keyword is given, the boolean re-turn indicates whether the string satisfied the requested test. The following option keywords are recognized:

Table 6.1 **DATATYPEO** Options

Alphanumeric Alphabetics (A-Z,a-z)

or Numerics (0-9)

```rexx

say datatype('123')
say datatype('1a f2','x') say datatype('aBcde','L')
```

Binary Digits String Lowercase Alphabetics (a-z) Mixed Upper/Lowercase Valid Numbers

Valid REXX Symbols Uppercase Alphabetics (A-Z) Integer Numbers

```rexx

==> NUM
==> 1
==> 0
```

Deletes the substring of the *string * argument beginning with the nth character for the specified *length* in characters. The default length is the remaining length of the string.

Deletes the substring of the *string * argument beginning with the nth word for the specified *length* in words. The default length is the remaining length of the string. The deleted string includes any trailing blanks following the last word.

```rexx

say delword('Tell me a story',2,2) ==> 'Tell story' say delword('one two three',3) ==> 'one two '
```

Checks the specified logical file name and returns the boolean value 1 (True) if the end-of-

:file has been reached, and O (False) otherwise. Example:

```rexx

say eof(infile)
==> 1
```

Returns the error message associated with the specified ARexx error code. The null string is returned if the number is not a valid error code.

```rexx

say errortext(41) ==> Invalid expression
```

Tests whether an external file of the given *filename* exists. The name string may include device and directory specifications.

```rexx

say exists('df0:c/ed') ==> 1
```

Copies data from the (optional) string into a previously-allocated memory area, which must be specified as a 4-byte address. The *length * parameter specifies the maximum number of characters to be copied; the default is the length of the string. If the specified length is longer than the string, the remaining area is filled with the *pad* character or nulls ( '00 'x). The returned value is the number of characters copied.

Caution is advised in using this function. Any area of memory can be overwritten, possibly causing a system crash. Task switching is forbidden while the copy is being done, so system performance may be degraded if long strings are copied.

```rexx

count = export('0004 OOOO'x,'The answer')
```

Returns a block of memory of the given length to the interpreter's internal pool. The *address * argument must be a 4-byte string obtained by a prior call to **GETSPACE(),** the internal allocator. It is not always necessary to release internally-allocated memory, since it will be released to the system when the program terminates. However, if a very large block has been allocated, returning it to the pool may avoid memory space problems. The return value is a boolean success flag.

```rexx

say freespace('00042000'x,32) ==> 1
```

Searches the Clip List for an entry matching the supplied *name* parameter, and returns the associated value string. The name-matching is case-sensitive, and the null string is returned if the name cannot be found. The usage and maintenance of Clip List entries is described in the Chapter 9.

```rexx

f *Assume 'numbers' contains 'PI=3.14159'*' say getclip('numbers') ==> PI=3.14159
```

GETSPACE{)

Allocates a block of memory of the specified length from the interpreter's internal pool. The returned value is the 4-byte address of the allocated block, which is not cleared or otherwise initialized. Internal memory is automatically returned to the system when the ARexx program terminates, so this function should not be used to allocate memory for use by external programs. The Support Library (described in Appendix D) includes the function ALLOCMEM() which to allocate memory from the system free list.

```rexx

say c2x(getspace(32)) ==> '0003BF40'x
```

Returns the hash attribute of a string as a decimal number, and updates the internal hash value of the string.

```rexx

==> 49
say hash(' 1')
```

Creates a string by copying data from the specified 4-byte address. If the length parameter is not supplied, the copy terminates when a null byte is found.

extval *=* import('0004 OOOO'x,8)

Searches for the first occurrence of the *pattern * argument in the *string * argument, beginning at the specified *start* position. The default start position is 1. The returned value is the index of the matched pattern, or O if the pattern was not found.

```rexx

say index("123456","23")
say index("123456","77")
say index("123123","23",3)
==> 2
==>
==> 5
```

Inserts the *new * string into the *old * string after the specified *start * position. The default starting position is 0. The new string is truncated or padded to the specified *length* as required, using the supplied pad character or blanks. If the start position is beyond the end

----.- of the old string, the old string is padded on the right.

```rexx

say insert('ab','12345') *==>* ab12345 say insert('123','++',3,5,'-') *==>*++-123--
```

Searches backwards for the first occurrence of the *pattern * argument in the *string * argument, beginning at the specified *start* position. The default starting position is the end of the string. The returned value is the index of the matched pattern, or O if the pattern was not found.

```rexx

say lastpos("123234","2") say lastpos("123234","5") say lastpos("123234","2",3)
==> 4
==>
==> 2
```

Returns the leftmost substring in the given *string * argument with the specified *length.*If the substring is shorter than the requested length, it is padded on the left with the supplied * pad*character or blanks.

```rexx

say left('123456',3)
say left('123456',8,'+')
say length('three')
==> 123
==> 123456++
==> 5
```

Returns the maximum of the supplied arguments, all of which must be numeric. At least two parameters must be supplied.

```rexx

say max(2.1,3,-1) ==> 3
```

Returns the minimum of the supplied arguments, all of which must be numeric. At least two parameters must be supplied.

```rexx

say min(2.1,3,-1) ==> -1
```

Opens an external file for the specified operation. The *file * argument defines the logical name by which the file will be referenced. The *filename* is the external name of the file, and may include device and directory specifications. The function returns a boolean value that indicates whether the operation was successful. There is no limit to the number of files that

can be open simultaneously, and all open files are closed automatically when the program exits.

```rexx

say open('MyCon','C0N:160/ 50/320/100/MyCon/cds') ==> 1 say open('outfile','ram:temp','W') ==> 1
```

Overlays the *new * string onto the *old * string beginning at the specified *start * position, which must be positive. The default starting position is 1. The new string is truncated or padded to the specified *length * as required, using the supplied *pad* character or blanks. If the start position is beyond the end of the old string, the old string is padded on the right.

```rexx

say overlay('bb', 'abed') ==> bbcd
```

Searches for the first occurrence of the *pattern * argument in the *string * argument, beginning at the position specified by the *start* argument. The default starting position is 1. The returned value is the index of the matched string, or O if the pattern wasn't found.

```rexx

say pos('23','123234')
say pos('77','123234')
say pos('23','123234',3)
==> 2
==> 0
==> 4
```

This function allows a program to change various attributes relating to the system environ-ment within which the program executes. The *option * argument is a keyword that specifies an environmental attribute; the currently implemented options are Directory and Pri-ority. The *value* argument supplies the new attribute value to be installed. The value returned by the function depends on the attribute selected. Some attributes return the previous value installed, while others may simply set a boolean success flag. The currently defined option keywords are listed below.

Directory. Specifies a new "current" directory. The current directory is used as the "root" for filenames that do not explicitly include a device specification. The return value is a boolean success flag.

Priority. Specifies a new task priority. The priority value must be an integer in the range -128 to 127, but the practical range is much more limited. ARexx pro-grams should never be run at a priority higher than that of the resident process, which currently runs at priority 4. The returned value is the previous priority level.

Returns a pseudorandom integer in the interval specified by the *min * and *max* arguments. The default minimum value is 0 and the default maximum value is 999. The interval max-min must be less than or equal to 1000. If a greater range of random integers is required, the values from the RANDUO function can be suitable scaled and translated.

The *seed* argument can be supplied to initialize the internal state of the random number generator.

thisroll random(1,6) nextroll = random(1,6)

U.,age: RANDU({.9eed})

```rexx

I*might be 1*I I* snake eyes?*I
```

Returns a uniformly-distributed pseudorandom number between 0 and 1. The number of digits of precision in the result is always equal to the current Numeric Digits setting. With the choice of suitable scaling and translation values, RANDU() can be used to generate pseudorandom numbers on an arbitrary interval.

The optional *seed* argument is used to initialize the internal state ofthe random number generator.

```rexx

firsttry = randu() numeric digits 3 tryagain = randu()
```

U.,age: READCH(file,length)

```rexx

I*0.371902021?*I
I*0.873?*I
```

Reads the specified number of characters from the given logical file into a string. The length of the returned string is the actual number of characters read, and may be less than the requested length if, for example, the end-of file was reached.

instring readch('input',10)

Reads characters from the given logical file into a string until a "newline" character is found. The returned string does not include the "newline."

```rexx

instring = readln('MyFile')
```

Removes an entry with the given *name* from the Library List maintained by the resident process. The boolean return is 1 if the entry was found and successfully removed. Note that this function does not make a distinction between function libraries and function hosts, but simply removes a named entry.

```rexx

say remlib('MyLibrary .library') ==> 1
```

Reverses the sequence of characters in the string. Example:

```rexx

say reverse('?ton yhw') ==> why not?
```

Returns the rightmost substring in the given *string * argument with the specified *length.*If the substring is shorter than the requested length, it is padded on the left with the supplied pad character or blanks.

```rexx

say right('123456' ,4) ==> 3456
say right('123456' ,8,'+') ==> ++123456
```

Moves to a new position in the given logical file, specified as an offset from an anchor position. The default anchor is Current. The returned value is the new position relative to the start of the file.

```rexx

say seek('input',10,'B')
say seek('input',0,'E')
==> 10
==> 356 I*file length*I
```

Adds a name-value pair to the Clip List maintained by the resident process. **If** an entry of the same name already exists, its value is updated to the supplied value string. Entries may

be removed by specifying a null value. The function returns a boolean value that indicates whether the operation was successful.

```rexx

say setclip('path' ,'df0:s') say setclip('path')
==> 1
==> 1
```

Returns the names in the resource list specified by the *option * argument, or tests to see whether an entry with the specified *name* is available. The currently implemented options keywords are Clip, Files, Libraries, and Ports, which are described below.

Clip. Examines the names in the Clip List.

Files. Examines the names of the currently open logical file names.

Libraries. Examines the names in the Library List, which are either function libraries or function hosts.

Ports. Examines the names in the system Ports List.

If the *name * argument is omitted, the function returns a string with the resource names separated by a blank space or the *pad * character, if one was supplied. **If ** the*name * argument is given, the returned boolean value indicates whether the name was found in the resource

list. The name entries are case-sensitive.

SIGN(}

Returns 1 if the *number * argument is positive or zero, and -1 if *number* is negative. The argument must be numeric.

```rexx

say sign(12) say sign(-33)
==> 1
==> -1
```

Reformats the *string * argument so that there are *n * spaces (blank characters) between each pair of words. **If ** the*pad * character is specified, it is used instead of blanks as the separator character. Specifying n as O will remove all blanks from the string.

```rexx

say space('Now is the time',3) say space('Now is the tirne,O) say space('1 2 3',1,'+')
==> 'Now is the
==> 'Nowisthetirne'
==> '1+2+3'
```

time'

Calling **STORAGE()** with no arguments returns the available system memory. If the *address * argument is given, it must be a 4-byte string, and the function copies data from the (op-tional)*string * into the indicated memory area. The *length * parameter specifies the maximum number of bytes to be copied, and defaults to the length of the string. If the specified length is longer than the string, the remaining area is filled with the *pad * character or nulls ( '00'x.)

The returned value is the previous contents of the memory area. This can be used in a subsequent call to restore the original contents.

Caution is advised in using this function. Any area of memory can be overwritten, possibly causing a system crash. Task switching is forbidden while the copy is being done, so system performance may be degraded if long strings are copied.

```rexx

say storage() ==> 248400 oldval = storage('0004 0000'x,'The answer') call storage '0004 0000'x,,32,'+'
say strip(' say what? ')
say strip(' say what? ','L')
say strip('++123+++','B','+')
==> 'say what?'
==> 'say what?
==> '123'
```

Returns the substring of the *string * argument beginning at the specified *start * position for the specified *length.* The starting position must be positive, and the default length is the remaining length of the string. **If ** the substring is shorter than the requested length, it is padded on the left with the blanks or the specified*pad * character.

```rexx

say substr('123456',4,2) ==> 45
say substr('myname',3,6,'=') ==> name==
```

Returns the substring of the ***string *** argument beginning with the***nth *** word for the specified***length*** in words. The default length is the remaining length of the string. The returned string will never have leading or trailing blanks.

```rexx

say subword('Now is the time ',2,2) ==> is the
```

Tests whether the ***name*** argument is a valid REXX symbol. If the name is not a valid symbol, the function returns the string BAD. Otherwise, the returned string is LIT if the symbol is uninitialized and VAR if it has been assigned a value.

```rexx

say symbol('J') say symbol('x') say symbol('++')
==> VAR
==> LIT
==> BAD
```

Returns the current system time or controls the internal elapsed time counter. The valid option keywords are listed below.

Table 6.2 TIME() Options

Elapsed time in seconds

Current time in hours since midnight Current time in minutes since midnight Reset the elapsed time clock

Current time in seconds since midnight

If no option is specified, the function returns the current system time in the form HH:MM: SS. Examples:

```rexx

I* Suppose that the time is
say time('Hours')
```

1:02 AM

```rexx

==> 1
say time('m')
==> 62
say time('S')
==> 3720
call time 'R'
say time('E')
I* reset timer
==> .020
```

Sets the tracing mode to that specified by the *option * keyword, which must be one of the valid alphabetic or prefix options. The tracing options are described in Chapter 7. The **TRACE()** function will alter the tracing mode even during interactive tracing, when **TRACE** instructions in the source program are ignored. The returned value is the mode in effect before the function call; this allows the previous trace mode to be restored later.

```rexx

I* Assume tracing mode is ?ALL
say trace('Results') ==> ?A
```

This function constructs a translation table and uses it to replace selected characters in the argument string. If only the *string * argument is given, it is translated to uppercase. If an *input * table is supplied, it modifies the translation table so that characters in the argument string that occur in the input table are replaced with the corresponding character in the *output* table. Characters beyond the end of the output table are replaced with the specified pad character or a blank.

Note that the result string is always of the same length as the original string. The input and output tables may be of any length.

```rexx

say translate("abcde", 11123","cbade","+") say translate("lov")
say translate("0110","10","01")
```

Removes trailing blanks from the *string* argument. Example:

```rexx

==> 321++
==> LOW
==> 1001
==> 4
say length(trim(' abc '))
```

Translates the *string* to uppercase. The action of this function is equivalent to that of

TRANSLATE(string), but it is slightly faster for short strings. Example:

```rexx

say upper('One Fine Day') ==> ONE FINE DAY
```

Returns the value of the symbol represented by the *name* argument. Example:

```rexx

I* Assume that J has the value 12
```

If the **Match ** argument is omitted, the function returns the index of the first character in the*string * argument which is not contained in the *list * argument, or O if all of the characters are in the list. If the Match keyword is supplied, the function returns the index of the first character which is in the list, or O if none of the characters are.

```rexx

say verify('123456','0123456789')
say verify('123a56','0123456789')
say verify('123a45' ,'abcdefghij','m')
==> 0
==>
==> 4
```

Returns the nth word in the *string * argument, or the null string if there are fewer than *n*

words. Example:

',2)

```rexx

say word('Now is the time
==> is
```

Returns the starting position of the nth word in the argument string, or O if there are fewer than n words.

',3)

```rexx

say wordindex('Now is the time
==> 8
```

Returns the length of the nth word in the *string* argument. Example:

```rexx

say wordlength('one two three',3) ==> 5
```

Returns the number of words in the *string* argument. Example:

```rexx

say words("You don't say!") ==> 3
```

Writes the *string* argument to the given logical file. The returned value is the actual number of characters written.

```rexx

==> 7
say writech('output' ,'Testing')
```

Writes the *string* argument to the given logical file with a "newline" appended. The returned value is the actual number of characters written.

```rexx

say writeln('output' ,'Testing') ==> 8
```

X2C{)

Converts a string of hex digits into the (packed) character representation. Blank characters are permitted in the argument string at byte boundaries.

```rexx

say x2c('12ab') say x2c('12 ab')
==> '12ab'x
==> '12ab'x
```

Generates a string consisting of all characters numerically between the specified *start * and *end * values. The default start character is '00'x, and the default end character is 'FF' x. Only the first character of the *start * and *end* arguments is significant.

```rexx

say xrange()
say xrange('a','f') say xrange(,'10'x)
==> '00010203 ... FDFEFF'x
==> 'abcdef'
==> '0001020304050607080910'x
```

