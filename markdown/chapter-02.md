# Chapter 2 Getting Acquainted 
This chapter explains how to install ARexx on your Amiga computer and shows some example programs.

## 2.1 Installing ARexx

ARexx requires an Amiga computer with at least 256k of memory, and will operate under V1.1 or V1.2 of the operating system. It uses the double-precision math library called "**mathieeedoubbas.library**" that is supplied with the Amiga WorkBench disk, so make sure that this file is present in your **LIBS:** directory. The distribution disk includes the language system, some example programs, and a set of the INCLUDE files required for integrating ARexx with other software packages. The distribution files are listed in Appendix E.

**ARexx and WorkBench**

ARexx can be installed and loaded from within the icon-based environment provided by the Amiga WorkBench. However, it is a primarily a text-oriented language system and requires a good text editor and file management environment to be most effective. Unless you purchased ARexx as part of an applications package that includes an integrated editor, you'll probably find it useful to become familiar with the Command Line Interface (CLI) environment on the Amiga.

**Installation**

The ARexx language system consists of a shared library, a resident program, and several command utilities. All of the required files are contained in the **:c** and **:libs** directories of the distribution disk. ARexx may be installed on any of the system disks with which it will be used, but first check the **:c** and **:libs** directories of each disk to make sure that there are no naming conflicts. The following steps will then install ARexx on the system disk, provided that two disk drives are available:

1. Activate a CLI window.

2. Copy the ARexx **:libs** directory to the system **LIBS:** directory with the command "**copy df1: libs to libs:**".

3. Copy the ARexx **:c** directory to the system **C:** directory with the command "**copy df1:C to c:**".

**Single-Drive Systems.** Installing software in a single-drive system can be very confusing, so an installation utility has been provided with the ARexx distribution disk. It copies the **:c** and **:libs** directories of the distribution disk into memory, and then prompts the user to insert ea.ch disk that is to receive the files. Follow these steps to run the installation utility:

1. Activate a CLI window.

2. Insert the distribution disk into drive 0 and type "**df0:rxinstall**".

3. At the program prompt, insert the system disk on which ARexx is to be installed into drive 0.

4. Repeat step 3 as required.

**Starting the Resident Process**

ARexx programs are launched by a background program called the *resident process.* It can be started by issuing the command **rexxmast** and must be active before any ARexx: programs can be run. The **rexxmast** program briefly displays a small window to announce itself, and then disappears into the background to await your next request. If you will be using ARexx: frequently, you can place the **rexxmast** command in the "**startup-sequence**" file that resides in the system **S:** directory. This will start the resident process automatically when you reboot the computer.

After the resident process has been loaded, ARexx: programs can be run from the CLI by typing the command **rx** followed by the program name and any arguments. For example, the sample program **calc.rexx**, which evaluates an expression, could be run by typing "**rx :rexx/calc 1+1**"

You may not need to start up the resident process if you are using a software package that starts it automatically. Applications that use ARexx can test whether the resident process is active by checking for a public message port named "REXX." If the port hasn't been opened, the program can issue the **rexxmast** command directly.

The resident process can be closed using the command **rxc**; it will then exit as soon as the last ARexx: program finishes execution. Unless you are very short on memory space, there is usually no reason to close ARexx, as it simply waits in the background for the next program to run.

**Naming Conventions**

ARexx programs can be named anything, but adopting a simple naming convention will make managing the programs much easier. Programs to be run from the CLI are usually given the file extension **.rexx** to distinguish them from programs written in other languages. Programs written as "macros" or "scripts" for a particular applications program should be given a file extension specific to that program. For example, a macro written for a communications program called "**MyComm**" might be named "**download.myc**". ARexx uses this file extension when it searches for a program file to be executed.

You can designate one directory as the system-wide source for ARexx programs by defining a **REXX:** "device" with the assign command. This directory should reside on a volume that is usually mounted, such as **SYS:** or a hard disk. For example, the command "**Assign rexx: sys:rexx**" defines the **REXX:** device as the **:rexx** directory on the system disk. Once defined, the **REXX:** device is searched after the current directory when looking for an ARexx program.

Before introducing the structure and syntax of the language, let's look at a few examples of ARexx programs. Readers familiar with other high-level programming languages should find many points of similarity between ARexx and other languages. In the examples that follow, new terms are highlighted in the text as they are introduced, and will be covered in depth in the next few chapters.

These short programs can be created using any text editor and then run from the Command Line Interface (CLI), or may simply be read as samples of the language. If the examples are to be run, first complete the installation procedures outlined in the previous section, and then start the ARexx resident process. Example programs can then be run by entering, for example, "**rx age**" at the CLI prompt.

