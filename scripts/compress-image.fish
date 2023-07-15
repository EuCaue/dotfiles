#  TODO: ask for a input o default use the default values

if test -z $argv
    for img in ./*.{jpg,png}
        set image_name (basename -s .png $img)
        set image_output $image_name".low.webp"
        convert $img -resize 854x480 $image_output
        echo "Image Converted: $image_output"
    end
end
