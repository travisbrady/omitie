open OUnit2

let test_load _ =
    let ner = Omitie.load_named_entity_extractor "sample_text.txt" in
    assert_bool "test_load" true

let suite = "Test OMitie" >:::
    ["test_load" >:: test_load]

let _ = run_test_tt_main suite

