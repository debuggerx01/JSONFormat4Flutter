import 'dart:convert' show json;

class ListWithStringResp {
  List<String?>? asd;
  List<List<String?>?>? qaz;
  List<Qwe?>? zxc;

  ListWithStringResp.fromParams({this.asd, this.qaz, this.zxc});

  factory ListWithStringResp(Object jsonStr) => jsonStr is String
      ? ListWithStringResp.fromJson(json.decode(jsonStr))
      : ListWithStringResp.fromJson(jsonStr);

  static ListWithStringResp? parse(jsonStr) =>
      ['null', '', null].contains(jsonStr) ? null : ListWithStringResp(jsonStr);

  ListWithStringResp.fromJson(jsonRes) {
    asd = jsonRes['asd'] == null ? null : [];

    for (var asdItem in asd == null ? [] : jsonRes['asd']) {
      asd!.add(asdItem);
    }

    qaz = jsonRes['qaz'] == null ? null : [];

    for (var qazItem in qaz == null ? [] : jsonRes['qaz']) {
      List<String?>? qazChild = qazItem == null ? null : [];
      for (var qazItemItem in qazChild == null ? [] : qazItem) {
        qazChild!.add(qazItemItem);
      }
      qaz!.add(qazChild);
    }

    zxc = jsonRes['zxc'] == null ? null : [];

    for (var zxcItem in zxc == null ? [] : jsonRes['zxc']) {
      zxc!.add(zxcItem == null ? null : Qwe.fromJson(zxcItem));
    }
  }

  @override
  String toString() {
    return '{"asd": ${asd != null ? '${json.encode(asd)}' : 'null'}, "qaz": ${qaz != null ? '${json.encode(qaz)}' : 'null'}, "zxc": $zxc}';
  }

  String toJSON() => this.toString();
}

class Qwe {
  String? qwe;

  Qwe.fromParams({this.qwe});

  Qwe.fromJson(jsonRes) {
    qwe = jsonRes['qwe'];
  }

  @override
  String toString() {
    return '{"qwe": ${qwe != null ? '${json.encode(qwe)}' : 'null'}}';
  }

  String toJSON() => this.toString();
}
