#!/usr/bin/env fish
set image_format
set suffix
set size
set output_folder

#  TODO: use args instead a **READ**


function questions
    read -P "What format the compress image should be? (Default: webp) " image_format
    read -P "Suffix for compressed images? (Default: -low) " suffix
    read -P "What should be compressed? (Default: 858x480) " size
    read -S -P "Output Folder? (Default: ./) " output_folder
    set image_format (string replace '.' '' $image_format)
end

function check_defaults
    if test -z $image_format
        set image_format webp
    end

    if test -z $suffix
        set suffix -low
    end

    if test -z $size
        set size 858x480
    end

    if test -z $output_folder
        set output_folder ./
    end
end

questions
check_defaults

if test -z $argv
    for img in ./*.{jpg,png}
        set extension (string match -r '\.[^.]*$' $img)
        set image_name (basename -s $extension $img)
        set image_output $image_name$suffix.$image_format
        convert $img -resize $size $output_folder$image_output
        echo "Image Converted: $image_output"
    end
else
    echo "Arguments are not current supported"
end
