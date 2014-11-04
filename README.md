# Compiling and running an Oracle Pro\*C-based application using C++-11.

So you want to write Oracle Pro\*C programs on a Mac with C++11 features? So do I, and after looking through a lot of
web pages and experimentation, I've been able to come up with a basic project that:

* Uses clang++ to compile C++11 source code
* Uses Oracle's Mac-native 11g Instant Client installation with its accompanying Pro\*C compiler
* Works on the latest version of OS X (10.10 as of this writing) with the latest XCode toolchain.

Hopefully this helps someone who also wants to compile native Mac apps that use Oracle's databases. Enjoy!

## Setup

The first thing needed is Oracle's Instant Client which is available at http://www.oracle.com/technetwork/topics/intel-macsoft-096467.html.
I used the 11.2.0.4.0 (64-bit) version and downloaded, well, pretty much everything except the WRC package (no idea what that's for). 
I installed everything into and defined $ORACLE_HOME as /opt/instantclient_11_2. 

That's the only Oracle-specific thing that needs to be done, I assume XCode has been installed in the usual place and configured.

## Files

### `ora.cfg`
This is the configuration file that the Pro\*C compiler will use to `mac_ora_cpp_test.pc` into `mac_ora_cpp_test.cpp`. It
defines the header locations (that took a *lot* of work to figure out!), along with code type (cpp). **Note!** The most
important part of the file is `parse=none`. This is the only setting that will allow all the various C++ objects and classes
to pass unaltered into the resulting cpp file. 

### `mac_ora_cpp_test.pc`
This is the actual source code that mingles Oracle sql with C++. It is hard-coded to log into a database identified as
`orcl` with the standard scott/tiger user, open a cursor to get the employee name from the employee table, putting the
name into a vector, and then after the cursor is done and closed, and after disconnecting from the database, uses a
C++11 lambda to print the list of names.

### `Makefile`
Standard Makefile with the exception that it first invokes the Pro\*C compiler, passing it the configuration file
(`ora.cfg`), and connects to the database for validation. The resulting cpp file is then compiled with clang++ with
pretty much everything you *absolutely need to have* to get a binary. The only exception to this is that if you don't
need C++-11 features, then you can omit the -std=c++11 line.
