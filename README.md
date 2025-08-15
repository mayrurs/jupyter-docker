# Jupyerlab Setup 

## Vim Bindings

For Vim  bindings the container installs the jupyterlab-vim plugin. Currently custom key bindings can only be set over the UI in  jupyterlab. To persist keybindings for <Esc>. We need to copy the `user-settings` and mount it into the container.

`docker cp jupyter-gpu:/root/.jupyter/lab/user-settings ./settings/`

This needs to be repeated everytime some user-settings are changed.

