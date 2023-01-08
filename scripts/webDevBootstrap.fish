#!/usr/bin/env fish
# TODO: fix the babel/react for JSX 
# TODO: improve the read for js/jsx or tsx/ts 
# TODO: fix the cd in the end of the script not working 

read -P "Folder name: " FOLDER
read -P "JSX OR TSX: " TSX
set TSX (string lower $TSX)
read -P "TS OR JS: " TS
set TS (string lower $TS)
read -P "styled-components (y/N): " STYLED
set STYLED (string lower $STYLED)
read -P "npm (default) OR yarn? " PKG

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

if test -z $STYLED
    set STYLED n
end

if test -z $TSX
    set TSX none
end

if test -z $TS
    set TS js
    echo "None value passed for (TS OR JS), using JS by default"
end

echo "Folder Name:" $FOLDER
echo "JSX/TSX:" $TSX
echo "TS OR JS:" $TS
echo "styled-components:" $STYLED
echo "Package Manager:" $PKG
echo "Path for directory:" $DIRPATH
sleep 1

read -P "Continue?: (Y/n) " CONTINUE
if test (string lower $CONTINUE = n)
    return 1
end

$PKG create vite ./$FOLDER/ &&
    cd $FOLDER/
if test (string lower $PKG = yarn)
    $PKG add -D eslint
    $PKG run eslint --init
else
    $PKG init @eslint/config
end



$PKG $INSTALL -D prettier &&
    $PKG $INSTALL eslint-config-airbnb &&

    if test (string lower $TS = js)
        $PKG $INSTALL eslint-config-airbnb-typescript
        return 1
    end

if test (string lower $STYLED = y)
    $PKG $INSTALL -D typescript-styled-plugin
    $PKG $INSTALL -D @types/styled-components
    $PKG $INSTALL styled-components
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
    #TODO: make a for in pkgs, for prevent not install pkgs 
    $PKG $INSTALL $PKGS
    return 1
end

cd $DIRPATH$FOLDER &&
    echo $DIRPATH$FOLDER
return 1
