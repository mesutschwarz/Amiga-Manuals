# Chapter 8 Parsing and Templates 
Parsing is a operation that extracts substrings from a string and assigns them to variables. It corresponds roughly to the notion of a "formatted read" used in other languages, but has been generalized in the several ways. Parsing is performed using the **PARSE ** instruction or its variants**ARG ** and**PULL.** The input for the operation is called the *parse string * and can come from several sources; these source options are described with the **PARSE** instruction in Chapter 4.

Parsing is controlled by a *template,* a group of tokens that specifies both the variables to be given values and the way to determine the value strings. Templates were described briefly with the **PARSE** instruction; the present chapter presents a more formal description of their structure and operation.

String-manipulation functions like **SUBSTR()** and **INDEX()** could also be used for pars-ing, but it is more efficient to use the instruction statements. This is especially true if many fields are to be extracted from a string.

The tokens that are valid in a template are symbols, strings, operators, parentheses, and commas. Any blanks that may be present as separators are removed before the template is processed. The tokens in a template ultimately serve to specify one of the two basic template objects:

Markers determine a scan position within the parse string, and

Targets are symbols to be assigned a value.

With these objects in mind, the parsing process can be described as one of associating with each target a starting and ending position in the parse string. The substring between these positions then becomes the value for the target.

Markers. There are three types of marker objects:

Absolute markers specify an actual index position in the parse string,

Relative markers specify a positive or negative offset from the current position, and

Pattern markers specify a position implicitly, by matching the pattern against the parse string beginning at the current scan position.

Targets, like markers, can affect the scan position if value strings are being extracted by *tokenization.* Parsing by tokenization extracts words (tokens) from the parse string, and

is used whenever a target is followed immediately by another target. During tokenization the current scan position is advanced past any blanks to the start of the next word. The ending index is the position just past the end of the word, so that the value string has neither leading nor trailing blanks.

Each template object is specified by one or more tokens, which have the following interpre-tations.

Symbols. A symbol token may specify either a target or a marker object. If it follows an operator token (+, -, or =), it represents a marker, and the symbol value is used as an absolute or relative position. Symbols enclosed in parentheses specify pattern markers, and the the symbol value is used as the pattern string.

If neither of the preceding cases applies and the symbol is a variable, then it specifies a target. F ixed symbols always specify absolute markers and must be whole numbers, except for the period (.) symbol which defines a placeholder target.

Strings. A string token always represents a pattern marker.

Parentheses. A symbol enclosed in parentheses is a pattern marker, and the value of the symbol is used as the pattern string. While the symbol may be either fixed or variable, it will usually be a variable, since a fixed pattern could be given more simply as a string.

Operators. The three operators "+," "-," and "=" are valid within a template, and must be followed by a fixed or variable symbol. The value of the symbol is used as a marker and must therefore represent a whole number. The"+" and"-" operators signify a relative marker, whose value is negated by the"-" operator. The"=" operator indicates an absolute marker, and is optional if the marker is defined by a fixed symbol.

Commas. The comma (,) marks the end of a template, and is used as a separator when multiple templates are provided with an instruction. The interpreter obtains a new parse string before processing each succeeding template. For some source options, the new string will be identical to the previous one. The ARG, EXTERNAL, and PULL options will generally supply a different string, as will the VAR option if the variable has been modified.

Scan positions are expressed as an index in the parse string, and can range from 1 (the start of the string) to the length of the string plus 1 (the end). An attempt to set the scan position before the start or after the end of the string instead sets it to the beginning or end, respectively.

The substring specified by two scan indices includes the characters from the starting position up to, but not including, the ending position. For example, the indices 1 and 10 specify characters 1-9 in the parse string. One additional rule is applied if the second scan index is less than or equal to the first: in this case the *remainder* of the parse string is used as the substring. This means that a template specification like

```rexx

parse arg 1 all 1 first second
```

will assign the entire parse string to the variable ALL. Of course, if the current scan index is already at the end of the parse string, then the remainder is just the null string.

