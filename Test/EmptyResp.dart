import 'dart:convert' show json;

class EmptyResp {
  Qwe? qwe;

  EmptyResp.fromParams({this.qwe});

  factory EmptyResp(Object jsonStr) => jsonStr is String
      ? EmptyResp.fromJson(json.decode(jsonStr))
      : EmptyResp.fromJson(jsonStr);

  static EmptyResp? parse(jsonStr) =>
      ['null', '', null].contains(jsonStr) ? null : EmptyResp(jsonStr);

  EmptyResp.fromJson(jsonRes) {
    qwe = jsonRes['qwe'] == null ? null : Qwe.fromJson(jsonRes['qwe']);
  }

  @override
  String toString() {
    return '{"qwe": $qwe}';
  }

  String toJson() => this.toString();
}

class Qwe {
  List<dynamic?>? asd;
  List<Object?>? qaz;
  List<dynamic?>? zxc;

  Qwe.fromParams({this.asd, this.qaz, this.zxc});

  Qwe.fromJson(jsonRes) {
    asd = jsonRes['asd'] == null ? null : [];

    for (var asdItem in asd == null ? [] : jsonRes['asd']) {
      asd!.add(asdItem);
    }

    qaz = jsonRes['qaz'] == null ? null : [];

    for (var qazItem in qaz == null ? [] : jsonRes['qaz']) {
      qaz!.add(qazItem);
    }

    zxc = jsonRes['zxc'] == null ? null : [];

    for (var zxcItem in zxc == null ? [] : jsonRes['zxc']) {
      zxc!.add(zxcItem);
    }
  }

  @override
  String toString() {
    return '{"asd": $asd, "qaz": $qaz, "zxc": $zxc}';
  }

  String toJson() => this.toString();
}
