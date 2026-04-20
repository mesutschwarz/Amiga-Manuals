# Appendix A Error Messages 
When the ARexx interpreter detects an error in a program, it returns an error code to indicate the nature of the problem. Errors are normally handled by displaying the error code, the source line number where the error occurred, and a brief message explaining the error condition. Unless the **SYNTAX ** interrupt has been previously enabled (using the**SIGNAL ** instruction), the program then terminates and control returns to the caller. Most syntax and execution errors can be trapped by the**SYNTAX** interrupt, allowing the user to retain control and perform whatever special error processing is required. Certain errors are generated outside of the context of an ARexx program, and therefore cannot be trapped by this mechanism. Refer to chapter 7 for further information on error trapping and processing.

Associated with each error code is a ***severity level*** that is reported to the calling program as the primary result code. The error code itself is returned as the secondary result. The subsequent propagation or reporting of these codes is of course dependent on the external (calling) program.

The following pages list all of the currently-defined error codes, along with the associ-ated severity level and message string.

Error: 1 Severity: 5 Message: Program not found

The named program could not be found, or was not an ARexx program. ARexx programs are expected to start with a"/*" sequence. This error is detected by the external interface and cannot be trapped by the ** SYNTAX**interrupt.

Error: 2 Severity: 10 Message: Execution halted

A control-C break or an external halt request was received and the program terminated.

- This error will be trapped if the **HALT** interrupt has been enabled.

'ï¿½- **Error: 3 Severity: 20 Message: Insufficient memory**

The interpreter was unable to allocate enough memory for an operation. Since memory space is required for all parsing and execution operations, this error cannot usually be trapped by the **SYNTAX** interrupt.

Error: 4 Severity: 10 Message: Invalid character

A non-ASCII character was found in the program. Control codes and other non-ASCII characters may be used in a program by defining them as hex or binary strings. This is a scan phase error and cannot be trapped by the **SYNTAX** interrupt.

Error: 5 Severity: 10 Message: Unmatched quote

A closing single or double quote was missing. Check that each string is properly delimited. This is a scan phase error and cannot be trapped by the SYNTAX interrupt.

Error: 6 Severity: 10 Message: Unterminated comment

The closing "*I" for a comment field was not found. Remember that comments may be nested, so each"/*" must be matched by a"â€¢/." This is a scan phase error and cannot be trapped by the ** SYNTAX**interrupt.

Error: 7 Severity: 10 Message: Clause too long

A clause was too long for the internal buffer used as temporary storage. The source line in question should be broken into smaller parts. This is a scan phase error and cannot be trapped by the **SYNTAX** interrupt.

Error: 8 Severity: 10 Message: Invalid token

An unrecognized lexical token was found, or a clause could not be properly classified. Thls is a scan phase error and cannot be trapped by the **SYNTAX** interrupt.

Error: 9 Severity: 10 Message: Symbol or string too long

An attempt was made to create a string longer than the maximum supported by the inter-preter. The implementation limits for internal structures are given in Appendix B.

Error: 10 Severity: 10 Message: Invalid message packet

An invalid action code was found in a message packet sent to the ARexx resident process. The packet was returned without being processed. This error is detected by the external interface and cannot be trapped by the **SYNTAX** interrupt.

Error: 11 Severity: 10 Message: Command string error

A command string could not be processed. This error is detected by the external interface and cannot be trapped by the **SYNTAX** interrupt.

Error: 12 Severity: 10 Message: Error return from function

An external function returned a non-zero error code. Check that the correct parameters were supplied to the function.

Error: 13 Severity: 10 Message: Host environment not found

The message port corresponding to a host address string could not be found. Check that the required external host is active.

Error: 14 Severity: 10 Message: Requested library not found

An attempt was made to open a function library included in the Library List, but the library could not be opened. Check that the correct name and version of the library were specified when the library was added to the resource list.

Error: 15 Severity: 10 Message: Function not found

A function was called that could not be found in any of the currently accessible libraries, and could not be located as an external program. Check that the appropriate function libraries have been added to the Libraries List.

Error: 16 Severity: 10 Message: Function did not return value

A function was called which failed to return a result string, but did not otherwise report an error. Check that the function was programmed correctly, or invoke it using the CALL instruction.

Error: 17 Severity: 10 Message: Wrong number of arguments

A call was made to a function which expected more (or fewer) arguments. This error will be generated if a Built-In or external function is called with more arguments than can be accomodated in the message packet used for external communications.

Error: 18 Severity: 10 Message: Invalid argument to function

An inappropriate argument was supplied to a function, or a required argument was missing. Check the parameter requirements specified for the function.

A PROCEDURE instruction was issued in an invalid context. Either no internal functions were active, or a PROCEDURE had already been issued in the current storage environment.

Error: 20 Severity: 10 Message: Unexpected THEN or WHEN

A WHEN or THEN instruction was executed outside of a valid context. The WHEN instruction is valid only within a SELECT range, and THEN must be the next instruction following an IF or WHEN.

Error: 21 Severity: 10 Message: Unexpected ELSE or OTHERWISE

An ELSE or OTHERWISE was found outside of a valid context. The OTHERWISE instruction is valid only within a SELECT range. ELSE is valid only following the THEN branch of an IF range.

