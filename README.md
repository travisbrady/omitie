omitie
======

OCaml bindings to MIT's MITIE information extraction library

Synopsis
========
Experimental bindings to the newly-released [MITIE library](https://github.com/mit-nlp/MITIE).  
Also see [this blog post](http://blog.dlib.net/2014/04/mitie-completely-free-and-state-of-art.html)
MITIE currently only provides functions for named entity recognition but work is apparently under way
on support for all manner of information extraction.

Install
=======
1. Install MITIE via the instructions in the MITIE readme
2. ocaml setup.ml -configure
3. ocaml setup.ml -build
4. ocaml setup.ml -install

If you just want to see omitie in action you can just build and play with simple.native which
mirrors the ner_example executable in the MITIE distribution.
Provided you've downloaded ner_model.dat this will extract named entities from a text file and
print the results to stdout.

Example of use of simple.native:
```bash
$ ./simple.native ner_model.dat sample_text.txt
The tagger supports 4 tags:
    PERSON
    LOCATION
    ORGANIZATION
    MISC
   Tag: ORGANIZATION Pegasus Airlines
   Tag: LOCATION Istanbul
   Tag: LOCATION Sochi
   Tag: LOCATION Russia
   Tag: LOCATION Turkey
   Tag: ORGANIZATION Transportation Ministry
   Tag: PERSON Meredith Vieira
   Tag: MISC Olympics
   Tag: PERSON Bob Costas
   Tag: PERSON Vieira
   Tag: MISC Olympics
   Tag: PERSON Bob Costas
   Tag: PERSON Bob
   Tag: ORGANIZATION NBC Olympics
   Tag: PERSON Jim Bell
   Tag: LOCATION Sochi
```
