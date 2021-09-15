# Markdown Cheat Sheet
*Source:* [GrimmStar](https://github.com/Grimmstar/.dotfiles)

# Headers
Code:
```
# H1
## H2
### H3
#### H4
##### H5
###### H6

h1 header
=========
h2 header
---------
```
Examples:
# H1
## H2
### H3
#### H4
##### H5
###### H6

h1 header
=========
h2 header
---------

# Formatting
Code:
```
Emphasis, aka italics, with *asterisks* or _underscores_.
Strong emphasis, aka bold, with **asterisks** or __underscores__.
Combined emphasis with **asterisks and _underscores_**.
Strikethrough uses two tildes. ~~Scratch this.~~
```

Examples:
Emphasis, aka italics, with *asterisks* or _underscores_.
Strong emphasis, aka bold, with **asterisks** or __underscores__.
Combined emphasis with **asterisks and _underscores_**.
Strikethrough uses two tildes. ~~Scratch this.~~

# Blockquotes
Examples:
> first level and paragraph
>> second level and first paragraph
>
> first level and second paragraph

Code:
```
> first level and paragraph
>> second level and first paragraph
>
> first level and second paragraph
```

# Lists
Examples:
## unordered - use *, +, or -
  * Red
  * Green
  * Blue

## ordered
  1. First
  2. Second
  3. Third
## nested - 4 spaces
- Level 1
    - Level 2
        - Level 3
            - Level 4
                - Level 5
                    - Level 6

Code:
```
## unordered - use *, +, or -
  * Red
  * Green
  * Blue

## ordered
  1. First
  2. Second
  3. Third
## nested - 4 spaces
    - Level 1
        - Level 2
            - Level 3
                - Level 4
                    - Level 5
                        - Level 6
```


# Paragraphs
Code:
```
Spaces are used at the beginning or end of sentences. In this example, leading and trailing spaces are shown with with dots: ⋅

⋅⋅⋅You can have properly indented paragraphs within list items. Notice the blank line above, and the leading spaces (at least one, but we'll use three here to also align the raw Markdown).

⋅⋅⋅To have a line break without a paragraph, you will need to use two trailing spaces.⋅⋅
⋅⋅⋅Note that this line is separate, but within the same paragraph.⋅⋅
⋅⋅⋅(This is contrary to the typical GFM line break behaviour, where trailing spaces are not required.)
```

Examples:
Spaces are used at the beginning or end of sentences. In this example, leading and trailing spaces are shown with with dots: ⋅

   You can have properly indented paragraphs within list items. Notice the blank line above, and the leading spaces (at least one, but we'll use three here to also align the raw Markdown).

   To have a line break without a paragraph, you will need to use two trailing spaces.
   Note that this line is separate, but within the same paragraph.
   (This is contrary to the typical GFM line break behaviour, where trailing spaces are not required.)

# Code
Code:
```
## use 4 spaces/1 tab
regular text
        code code code
## or:
Use the `printf()` function

## or:
```blockfence```

## inline code:
This is a regular sentance with `code` inline.
```

Examples:
## use 4 spaces/1 tab
regular text

    code code code

## or:
Use the `printf()` function

## blockfence
```
code code code
```

## inline code
This is a regular sentance with `code` inline.

# HR's
Code:
```
## three or more of the following
***
---
___
```

Examples:
***
---
___

# Links
Code:
```
This is [an example](http://example.com "Title") inline link.

[I'm a reference-style link][Arbitrary case-insensitive reference text]

[I'm a relative reference to a repository file](../blob/master/LICENSE)

[You can use numbers for reference-style link definitions][1]

Or leave it empty and use the [link text itself].

URLs and URLs in angle brackets will automatically get turned into links.
http://www.example.com or <http://www.example.com> and sometimes
example.com (but not on Github, for example).

Some text to show that the reference links can follow later.

[arbitrary case-insensitive reference text]: https://www.mozilla.org
[1]: http://slashdot.org
[link text itself]: http://www.reddit.com
```

Examples:
This is [an example](http://example.com "Title") inline link.

[I'm a reference-style link][Arbitrary case-insensitive reference text]

[I'm a relative reference to a repository file](../blob/master/LICENSE)

[You can use numbers for reference-style link definitions][1]

Or leave it empty and use the [link text itself].

URLs and URLs in angle brackets will automatically get turned into links.
http://www.example.com or <http://www.example.com> and sometimes
example.com (but not on Github, for example).

Some text to show that the reference links can follow later.

[arbitrary case-insensitive reference text]: https://www.mozilla.org
[1]: http://slashdot.org
[link text itself]: http://www.reddit.com

# Images
```
![Alt Text](/path/to/file.png)
```

# Tables
Tables are supported by using pipe (|) separators between columns and colons (:) for justification.
Code:
```
| Tables   | Look   | Like this |
| -------- | -----  | --------- |
| Left     | right: | :center:  |
```

Examples:
| Tables   | Look   | Like this |
| -------- | -----  | --------- |
| Left     | right: | :center:  |


# Footnotes
Examples:
Here's a sentence with a footnote. [^1]

[^1]: This is the footnote.

Code:
```
Here's a sentence with a footnote. [^1]

[^1]: This is the footnote.
```

# Heading IDs
Examples:
### My Great Heading {#custom-id}

Code:
```
 	### My Great Heading {#custom-id}
```

# Definition lists
Examples:
term
: definition
term
: definition

<dl>
  <dt>Definition list</dt>
  <dd>Is something people use sometimes.</dd>

  <dt>Markdown in HTML</dt>
  <dd>Does *not* work **very** well. Use HTML <em>tags</em>.</dd>
</dl>

Code:
```
term
: definition
term
: definition

<dl>
  <dt>Definition list</dt>
  <dd>Is something people use sometimes.</dd>

  <dt>Markdown in HTML</dt>
  <dd>Does *not* work **very** well. Use HTML <em>tags</em>.</dd>
</dl>
```

# Task lists
```
- [x] Make a list
- [ ] Add things to list
- [ ] Profit?
```

Use the backslash character \ to escape Markdown syntax characters.
You can escape the following characters:
Asterisk \*
Underscore \_
Curly braces \{ \}
Square brackets \[ \]
Brackets \( \)
Hash \#
Plus \+
Minus \-
Period \.
Exclamation point \!
