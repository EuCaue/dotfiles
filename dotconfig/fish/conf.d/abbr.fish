abbr -a -g tn "tmux new -s (pwd | sed 's/.*\///g')" # tmux session 
abbr -a -g cpdf "gs -sDEVICE=pdfwrite -dCompatibilityLevel=1.4 -dPDFSETTINGS=/screen -dNOPAUSE -dQUIET -dBATCH -sOutputFile=output.pdf input.pdf"
abbr -a -g tma "tmux attach -t"
