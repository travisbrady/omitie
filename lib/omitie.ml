open Printf

let (!@) = Ctypes.(!@)
let (+@) = Ctypes.(+@)
let uloi = Unsigned.ULong.of_int
let ulti = Unsigned.ULong.to_int

let free = Mitie.mitie_free
let close_model = Mitie.mitie_free

let load_named_entity_extractor = Mitie.mitie_load_named_entity_extractor

let get_num_possible_ner_tags ner = ulti (Mitie.mitie_get_num_possible_ner_tags ner)

let get_named_entity_tagstr ner idx =
    Mitie.mitie_get_named_entity_tagstr ner (uloi idx)

let load_entire_file = Mitie.mitie_load_entire_file

let tokenize = Mitie.mitie_tokenize

let extract_entities = Mitie.mitie_extract_entities

let ner_get_num_detections ner = ulti (Mitie.mitie_ner_get_num_detections ner)

let ner_get_detection_position dets idx =
    let res = Mitie.mitie_ner_get_detection_position dets (uloi idx) in
    ulti res

let ner_get_detection_length dets idx =
    ulti (Mitie.mitie_ner_get_detection_length dets (uloi idx))

let ner_get_detection_tag dets idx =
    ulti (Mitie.mitie_ner_get_detection_tag dets (uloi idx))

let ner_get_detection_tagstr dets idx =
    Mitie.mitie_ner_get_detection_tagstr dets (uloi idx)

let extract ner str =
    let tokens = tokenize str in
    let dets = extract_entities ner tokens in
    let num_dets = ner_get_num_detections dets in

    let nes = ref [] in
    for i = 0 to (num_dets - 1) do
        let pos = ner_get_detection_position dets i in
        let len = ner_get_detection_length dets i in

        let nechunks = ref [] in
        for j = pos to (pos + len - 1) do
            nechunks := (!@(tokens +@ j)) :: !nechunks
        done;

        let ne = String.concat " " (List.rev !nechunks) in
        let tag = ner_get_detection_tagstr dets i in
        nes := (tag, ne) :: !nes;
    done;

    free (Ctypes.to_voidp tokens);
    free dets;
    List.rev !nes

