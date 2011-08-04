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

let rev_cat_somes (oas : 'a option list) : 'a list =
  List.fold_left
   (fun acc x ->
     match x with
      | None -> acc
      | Some x' -> x' :: acc) [] oas

let cat_somes (xs : 'a option list) : 'a list =
  List.rev (rev_cat_somes xs)
