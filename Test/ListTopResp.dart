import 'dart:convert' show json;

class ListTopResp {
  List<Resp> list;

  ListTopResp.fromParams({this.list});

  factory ListTopResp(jsonStr) => jsonStr == null
      ? null
      : jsonStr is String
          ? ListTopResp.fromJson(json.decode(jsonStr))
          : ListTopResp.fromJson(jsonStr);

  ListTopResp.fromJson(jsonRes) {
    list = jsonRes == null ? null : [];

    for (var listItem in list == null ? [] : jsonRes) {
      list.add(listItem == null ? null : Resp.fromJson(listItem));
    }
  }

  @override
  String toString() {
    return '{"json_list": $list}';
  }
}

class Resp {
  String a;
  String b;

  Resp.fromParams({this.a, this.b});

  Resp.fromJson(jsonRes) {
    a = jsonRes['a'];
    b = jsonRes['b'];
  }

  @override
  String toString() {
    return '{"a": ${a != null ? '${json.encode(a)}' : 'null'}, "b": ${b != null ? '${json.encode(b)}' : 'null'}}';
  }
}
