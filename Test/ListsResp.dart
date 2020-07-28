import 'dart:convert' show json;

class ListsResp {
  List<List<List<int>>> asd;
  List<int> qaz;
  List<List<List<Zxc>>> qwe;

  ListsResp.fromParams({this.asd, this.qaz, this.qwe});

  factory ListsResp(jsonStr) => jsonStr == null
      ? null
      : jsonStr is String
          ? ListsResp.fromJson(json.decode(jsonStr))
          : ListsResp.fromJson(jsonStr);

  ListsResp.fromJson(jsonRes) {
    asd = jsonRes['asd'] == null ? null : [];

    for (var asdItem in asd == null ? [] : jsonRes['asd']) {
      List<List<int>> asdChild = asdItem == null ? null : [];
      for (var asdItemItem in asdChild == null ? [] : asdItem) {
        List<int> asdChildChild = asdItemItem == null ? null : [];
        for (var asdItemItemItem in asdChildChild == null ? [] : asdItemItem) {
          asdChildChild.add(asdItemItemItem);
        }
        asdChild.add(asdChildChild);
      }
      asd.add(asdChild);
    }

    qaz = jsonRes['qaz'] == null ? null : [];

    for (var qazItem in qaz == null ? [] : jsonRes['qaz']) {
      qaz.add(qazItem);
    }

    qwe = jsonRes['qwe'] == null ? null : [];

    for (var qweItem in qwe == null ? [] : jsonRes['qwe']) {
      List<List<Zxc>> qweChild = qweItem == null ? null : [];
      for (var qweItemItem in qweChild == null ? [] : qweItem) {
        List<Zxc> qweChildChild = qweItemItem == null ? null : [];
        for (var qweItemItemItem in qweChildChild == null ? [] : qweItemItem) {
          qweChildChild.add(
              qweItemItemItem == null ? null : Zxc.fromJson(qweItemItemItem));
        }
        qweChild.add(qweChildChild);
      }
      qwe.add(qweChild);
    }
  }

  @override
  String toString() {
    return '{"asd": $asd, "qaz": $qaz, "qwe": $qwe}';
  }
}

class Zxc {
  int zxc;

  Zxc.fromParams({this.zxc});

  Zxc.fromJson(jsonRes) {
    zxc = jsonRes['zxc'];
  }

  @override
  String toString() {
    return '{"zxc": $zxc}';
  }
}
