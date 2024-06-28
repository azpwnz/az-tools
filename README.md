
# az-tools

This repository contains the `get_multifile_prompt.sh` script and potentially other useful scripts in the future.

## get_multifile_prompt.sh

The `get_multifile_prompt.sh` script concatenates the contents of multiple files, optionally searching in subdirectories, and copies the result to the clipboard. This script is particularly useful when working with large language models (LLMs).

### Why this is useful for LLMs

Efficiently programming multifile projects:
LLMs are pretty powerful when they’re working with a project split up into multiple files. They’re great with simple files, even if there are many of them. By using `gmfp` (get multifile prompt), you can easily prepare a comprehensive prompt for the LLM that includes all relevant code files, ensuring the model has all the context it needs to understand and work on your project effectively.


### Setup

1. **Make the script executable:**

    ```sh
    chmod +x get_multifile_prompt.sh
    ```

2. **Create an alias for easy access:**

    Open your `.zshrc` (or `.bashrc` if you're using Bash) file in a text editor:

    ```sh
    nano ~/.zshrc
    ```

    Add the following line to create an alias:

    ```sh
    alias gmfp='/path/to/get_multifile_prompt.sh'
    ```

    Save the file and exit the text editor.

3. **Reload the shell configuration:**

    ```sh
    source ~/.zshrc
    ```

### Usage

You can now use the `gmfp` command to run the script. Here are some examples:

- **Search only in the current directory for `.tsx` files:**

    ```sh
    gmfp "*.tsx"
    ```

- **Search in the current directory and all subdirectories for `.tsx` files:**

    ```sh
    gmfp -r "*.tsx"
    ```

- **Search in the current directory and all subdirectories for `.tsx` and `.css` files:**

    ```sh
    gmfp -r "*.tsx" "*.css"
    ```

- **Search for all files in the current directory only:**

    ```sh
    gmfp
    ```

- **Search for all files in the current directory and its subdirectories:**

    ```sh
    gmfp -r
    ```

### Example

Here is an example of how this script works and why it is useful when working with LLMs:

```sh
gmfp -r "*.py"
```

This command will find all Python files in the current directory and subdirectories, concatenate them into one prompt, and copy it to the clipboard. Each file's content is encapsulated in backticks along with its path, as shown below:

```
\```./folder1/script1.py
print("Hello from script1")
\```

```./folder2/script2.py
print("Hello from script2")
\```
```

### Notes

I took the original version of this script from [EasyModularScripts](https://github.com/dnbt777/EasyModularScripts/blob/main/ai-tools/get_multifile_prompt.sh), but added subdirectories (recursion functionality).

### Requirements

- For macOS users, `pbcopy` is typically pre-installed.
- For Linux users, install `xclip` if it is not already installed:

    ```sh
    sudo apt-get install xclip
    ```

### Contribution

Feel free to fork this repository, submit issues, and make pull requests. Contributions are welcome!
