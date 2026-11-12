# CSC 4890 midterm project in OCaml

This program uses only OCaml's standard library; no additional packages or build system are required.

- `sentence_generator.ml`: complete source with explanatory comments.
- The five sentences from seed 0 are included in the output example below.

## Install OCaml

Choose the instructions for your operating system. If `ocaml -version` and `ocamlc -version` already report versions, skip to **Open the project folder**.

### Windows 10 and Windows 11

Use **Windows PowerShell** or a PowerShell tab in Windows Terminal for all Windows commands below, rather than Command Prompt or Git Bash. These steps use native Windows OCaml through opam 2.2 or newer; WSL is not required.

1. Check that Windows Package Manager is available:

   ```powershell
   winget --version
   ```

   If it is not recognized, install or update **App Installer** from the
   Microsoft Store, then reopen PowerShell. See Microsoft's
   [WinGet installation instructions](https://learn.microsoft.com/en-us/windows/package-manager/winget/).
   If WinGet is unavailable, use the alternative installer in the official
   [opam installation instructions](https://opam.ocaml.org/doc/Install.html).
   The published Windows opam binary targets x64; other architectures may need
   an alternative environment described in the
   [OCaml Windows guide](https://ocaml.org/docs/ocaml-on-windows).

2. Install Git and opam, accepting the installers' prompts:

   ```powershell
   winget install --id Git.Git --exact
   winget install --id OCaml.opam --exact
   ```

3. Close PowerShell and open it again so that it can find the installed tools.
   Initialize opam as your normal user:

   ```powershell
   opam --version
   opam init
   ```

   Allow opam to create its own internal Cygwin installation when prompted, and accept installation of the default OCaml compiler. This may take several minutes. Follow any instructions printed by the installer.

4. Activate OCaml in the current PowerShell window:

   ```powershell
   (& opam env --shell=powershell) -split '\r?\n' | ForEach-Object { Invoke-Expression $_ }
   ```

   Run this activation command again in each new PowerShell window before using OCaml, unless opam has configured automatic activation.

5. Verify the installation:

   ```powershell
   ocaml -version
   ocamlc -version
   ```

These steps follow the official
[OCaml Windows guide](https://ocaml.org/docs/ocaml-on-windows) and
[opam environment documentation](https://opam.ocaml.org/doc/man/opam-env.html).

### macOS

1. Open **Terminal**. If Homebrew is not installed, follow the installer at [brew.sh](https://brew.sh/) and complete the **Next steps** it prints to make the `brew` command available. Homebrew's [requirements](https://docs.brew.sh/Installation) depend on your macOS version and hardware. If your Mac does not meet them, use an alternative from the [official OCaml installation guide](https://ocaml.org/docs/installing-ocaml), such as opam or MacPorts, compatible with your system.

2. Install OCaml directly; opam is not needed for this program:

   ```sh
   brew install ocaml
   ```

   If the installer requests Apple's Command Line Tools, run `xcode-select --install`, complete the installation dialog, then retry. See the [Homebrew OCaml package](https://formulae.brew.sh/formula/ocaml).

3. Verify the installation:

   ```sh
   ocaml -version
   ocamlc -version
   ```

### Linux and BSD

On Ubuntu or Debian, install the compiler directly:

```sh
sudo apt-get update
sudo apt-get install ocaml
ocaml -version
ocamlc -version
```

For other Linux distributions or BSD, install OCaml using your system's package
manager or follow the [official OCaml installation guide](https://ocaml.org/docs/installing-ocaml).

If using opam, complete `opam init` and activate its environment in a Bash or Zsh terminal with `eval "$(opam env)"`. Repeat activation in new terminals if it has not been configured automatically. Other shells should use the activation command printed by opam for that shell.

## Open the project folder

Download `sentence_generator.ml` from this repository using its **Download raw file** button, or clone the repository if Git is installed. Open a terminal and change to the folder containing the downloaded source. Replace the example path below with that folder's actual path; keep the quotation marks.

Windows PowerShell example:

```powershell
Set-Location "C:\Users\YourName\Downloads\ocaml_midterm"
Get-Item .\sentence_generator.ml
```

macOS, Linux, or BSD example:

```sh
cd "/path/to/ocaml_midterm"
ls sentence_generator.ml
```

The last command should show the source file. Run the remaining commands in this same terminal, at its normal prompt, rather than inside the interactive OCaml prompt (`#`). If you opened OCaml interactively, enter `#quit;;` first.

## Run the program

The same command runs the source on Windows PowerShell, macOS, Linux, and BSD once OCaml is installed:

```text
ocaml sentence_generator.ml
```

The program prints exactly five lines, one sentence per line. A normal run initializes its random state from the system, so later runs can differ. 

To use the seed for the included sample:
```text
ocaml sentence_generator.ml --seed 0
```

Output example for seed `0`:

```text
a boy likes
the boy with the girl sees with a girl
the boy likes the bird with the girl
a bird sees with a flower
the flower with the girl sees a girl
```

The included output was generated with OCaml 5.5.2. An integer seed repeats the result with the same OCaml random-number implementation. Different compiler versions may produce different valid sentences for the same seed.

To save a run on Windows PowerShell:

```powershell
ocaml sentence_generator.ml --seed 0 | Set-Content -Encoding ascii my_sentences.txt
```

On macOS, Linux, or BSD:

```sh
ocaml sentence_generator.ml --seed 0 > my_sentences.txt
```

## Compile and run instead

Compilation is optional; running the source above is sufficient.

Windows PowerShell:

```powershell
ocamlc -o sentence_generator.exe sentence_generator.ml
.\sentence_generator.exe
.\sentence_generator.exe --seed 0
```

macOS, Linux, or BSD:

```sh
ocamlc -o sentence_generator sentence_generator.ml
./sentence_generator
./sentence_generator --seed 0
```

Compile on the computer where you will run the program, and keep its OCaml environment active. Compiled files should not be copied between operating systems as a substitute for compiling the source.

If `ocaml` is not recognized or found, repeat the environment activation for an opam installation, or complete Homebrew's printed Next steps on macOS. If the source file cannot be found, check the folder path in **Open the project folder**.
