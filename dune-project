(lang dune 3.19)

(using menhir 3.0)

(name tilapia)

(generate_opam_files true)

(source
 (github duermes/tilapia-lang))

(authors "Lorena <author@example.com>")

(maintainers "Maintainer Name <maintainer@example.com>")

(license MIT)

(documentation https://github.com/duermes/tilapia-lang/blob/main/specification.md)

(package
 (name tilapia)
 (synopsis "tilapias no difundir")
 (description "no difundir tilapias")
 (depends ocaml)
 (tags
  ("add topics" "to describe" your project)))

; See the complete stanza docs at https://dune.readthedocs.io/en/stable/reference/dune-project/index.html
