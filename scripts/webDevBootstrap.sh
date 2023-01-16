#!/bin/sh

read -p "Folder name: " -r FOLDER
read -p "JSX OR TSX (optional, leave empty if you don't want): " -r TSX
TSX=${TSX,,}
read -p "styled-components (y/N): " -r STYLED
STYLED=${STYLED,,}
read -p "tailwind-css (y/N): " -r TW
TW=${TW,,}
read -p "npm (default) OR yarn? " -r PKG

if  [ "$PKG" != "npm" ] && [ "$PKG" != "yarn" ]; then
    PKG="npm"
    echo ""
    echo "None package manager passed, using npm by default..."
    echo ""
fi
PKG=${PKG,,}

read -p "Create the folder in the current directory? (Y/n): " -r DIR
DIR=${DIR,,}

if [ "$DIR" = "n" ]; then
    read -p "Path for directory: " -r DIRPATH &&
      cd $DIRPATH
      echo $DIRPATH 
fi

INSTALL=i
if [ "$PKG" = "yarn" ]; then
  INSTALL=add
fi

if [ -z "$TSX" ] || [ "$TSX" = " " ]; then
  TSX=undefined
  read -p "TS OR JS: " -r TS 
  TS=${TS,,}

    if [ -z "$TS" ] || [ "$TS" = " " ]; then
    TS=js
    echo "None value passed for (TS OR JS), using JS by default"
    fi

fi

echo "Folder Name:" $FOLDER
echo "JSX/TSX:" $TSX
if [ -z "$TSX" ] || [ "$TSX" = " " ]; then
  echo "TS OR JS:" $TS 
fi

if [ -z "$TW" ] || [ "$TW" = " " ]; then
    TW="undefined"
    echo "tailwind-css:" $TW
    exit 1
else 
    echo "tailwind-css:" $TW
fi

if [ -z "$STYLED" ] || [ "$STYLED" = " " ]; then
    STYLED="undefined"
    echo "styled-components:" $STYLED
    exit 1
else 
    echo "styled-components:" $STYLED
fi
echo "Package Manager:" $PKG
if [ -z "$DIRPATH" ] || [ "$DIRPATH" = " " ]; then
    echo "Path For directory: " $PWD 
    exit 1
else 
    echo "Path for directory:" $DIRPATH
fi

read -p "Continue?: (Y/n) " -r CONTINUE
CONTINUE=${CONTINUE,,}

if [ "$CONTINUE" = "n" ]; then 
    echo "SCRIPT ENDED"
    exit 0 
fi

$PKG create vite ./$FOLDER/ &&
    cd $FOLDER/

if  [ "$PKG" = "yarn" ]; then
    $PKG add -D eslint
    $PKG run eslint --init
else
    $PKG init @eslint/config
fi

$PKG $INSTALL -D prettier &&
    $PKG $INSTALL eslint-config-airbnb &&
if [ "$TS" = "ts" ]; then 
      $PKG $INSTALL eslint-config-airbnb-typescript
      exit 1
fi 

if  [ "$STYLED" = "y" ]; then
    $PKG $INSTALL -D typescript-styled-plugin
    $PKG $INSTALL -D @types/styled-components
    $PKG $INSTALL styled-components
    exit 1
fi

if  [ "$TW" = "y" ]; then
    $PKG $INSTALL -D tailwindcss postcss autoprefixer 
    npx tailwindcss init -p
    echo "Add yours sources folder in tailwind.config.cjs in content section."
    exit 1
fi

if [ "$TSX" = "jsx" ]; then
    $PKG $INSTALL prop-types &&
        $PKG $INSTALL eslint-config-airbnb &&
        $PKG $INSTALL -D @babel/eslint-plugin eslint-plugin-react eslint-plugin-react-hooks prettier eslint-config-prettier eslint-plugin-prettier @babel/eslint-parser
    cp $HOME/Dev/reactBoilerPlate/jsx/.* ./
    exit 1
fi

if ["$TSX" = "tsx" ]; then
    $PKG $INSTALL -D prettier eslint-config-prettier eslint-plugin-prettier
    $PKG $INSTALL -D @typescript-eslint/eslint-plugin @typescript-eslint/parser
    $PKG $INSTALL -D eslint-config-airbnb-typescript @typescript-eslint/eslint-plugin @typescript-eslint/parser
    $PKG $INSTALL -D @babel/eslint-plugin prettier eslint-config-prettier eslint-plugin-prettier
    $PKG $INSTALL -D @typescript-eslint/eslint-plugin @typescript-eslint/parser
    $PKG $INSTALL -D @babel/eslint-plugin eslint-plugin-react eslint-plugin-react-hooks prettier eslint-config-prettier eslint-plugin-prettier @babel/eslint-parser
    cp $HOME/Dev/reactBoilerPlate/tsx/.* ./
    exit 1
fi

echo -----------------------------------------------------
echo "              Project BootStrap done.                "
echo -----------------------------------------------------


read -p "Do you want to install any additional packages? (y/N) " -r OPTPKGS
OPTPKGS=${OPTPKGS,,}

if [ "$OPTPKGS" = "y" ]; then
    read -a -p "Packages: (separated by space): " -r PKGS
    for OPTPKG in $PKGS; do
      $PKG $INSTALL $OPTPKG
    done
    exit 1
fi 

echo $DIRPATH$FOLDER
exit 1
