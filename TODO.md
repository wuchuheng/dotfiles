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

## Bugs


## Tasks


## Completed

- [x] **Tmux: toggle the statue bar visable in tmux**
  - Implement the status bar to hide when hitting `Ctrl + b + b`