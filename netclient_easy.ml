module HHard = Http_client

(* The Http_client api violates 2.1 - 2.4 of "The Little Manual of API Design"
 * (http://www.datakom.com.tr/files/data_sheets/api-design.pdf)
 * TODO fix this *)
(* TODO client side caching *)
let http_get_with_header (uri : string) (header : (string * string) list) : string option =
  let pipeline = new HHard.pipeline in
  let http_call = new HHard.get uri in
  let http_header = http_call # request_header `Base in
  List.iter (fun (key, value) -> http_header # update_field key value) header;
  pipeline # add http_call;
  pipeline # run ();
  match http_call # status with
    | `Successful -> Some (http_call # response_body # value)
    | _ -> None
