echo "Reboot shell in 5 seconds .."
sleep 5

# Reboot shell or change shell to zsh
if [ "$SHELL" != '/bin/zsh' ]; then
    echo_info "change shell $SHELL to /bin/zsh"
    chsh -s /usr/local/bin/zsh
    exec /usr/local/bin/zsh
else
    exec "${SHELL}" -l
fi
