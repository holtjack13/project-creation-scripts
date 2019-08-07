## Getting Started
To begin with, clone the repository to a location of choice on your machine.
Once the scripts are on your machine, open the configuration file for your
shell of choice and create an environment variable called `PROJECT_TEMPLATE_SCRIPTS`,
loading it with the repositories' location. For example, if you use bash, you
would navigate to `.bashrc` in the home directory and add the following:
```bash
PROJECT_TEMPLATE_SCRIPTS=<your-location-here>
export PROJECT_TEMPLATE_SCRIPTS
```
For convienient running of the scripts wherever you are, simply add
the following functions to your shell configuration file:
```bash
function create_c++_project()
{
    ${PROJECT_TEMPLATE_SCRIPTS}/create_c++_project.sh $1
}

function create_python_project()
{
    ${PROJECT_TEMPLATE_SCRIPTS}/create_python_project.sh $1
}
```

## Script Usage

### Create C++ Project
The C++ project creation script creates a CMake based C++ project, complete
with Catch2 and CTest integration for performing unit testing. The script
takes a single argument, the project name. If you've added the functions
described above, run the following in your terminal:
```console
foo@bar:~$ create_c++_project <project-name>
```
If not, run the following instead
```console
foo@bar:~$ <script-location>/create_c++_project.sh <project-name>
```

The project structure created by the script is as follows:
```console
foo@bar:~$ tree test
test
├── bin
├── build
├── CMakeLists.txt
├── include
├── src
│   └── main.cpp
└── tests
    ├── bin
    ├── CMakeLists.txt
    ├── include
    └── src
        └── main_test.cpp
```
To build the project, navigate to the empty build directory and run the
following commands:
```console
foo@bar:~$ cmake .. -DCMAKE_BUILD_TYPE=Debug -DTESTS_ON=1
foo@bar:~$ make
```
The first command invokes CMake, telling it to generate a debug build system 
for the project, and for the unit test subproject in the tests directory. 
Both the build type and whether the test subproject is rebuilt can be toggled at 
the command line.

The second command produces the project executables, storing them in their
respective `bin` directories.

