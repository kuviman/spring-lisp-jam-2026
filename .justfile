default:
    just --list

compile-mks backend:
    mkdir -p target
    kast mini compile \
        --target c \
        --prepend $KAST_PATH/mini/backends/c/runtime.c \
        --prepend lisp/src/backends/{{backend}}.c \
        $KAST_PATH/mini/backends/c/runtime.mks \
        $(fd --extension mks --exclude '**/backends/*') \
        lisp/src/backends/{{backend}}.mks \
        > target/lisp.c

compile-c:
    gcc target/lisp.c \
        -o target/lisp \
        -I $MINICORO_INCLUDE \
        -lm \
        -lraylib \
        -lreadline \
        -ggdb \
        -fno-omit-frame-pointer \
        -fsanitize=address \
        -fsanitize=undefined 

build:
    just compile-mks native
    just compile-c

lisp *args:
    just build
    ./target/lisp {{args}}
