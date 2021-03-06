open Tyxml
open Omd

let content_placeholder = "__CONTENT_PLACEHOLDER__"
let title_prefix = "title: "
let cnums = [|"〇";"一";"二";"三";"四";"五";"六";"七";"八";"九"|]
let intro = "我是陈贤安，喜欢钻研构建程序介面的技术，偏好静态类型函数式编程。常用编程语言有 Swift、Objective-C、JavaScript 和 OCaml。能看懂 C，想学会 Haskell 和 Erlang。逼急了也能撸起袖子码码其他的语言。realazy, 意取“真懒”，因为我相信，懒，对程序员来说，是一种美德。"

type ('a, 'b) result = Ok of 'a | Error of 'b

let has_prefix prefix str =
  let plen = String.length prefix in
  String.length str >= plen
  && compare (String.sub str 0 plen) prefix == 0

let substring_from pos str =
  let len = String.length str in
  String.sub str pos (len-pos)

let to_cnum anum =
  let idx = (int_of_char anum) - (int_of_char '0') in
  Array.get cnums idx

let to_chinese_year year_str =
  let clist = ref [] in
  String.iter (fun c -> clist := !clist @ [to_cnum c]) year_str;
  String.concat "" !clist

let to_chinese_md md_str =
  let atens = String.get md_str 0 in
  let ctens = match atens with
    | '0' -> ""
    | '1' -> "十"
    | _ as i -> (to_cnum i) ^ "十"
  in
  let aones = String.get md_str 1 in
  let cones = match aones with
    | '0' -> ""
    | _ as i -> to_cnum i
  in
  ctens ^ cones

let to_chinese_date date_str =
  let comps = Str.split (Str.regexp "\\-") date_str in
  let mapi i c = match i with
    | 0 -> to_chinese_year c ^ "年"
    | 1 -> to_chinese_md   c ^ "月"
    | 2 -> to_chinese_md   c ^ "日"
    | _ -> ""
  in
  let strs = List.mapi mapi comps in
  String.concat "" strs

