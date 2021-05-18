# APCSP Performance Task
This repository contains the source files for my 2021 APCSP Performance Task
submission. Though I have no intent with this project save submission to the
College Board, this is an open source work licensed under the BSD 3 Clause
license. The license can be found at [`/LICENSE`](./LICENSE).

This project is a TUI (Terminal User Interface) arithmetic expression
interpreter. It allows for mathematical expressions to be entered and
subsequently evaluated. It has two main parts - a parser, and a runtime. The
parser is tasked with dissecting the user's input and formatting it in a more
machine-friendly way. This machine-friendly representation is known as an AST -
Abstract Syntax Tree. The AST is then passed to the runtime, which is tasked
with evaluating the expression and returning the result.

Within the parser, there are two subsections of the program: the lexer and...
the parser. Those Computer Scientists working on compiler theory don't seem to
be very adept at providing distinct names for distinct things.

In any case, the lexer and the "lower parser" divide the work of the "upper
parser". The lexer takes care of translating the raw textual information
provided by the user into "tokens" - individual chunks of meaning, such as a
number or a symbol. The lexer then passes this list of tokens to the "lower
parser", which does the rest of the work of turning the tokens into a proper
AST.

## Current Version: `1.0.0`
[SemVer specification](https://semver.org "SemVer Specification")

## Documentation
There is currently no documentation for this project.

## Source Files
The source code can be found in the [`/src`](./src/) directory.

## Dependencies
This project relies on the following dependencies:
- Glasgow Haskell Compiler (`ghc`)

## Building
With git installed, the project can be cloned with the command
`git clone https://github.com/ancomcat/APCSP_Performance.git`. This will clone
the project into the current working directory.

Users that have a POSIX-compatible shell handy can use the build script
provided by running `./compile` from the project's root directory.

Windows users can compile the project by running
`ghc src\*.hs src\*\*.hs -outputdir build\ -o target\apcsp-performance.exe`
in CMD.

After compilation, either with the provided script or with the provided
command, the executable should be located at `target/apcsp-performance`
(`target\apcsp-performance.exe` for Windows users).
