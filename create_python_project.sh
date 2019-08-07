#!/bin/sh

# Create python project directory variable
PYTHON_PROJECT_DIRECTORY=${PYTHON_PROJECT_DIRECTORY:-$1}

# Create project directory
mkdir $PYTHON_PROJECT_DIRECTORY

# Initialise project directory as a git repository
git init $PYTHON_PROJECT_DIRECTORY

# Move into directory
pushd $PYTHON_PROJECT_DIRECTORY

# Create docs directory, and directory for python package files
# (which has the same name as the project directory)
mkdir docs
mkdir $PYTHON_PROJECT_DIRECTORY

# Make basic README.md file
cat << EOF > README.md
# ${PYTHON_PROJECT_DIRECTORY}
Insert project overview here...
EOF

# Make license file for license details (initially blank)
touch LICENSE

touch requirements.txt

touch setup.py

# Enter python package directory (where source code and tests will live)
pushd $PYTHON_PROJECT_DIRECTORY

# Create test code directory
mkdir tests

# Create hello world program
cat << EOF > $PYTHON_PROJECT_DIRECTORY.py
def main():
    print("Hello, World!")

main()
EOF

popd
popd
