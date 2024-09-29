#!/usr/bin/env sh

# cursor links for base
source_directory="/usr/share/icons/Adwaita/cursors"

tempfile=$(mktemp)

# find symbolics to use as reference
fd --type l --absolute-path --base-directory "$source_directory" --exec sh -c '
    symlink="{}"
    target=$(readlink "$symlink")
    echo "$symlink $target"
' >"$tempfile"

symlinks=()
targets=()

while IFS=' ' read -r symlink target; do
  symlinks+=("$symlink")
  targets+=("$target")
done <"$tempfile"

rm "$tempfile"

# creating the symbolic links
for i in "${!symlinks[@]}"; do
  relative_target=$(basename "${targets[$i]}")
  new_symlink="$(basename ${symlinks[$i]})"

  ln -s "$relative_target" "$new_symlink"

  echo "creating symbolic link: $new_symlink -> $relative_target"
done
