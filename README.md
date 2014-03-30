This is my ~/.vim dir

Installation
============

Clone the repo:
`git clone git@github.com:davidarias/vimfiles.git ~/.vim`

Grab the plugin submodules:
`cd ~/.vim && git submodule init && git submodule update`


Make sure vim finds the vimrc file by either symlinking it:
`ln -s ~/.vim/vimrc ~/.vimrc`

or by sourcing it from  your own ~/.vimrc:
`source ~/.vim/vimrc`

Some plugins need extra install steps:
--------------------------------------

**YouCompleteMe:**

`cd ~/.vim/bundle/YouCompleteMe`

`./install.sh`

See readme for install support for c/c++ projects

**tern for vim**

`cd ~/.vim/bundle/tern_for_vim`

`npm install`

For javascript tags support install https://github.com/faceleg/doctorjs


Update Submodules
=================

`git submodule foreach git pull origin master`
