open Printf

let () =
    let ner = Omitie.load_named_entity_extractor (Sys.argv.(1)) in

    let num_tags = Omitie.get_num_possible_ner_tags ner in
    printf "The tagger supports %d tags:\n" num_tags;
    for i = 0 to (num_tags - 1) do
        printf "    %s\n" (Omitie.get_named_entity_tagstr ner i)
    done;

    let text_data = Omitie.load_entire_file (Sys.argv.(2)) in
    let tokens = Omitie.tokenize text_data in

    let nes = Omitie.extract ner tokens in
    List.iter (fun (tag, ne) -> printf "   Tag: %s %s\n" tag ne) nes;

    ()
