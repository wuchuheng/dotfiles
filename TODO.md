# Project Todo List

This document outlines planned features, known bugs, and tasks to be completed for the project. It's divided into sections for better organization.

## Features

- [ ] **Embad lua **
  - Implement lua as a dependence in the project 
  
- [ ] **Task Notification `n`**
  - [ ] Implement a `n` cmd to notice the `cmd` result, like:
    ```bash
    ls -ahl | n # <-- the cmd `n` will receive the `ls -ahl` result and send the email to user.
    ```
  - [ ] Implement the notification web server to receive the message from a specific port, and the user access the web server in the browser to get the message.
    - [ ] the notice voice will be noticed in the browser.
    - [ ] the desktop notice will be noticed frome the browser.
  - [ ] Implement the `n` cmd to notice the `cmd` result via http protocol to send the message to local web server opened in the browser, and then the browser will send the message to the user.

  - [x] Implement the `dot ls` cmd to list of the description of the plugin, and the user can get the plugin description from the `dot ls` cmd. like:
    ```bash
    dot ls # <-- the cmd will list the description of the plugin.
    
    # the result will be like:
    1. certificate:
      certificate.create_by_dns: Create a new certificate by DNS.
    2. web-vim: Open a new neovim to develop a web project.
    3. ...
    ```
  - [ ] Implement the documents of workflow to describe what the workflow do and how to use it. like execute the `dot workflows` cmd to get the workflow description.
    ```bash
    dot workflows # <-- the cmd will list the description of the workflow.
    
    # the result will be like:
    1. git_gtp_workflow: The workflow to get the git project from the git server.
      certificate.create_by_dns: Create a new certificate by DNS.
    2. ...
    ```

## Bugs


## Tasks


## Completed

- [x] **Tmux: toggle the statue bar visable in tmux**
  - Implement the status bar to hide when hitting `Ctrl + b + b`