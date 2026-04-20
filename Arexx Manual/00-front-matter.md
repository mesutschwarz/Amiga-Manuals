# Front Matter

Version 1.0

The REXX Language for the Amiga

Copyright © 1987 William S. Hawes All Rights Reserved

Copyright Notice

ARexx software and documentation are Copyright @1987 by William S. Hawes. No part of the software or documentation may be reproduced, transmitted, translated into other languages, posted to a network, or distributed in any way without the express written permission of the author.

Disclaimer

This product is offered for sale "as is" with no representation of fitness for any particular purpose. The user assumes all risks and responsibilities related to its use. The material within is believed to be accurate, but the author reserves the right to make changes to the software or documentation without notice.

Distribution

ARexx software and documentation are available from:

William S. Hawes

P.O. Box 308

Maynard, MA 01754

(508) 568-8695

Please direct orders or inquiries about this product to the above address. Site licenses are available; write for further information.

About ...

ARexx was developed on an Amiga 1000 computer with 512K bytes of memory and two floppy disk drives. The language prototype was developed in C using Lattice C, and the production version was written in assembly-language using the Metacomco Assembler. The documention was created using the TxEd editor, and was set in T£X using AmigaT£X. This is a 100% Amiga product.

Trademarks

Amiga, Amiga WorkBench, and Intuition are trademarks of Commodore-Amiga, Inc.


**Introduction**

Welcome to ARexx, an implementation of the REXX language for the Amiga computer. ARexx is a powerful programming tool, but one which by virtue of its clean syntax and sparse vocabulary is also easy to learn and easy to use.

**1. Organization of this Document**

This document will attempt to fill the roles of User's Manual, Language Reference, and Programmer's Guide. The chapters that follow have been organized to provide a gentle introduction to the language.

Chapter l, ***What is ARexx?,*** gives an overview of the ARexx language and its implementation on the Amiga.

Chapter 2, ***Getting Acquainted,*** tells how to install ARexx on your Amiga and presents several example programs to illustrate the features of the language.

Chapter 3, ***Elements of the Language,*** introduces the language structure and syntax.

Chapter 4, ***Instructions,*** describes the action statements of ARexx.

Chapter 5, ***Commands,*** describes the program statements used to communicate with external programs.

Chapter 6, ***Functions,*** explains how functions are called and documents the Built-In Function library.

Chapter 7, ***Tracing and Interrupts,*** describes the source-level debugging features useful for developing and testing programs.

Chapter 8, ***Parsing and Templates,*** describes the instructions used to extract words or fields from strings.

Chapter 9, ***The Resident Process,*** describes the capabilities of the global communications and resources manager.

Chapter 10, ***Interfacing to ARexx,*** describes how to design and implement an interface between ARexx and an external program.

Appendix A, ***Error Messages,*** lists the error messages issued by the interpreter.

Appendix B, ***Limits and Compatibility,*** discusses the compatibility of ARexx with the language standard.

Appendix C, ***The ARexx Systems Library,*** documents the functions in the ARexx systems library.

Appendix D, ***The Support Library,*** documents the library of Amiga-specific functions.

Appendix E, ***Distribution Files,*** lists the files on the distribution disk.

Finally, a Glossary and an Index are provided.

**Using this Manual**

If you are new to the REXX language, or perhaps to programming itself, you should review chapters 1 through 4 and then play with ARexx by running some of the sample programs given in chapter 2. Further examples are available in the **:rexx** directory of the distribution disk.

If you are already familiar with REXX you may wish to skip directly to chapter 5, which begins to present some of the system-dependent features of this implementation. A summary of the compatibility of ARexx with the language definition is contained in Appendix B.

**Typographic Conventions**

Describing a language is sometimes difficult because of the multiple and changing contexts involved. To help clarify the presentation here, a simple typographic convention has been adopted throughout the document. All of the terms and words specific to the REXX language, as well as the program examples and computer input and output, have been set **in typewriter font like this.** This should help to distinguish the language keywords and examples from the surrounding text.

**2. Future Directions**

ARexx, like most software products, will probably evolve somewhat over the next few years as new features are added, old bugs are removed, and market imperatives become more apparent. While the core language will probably undergo few modifications, many capabilities will be added to the function libraries supported by ARexx. Your comments and suggestions for improvements to ARexx are most welcome.

The author sincerely hopes that other software developers will consider using ARexx with their products. The advantages of having a rich variety of software products sharing a common user interface and a common procedural interface cannot be overstated. This is the underlying promise of the Amiga's multitasking capability, and that which most sets it apart from other inexpensive computers.

Example Programs. One of the best ways to learn a computer language is to study examples written by more experienced programmers. The ARexx distribution disk includes a few example programs in the : rexx directory, and more programs will be added in future releases.

If you have written a REXX language program (for any computer) that you think would be of interest to a more general audience, please send it to the author for consideration. Programs should be of interest either in terms of their specific functionality or as an example of programming technique. Each program submitted should include an author credit and a few lines of commentary on its intended function.
