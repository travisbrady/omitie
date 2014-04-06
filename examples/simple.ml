open Printf

(* Stolen from Core *)
let input_all t =
  (* We use 65536 because that is the size of OCaml's IO buffers. *)
  let buf_size = 65536 in
  let buf = String.create buf_size in
  let buffer = Buffer.create buf_size in
  let rec loop () =
    let len = input t buf 0 (String.length buf) in
    if len > 0 then begin
      Buffer.add_substring buffer buf 0 len;
      loop ();
    end
  in
  loop ();
  Buffer.contents buffer;
;;

let () =
    let ner = Omitie.load_named_entity_extractor (Sys.argv.(1)) in

    let num_tags = Omitie.get_num_possible_ner_tags ner in
    printf "The tagger supports %d tags:\n" num_tags;
    for i = 0 to (num_tags - 1) do
        printf "    %s\n" (Omitie.get_named_entity_tagstr ner i)
    done;

    let fn = Sys.argv.(2) in
    let text_data = input_all (open_in fn) in

    let nes = Omitie.extract ner text_data in
    List.iter (fun (tag, ne) -> printf "   Tag: %s %s\n" tag ne) nes;

    Omitie.close_model ner;

    ()