Error: 22 Severity: 10 Message: Unexpected BREAK, LEAVE, or ITERATE

The BREAK instruction is valid only within a DO range or inside an INTERPRETed string. The LEAVE and ITERATE instructions are valid only within an *iterative* DO range.

Error: 23 Severity: 10 Message: Invalid statement in SELECT

A invalid statement was encountered within a SELECT range. Only WHEN, THEN, and OTH-ERWISE statements are valid within a SELECT range, except for the conditional statements following THEN or OTHERWISE clauses.

Error: 24 Severity: 10 Message: Missing or multiple THEN

An expected THEN clause was not found, or another THEN was found after one had already been executed.

None of the WHEN clauses in a SELECT succeeded, but no OTHERWISE clause was supplied.

Error: 26 Severity: 10 Message: Missing or unexpected END

The program source ended before an END was found for a DO or SELECT instruction, or an END was encountered outside of a DO or SELECT range.

Error: 27 Severity: 10 Message: Symbol mismatch

The symbol specified on an END, ITERATE, or LEAVE instruction did not match the index variable for the associated DO range. Check that the active loops have been nested properly.

Error: 28 Severity: 10 Message: Invalid DO syntax

An invalid DO instruction was executed. An initializer expression must be given if a TO or BY expression is specified, and a FOR expression must yield a non-negative integer result.

Error: 29 Severity: 10 Message: Incomplete IF or SELECT

An IF or SELECT range ended before all of the required statements were found. Check whether the conditional statement following a THEN, ELSE, or OTHERWISE clause was omitted.

Error: 30 Severity: 10 Message: Label not found

A label specified by a SIGNAL instruction, or implicitly referenced by an enabled interrupt,

could not be found in the program source. Labels defined dynamically by an INTERPRET --instruction or by interactive input are not included in the search.

Error: 31 Severity: 10 Message: Symbol expected

A non-symbol token was found where only a symbol token is valid. The DROP, END, LEAVE, ITERATE, and UPPER instructions may only be followed by a symbol token, and will generate this error if anything else is supplied. This message will also be issued if a required symbol is missing.

Error: 32 Severity: 10 Message: Symbol or s tring expected

An invalid token was found in a context where only a symbol or string is valid.

Error: 33 Severity: 10 Message: Invalid keyword

A symbol token in an instruction clause was identified as a keyword, but was invalid in the specific context.

Error: 34 Severity: 10 Message: Required keyword missing

An instruction clause required a specific keyword token to be present, but it was not sup-plied. For example, this message will be issued if a SIGNAL ON instruction is not followed by one of the interrupt keywords (e.g. SYNTAX.)

Error: 35 Severity: 10 Message: Extraneous characters

A seemingly valid statement was executed, but extra characters were found at the end of the clause.

Error: 36 Severity: 10 Message: Keyword conflict

Two mutually exclusive keywords were included in an instruction clause, or a keyword was included twice in the same instruction.

Error: 37 Severity: 10 Message: Invalid template

The template provided with an ARG, PARSE, or PULL instruction was not properly con-structed. Refer to Chapter 8 for a description of template structure and processing.

Error: 38 Severity: 10 Message: Invalid TRACE request

The alphabetic keyword supplied with a TRACE instruction or as the argument to the TRACE() Built-In function was not valid. Refer to Chapter 7 for the valid TRACE options.

Error: 39 Severity: 10 Message: Uninitialized variable

An attempt was made to use an uninitialized variable while the NOVALUE interrupt was enabled.

Error: 40 Severity: 10 Message: Invalid variable name An attempt was made to a value to a fixed symbol.

Error: 41 Severity: 10 Message: Invalid expression

An error was detected during the evaluation an expression. Check that each operator has the correct number of operands, and that no extraneous tokens appear in the expression. This error **will** be detected only in expressions that are actually evaluated. No checking is

performed on expressions in clauses that are being skipped.

Error: 42 Severity: 10 Message: Unbalanced parentheses

An expression was found with an unequal number of opening and closing parentheses.

Error: 43 Severity: 43 Message: Nesting limit exceeded

The number of subexpressions in an expression was greater than the maximum allowed. The expression should be simplified by breaking it into two or more intermediate expressions.

Error: 44 Severity: 10 Message: Invalid expression result

The result of an expression was not valid within its context. For example, this message will be issued if an increment or limit expression in a DO instruction yields a non-numeric result.

Error: 45 Severity: 10 Message: Expression required

An expression was omitted in a context where one is required. For example, the SIGNAL instruction, if not followed by the keywords ON or OFF, must be followed by an expression.

Error: 46 Severity: 10 Message: Boolean value not O or 1

An expression result was expected to yield a boolean result, but evaluated to something other than O or 1.

Error: 47 Severity: 10 Message: Arithmetic conversion error

A non-numeric operand was used in a operation requiring numeric operands. This message will also be generated by an invalid hex or binary string.

Error: 48 Severity: 10 Message: Invalid operand

An operand was not valid for the intended operation. This message will be generated if an attempt is made to divide by 0, or if a fractional exponent is used in an exponentiation operation.

