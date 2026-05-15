default:
    just --list

lisp *args:
    (cd lisp && just build)
    ./lisp/target/main {{args}}

