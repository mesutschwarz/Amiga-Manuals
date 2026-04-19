# Appendix B Limits and Compatibility 
ARexx was designed to adhere closely to the REXX language standard. This appendix discusses those areas where ARexx departs from the standard.

Language definitions seldom include predefined limits to the program structures that can be created. Only a few such restrictions were imposed in implementing ARexx, and most of the internal structures are limited only by the total amount of memory available. The current implementation limits are listed below.

Length of Strings. Strings, symbol names, and value strings are limited to a maximum length of 65,535 bytes.

Length of Clauses. Clauses are limited to a maximum of 800 characters after removing comments and multiple blanks.

Nodes in Compound Names. Compound symbol names may include a maximum of 50 nodes, including the stem.

Arguments to Functions. Built-In and external functions are limited to a maximum of 15 arguments. There is no limit to the number of arguments that may be passed to an internal function.

Subexpression Nesting. The maximum nesting level for subexpressions is 32.

ARexx departs in a few ways from the language definition. The differences can be classified as omissions or extensions, and are described below.

Omissions. The only significant specification of the language standard omitted from this implementation is the arbitrary-precision arithmetic facility. Arithmetic operations are limited to about 14 digits of precision, and the FUZZ option is not implemented at all. Only the SCIENTIFIC format is used for exponential notation. The full numeric capabilities will be provided in a later release.

Extensions. The following extensions to the language standard have been included in this implementation:

BREAK *Instruction.* A new instruction called BREAK has been implemented. It is used to exit from the scope of any DO or INTERPRET instruction.

```rexx

ECHO *Instruction.* The ECHO instruction has been included as a synonym for SAY.
SHELL *Instruction.* The SHELL instruction has been included as a synonym for ADDRESS.
```

SIGNAL *Options.* Several additional SIGNAL keywords have been implemented. BREAK_C, BREAK..D, BREAK.E, and BREAK..F will detect and trap the control-C through control-F signals passed by AmigaDOS. T he IOERR- keyword traps errors detected by the 1/0 system.

Stem Symbols. A stem symbol is valid anywhere that a simple symbol could be em-ployed.

Template Processing. Templates have been generalized in several ways. Variable sym-bols may be used as positional tokens if preceded by an operator; the "=" operator is used to denote an absolute position. Multiple templates can be used with all source forms of the PARSE instruction.

