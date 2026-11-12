type symbol = Terminal of string | Nonterminal of string

(* The ten productions below define the grammar. *)
let grammar : (string * symbol list array) list =
  [
    ("SENTENCE", [| [Nonterminal "NOUN-PHRASE"; Nonterminal "VERB-PHRASE"] |]);
    ("NOUN-PHRASE",
     [| [Nonterminal "CMPLX-NOUN"];
        [Nonterminal "CMPLX-NOUN"; Nonterminal "PREP-PHRASE"] |]);
    ("VERB-PHRASE",
     [| [Nonterminal "CMPLX-VERB"];
        [Nonterminal "CMPLX-VERB"; Nonterminal "PREP-PHRASE"] |]);
    ("PREP-PHRASE", [| [Nonterminal "PREP"; Nonterminal "CMPLX-NOUN"] |]);
    ("CMPLX-NOUN", [| [Nonterminal "ARTICLE"; Nonterminal "NOUN"] |]);
    ("CMPLX-VERB",
     [| [Nonterminal "VERB"];
        [Nonterminal "VERB"; Nonterminal "NOUN-PHRASE"] |]);
    ("ARTICLE", [| [Terminal "a"]; [Terminal "the"] |]);
    ("NOUN",
     [| [Terminal "boy"]; [Terminal "girl"];
        [Terminal "flower"]; [Terminal "bird"] |]);
    ("VERB", [| [Terminal "touches"]; [Terminal "likes"]; [Terminal "sees"] |]);
    ("PREP", [| [Terminal "with"] |]);
  ]

(* Expand a symbol into terminal words by selecting each rule's alternatives
   with equal probability. A rule with one alternative always uses that
   alternative. *)
let rec expand rng = function
  | Terminal word -> [word]
  | Nonterminal name ->
      let alternatives = List.assoc name grammar in
      let index = Random.State.int rng (Array.length alternatives) in
      expand_sequence rng alternatives.(index)

(* let bindings ensure that random choices occur from left to right.
   This is necessary due to OCaml not specifying the order
   in which function arguments are evaluated. *)
and expand_sequence rng = function
  | [] -> []
  | first :: rest ->
      let first_words = expand rng first in
      let rest_words = expand_sequence rng rest in
      first_words @ rest_words

let generate_sentence rng =
  String.concat " " (expand rng (Nonterminal "SENTENCE"))

let () =
  (* Normally, the random state is initialized using the operating system.
     The optional --seed argument makes a run repeatable when using the
     same OCaml random-number implementation and version. *)
  let seed = ref None in
  let options =
    [ ("--seed", Arg.Int (fun value -> seed := Some value),
       "INTEGER  reproduce a run using an integer seed") ]
  in
  let reject_argument value =
    raise (Arg.Bad ("Unexpected argument: " ^ value))
  in
  Arg.parse options reject_argument
    "Usage: sentence_generator [--seed INTEGER]";
  let rng =
    match !seed with
    | None -> Random.State.make_self_init ()
    | Some value -> Random.State.make [| value |]
  in
  (* Print exactly five sentences using lowercase words without punctuation
     to match the grammar's terminal vocabulary. Repeated sentences are
     allowed because the assignment does not require unique results. *)
  for _number = 1 to 5 do
    print_endline (generate_sentence rng)
  done
