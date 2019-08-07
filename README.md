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
with Catch2 and CTest integration for performing unit testing. The directory
structure created is as follows:
```console
tree test
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
