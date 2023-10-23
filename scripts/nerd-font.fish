#!/usr/bin/env fish

set input_folder ""
set output_folder ""

if test -z $argv[1]
    echo "Need args: "
    echo "input-folder=folder"
    echo "output-folder=folder"
    return 1
end

for arg in $argv
    set key (string split = $arg)[1]
    set value (string split = $arg)[2]

    switch "$key"
        case input-folder
            set input_folder $value

        case output-folder
            set output_folder $value
    end
end

echo "$input_folder"
echo "$output_folder"

mkdir -p "$output_folder"
printf "%b" "\e[1;33m==> WARNING: \e[0mNow patching all fonts. This will take very long...\n"
parallel -j $(math ( nproc ) / 2) fontforge --script $HOME/Downloads/Compressed/FontPatcher/font-patcher -c -out "$output_folder" ::: ./$input_folder/*.{otf, ttf}

cd $output_folder
