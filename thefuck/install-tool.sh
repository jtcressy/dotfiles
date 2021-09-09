if ! [ -x "$(command -v thefuck)"]
then
  echo "installing thefuck"
  if [ "$(uname -s)" == "Darwin"]
  then
    brew install thefuck
  else
    pip install thefuck
  fi

else
  echo "thefuck already installed"
  thefuck --version
fi
