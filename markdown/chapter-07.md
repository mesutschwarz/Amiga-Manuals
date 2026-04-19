# Chapter 7 Tracing and Interrupts 
ARexx provides tracing and source-level debugging facilities that are unusual in a high-level language. ***Tracing *** refers to the ability to display selected statements in a program as the program executes. When a clause is traced, its line number, source text, and related information are displayed on the console. The tracing action of the interpreter is determined by a***trace option *** that selects which source clauses will be traced, and two modifier flags that control***command inhibition *** and***interactive tracing.***

The internal ***interrupt system*** enables an ARexx program to detect certain synchronous or asynchronous events and to take special actions when they occur. Events such as a syntax error or an external halt request that would normally cause the program to exit can instead be trapped so that corrective actions can be taken.

Trace options are sometimes called an alphabetic options, since the keywords that select an option can be shortened to one letter for convenience. The alphabetic options are:

ALL. All clauses are traced.

COMMANDS. All command clauses are traced before being sent to the external host. Non-zero return codes are displayed on the console.

ERRORS. Commands that generate a non-zero return code are traced after the clause is executed.

INTERMEDIATES. All clauses are traced, and intermediate results are lisplayed dur-ing expression evaluation. These include the values retrieved for variaples, expanded compound names, and the results of function calls.

LABELS. All label clauses are traced as they are executed. A label will be displayed each time a transfer of control takes place.

NORMAL. Command clauses with return codes that exceed the current error failure level are traced after execution, and an error message is displayed. This is the default trace option.

RESULTS. All clauses are traced before execution, and the final result of each expression is displayed. Values assigned to variables by ARG, PARSE, or PULL instructions are also displayed.

SCAN. This is a special option that traces all clauses and checks for errors, but suppresses the actual execution of the statements. It is helpful as a preliminary screening step for a newly-created program.

The tracing mode can be set using either the **TRACE ** instruction or the**TRACE()** Built-In function. The **RESULTS** trace option is recommended for general-purpose testing. Tracing can be selectively disabled from within a program so that previously-tested parts of a program can be skipped.

Each trace line displayed on the console is indented to show the effective control (nesting) level at that clause, and is identified by a special three-character code, as shown in Table 7.1 below. The source for each clause is preceded by its line number in the program. Expression results or intermediates are enclosed in double quotes so that leading and trailing blanks will be apparent.

Table 7.1 Tracing Prefix Codes

+++ Command or syntax error

>C> EA'J)anded compound name

>F> Result of a function call

>L> Label clause

>O> Result of a dyadic operation

>P> Result of a prefix operation

>U> Uninitialized variable

>V> Value of a variable

>.> "Placeholder" token value

The tracing output from a program is always directed to one of two logical streams. The interpreter first checks for a stream named STDERR, and directs the output there if the stream exists. Otherwise the trace output goes to the standard output stream STDOUT and will be interleaved with the normal console output of the program. The STDERR and STDOUT streams can be opened and closed under program control, so the programmer has complete control over the destination of tracing output.

In some cases a program may not have a predefined output stream. For example, a program invoked from a host application that did not provide input and output streams would not have an output console. To provide a tracing facility for such programs, the resident process can open a special *global tracing console* for use by any active program. When this console opens, the interpreter automatically opens a stream named STDERR for each ARexx program in which STDERR is not currently defined, and the program then diverts its tracing output to the new stream.

The global console can be opened and closed using the command utilities teo and tee, respectively. The console may not close immediately upon request, however. The resident process waits until all active programs have diverted their tracing streams back to the default state before actually closing the console. Applications programs may provide direct control over the tracing console by sending request packets to the resident process, which is discussed in Chapter 10.

The trace stream (STDERR or STDOUT) is also used for trace input, so a program in interactive tracing mode will wait for user input from this console. The global tracing console is always shared among all currently active programs. Since it may be confusing to

have several programs simultaneously writing writing to the same console, it is recommended that only one program at a time be traced using the global console.

ARexx provides a tracing mode called ***command inhibition*** that suppresses host commands. In this mode command clauses are evaluated in the normal manner, but the command is not actually sent to the external host, and the return code is set to zero. This provides a way to test programs that issue potentially destructive commands, such as erasing files or formatting disks. Command inhibition does not apply to command clauses that are entered interactively. These commands are always performed, but the value of the special variable RC is left unchanged.

Command inhibition may be used in conjunction with any trace option. It is controlled by the "!" character, which may appear by itself or may precede any of the alphabetic options in a TRACE instruction. Each occurrence of the"!" character "toggles" the inhibition mode currently in effect. Command inhibition is cleared when tracing is set to OFF.

Interactive tracing is a debugging facility that allows the user to enter source statements while a program is executing. These statements may be used to examine or modify variable values, issue commands, or otherwise interact with the program. Any valid language state-ments can be entered interactively, with the same rules and restrictions that apply to the INTERPRET instruction. In particular, compound statements such as DO and SELECT must be complete within the entered line.

Interactive tracing can be used with any of the trace options. While in interactive tracing mode, the interpreter pauses after each traced clause and prompts for input with the code "+++." At each pause, three types of user responses are possible:

If a null line is entered, the program continues to the next pause point.

If an "=" character is entered, the preceding clause is executed again.

Any other input is treated as a 'debugging statement, and is scanned and executed.

