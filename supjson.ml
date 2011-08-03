module Y = Yojson

let from_string : Y.Basic.json -> string option = function
  | `String s -> Some s
  | _         -> None

let from_int : Y.Basic.json -> int option = function
  | `Int s -> Some s
  | _      -> None

let from_list : Y.Basic.json -> Y.Basic.json list option = function
  | `List xs -> Some xs
  | _        -> None

let from_assoc : Y.Basic.json -> (string * Y.Basic.json) list option = function
  | `Assoc xys -> Some xys
  | _          -> None