let site_template title body_id footer_extra =
  let open Unix in
  let time = Unix.time () |> Unix.localtime in
  let year = (time.tm_year + 1900) |> string_of_int |> Html.pcdata in
  [%html {|
  <html class='no-webfont'>
    <head>
      <title>|} (Html.pcdata title) {|</title>
      <meta charset='utf-8' />
      <meta name='viewport' content='width=device-width, initial-scale=1' />
      <link rel='alternate' type='application/atom+xml' title='Realazy' href='http://feeds.feedburner.com/realazy' />
      <link rel='stylesheet' href='/assets/style.css' />
      <script src='/assets/highlight.js'> </script>
    </head>
    <body id='|}body_id{|'>
      |} [ Html.pcdata content_placeholder ] {|
      <footer>
      |}
      footer_extra

      {|<p>2005 ～ |} [ year ] {| &copy;
                                  <span><a href='/'>realazy</a></span>
                                  <span><a href='https://twitter.com/_cxa'>Twitter</a></span>
                                  <span><a href='https://github.com/cxa'>GitHub</a></span>
                                  <span><a href="https://github.com/cxa/cxa.github.com.git">本站源码</a></span>
       </p>
       </footer>
       <script>
        WebFontConfig = {
          custom: {
            families: ['EB Garamond:n4,n7', 'Noto Serif CJK SC:n4,n8'],
            urls: ['/assets/fonts.css']
          },
          timeout: 60000
        };

        (function (d) {
          [].forEach.call(d.querySelectorAll('pre code'), function(b){ hljs.highlightBlock(b) });
          var a = navigator.userAgent||navigator.vendor||window.opera,
              isMobile = /(android|bb\d+|meego).+mobile|avantgo|bada\/|blackberry|blazer|compal|elaine|fennec|hiptop|iemobile|ip(hone|ad|od)|iris|kindle|lge |maemo|midp|mmp|mobile.+firefox|netfront|opera m(ob|in)i|palm( os)?|phone|p(ixi|re)\/|plucker|pocket|psp|series(4|6)0|symbian|treo|up\.(browser|link)|vodafone|wap|windows ce|xda|xiino/i.test(a)||/1207|6310|6590|3gso|4thp|50[1-6]i|770s|802s|a wa|abac|ac(er|oo|s\-)|ai(ko|rn)|al(av|ca|co)|amoi|an(ex|ny|yw)|aptu|ar(ch|go)|as(te|us)|attw|au(di|\-m|r |s )|avan|be(ck|ll|nq)|bi(lb|rd)|bl(ac|az)|br(e|v)w|bumb|bw\-(n|u)|c55\/|capi|ccwa|cdm\-|cell|chtm|cldc|cmd\-|co(mp|nd)|craw|da(it|ll|ng)|dbte|dc\-s|devi|dica|dmob|do(c|p)o|ds(12|\-d)|el(49|ai)|em(l2|ul)|er(ic|k0)|esl8|ez([4-7]0|os|wa|ze)|fetc|fly(\-|_)|g1 u|g560|gene|gf\-5|g\-mo|go(\.w|od)|gr(ad|un)|haie|hcit|hd\-(m|p|t)|hei\-|hi(pt|ta)|hp( i|ip)|hs\-c|ht(c(\-| |_|a|g|p|s|t)|tp)|hu(aw|tc)|i\-(20|go|ma)|i230|iac( |\-|\/)|ibro|idea|ig01|ikom|im1k|inno|ipaq|iris|ja(t|v)a|jbro|jemu|jigs|kddi|keji|kgt( |\/)|klon|kpt |kwc\-|kyo(c|k)|le(no|xi)|lg( g|\/(k|l|u)|50|54|\-[a-w])|libw|lynx|m1\-w|m3ga|m50\/|ma(te|ui|xo)|mc(01|21|ca)|m\-cr|me(rc|ri)|mi(o8|oa|ts)|mmef|mo(01|02|bi|de|do|t(\-| |o|v)|zz)|mt(50|p1|v )|mwbp|mywa|n10[0-2]|n20[2-3]|n30(0|2)|n50(0|2|5)|n7(0(0|1)|10)|ne((c|m)\-|on|tf|wf|wg|wt)|nok(6|i)|nzph|o2im|op(ti|wv)|oran|owg1|p800|pan(a|d|t)|pdxg|pg(13|\-([1-8]|c))|phil|pire|pl(ay|uc)|pn\-2|po(ck|rt|se)|prox|psio|pt\-g|qa\-a|qc(07|12|21|32|60|\-[2-7]|i\-)|qtek|r380|r600|raks|rim9|ro(ve|zo)|s55\/|sa(ge|ma|mm|ms|ny|va)|sc(01|h\-|oo|p\-)|sdk\/|se(c(\-|0|1)|47|mc|nd|ri)|sgh\-|shar|sie(\-|m)|sk\-0|sl(45|id)|sm(al|ar|b3|it|t5)|so(ft|ny)|sp(01|h\-|v\-|v )|sy(01|mb)|t2(18|50)|t6(00|10|18)|ta(gt|lk)|tcl\-|tdg\-|tel(i|m)|tim\-|t\-mo|to(pl|sh)|ts(70|m\-|m3|m5)|tx\-9|up(\.b|g1|si)|utst|v400|v750|veri|vi(rg|te)|vk(40|5[0-3]|\-v)|vm40|voda|vulc|vx(52|53|60|61|70|80|81|83|85|98)|w3c(\-| )|webc|whit|wi(g |nc|nw)|wmlb|wonu|x700|yas\-|your|zeto|zte\-/i.test(a.substr(0,4));
          if (isMobile) return;
          d.documentElement.className = d.documentElement.className.replace(/no\-webfont/, '');
          var wf = d.createElement('script'),
              s = d.scripts[0];
          wf.src = '/assets/webfontloader.js';
          wf.async = true;
          s.parentNode.insertBefore(wf, s);
        })(document);
      </script>
    </body>
  </html>
  |}]

let mkpage title body_id body_content ft_extra oc =
  site_template title body_id ft_extra
  |> Format.asprintf "%a" (Html.pp ())
  |> Str.replace_first (Str.regexp_string content_placeholder) body_content
  |> Markup.string
  |> Markup.to_channel oc


module Post = struct
  type t =
    { title  : string;
      date   : string;
      content: string;
    }

  let of_file filepath =
    let ic = open_in filepath in
    let filename = Filename.basename filepath in
    let date = String.sub filename 0 (4+1+2+1+2) in (* yyyy-mm-dd *)
    let quit_loop = ref false in
    (* TODO: make it lazy *)
    let post = ref (Error (Format.sprintf "Could not convert %s to post" filepath)) in
    try
      while not !quit_loop do
        let line = input_line ic in
        if has_prefix title_prefix line then begin
            quit_loop := true;
            input_line ic |> ignore; (* skip next line *)
            let title = substring_from (String.length title_prefix) line in
            let len = in_channel_length ic - pos_in ic in
            let rawcontent = really_input_string ic len in
            let content = Omd.of_string rawcontent |> Omd.to_html in
            close_in ic;
            post := Ok { title; date; content; }
          end
      done;
      !post
    with
    | End_of_file -> close_in ic; !post
    | _ -> close_in_noerr ic; !post

  let to_html post =
    let cdt = [ Html.pcdata @@ to_chinese_date post.date ] in
    let subtitle = [
        [%html "<a href='/'>真・懒</a>"];
        [%html "写于"];
        [%html "<time datetime="post.date">"cdt"</time>"]]
    in
    let to_tyxml = [%html {|
      <header>
        <h1>|} [(Html.pcdata post.title)] {|</h1>
        <p>
          |} subtitle {|
        </p>
      </header>
      <main>
        |} [(Html.pcdata content_placeholder)] {|
      </main>
    |}]
    in
    let elt_to_html elt =
      elt
      |> Format.asprintf "%a" (Html.pp_elt ())
      |> Str.replace_first (Str.regexp_string content_placeholder) post.content
    in
    to_tyxml
    |> List.map elt_to_html
    |> String.concat ""

  let to_page post ft_extra oc =
    mkpage ("realazy: " ^ post.title) "post" (to_html post) ft_extra oc

