# Chapter 5 Commands 
The **REXX ** language is unusual in that an entire syntactic class of program statements are reserved for*commands, * statements that have meaning not within the language itself but rather to an external program. When a command clause is found in a program, it is evaluated as an expression and then sent through the *command interface * to an explicit or implicit *host application, * an external program that has announced its ability to receive commands. The host application then processes the command and returns a result code that indicates whether the command was performed successfully. In this manner every host program becomes fully programmable, and with even a limited set of predefined operations can be customized by the end user.

This chapter discusses the ARexx command interface and examines some of the ways in which commands can be used to build programs for an external program. Such programs are often called "macro programs" because they implement a complex ("macro") action from a series of simpler "micro" commands.

Chapter 10 has detailed information on the data structures required to implement a command interface for an applications program.

Syntactically, a command clause is just an expression that can't be classified as another type of clause. The actual structure of the command is dictated by the external host to which it is intended, but in most cases will follow the model of a name or letter followed by parameter data. Command names can be given as either a symbol or a string. However, it is generally safer to use a string for the name, since it can't be assigned a value or be mistaken for an instruction keyword. For example, the following might be commands for a text editor:

JUMP current+10 'insert' ***nevstring***'TOP'

```rexx

I* advance to next I* blast it in
I* back to the top
```

Since command clauses are expressions, they are fully evaluated before being sent to the host. Any part of the final command string can be computed within the program, so virtually any sort of command structure can be created.

The interpretation of the received commands depends entirely on the host application. In the simplest case the command strings will correspond exactly to commands that could be entered directly by a user. For instance, positional control (up/down) commands for a text editor would probably have identical interpretations whether issued by the user or from a program. Other commands may be valid only when issued from a macro program; a command to simulate a menu operation would probably not be entered by the user.

The destination for a command is determined by the current ***host address,*** which is the name of the ***public message port*** managed by an external program. ARexx maintains two implicit host addresses, a "current" and a "previous" value, as part of the program's storage environment. These values can be changed at any time using the **ADDRESS** instruction (or its synonym,**SHELL,)** and the current host address can be inspected with the **ADDRESS()** Built-In function. The default host address string is "REXX", but this can be overridden when a program is invoked. In particular, most host applications will supply the name of their public port when they invoke a macro program, so that the macro can automatically issue commands back to the host.

One special host address is recognized: the string **COMMAND** indicates that the command should be issued directly to the underlying DOS. All other host addresses are assumed to refer to a public message port. An attempt to send a command to a non-existent message port will generate the syntax error "Host environment not found."

Single commands can be sent to a specific host without disturbing the host address settings. This is done using the **ADDRESS** instruction, as the following example illustrates:

```rexx

ADDRESS MYEDIT 'jump top'
```

This example would send the command "jump top" to an external host named **"MYEDIT."**

It is important to note that you cannot send commands to a host application without knowing the name of its public message port. Writing macro programs to communicate with two or more hosts may require some clever programming to determine whether both hosts are active and what their respective host addresses are.

ARexx implements its command interface using the message-paï¿½sing facilities provided by the EXEC operating system. Each host application must provide a public message port, the name of which is referred to as the ***host address.*** ARex.x programs issue commands by placing the command string in a message packet and sending the packet to the host's message port. The program "sleeps" while the host processes the command, and awakens when the message packet returns. The entire process can be regarded as a dialogue between the host application and a macro program: the host initiates the dialogue by invoking the macro, and the macro program replies with one or more command strings. The commands that can be sent are not limited to simple text strings, but might be address pointers or even bit-mapped images.

After it finishes processing a command, the host "replies" the message packet with a ***return code *** that indicates the status of the command. This return code is placed in the ARexx special variable**RC** so that it can be examined by the program. A value of zero is assumed to mean that no errors occurred, while positive values usually indicate progressively more severe error conditions. The return code allows the macro program to determine whether the command succeeded and to take action if it failed, so it is important for each applications program to document the meanings of the return codes for its commands.

Using Commands in Macro Programs

ARex.x can be used to write programs for any host application that includes a suitable command interface. Some applications programs are designed with an embedded macro language, and may include many predefined macro commands. \Vith a well-designed macro language interface the user will be usually be unaware of whether a given action is imple-mented as a primitive operation or as a macro program.

The starting point in designing a macro program is to examine the commands that would be required to perform it manually. The documentation for the host application pro-gram should then describe the possible return codes for each command; these codes can be used to determine whether the operation performed by the command was successful. Check also for "shortcut" commands that may be available only to macro programs; some appli-cations programs may include very powerful functions that were implemented specifically for use in macro programs.

Using ARexx with Command Shells

Although ARex.x was designed to work most effectively with programs that support its specific command interface, it can be used with any "command shell" program that uses standard I/O mechanisms to obtain its input stream. There are several ways to use ARexx to prepare a stream of commands for such program.

One obvious technique is to create an actual command file on the "RAM:" disk and then pass it directly to the command shell. For example, you could open a new CLI window to run a standard "execute" script using the following short program:

```rexx

I*Launch a  newCLI*I address command
conwindow = "CON;0/0/640/100/Newâ–¡ne"
I*create a command file on the fly*I call open out,"ram:$$temp",write
call writeln out, 'echo "this is a test"' call close out
I*open the new CLI window*I 'newcli' conwindow "ram:$$temp" exit
```

Since no disk accesses are required, this method is actually fairly fast, if not very elegant. Another alternative is to use the command stacking facility provided by the PUSH and

QUEUE instructions. These instructions allow an ARexx program to stack an arbitrary stream of commands and data for the command shell or other program to read. Any set of commands that could be "typed ahead" at a command prompt can be prepared in this fashion. After the ARexx program exits, the next program that uses the input stream will read the prepared commands and can process them in the normal fashion.

Sometimes it is necessary to write and test macro programs that issue potentially destructive commands. For instance, a program to find and delete unneeded files would be difficult to test safely, since it might accidentally delete the wrong files and would require a continual source of new files for testing.

To simplify the development and testing of such programs, ARexx provides a special tracing mode called ***command inhibition*** that suppresses host commands. While in com-mand inhibition mode, command processing proceeds normally except that the command is not actually issued and the variable RC is set to 0. T his allows the program logic to be verified before any commands are actually sent to the external program. Chapter 7 has further information on this facility.

