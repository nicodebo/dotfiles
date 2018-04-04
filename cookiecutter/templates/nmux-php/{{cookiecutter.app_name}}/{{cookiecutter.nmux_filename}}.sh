# ref: https://github.com/aaronhalford/tmux-scripts/blob/master/mytmux
# the filename must have an extension, otherwise the following lines will
# return a blank session name
fname="$0i"
fname=${fname%.*}
sess=${fname##*/}

# check if session exists
tmux has-session -t "$sess"
if [ $? != 0 ]
then

  # if session does not exist create it
  # note - default window numbered either 0 or 1 depending on tmux 'base-index'
  # note - my setup assumes 'base-index' was set at 1
  tmux new-session -s "$sess" -n editor -d

  # create window 2
  tmux new-window -n terminal

  # create window 3
  tmux new-window -n webserver

  # create window 4
  tmux new-window -n firefox

  # window 1 - default window for normal use. lets make sure this starts in our home directory.
  tmux send-keys -t "$sess":1 'cd {{cookiecutter.project_directory}} && sleep 2' C-m
  tmux send-keys -t "$sess":1 'nvim -S' C-m

  # window 2 - Terminal
  tmux send-keys -t "$sess":2 'cd {{cookiecutter.project_directory}} && sleep 2' C-m

  # window 3 - webserver
  tmux send-keys -t "$sess":3 'cd {{cookiecutter.project_directory}} && sleep 2' C-m
  tmux send-keys -t "$sess":3 'docker-compose up' C-m

  # window 3 - Firefox
  tmux send-keys -t "$sess":4 'cd {{cookiecutter.project_directory}} && sleep 2' C-m
  tmux send-keys -t "$sess":4 'firefox --new-instance http://localhost &' C-m
  # wait for firefox to spawn before swapping clients
  tmux send-keys -t "$sess":4 'xdotool search --sync --onlyvisible --class "Firefox" &&
    echo -e "local awful = require(\"awful\")\nawful.client.swap.byidx(1)" | awesome-client &&
    echo -e "local awful = require(\"awful\")\nawful.client.focus.byidx(1)" | awesome-client' C-m
  tmux split-window -v -p 70 -t "$sess":4
  tmux send-keys -t "$sess":4.2 'cd {{cookiecutter.project_directory}} && sleep 2' C-m
  tmux send-keys -t "$sess":4.2 'while true; do ls
  **/*.{{cookiecutter.file_extensions}} 2> /dev/null | entr -d reload-browser Firefox; done' C-m

  # Select the editor window
  tmux select-window -t "$sess":3

  # end if statement and attach "$sess" if it existed
fi
tmux attach -t "$sess"
