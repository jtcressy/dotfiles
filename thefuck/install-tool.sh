if command -v thefuck;
then
  if [ -x "$(command -v thefuck)"];
  then
    echo "thefuck already installed"
    thefuck --version
  else
    echo "installing thefuck"
    if [ "$(uname -s)" == "Darwin"]
    then
      brew install thefuck
    else
      pip install thefuck
    fi
  fi
fi
