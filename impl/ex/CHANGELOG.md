# CHANGELOG

### v0.9.2
  * Documentation
    * Adds additional information to README
    * Adds documentation to functions in Predicator
  * Enhancements
    * Adds `compile!`, `evaluate`, `evaluate!`, `evaluate_instructions`, `evaluate_instructions!` functions to Predicator
    * Adds `Ecto.PredicatorInstructions` Ecto type

### v0.9.1
  * Documentation
    * Moves project from [predicator/predicator_elixir](https://github.com/predicator/predicator_elixir) to [riddler/predicator](https://github.com/riddler/predicator/tree/master/impl/ex)

## v0.9.0
  * BREAKING CHANGE
    * Evaluates `compare` instead of `comparator` to be compatible with ruby predicator lib.

### v0.8.1
* Enhancements
  * Adds leex and parsing for `and` and `or`.
  * Adds leex and parsing for `!` and boolean.

## v0.8.0
  * New
    * `Predicator.matches?/3` accepts evaluator options.
  * Enhancements
    * Adds leex and parsing for `isblank` and `ispresent`.
    * Supports escaped double quote strings.
  * Fix
    * `in` and `notin` accept list of strings.

### v0.7.3
  * Enhancements
    * Adds leex and parsing for `in`, `notin`, `between`, `startswith`, `endswith` instructions

### v0.7.1
  * New
    * Adds `between` instruction for eval on dates

## v0.7.0
  * New
    * Adds 2 new comparison predicates for `starts_with` & `ends_with`

## v0.6.0
  * Updates & New
    * Adds 3 new evaluatable predicates for `to_date`, `date_ago`, and `date_from_now`

## v0.5.0
  * Updates
    * Evaluator now reads new coercion instructions `to_int`, `to_str`, & `to_bool`

## v0.4.0
  * New
    * Adds 4 new functions to the `Predicator` module `eval/3`, `leex_string/1`, `parsed_lexed/1`, & `leex_and_parse/1`

## v0.3.0
  * Enhancements
    * Adds options to `Predicator.Evaluator.execute/3` as a keyword list to define if the context map is a string keyed list `[map_type: :string]` or atom keyed for the default `[map_type: :atom]`
