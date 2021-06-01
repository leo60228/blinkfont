#!/usr/bin/env bash
set -e

rm -rf build

mkdir build build/svg build/svg-anim build/svg-opt

cp --no-preserve=mode,ownership "$1" build/blink.otf

fonts2svg -o build/svg build/blink.otf

if [ -d build/svg/_moreSVGs_ ]; then
    mv build/svg/_moreSVGs_/* build/svg
    rmdir build/svg/_moreSVGs_
fi

for svg in build/svg/*.svg; do
    svgcleaner "$svg" "build/svg-opt/$(basename "$svg")"
    xsltproc --novalid -o "build/svg-anim/$(basename "$svg")" animate.xsl "build/svg-opt/$(basename "$svg")"
done

addsvg -m build/svg-anim build/blink.otf

cp build/blink.otf demo/blink.otf
