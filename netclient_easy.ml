module A2L = BatList
module HHard = Http_client

type header = (string * string) list

type uri = string

let update_header http_header (header : (string * string) list) : unit =
  List.iter (fun (key, value) -> http_header # update_field key value) header

let http_result http_call : string option =
  match http_call # status with
    | `Successful -> Some (http_call # response_body # value)
    | _ -> None


(* The Http_client api violates 2.1 - 2.4 of "The Little Manual of API Design"
 * (http://www.datakom.com.tr/files/data_sheets/api-design.pdf)
 * TODO fix this *)
(* TODO client side caching *)
let http_get_with_header (uri : string) (header : (string * string) list) : string option =
  let pipeline = new HHard.pipeline in
  let http_call = new HHard.get uri in
  let http_header = http_call # request_header `Base in
  update_header http_header header;
  pipeline # add http_call;
  pipeline # run ();
  http_result http_call

let http_gets_with_headers (uris_headers : (uri * header) list) : string option list =
  let pipeline = new HHard.pipeline in
  let http_calls = A2L.map (fun (uri, _) -> new HHard.get uri) uris_headers in
  let http_headers = A2L.map (fun http_call -> http_call # request_header `Base) http_calls in
  A2L.iter2 update_header http_headers (A2L.map snd uris_headers);
  List.iter (fun http_call -> pipeline # add http_call) http_calls;
  pipeline # run ();
  A2L.map (fun http_call -> http_result http_call) http_calls
