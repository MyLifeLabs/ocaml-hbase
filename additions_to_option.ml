let bind (oa : 'a option) (f : 'a -> 'b option) : 'b option =
  match oa with
    | Some a -> f a
    | None -> None

let safe_assoc (x : 'a) (xs : ('a * 'b) list) : 'b option =
  try Some (List.assoc x xs)
  with Not_found -> None

let option_of_list : 'a list -> 'a option = function
  | (x :: xs) -> Some x
  | _         -> None
