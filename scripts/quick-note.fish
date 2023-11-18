#!/usr/bin/env fish

cd $HOME/Documents/vault &&

    set noteFileName "$HOME/Documents/vault/Personal/quicknotes/quick-note$(date +%m-%Y).md"

if test ! -f $noteFileName
    echo "# Notes for $(date +%Y-%m-%d)" >$noteFileName
end


nvim -c "norm Go" \
    -c "norm Go## $(date +"%d/%m %H:%M")" \
    -c "norm G2o" \
    -c "norm zz" \
    -c "set spell" \
    -c "set spelllang=en_us,pt_br" \
    -c startinsert $noteFileName
