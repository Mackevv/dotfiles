#!/bin/bash

cd ~/documents/notes/
echo "= New note" > newnote.typ
v newnote.typ -c 'terminal typst watch newnote.typ'


