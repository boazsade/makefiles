# makefiles
A set of makefiles that allow building automatically from any location any code using very few dependencies - this is almost as automatic as it can be for make
You still need to do some work for this to work - 
you would need to set the location of the compiler (if you don't use the system compiler - which i don't)
You would need to add a file call build.sh (it can be empty) at the project root directory.
You would need to set actual location for your libs directory, shared lib directory and application directory
This has support for building and running unit tests
Building tests (that are not part of the application)
Building applications
Building static libraries
Building and linking shared libraries