When a pattern marker is matched against the parse string, the marker position is the index of the first character of the matched pattern, or the end of the string if no match was found. The pattern is removed from the string whenever a match is found. This is the only operation that modifies the parse string during the parsing process.

Templates are scanned from left to right with the initial scan index set to 1, the start of the parse string. The scan position is updated each time a marker object is encountered, according to the type and value of the marker. Whenever a target object is found, the value to be assigned is determined by examining the next template object. If the next object is another target, the value string is determined by tokenizing the parse string. Otherwise, the current scan position is used as the start of the value string, and the position specified by the following marker is used as the end point.

The scan continues until all of the objects in the template have been used. Note that every target will be assigned a value; once the parse string has been exhausted, the null string is assigned to any remaining targets.

Templates in Action

The preceding section is rather abstract, so let's look now at some examples of parsing with templates.

Parsing by Tokenization

Computer programs frequently require splitting a string into its component words or tokens. This is easily accomplished with a template consisting entirely of variables (targets).

```rexx

I*Assume "hammer 1 each $600.00" was entered*I pull item qty units cost
```

In this example the input line from the PULL instruction is split into words and assigned to the variables in the template. The variable item receives the value "hammer," qty is set to "1," units is set to "each," and cost gets the value "$600.00." The final placeholder (.) is given a null value, since there are only four words in the input. However, it forces the preceding variable cost to be given a tokenized value. If the placeholder were omitted, the remainder of the parse string would be assigned to cost, which would then have a leading blank.

In the next example, the first word of a string is removed and the remainder is placed back in the string. The process continues until no more words are extracted.

```rexx

I*Assume "result" contains a string of words*I do forever
I*Get first word of string*I parse var result first result
if first == '' then leave
I*... process  words. . .*I end
```

The next example uses pattern markers to extract the desired fields. The "pattern" in this case is very simple - just a single charader - but in genera.I can be an arbitrary string of any length. This form of parsing is useful whenever delimiter characters are present in the parse string.

```rexx

I* Assume an argument string "12,35.5,1" arg hours ',' rate ',' withhold
```

Keep in mind that the pattern is actually removed from the parse string when a match is found. If the parse string is scanned again from the beginning, the length and structure of the string may be different than at the start of the parsing process. However, the original source of the string is never modified.

Parsing with positional markers is used whenever the fields of interest are known to be in certain positions in a string. In the next example, the records being processed contain a variable length field. The starting position and length of the field are given in the first part of the record, and a variable positional marker is used to extract the desired field.

'*

records look like:

'*

```rexx

'*start: 1-5*'
```

length: **6-10***'

'*name: @(start,length)*I

```rexx

parse value record with1 start +5 length +5 =start name +length
```

The "=start" sequence in the above example is an absolute marker whose value is the position placed in the variable start earlier in the scan. The "+length" sequence supplies the effective length of the field.

It is sometimes useful to specify more than one template with an instruction, which can be done by separating the templates with a comma. In this next example, the ARG instruction (or PARSE UPPER ARG) is used to access the argument strings provided when the program was called. Each template accesses the succeeding argument string.

```rexx

I*Assume arguments were ('one two',12,sort)*I arg first second,amount,action,option
```

The first template consists of the variables first and second, which are set to the values "one" and "two," respectively. In the next two templates amount gets the value "12" and action is set to "SORT." The last template consists of the variable "option," which is set to the null string, since only three arguments were available.

When multiple templates are used with the EXTERNAL or PULL source options, each additional template requests an additional line of input from the user. 1n the next example two lines of input are read:

```rexx

I*read last, first, and middle names and ssn*I pull last ',' first middle,ssn
```

The first input line is expected to have three words, the first of which is followed by a comma, which are assigned to the variables last, first, and middle. The entire second input line is assigned to the variable **ssn.**

Multiple templates can be useful even with a source option that returns the identical parse string. If the first template included pattern markers that altered the parse string, the subsequent templates could still access the original string. Note that subsequent parse strings obtained from the VALUE source do not cause the expression to be reevaluated, but only retrieve the prior result.

