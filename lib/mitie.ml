open Ctypes
open Foreign

type mitie_named_entity_extractor
type mitie_named_entity_detections

let mitie_free = foreign "mitie_free" (ptr void @-> returning (ptr void))
let mitie_load_entire_file = foreign "mitie_load_entire_file" (string @-> returning string)
let mitie_tokenize = foreign "mitie_tokenize" (string @-> returning (ptr string))
let mitie_load_named_entity_extractor = foreign "mitie_load_named_entity_extractor" (string @-> returning (ptr void))
let mitie_get_num_possible_ner_tags = foreign "mitie_get_num_possible_ner_tags" (ptr void @-> returning ulong)
let mitie_get_named_entity_tagstr = foreign "mitie_get_named_entity_tagstr" (ptr void @-> ulong @-> returning string)
let mitie_extract_entities = foreign "mitie_extract_entities" (ptr void @-> ptr string @-> returning (ptr void))
let mitie_ner_get_num_detections = foreign "mitie_ner_get_num_detections" (ptr void @-> returning ulong)
let mitie_ner_get_detection_position = foreign "mitie_ner_get_detection_position" (ptr void @-> ulong @-> returning ulong)
let mitie_ner_get_detection_length = foreign "mitie_ner_get_detection_length" (ptr void @-> ulong @-> returning ulong)
let mitie_ner_get_detection_tag = foreign "mitie_ner_get_detection_tag" (ptr void @-> ulong @-> returning ulong)

let mitie_ner_get_detection_tagstr = foreign "mitie_ner_get_detection_tagstr" (ptr void @-> ulong @-> returning string)

let get_num_possible_ner_tags ner = Unsigned.ULong.to_int (mitie_get_num_possible_ner_tags ner)

