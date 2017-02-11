#!/usr/bin/env bash


if [[ -z ${MODE+x} ]]; then
    internMode=Productive
else
    internMode=$MODE
fi

echo Mode is: $MODE and internMode is: $internMode

export MODE=$internMode
