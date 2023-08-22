tmpfile=`mktemp`.sh
tmux capture-pane -pS - > $tmpfile
# open as scratch file (so I can quit without saving), remove all trailing newlines and go to end of file
tmux new-window -n tmux-output "nvim -c ':setlocal buftype=nofile | :setlocal bufhidden=hide | :setlocal noswapfile | %s/\n\+\%$//e | normal G' $tmpfile"
