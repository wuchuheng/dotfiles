# Dotfiles

<p align="center">
    <a herf='https://github.com/wuchuheng/dotfiles/actions/workflows/test.yaml' alg='Test Dotfiles'>
        <img src='https://github.com/wuchuheng/dotfiles/actions/workflows/test.yaml/badge.svg?branch=master' />
    </a>
</p>

Welcome to my personal dotfiles repository for Zsh, managed with the Zsh Plugin Manager (ZPM). This setup is designed to streamline my shell environment with custom configurations, functions, and themes for Zsh.

## Prerequisites

Before you get started, ensure you have `zsh` installed on your system. ZPM will be used to manage Zsh plugins and themes.

## Installation

```sh
curl -fsSL https://raw.githubusercontent.com/wuchuheng/dotfiles/master/install.sh | bash
```

## Workflows

### 1 gdsc_gdp_workflow

`git_gdp_workflow` - A workflow to copy the AI gpt prompt to the clipboard.and the prompt use to generate the standard git commit message by AI gpt like `chat gtp4`. and the flowing is the steps of the workflow:
 - add all the changes to the stage
 - show the changes
 - add the prompt for the AI gdp to use the standard git commit message to generate the standar commit message
 - copy the changes to the clipboard

## aliases

### 1. fonts
[NerdFont Regular](src/assets/fonts/0xProto/)

## Contributing

Feel free to fork this repository and customize your own Zsh environment. If you have suggestions or improvements, pull requests are welcome.

## License

This dotfiles repository is open-sourced under the MIT license.