We'll begin with a "Hello, World" program that simply displays a message on the console screen.
```rexx
/*A simple program*/
say 'Hello, World'
```
This program consists of a ***comment*** line that describes the program and an ***instruction*** that displays text on the console. For historical reasons, ARexx programs begin with a comment line; the initial "/*" says "I'm an ARexx program" to the interpreter when it searches for a program.

Instructions are language statements that denote a certain action to be performed, and always start with a ***symbol***, in this case the word **say**. Symbols are translated to uppercase when the program is run, so the symbol **say** here is equivalent to **SAY**. Following **say** is an example of a ***string,*** which is a series of characters surrounded by quotes (' '). Double quotes (" ") could also have been used to define the string.

In the next program we'll display a prompt for input and then read some information from the user.

```rexx
/*Calculate age in days*/
say 'Please enter your age'
pull age
say 'You are about' age*365 'days old'
```

This program uses the pull instruction to read a line of input into a ***variable*** called **age**, which is then used with a **say** instruction. Variables are symbols that may be assigned a value. The words following **say** form an***expression*** in which strings are joined and an arithmetic calculation is performed.

Note that the variable **age** did not have to be declared as a number; instead, its value was checked when it was actually used in the expression. To see what would happen if **age** wasn't a number, try rerunning the program with a non-numeric entry for the **age**. The resulting error message shows the line number and type of error that occurred, after which the program ends.

The next program introduces the do instruction, which allows program statements to be executed repeatedly. It also illustrates the ***exponentiation*** operator, which is used to raise a number to an integral power.

```rexx
/*Calculate some squares and cubes */
do i = 1 to 10          /* 10 iterations */
    say i i**2 i**3     /* calculations */
end                     /* end of loop */
say 'all done'
```

The **do** instruction causes the statements between the **do** and **end** instructions to be executed 10 times. The variable i is the ***index variable*** for the loop, and is incremented by 1 for each iteration. The number following the symbol **to** is the ***limit*** for the do instruction, and could have been a full expression rather than just the constant **10**. Note that the statements within the loop have been indented. This is not required by the language, but it makes the program more readable and is therefore good programming practice.

The subject of the next example is the if instruction, a often-used control statement that allows statements to be conditionally executed. The numbers from 1 to 10 are classified as even or odd by dividing them by 2 and then checking the remainder.

```rexx
/* Even or odd? */
do i = 1 to 10
    if i//2 = 0 then type = 'even'
                else type = 'odd' 
    say i ' is' type
end
```

This example introduces the **//** arithmetic operator, which calculates the remainder after a division operation. The if instruction tests whether the remainder is 0 and executes the **then** branch if it is, thereby setting the variable **type** to "**even**". If the remainder was not 0, the alternative **else** branch is executed and **type** is set to "**odd**".

The next example introduces the concept of a ***function,*** which is a group of statements that can be executed by mentiouing the function name in a suitable context. Functions are an important part of most programming languages, as they allow large, complex programs to be built from smaller modules. Functions are specified in an expression as a name followed by an open parenthesis. One or more expressions called ***arguments*** may follow the parenthesis; these are used to pass information to the function for processing.

```rexx
/* Defining and calling a function */
do i = 1 to 5
    say i square(i)     /* call square */ 
end
exit                    /* all done */

square:                 /* function name */
arg X                   /* get the 'X' argument */
return x **2            /* square it and return */
```

The function ***square*** is defined in the lines following the ***label* square:** up through the **return** instruction. Two new instructions are introduced here: **arg** retrieves the value of the argument string, and **return** passes the function's result back to the point where the function was called.

One final example will suffice for now. A new instruction called **trace** is used here to activate the tracing features of ARexx.

```rexx
/*Demonstrate "results" tracing*/
trace results
sum=0; sumsq=0; 
do i = 1 to 5
    sum = sum+ i
    sumsq = sumsq + i**2 
end
say 'sum= ' sum 'sumsq=' sumsq
```

When this program is run, the console displays the source lines as they are executed, and shows the final results of expressions. This makes it easy to tell what the program is really doing, and helps reduce the time required to develop and test a new program. One minor point is illustrated here: the third line shows two distinct statements separated by a semicolon (; ). The semicolon is an example of a *special character,* characters that have particular meanings within ARexx programs.

The following chapters will present further information on the language statements illustrated here and will introduce others that have not been shown. Take heart, though; ARexx is a "small" language and there are relatively few words and rules to learn.
