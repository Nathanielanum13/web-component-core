#!/bin/bash

# Function to convert PascalCase to kebab-case
pascal_to_kebab() {
  # Use sed to perform the conversion
  echo "$1" | sed -E 's/([A-Z])/-\1/g' | sed 's/^-//' | tr '[:upper:]' '[:lower:]'
}

# Function to copy .vue to .ce.vue
copy_vue_to_ce() {
  for dir in ./src/components/*/; do
    if [ -d "$dir" ]; then
      subdir_name=$(basename "$dir")
      if [ -f "$dir$subdir_name.vue" ]; then
        cp "$dir$subdir_name.vue" "$dir$subdir_name.ce.vue"
      fi
    fi
  done
}

# Function to generate and define custom elements
generate_custom_elements() {
  for dir in ./src/components/*/; do
    if [ -d "$dir" ]; then
      subdir_name=$(basename "$dir")
      kebab_name=$(pascal_to_kebab $subdir_name)
      if [ -f "$dir$subdir_name.ce.vue" ]; then
        echo "import { defineCustomElement } from 'vue'" > "$dir$subdir_name.js"
        echo "import ${subdir_name} from '@/components/${subdir_name}/${subdir_name}.ce.vue'" >> "$dir$subdir_name.js"
        echo "" >> "$dir$subdir_name.js"
        echo "const ${subdir_name}Component = defineCustomElement(${subdir_name})" >> "$dir$subdir_name.js"
        echo "" >> "$dir$subdir_name.js"
        echo "customElements.define('${kebab_name}', ${subdir_name}Component)" >> "$dir$subdir_name.js"
        echo "export { ${subdir_name}Component }" >> "$dir$subdir_name.js"
      fi
    fi
  done
}

# Function to undo the process
undo_process() {
  for dir in ./src/components/*/; do
    if [ -d "$dir" ]; then
      subdir_name=$(basename "$dir")
      if [ -f "$dir$subdir_name.ce.vue" ]; then
        rm "$dir$subdir_name.ce.vue"
      fi
      if [ -f "$dir$subdir_name.js" ]; then
        rm "$dir$subdir_name.js"
      fi
    fi
  done
}

# Main menu
if [ "$1" == "--undo" ]; then
  undo_process
else
    copy_vue_to_ce
    generate_custom_elements
fi
