#!/usr/bin/env fish
# TODO: fix the babel/react for JSX 

read -P "Folder name: " FOLDER
read -P "JSX OR TSX (optional, leave empty if you don't want): " TSX
set TSX (string lower $TSX)
read -P "styled-components (y/N): " STYLED
set STYLED (string lower $STYLED)
read -p "tailwind-css (y/N): " -r TW
set TW (string lower $TW)
read -P "npm(default) OR yarn? " PKG



if test $PKG != npm; and test $PKG != yarn
    set PKG npm
    echo ""
    echo "None package manager passed, using npm by default..."
    echo ""
end
set PKG (string lower $PKG)

read -P "Create the folder in the current directory? (Y/n): " DIR
set DIR (string lower $DIR)
if test $DIR = n
    read -S -P "Path for directory: " DIRPATH &&
        cd $DIRPATH
end

set INSTALL i
if test $PKG = yarn
    set INSTALL add
end

if test -z $TSX
    set TSX undefined
    read -P "TS OR JS: " TS
    set TS (string lower $TS)

    if test -z $TS
        set TS js
        echo "None value passed for (TS OR JS), using JS by default"
    end
end


echo "Folder Name:" $FOLDER
echo "JSX/TSX:" $TSX
if test -z $TSX; or test $TSX == " "
    echo "TS OR JS:" $TS
    return 1
end

if test -z $TW; or test $TW == " "
    set TW undefined
    echo "tailwind-css:" $TW
    return 1
else
    echo "tailwind-css:" $TW
end

if test -z $STYLED; or test $STYLED == " "
    set STYLED undefined
    echo "styled-components:" $STYLED
    return 1
else
    echo "styled-components:" $STYLED
end

echo "Package Manager:" $PKG

if test -z $DIRPATH; or $DIRPATH = " "
    echo "Path For directory: " $PWD
    return 1
else
    echo "Path for directory:" $DIRPATH
    return 1
end
sleep 1

read -P "Continue?: (Y/n) " CONTINUE
if test (string lower $CONTINUE = n)
    return 0
end

$PKG create vite ./$FOLDER/ &&
    cd $FOLDER/
if test (string lower $PKG = yarn)
    $PKG add -D eslint
    $PKG run eslint --init
    return 1
else
    $PKG init @eslint/config
    return 1
end



$PKG $INSTALL -D prettier &&
    $PKG $INSTALL eslint-config-airbnb &&

    if test (string lower $TS = ts)
        $PKG $INSTALL eslint-config-airbnb-typescript
        return 1
    end

if test (string lower $STYLED = y)
    $PKG $INSTALL -D @styled/typescript-styled-plugin
    $PKG $INSTALL -D @types/styled-components
    $PKG $INSTALL styled-components
    return 1
end

if test (string lower $TW = y)
    $PKG $INSTALL -D tailwindcss postcss autoprefixer
    npx tailwindcss init -p
    echo "Add yours sources folder in tailwind.config.cjs in content section."
    return 1
end

if test (string lower $TSX = jsx)
    $PKG $INSTALL prop-types &&
        $PKG $INSTALL eslint-config-airbnb &&
        $PKG $INSTALL -D @babel/eslint-plugin eslint-plugin-react eslint-plugin-react-hooks prettier eslint-config-prettier eslint-plugin-prettier @babel/eslint-parser
    cp $HOME/Dev/reactBoilerPlate/jsx/.* ./
    return 1
end


if test (string lower $TSX = tsx)
    $PKG $INSTALL -D prettier eslint-config-prettier eslint-plugin-prettier
    $PKG $INSTALL -D @typescript-eslint/eslint-plugin @typescript-eslint/parser
    $PKG $INSTALL -D eslint-config-airbnb-typescript @typescript-eslint/eslint-plugin @typescript-eslint/parser
    $PKG $INSTALL -D @babel/eslint-plugin prettier eslint-config-prettier eslint-plugin-prettier
    $PKG $INSTALL -D @typescript-eslint/eslint-plugin @typescript-eslint/parser
    $PKG $INSTALL -D @babel/eslint-plugin eslint-plugin-react eslint-plugin-react-hooks prettier eslint-config-prettier eslint-plugin-prettier @babel/eslint-parser
    cp $HOME/Dev/reactBoilerPlate/tsx/.* ./
    return 1
end

echo -----------------------------------------------------
echo "              Project BootStrap done.                "
echo -----------------------------------------------------

read -P "Do you want to install any additional packages? (y/N) " OPTPKGS
if test (string lower $OPTPKGS = y)
    read -a -P "Packages: (separated by space): " PKGS
    for OPTPKG in $PKGS
        $PKG $INSTALL $OPTPKG
    end
    return 1
end

echo $DIRPATH$FOLDER
return 1
