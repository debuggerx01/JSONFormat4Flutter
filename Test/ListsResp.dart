import 'dart:convert' show json;

class ListsResp {

  List<List<List<int>>> asd;
  List<int> qaz;
  List<List<List<Zxc>>> qwe;

  ListsResp.fromParams({this.asd, this.qaz, this.qwe});

  factory ListsResp(jsonStr) => jsonStr is String ? ListsResp.fromJson(json.decode(jsonStr)) : ListsResp.fromJson(jsonStr);

  ListsResp.fromJson(jsonRes) {
    asd = [];

    for (var asdItem in jsonRes['asd']){
  List<List<int>> asdChild = [];
    for (var asdItemItem in asdItem){
  List<int> asdChildChild = [];
    for (var asdItemItemItem in asdItemItem){
            asdChildChild.add(asdItemItemItem);
    }
      asdChild.add(asdChildChild);
    }
      asd.add(asdChild);
    }

    qaz = jsonRes['qaz'].cast<int>();

    qwe = [];

    for (var qweItem in jsonRes['qwe']){
  List<List<Zxc>> qweChild = [];
    for (var qweItemItem in qweItem){
  List<Zxc> qweChildChild = [];
    for (var qweItemItemItem in qweItemItem){
            qweChildChild.add(new Zxc.fromJson(qweItemItemItem));
    }
      qweChild.add(qweChildChild);
    }
      qwe.add(qweChild);
    }
  }

  @override
  String toString() {
    return '{"asd": $asd,"qaz": $qaz,"qwe": $qwe}';
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

