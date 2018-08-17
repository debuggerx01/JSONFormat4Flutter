import 'dart:convert' show json;

class EmptyResp {

  Qwe qwe;

  EmptyResp.fromParams({this.qwe});

  factory EmptyResp(jsonStr) => jsonStr == null ? null : jsonStr is String ? new EmptyResp.fromJson(json.decode(jsonStr)) : new EmptyResp.fromJson(jsonStr);

  EmptyResp.fromJson(jsonRes) {
    qwe = jsonRes['qwe'] == null ? null : new Qwe.fromJson(jsonRes['qwe']);
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
    asd = jsonRes['asd'] == null ? null : [];

    for (var asdItem in asd == null ? [] : jsonRes['asd']){
            asd.add(asdItem);
    }

    qaz = jsonRes['qaz'] == null ? null : [];

    for (var qazItem in qaz == null ? [] : jsonRes['qaz']){
            qaz.add(qazItem);
    }

    zxc = jsonRes['zxc'] == null ? null : [];

    for (var zxcItem in zxc == null ? [] : jsonRes['zxc']){
            zxc.add(zxcItem);
    }
  }

  @override
  String toString() {
    return '{"asd": $asd,"qaz": $qaz,"zxc": $zxc}';
  }
}

