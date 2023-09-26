function fzf-keybindings
    switch (commandline -opc)
        case "fzf"
            bind \cn 'commandline -f next'
            bind \cp 'commandline -f prev'
        case '*'
            bind \cn ''
            bind \cp ''
    end
end

fzf-keybindings