The pause points during interactive tracing are determined by the tracing option cur-rently in effect, as the interpreter pauses only after a traced clause. However, certain instructions cannot be safely (or sensibly) re-executed, so the interpreter will not pause after executing one of these. The "no-pause" instructions are CALL, DO, ELSE, IF, THEN, and OTHERWISE. The interpreter will also not pause after any clause that generated an execution error.

Interactive tracing mode is controlled by the "?" character, either by itself or in combination with an alphabetic trace option. Any number of"?" characters may precede an option, and each occurrence toggles the mode currently in effect. For example, if the current trace option was NORMAL, then "TRACE ?R" would set the option to RESULTS and select interactive tracing mode. A subsequent "TRACE ?" would tum off interactive tracing.

The ARexx interpreter provides special error processing while it executes debugging state-ments. Errors that occur during interactive debugging are reported, but do not cause the program to terminate. This special processing applies only to the statements that were entered interactively. Errors occurring in the program source statements are treated in the usual way whether or not the interpreter is in interactive tracing mode.

In addition to the special error processing, the interpreter also disables the internal interrupt flags during interactive debugging. This is necessary to prevent an accidental transfer of control due to an error or uninitialized variable. However, if a **"SIGNAL label"** instruction is entered, the transfer will take place, and any remaining interactive input will be abandoned. The **SIGNAL** instruction can still be used to alter the interrupt flags, and the new settings will take effect when the interpreter returns to normal processing.

The ARexx resident process maintains an *external tracing flag * that can be used to force programs into interactive tracing mode. The tracing flag can be set using the ts command utility. When the flag is set, any program not already in interactive tracing mode will enter it immediately. The internal trace option is set to **RESULTS ** unless it is currently set to**INTERMEDIATES ** or**SCAN,** in which case it remains unchanged. Programs invoked while the external tracing flag is set will begin executing in interactive tracing mode.

The external tracing flag provides a way to regain control over programs that are caught in loops or are otherwise unresponsive. Once a program enters interactive tracing mode, the user can step through the program statements and diagnose the problem. There is one caveat, though: external tracing is a global flag, so all currently-active programs are affected by it. The tracing flag remains set until it is cleared using the "te" command utility. Each program maintains an internal copy of the last state of the tracing flag, and sets its tracing option to **OFF** when it observes that the tracing flag has been cleared.

ARexx maintains an internal interrupt system that can be used to detect and trap certain error conditions. When an interrupt is enabled and its corresponding condition arises, a transfer of control to the label specific to that interrupt occurs. This allows a program to retain control in circumstances that might otherwise cause the program to terminate. The interrupt conditions can caused by either *synchronous * events like a syntax error, or *asynchronous* events like a "control-C" break request. Note that these internal interrupts are completely separate from the hardware interrupt system managed by the EXEC operating system.

The interrupts supported by ARexx are described below. The name assigned to each is actually the label to which control will be tranferred. Thus, a **SYNTAX ** interrupt will transfer control to the label**"SYNTAX:."**Interrupts can be enabled or disabled using the ** SIGNAL**instruction. For example, the instruction **"SIGNAL ON SYNTAX"** would enable the **SYNTAX** interrupt.

BREAK_C. This interrupt will trap a control-C break request generated by DOS. If the interrupt is not enabled, the program terminates immediately with the error message "Execution halted" and returns with the error code set to 2.

BREAK_D. The interrupt will detect and trap a control-D break request issued by DOS. The break request is ignored if the interrupt is not enabled.

BREAK.E. The interrupt will detect and trap a control-E break request issued by DOS. The break request is ignored if the interrupt is not enabled.

BREAK...F. The interrupt will detect and trap a control-F break request issued by DOS. The break request is ignored if the interrupt is not enabled.

ERROR. This interrupt is generated by any host command that returns a non-zero code.

HALT. An external halt request will be trapped if this interrupt is enabled. Otherwise, the program terminates immediately with the error message "Execution halted" and returns with the error code set to 2.

!DERR. Errors detected by the I/O system will be trapped if this interrupt is enabled.

NOVALUE. An interrupt will occur if an uninitialized variable is used while this condition is enabled. The usage could be within an expression, in the UPPER instruction, or with the VALUE() built-in function.

SYNTAX. A syntax or execution error will generate this interrupt. Not all errors such errors can be trapped, however. In particular, certain errors occurring before a program is actually executing, and those detected by the ARexx externaJ interface, cannot be trapped by the SYNTAX interrupt.

When an interrupt forces a transfer of control, all of the currently active control. ranges are dismantled, and the interrupt that caused the transfer is disabled. This latter action is necessary to prevent a possible recursive interrupt loop. Only the control structures in the current environment are affected, so an interrupt generated within a function will not affect the caller's environment.

Interrupts are useful primarily to allow a program to take special error-recoveryactions. Such actions might involve informing externaJ programs that an error occurred, or simply reporting further diagnostics to help in isolating the problem. In the following example, the program issues a "message" command to an externaJ host caJled "My Edit" whenever a syntax error is detected:

Tracing and Interrupts 75

/â€¢ A macro program for 'MyEdit' â€¢I signal on syntax /â€¢ enable interrupt â€¢/

. (normal processing) exit

syntax: /â€¢ syntax error detectedâ€¢/

```rexx

address 'MyEdit'
```

'message' 'error' re errortext(rc) exit 10

