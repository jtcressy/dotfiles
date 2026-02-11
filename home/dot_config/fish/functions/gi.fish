function gi --description "Generate .gitignore from gitignore.io templates"
    curl -sL "https://www.toptal.com/developers/gitignore/api/$argv"
end
