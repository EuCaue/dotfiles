#!/bin/bash

# =============== Audiobook Converter Script ===============
# Converts an ebook file to an audiobook using Calibre and Piper
# Supports splitting the ebook into chunks by reading time.
# Dependencies: piper, ebook-convert (from Calibre)
# ==========================================================

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Help
usage() {
  echo -e "${YELLOW}Usage:${NC} $0 --ebook <file> --model <piper_model> [--output <output_file>] [--output-path <output_dir>] [--format <audio_format>] [--split-minutes <min>]"
  echo -e "${YELLOW}Example:${NC} $0 --ebook book.epub --model en_US-lessac --output-path ./audiobooks --format mp3 --split-minutes 5"
  exit 1
}

# Default values
audio_format_output="mp3"
ebook_file_path=""
audio_output_path=""
audio_output_dir=""
model=""
split_minutes=0

# Argument parsing
while [[ $# -gt 0 ]]; do
  case "$1" in
  --ebook)
    ebook_file_path="$2"
    shift 2
    ;;
  --output)
    audio_output_path="$2"
    shift 2
    ;;
  --output-path)
    audio_output_dir="$2"
    shift 2
    ;;
  --format)
    audio_format_output="$2"
    shift 2
    ;;
  --model)
    model="$2"
    shift 2
    ;;
  --split-minutes)
    split_minutes="$2"
    shift 2
    ;;
  -* | --*)
    echo -e "${RED}Unknown option:${NC} $1"
    usage
    ;;
  *)
    shift
    ;;
  esac
done

# Required arguments check
if [ -z "$ebook_file_path" ] || [ -z "$model" ]; then
  echo -e "${RED}Error:${NC} --ebook and --model are required."
  usage
fi

# Resolve paths
ebook_file_path=$(realpath "$ebook_file_path")
ebook_name=$(basename "$ebook_file_path")
ebook_basename="${ebook_name%.*}"

# Temporary file
temp_txt_path="/tmp/${ebook_basename}.txt"

# Define audio output path
if [ -n "$audio_output_path" ]; then
  : # output já definido
elif [ -n "$audio_output_dir" ]; then
  mkdir -p "$audio_output_dir"
  audio_output_path="${audio_output_dir}/${ebook_basename}-OUTPUT.${audio_format_output}"
else
  audio_output_path="$(dirname "$ebook_file_path")/${ebook_basename}-OUTPUT.${audio_format_output}"
fi

# Logging
echo -e "${BLUE}Ebook:${NC} $ebook_file_path"
echo -e "${BLUE}Model:${NC} $model"
echo -e "${BLUE}Audio Format:${NC} $audio_format_output"
echo -e "${BLUE}Output Path:${NC} $audio_output_path"
[[ "$split_minutes" -gt 0 ]] && echo -e "${BLUE}Split every:${NC} $split_minutes minute(s)"

# Convert ebook to plain text
if [ ! -f "$temp_txt_path" ]; then
  echo -e "${YELLOW}Converting ebook to text...${NC}"
  ebook-convert "$ebook_file_path" "$temp_txt_path" || {
    echo -e "${RED}Failed to convert ebook to text.${NC}"
    exit 1
  }
else
  echo -e "${YELLOW}Reusing existing temp file:${NC} $temp_txt_path"
fi

# Function to split text by reading time
split_text_by_minutes() {
  local file="$1"
  local minutes="$2"
  local wpm=200
  local words_per_chunk=$((minutes * wpm))
  local output_dir="/tmp/${ebook_basename}_chunks"
  mkdir -p "$output_dir"

  local count=1
  local buffer=""
  local word_count=0

  while read -r line || [[ -n "$line" ]]; do
    for word in $line; do
      buffer+="$word "
      ((word_count++))

      if ((word_count >= words_per_chunk)); then
        chunk=$(echo "$buffer" | sed 's/\(.*\.\).*/\1/')
        [ -z "$chunk" ] && chunk="$buffer"
        echo "$chunk" >"$output_dir/part_${count}.txt"
        ((count++))
        buffer=""
        word_count=0
      fi
    done
  done <"$file"

  # salva último pedaço, se sobrar
  if [ -n "$buffer" ]; then
    echo "$buffer" >"$output_dir/part_${count}.txt"
  fi

  echo "$output_dir"
}

# Gerar áudio com ou sem divisão
if [[ "$split_minutes" -gt 0 ]]; then
  chunk_dir=$(split_text_by_minutes "$temp_txt_path" "$split_minutes")
  find "$chunk_dir" -type f -name 'part_*.txt' | sort -V | while read -r part_file; do
    part_name=$(basename "$part_file" .txt)
    part_audio_output="${audio_output_path%.*}_$part_name.${audio_format_output}"

    echo -e "${YELLOW}Generating audio for:${NC} $part_file"
    "$HOME/.local/bin/piper-folder/piper" --model "$model" --output_file "$part_audio_output" <"$part_file" || {
      echo -e "${RED}Failed to generate audio for ${part_file}.${NC}"
    }
  done
else
  echo -e "${YELLOW}Generating full audio...${NC}"
  "$HOME/.local/bin/piper-folder/piper" --model "$model" --output_file "$audio_output_path" <"$temp_txt_path" || {
    echo -e "${RED}Failed to generate audio.${NC}"
    exit 1
  }

  echo -e "${GREEN}Done. Audiobook saved to:${NC} $audio_output_path"
  xdg-open "$audio_output_path" &>/dev/null &
fi

# Cleanup
rm -f "$temp_txt_path"
