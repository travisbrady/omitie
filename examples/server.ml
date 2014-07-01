open Core.Std
open Async.Std
open Cow
open Opium.Std

module NamedEntity = struct
    open Caml
    type t = {
        tag:    string;
        entity: string
    } with json
end

module ExtractResult = struct
    open Caml
    type t = {
        results: NamedEntity.t list
    } with json
end

let ner = Omitie.load_named_entity_extractor "ner_model.dat"
let empty_response = ExtractResult.json_of_t {ExtractResult.results = []}

let extract = get "/extract" begin fun req ->
    match Uri.get_query_param (Request.uri req) "text" with
    | Some (text) ->
        let nes = Omitie.extract ner text 
            |> List.map ~f:(fun (tag, entity) -> {NamedEntity.tag = tag; NamedEntity.entity= entity})
        in
        let ret = {ExtractResult.results = nes} in
        `Json (ExtractResult.json_of_t ret) |> respond'
    | None ->
        `Json empty_response |> respond'
end

let _ =
    App.empty
    |> extract
    |> App.command
    |> Command.run

