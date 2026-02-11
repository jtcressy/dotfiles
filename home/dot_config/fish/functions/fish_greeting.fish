function fish_greeting
    if test -x /usr/libexec/ublue-motd; and not test -e $HOME/.config/no-show-user-motd
        /usr/libexec/ublue-motd
    end
end
