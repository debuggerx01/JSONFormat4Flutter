import 'dart:convert' show json;


class EmptyResp {

  Qwe qwe;


  EmptyResp.fromParams({this.qwe});

  factory EmptyResp(jsonStr) => jsonStr is String ? EmptyResp.fromJson(json.decode(jsonStr)) : EmptyResp.fromJson(jsonStr);

  EmptyResp.fromJson(jsonRes) {
    qwe = new Qwe.fromJson(jsonRes['qwe']);

  }

  @override
  String toString() {
    return '{"qwe": $qwe}';
  }
}



class Qwe {

  List<dynamic> asd;
  List<Object> qaz;
  List<dynamic> zxc;


  Qwe.fromParams({this.asd, this.qaz, this.zxc});

  Qwe.fromJson(jsonRes) {
    asd = jsonRes['asd'];
    qaz = jsonRes['qaz'];
    zxc = jsonRes['zxc'];

  }

  @override
  String toString() {
    return '{"asd": $asd,"qaz": $qaz,"zxc": $zxc}';
  }
}

