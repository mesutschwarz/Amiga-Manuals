# Chapter 1 What is ARexx? 
ARexx is a high-level language useful for prototyping, software integration, and general programming tasks. It is an implementation of the REXX language described by M. F. Cowlishaw in ***The REXX Language: A Practical Approach to Programming***(Prentice-Hall, 1985), and follows the language definition closely. ARexx is particularly well suited as a command language. Command programs, sometimes called "scripts" or "macros", are widely used to extend the predefined commands of an operating system or to customize an applications program.

As a programming language, ARexx can be useful to a wide cross section of users. For the novice programmer, ARexx is an easy-to-learn yet powerful language that serves as a good introduction to programming techniques. Its source-level debugging facilities will help take some of the mystery out of how programs work (or don't work, as is more frequently the case.)

For the more sophisticated user, ARexx provides the means to build fully integrated software packages, combining different applications programs into an environment tailored to their needs. A common command language among applications that support ARexx will bring uniformity to procedural interfaces, much as the Amiga's Intuition provides uniformity in the graphical interface.

Finally, for the software developer, ARexx offers a straightforward way to build fully programmable applications programs. Developers can concentrate their efforts on making the basic operations of their programs fast and efficient, and let the end user add the frills and custom features.

## 1.1 Language Features

Some of the important features of the language are:

**Typeless Data.** Data are treated as typeless character strings. Variables do not have to be declared before being used, and all operations dynamically check the validity of the operands.

**Command Interface.** ARexx programs can issue commands to external programs that provide a suitable command interface. Any software package that implements the command interface is then fully programmable using ARexx, and can be extended and customized by the end user.

**Tracing and Debugging.**  ARexx includes source-level debugging facilities that allow the programmer to see the step-by-step actions of a program as it runs, thereby reducing the time required to develop and test programs. An internal interrupt system permits special handling of errors that would otherwise cause the program to terminate.

**Interpreted Execution.** ARexx programs are run by an interpreter, so separate compila-tion and linking steps are not required. This makes it especially useful for prototyping and as a learning tool.

**Function Libraries.** External function libraries can be used to extend the capabilities of the language or as bridges to other programs. Libraries also allow ARexx programs to be used as "test drivers" for software development and testing.

**Automatic Resource Management.** Internal memory allocation related to the creation and destruction of strings and other data structures is handled automatically.

## 1.2 ARexx on the Amiga

ARexx was designed to run on the Amiga, and makes use of many of the features of its multitasking operating system. ARexx programs run as separate tasks and may communicate with each other or with external programs. The interpreter follows the design guidelines expected of well-behaved programs in a multitasking environment: specifically, it uses as little memory as possible and is careful to return resources to the operating system when they are no longer needed. Memory requirements were minimized by implementing the entire ARexx system as a shared library, so that only one copy of the program code must be loaded.

## 1.3 Further Information

The aforementioned book by M. F. Cowlishaw is highly recommended to those interested in further information about REXX. It presents an interesting discussion of the design and development of the language.

