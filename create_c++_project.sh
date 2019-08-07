#!/bin/sh

# Initialise project directory variable
CXX_PROJECT_DIRECTORY=${CXX_PROJECT_DIRECTORY:-$1}

CXX_EXECUTABLE_NAME="${CXX_PROJECT_DIRECTORY}-bin"

# Create project directory
mkdir $CXX_PROJECT_DIRECTORY

# Initialise project directory as a git repository
git init $CXX_PROJECT_DIRECTORY

pushd $CXX_PROJECT_DIRECTORY

# Create build, binary, include, source, and test directories
mkdir build bin include src tests

# Create root level CMakeLists.txt 
cat << EOF > CMakeLists.txt
cmake_minimum_required(VERSION 3.8)

project($CXX_PROJECT_DIRECTORY)

set(EXECUTABLE_OUTPUT_PATH \${CMAKE_SOURCE_DIR}/bin)

# Packages

# Create executable and configure
add_executable($CXX_EXECUTABLE_NAME)

target_sources($CXX_EXECUTABLE_NAME
    PRIVATE
        src/main.cpp
)

target_include_directories($CXX_EXECUTABLE_NAME
    PUBLIC
        include
)

# Add relevant compiler warnings depending on platform 
if(MSVC)
    target_compile_options($CXX_EXECUTABLE_NAME
        PRIVATE
            /W4
            /w14640
    )
else()
    target_compile_options($CXX_EXECUTABLE_NAME
        PRIVATE
            -Wall
            -Wextra
            -Wshadow
            -Wnon-virtual-dtor
            -Wpedantic
        )
endif()

# Add additional compiler settings depending on Debug or Release for G++ or
# Clang++. If built using Windows, user can choose Debug or Release from Visual 
# Studio.
if(NOT MSVC)
    if($<STREQUAL:\${CMAKE_BUILD_TYPE}:Debug>)
        target_compile_options($CXX_EXECUTABLE_NAME
            PRIVATE
                -g
        )
    elseif($<STREQUAL:\${CMAKE_BUILD_TYPE}:Release>)
        target_compile_options($CXX_EXECUTABLE_NAME
            PRIVATE
                -O2
                -DNDEBUG
        )
    endif()
endif()

if(TESTS_ON)
    add_subdirectory(tests)
endif()
EOF

#Create .gitignore file
cat << EOF > .gitignore
# Ignore build directory contents and executables
bin/*
build/*
tests/bin/*
EOF

pushd src

# Copy contents of template hello world program into new file main.cpp
cp ${PROJECT_TEMPLATE_SCRIPTS}/template_files/c++/hello_world.cpp main.cpp

popd

pushd tests

# Make binary, source and include directories for the unit testing code
mkdir bin src include

# Create CMakeLists.txt file for unit tests. Unit tests are considered a
# seperate project for seperation of concerns
cat << EOF > CMakeLists.txt
project(${CXX_PROJECT_DIRECTORY}-tests)

set(EXECUTABLE_OUTPUT_PATH \${CMAKE_SOURCE_DIR}/tests/bin)

# Packages
find_package(Catch2 REQUIRED)

enable_testing()

add_executable(unit-tests)

target_sources(unit-tests
    PRIVATE
        src/main_test.cpp
)

target_include_directories(unit-tests
    PRIVATE
        include
)

target_link_libraries(unit-tests
    PRIVATE
        Catch2::Catch2
)

include(ParseAndAddCatchTests)
ParseAndAddCatchTests(unit-tests)
EOF

pushd src

# Write contents of template file to new file called main_test.cpp
cp ${PROJECT_TEMPLATE_SCRIPTS}/template_files/c++/catch2_unit_test_example.cpp main_test.cpp

popd

# Return to script call location
popd
popd

