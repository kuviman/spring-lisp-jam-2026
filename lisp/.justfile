default:
    just --list

compile-mks backend:
    mkdir -p target
    kast mini compile \
        --target c \
        --prepend $KAST_PATH/mini/backends/c/runtime.c \
        --prepend src/backends/{{backend}}.c \
        $KAST_PATH/mini/backends/c/runtime.mks \
        $(fd --extension mks --exclude '**/backends/*') \
        src/backends/{{backend}}.mks \
        > target/main.c

compile-c:
    gcc target/main.c \
        -I $MINICORO_INCLUDE \
        -lm \
        -lraylib \
        -lreadline \
        -o target/main

build:
    just compile-mks native
    just compile-c

run:
    just build
    ./target/main

