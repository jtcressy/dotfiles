#!/bin/sh
if command -v thefuck && [ -x "$(command -v thefuck)"];
then
  echo "thefuck already installed"
  thefuck --version
else
  echo "installing thefuck"
  if [ "$(uname -s)" = "Darwin" ];
  then
    brew install thefuck
  else
    pip install thefuck || pip3 install thefuck || true
  fi
fi
