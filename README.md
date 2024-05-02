# Nextor

Nextor is a disk operating system for MSX computers. It is built on top of the source code of MSX-DOS 2.31, released in 1991.

The source code of Nextor is published with permission from the MSX Licensing Corporation under certain terms. **Please take a moment to read [the license terms](LICENSE.md) for details**.

Please visit [the Nextor section in Konamiman's MSX page](https://www.konamiman.com/msx/msx-e.html#nextor) for binaries.

## Repository structure

Note that there is no `master` branch, but branches for each major version of Nextor (v2.0 and v2.1 currently).

* [**source**](/source): The source code of Nextor itself.

    * [**kernel**](source/kernel): The kernel ROM, includes the FDISK tool.

    * [**command**](source/command): `NEXTOR.SYS`, `COMMAND2.COM` and the command line tools that were originally supplied with MSX-DOS.

    * [**tools**](source/tools): The new command line tools created for Nextor.

* [**buildtools**](/buildtools): Tools needed for building Nextor on Windows (deprecated) and Linux (recommended). Includes the source for two custom made tools: [`mknexrom`](/buildtools/sources/mknexrom.c) (C) and [`SymToEqus`](/buildtools/sources/SymToEqus.cs) (C#).

* [**docs**](/docs): Documentation for both users and developers.

## How to build Nextor

Nextor requires Linux to be built. It should work on macOs too, but that hasn't been tested. If you are on Windows 10 or 11 you can use [WSL](https://docs.microsoft.com/en-us/windows/wsl/install-win10).

To build Nextor you'll need:

* `make`. On Debian/Ubuntu-ish systems you can just `apt-get install make`.
* [The Nestor80 tools](https://github.com/Konamiman/Nestor80). Go to [the releases section](https://github.com/Konamiman/Nestor80/releases) and download the appropriate variant of the latest version for the assembler (N80), the linker (LK80) and the library manager (LB80).
* [SDCC](http://sdcc.sourceforge.net/) **v4.2 or newer**, for FDISK and the command line tools written in C. On Debian/Ubuntu-ish systems you can just `apt-get install sdcc`.
* `objcopy` from [the binutils package](https://www.gnu.org/software/binutils/). On Debian/Ubuntu-ish systems you can just `apt-get install binutils`.
* `mknexrom` to generate the ROM files with the drivers. You have it in the `buildtools/Linux` folder, but you can also build it from the source in the `buildtools/sources` directory.

Except for those obtained via `apt`, you'll need to place these tools at a suitable location to be able to use them, e.g. `/usr/bin`.

There are five makefiles that will take care of building the different components of Nextor. Once the tools are in place you can just `cd` to the appropriate directory and run `make`:

* `source/kernel`: builds the kernel ROM files and copies them to the `bin/kernels` directory. There are handy aliases for the different ROM files, so you can run e.g. `make ide`; see the `kernels` rule at the beginning of the file for the full list.
* `source/command/msxdos`: builds `NEXTOR.SYS` and copies it to the `bin/tools` directory.
* `source/tools`: builds the command line tools written in assembler and copies them to the `bin/tools` directory.
* `source/tools/C`: builds the command line tools written in C and copies them to the `bin/tools` directory.
* `source`: this one just invokes the other four in sequence, so it builds pretty much everything. It supports `make clean` too.

You may want to take a look at [this now closed pull request from Dean Netherton](https://github.com/Konamiman/Nextor/pull/79) that contains a different attempt at writing makefiles for bulding Nextor. It even has some nice extra features like building FDD and HDD images with Nextor, and building the `mknexrom` tool itself.

## How to build Nextor on all platforms with Docker

Using this method for building Nextor is easier. Everything you need for compiling Nextor already installed in the Docker image. If you have [Docker](https://www.docker.com) installed you can build Nextor on Linux, macOS and Windows, on Arm64 and Intel x86_64 by running the following command:

```sh
./build_nextor.sh
```

After compilation, the `ROM` files will be available in the `dist` directory.

_Note that the `build_builder.sh` and the content in the `docker` directory are used to create the Docker builder image. You don't need to run them to build Nextor._