end


open Post

let raw_posts_from dir =
  let filter acc item =
    if Filename.check_suffix item ".md"
    then Array.append acc [|item|]
    else acc
  in
  let posts = Sys.readdir dir |> Array.fold_left filter [||] in
  Array.sort (fun a b -> -(String.compare a b)) posts;
  posts

let mkposts from_dir to_dir =
  let rawposts = raw_posts_from from_dir in
  let mkpost_write_file rp =
    let post_result = Post.of_file @@ Filename.concat from_dir rp in
    match post_result with
    | Ok post ->
       let file = (Filename.basename rp |> Filename.chop_extension) ^ ".html" in
       let out_filepath = Filename.concat to_dir file in
       let oc = open_out out_filepath in
       let%html extra = "<div class='intro'><img src='/assets/avatar.jpg' width='128' alt='头像' /><p>" [(Html.pcdata intro)] "</p></div>" in
       Post.to_page post [extra] oc;
       close_out oc
    | Error e -> print_endline e
  in
  Array.iter mkpost_write_file rawposts

let mkhome raw_posts_dir =
  let mkpost_items acc rp =
    let post_result = Post.of_file @@ Filename.concat raw_posts_dir rp in
    match post_result with
    | Ok post ->
       let file = (Filename.basename rp |> Filename.chop_extension) ^ ".html" in
       let item = Printf.sprintf "<li><a href='/posts/%s'><span>%s</span> <span>%s</span></a></li>" file post.title post.date in
       acc ^ item
    | Error _ -> acc
  in
  let rawposts = raw_posts_from raw_posts_dir in
  let items =
    "<header>
       <h1>真・懒</h1>
       <p>欢迎光临。" ^ intro ^ "</p>
     </header>
     <main>
       <ul>"
         ^ (Array.fold_left mkpost_items "" rawposts) ^ "
       </ul>
     </main>"
  in
  let oc = open_out "../index.html" in
  mkpage "realazy" "toc" items [] oc;
  close_out oc

let mk404 () =
  let oc = open_out "../404.html" in
  mkpage "realazy: 404" "four04" "
  <header>
    <h1>真・找不到</h1>
  </header>
  <main>
    <p>您进入了无人之境，a.k.a 404.</p>
  </main>
  " [] oc;
  close_out oc

let mkatom from_dir =
  let open Syndic_atom in
  let aut =
    { name = "Realazy"
    ; uri = Some (Uri.of_string "http://realazy.com")
    ; email = None
    }
  in
  let fold_post acc rp =
    let post_result = Post.of_file @@ Filename.concat from_dir rp in
    match post_result with
    | Ok post ->
      (* Syndic doesn't provide tz option, will repalce -00:00 to +08:00 later *)
      let entry_dt =
        post.date ^ "T10:00:00-00:00"
        |> Syndic_date.of_rfc3339
      in
      let content:content = Html (None, post.content)  in
      let link =
        let uri =
          let path = (Filename.basename rp |> Filename.chop_extension) ^ ".html" in
          Printf.sprintf "http://realazy.com/posts/%s" path
          |> Uri.of_string
        in
        link uri
      in
      let e =
        entry
          ~links: [link]
          ~content
          ~id:(Digest.string rp |> Uri.of_string)
          ~authors:(aut, [])
          ~title:(Text post.title)
          ~updated:entry_dt
          ()
      in
      e :: acc
    | Error e ->
      print_endline e;
      acc
  in
  let f =
    let entries =
      let rawposts = raw_posts_from from_dir in
      rawposts |> Array.to_list |> List.fold_left fold_post [] |> List.rev
    in
    let updated =
      let latest = List.nth entries 0 in
      latest.updated
    in
    feed
      ~authors:[aut]
      ~icon:(Uri.of_string "http://realazy.com/favicon.ico")
      ~id:(Uri.of_string "realazy.com:posts")
      ~title:(Text "Realazy")
      ~updated
      entries
  in
  let out_file = "../feed.atom" in
  write f out_file;
  let ic = open_in out_file in
  let replace_tz inp =
    Str.global_replace (Str.regexp_string "-00:00") "+08:00" inp
  in
  let lines = ref [] in
  begin
    try
      while true do
        lines := (input_line ic) :: !lines;
      done
    with
      End_of_file -> close_in ic
  end;
  let str = String.concat "" (List.rev !lines) |> replace_tz in
  let oc = open_out out_file in
  output_string oc str;
  close_out oc

let () =
  let raw_posts_dir =  "../_raw/posts" in
  mkposts raw_posts_dir "../posts";
  mkhome raw_posts_dir;
  mk404 ();
  mkatom raw_posts_dir
