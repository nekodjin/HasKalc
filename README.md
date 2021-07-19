# HasKalc
### A Calculator Written in Haskell

This project was originally a submission to the College Board for the APCSP
Create Performance Task. It is licensed under the BSD 3 Clause license, which
is available at [`/LICENSE`](./LICENSE).

## Current Version: `1.0.3`
Changelog is available at [`/changelog.md`](./changelog.md).
<br>
[SemVer Spec](https://semver.org)

## Dependencies
- [Glasgow Haskell Compiler](https://haskell.org/ghc/) 8.x.x

## Documentation
There is currently no documentation for this project

## Source files
Source files are located in the [`/src`](./src/) directory.

## Building

1.  Clone the source
    <br>
    `git clone https://github.com/nekodjin/HasKalc.git`
2.  Build
    - With a POSIX-Compliant Shell:
      <br>
      `sh compile`
    - With Windows CMD:
      <br>
      ```
      mkdir build
      mkdir target
      ghc src\Interpreter\Interpreter.hs src\Lexer\Lexer.hs src\Lexer\Operator.hs src\Lexer\Token.hs src\Parser\Checker.hs src\Parser\Expression.hs src\Parser\Operator.hs src\Parser\Parser.hs src\Main.hs -outputdir build -o target\haskalc.exe -O2
      ```
3.  Execute
    - For Windows:
      <br>
      `target\haskalc`
    - For Other OSes:
      <br>
      `target/haskalc`
