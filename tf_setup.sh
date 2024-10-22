#!/bin/bash

usage() {
  echo "Usage: $0 [-p project_directory] -m module_name [module_name ...]"
  exit 1
}

PROJECT_DIR="."
MODULES=()

while [[ $# -gt 0 ]]; do
  key="$1"
  case $key in
    # Project directory option
    -p)
      PROJECT_DIR="$2"
      shift # Past argument
      shift # Past value
      ;;
    -m)
      shift # Past -m
      while [[ $# -gt 0 && "$1" != -* ]]; do
        MODULES+=("$1")
        shift
      done
      ;;
    # Invalid option
    *)
      usage
      ;;
  esac
done

# Check if at least one module name was provided
if [ ${#MODULES[@]} -eq 0 ]; then
  echo "Error: No modules specified. Use -m to specify module names."
  usage
fi

# Create the project directory if it doesn't exist
if [ ! -d "$PROJECT_DIR" ]; then
  mkdir -p "$PROJECT_DIR"
  echo "Created project directory: $PROJECT_DIR"
else
  echo "Project directory exists: $PROJECT_DIR"
fi

# Create the main.tf file in the project directory if it doesn't exist
if [ ! -f "$PROJECT_DIR/main.tf" ]; then
  touch "$PROJECT_DIR/main.tf"
  echo "Created main.tf in $PROJECT_DIR"
else
  echo "main.tf already exists in $PROJECT_DIR. Skipping."
fi

# Define the modules directory inside the project directory
MODULES_DIR="$PROJECT_DIR/modules"

# Create the modules directory if it doesn't exist
if [ ! -d "$MODULES_DIR" ]; then
  mkdir -p "$MODULES_DIR"
  echo "Created modules directory: $MODULES_DIR"
else
  echo "Modules directory exists: $MODULES_DIR"
fi

# Loop through each module and create directories and files
for MODULE in "${MODULES[@]}"; do
  MODULE_DIR="$MODULES_DIR/$MODULE"
  if [ ! -d "$MODULE_DIR" ]; then
    mkdir -p "$MODULE_DIR"
    touch "$MODULE_DIR/main.tf" "$MODULE_DIR/variables.tf" "$MODULE_DIR/outputs.tf"
    echo "Created module: $MODULE in $MODULE_DIR"
  else
    echo "Module $MODULE already exists in $MODULE_DIR. Skipping."
  fi
done

echo "Setup complete."
