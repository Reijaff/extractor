#! /bin/bash

infile=$1
outdir=$2

# override 65535k docker default size with tmpfs default
mem=$(($(free | awk '/^Mem:/{print $2}') / 2))k

indir=$(realpath $(dirname "${infile}"))
outdir=$(realpath "${outdir}")
infilebn=$(basename "${infile}")

docker run --rm -it --tmpfs /tmp:rw,size=${mem} \
  -v "${indir}":/firmware-in:ro \
  -v "${outdir}":/firmware-out \
  "ghcr.io/reijaff/extractor" \
  -np \
  /firmware-in/"${infilebn}" \
  /firmware-out
