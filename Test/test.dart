import 'dart:io';
import 'dart:math' show min;
import 'dart:convert' show json;
import 'package:test/test.dart';
import 'EmptyResp.dart';
import 'RegionResp.dart';
import 'WanResp.dart';
import 'ListsResp.dart';
import 'IgnoreMapResp.dart';

void main() {

  test('Test null', (){
    String str0 = '{"asd":[[[1]]],"qwe":[[[{"zxc":1}]]],"qaz":[1]}';
    String str1 = '{"asd":[[[null,null]]],"qwe":[[[null]]],"qaz":[null,null,null]}';
    String str2 = '{"asd":[[[]]],"qwe":[[[{"zxc":null}]]],"qaz":[null]}';
    String str3 = '{"asd":[[]],"qwe":[[[]]],"qaz":null}';
    String str4 = '{"asd":[],"qwe":[[]],"qaz":null}';
    String str5 = '{"asd":null,"qwe":[],"qaz":null}';
    String str6;
    expect(json.decode(new ListsResp(str0).toString()), json.decode(str0));
    expect(json.decode(new ListsResp(str1).toString()), json.decode(str1));
    expect(json.decode(new ListsResp(str2).toString()), json.decode(str2));
    expect(json.decode(new ListsResp(str3).toString()), json.decode(str3));
    expect(json.decode(new ListsResp(str4).toString()), json.decode(str4));
    expect(json.decode(new ListsResp(str5).toString()), json.decode(str5));
    expect(json.decode(new ListsResp(str6).toString()), null);

  });
  test('Test Region', () {
    String str = readFromFile('Region');
    RegionResp resp = new RegionResp(str);
    var jsonRes = json.decode(str);

    /// 测试传入String和json进行解析的结果是否相同
    expect(resp.toString(), new RegionResp(jsonRes).toString());

    /// 逐个字段检查是否与json.decode()的结果相同
    expect(resp.code, jsonRes['code']);
    expect(resp.message, jsonRes['message']);
    expect(resp.ttl, jsonRes['ttl']);
    expect(resp.data.page.num, jsonRes['data']['page']['num']);
    expect(resp.data.page.size, jsonRes['data']['page']['size']);
    expect(resp.data.page.count, jsonRes['data']['page']['count']);
    for (var index = 0; index < jsonRes['data']['archives'].length; index++) {
      expect(resp.data.archives[index].aid,
          jsonRes['data']['archives'][index]['aid']);
      expect(resp.data.archives[index].attribute,
          jsonRes['data']['archives'][index]['attribute']);
      expect(resp.data.archives[index].copyright,
          jsonRes['data']['archives'][index]['copyright']);
      expect(resp.data.archives[index].ctime,
          jsonRes['data']['archives'][index]['ctime']);
      expect(resp.data.archives[index].desc,
          jsonRes['data']['archives'][index]['desc']);
      expect(resp.data.archives[index].duration,
          jsonRes['data']['archives'][index]['duration']);
      expect(resp.data.archives[index].dynamic,
          jsonRes['data']['archives'][index]['dynamic']);
      expect(resp.data.archives[index].pic,
          jsonRes['data']['archives'][index]['pic']);
      expect(resp.data.archives[index].pubdate,
          jsonRes['data']['archives'][index]['pubdate']);
      expect(resp.data.archives[index].state,
          jsonRes['data']['archives'][index]['state']);
      expect(resp.data.archives[index].tid,
          jsonRes['data']['archives'][index]['tid']);
      expect(resp.data.archives[index].title,
          jsonRes['data']['archives'][index]['title']);
      expect(resp.data.archives[index].tname,
          jsonRes['data']['archives'][index]['tname']);
      expect(resp.data.archives[index].videos,
          jsonRes['data']['archives'][index]['videos']);

      expect(resp.data.archives[index].rights.bp,
          jsonRes['data']['archives'][index]['rights']['bp']);
      expect(resp.data.archives[index].rights.download,
          jsonRes['data']['archives'][index]['rights']['download']);
      expect(resp.data.archives[index].rights.elec,
          jsonRes['data']['archives'][index]['rights']['elec']);
      expect(resp.data.archives[index].rights.hd5,
          jsonRes['data']['archives'][index]['rights']['hd5']);
      expect(resp.data.archives[index].rights.movie,
          jsonRes['data']['archives'][index]['rights']['movie']);
      expect(resp.data.archives[index].rights.no_reprint,
          jsonRes['data']['archives'][index]['rights']['no_reprint']);
      expect(resp.data.archives[index].rights.pay,
          jsonRes['data']['archives'][index]['rights']['pay']);

      expect(resp.data.archives[index].owner.face,
          jsonRes['data']['archives'][index]['owner']['face']);
      expect(resp.data.archives[index].owner.mid,
          jsonRes['data']['archives'][index]['owner']['mid']);
      expect(resp.data.archives[index].owner.name,
          jsonRes['data']['archives'][index]['owner']['name']);

      expect(resp.data.archives[index].stat.aid,
          jsonRes['data']['archives'][index]['stat']['aid']);
      expect(resp.data.archives[index].stat.coin,
          jsonRes['data']['archives'][index]['stat']['coin']);
      expect(resp.data.archives[index].stat.danmaku,
          jsonRes['data']['archives'][index]['stat']['danmaku']);
      expect(resp.data.archives[index].stat.favorite,
          jsonRes['data']['archives'][index]['stat']['favorite']);
      expect(resp.data.archives[index].stat.his_rank,
          jsonRes['data']['archives'][index]['stat']['his_rank']);
      expect(resp.data.archives[index].stat.like,
          jsonRes['data']['archives'][index]['stat']['like']);
      expect(resp.data.archives[index].stat.now_rank,
          jsonRes['data']['archives'][index]['stat']['now_rank']);
      expect(resp.data.archives[index].stat.reply,
          jsonRes['data']['archives'][index]['stat']['reply']);
      expect(resp.data.archives[index].stat.share,
          jsonRes['data']['archives'][index]['stat']['share']);
      expect(resp.data.archives[index].stat.view,
          jsonRes['data']['archives'][index]['stat']['view']);
    }

    /// 检查bean对象toString还原成json字符串后再交给json解析的结果是否与原始字符串相同
    expect(jsonRes, json.decode(resp.toString()));
  });

  test('Test WanAndroid', () {
    String str = readFromFile('Wan');
    WanResp resp = new WanResp(str);
    var jsonRes = json.decode(str);

    /// 测试传入String和json进行解析的结果是否相同
    expect(resp.toString(), new WanResp(jsonRes).toString());

    /// 逐个字段检查是否与json.decode()的结果相同
    expect(resp.errorCode, jsonRes['errorCode']);
    expect(resp.errorMsg, jsonRes['errorMsg']);

    for (var index = 0; index < jsonRes['data'].length; index++) {
      expect(resp.data[index].name, jsonRes['data'][index]['name']);
      expect(resp.data[index].courseId, jsonRes['data'][index]['courseId']);
      expect(resp.data[index].id, jsonRes['data'][index]['id']);
      expect(resp.data[index].order, jsonRes['data'][index]['order']);
      expect(resp.data[index].parentChapterId,
          jsonRes['data'][index]['parentChapterId']);
      expect(resp.data[index].visible, jsonRes['data'][index]['visible']);

      for (var cindex = 0;
          cindex < jsonRes['data'][index]['children'].length;
          cindex++) {
        expect(resp.data[index].children[cindex].children,
            jsonRes['data'][index]['children'][cindex]['children']);
        expect(resp.data[index].children[cindex].visible,
            jsonRes['data'][index]['children'][cindex]['visible']);
        expect(resp.data[index].children[cindex].parentChapterId,
            jsonRes['data'][index]['children'][cindex]['parentChapterId']);
        expect(resp.data[index].children[cindex].order,
            jsonRes['data'][index]['children'][cindex]['order']);
        expect(resp.data[index].children[cindex].courseId,
            jsonRes['data'][index]['children'][cindex]['courseId']);
        expect(resp.data[index].children[cindex].name,
            jsonRes['data'][index]['children'][cindex]['name']);
        expect(resp.data[index].children[cindex].id,
            jsonRes['data'][index]['children'][cindex]['id']);
      }

      /// 检查bean对象toString还原成json字符串后再交给json解析的结果是否与原始字符串相同
      expect(jsonRes, json.decode(resp.toString()));
    }
  });

  test('test many empty', () {

    String str = readFromFile('Empty');
    EmptyResp resp = new EmptyResp(str);
    var jsonRes = json.decode(str);

    /// 测试传入String和json进行解析的结果是否相同
    expect(resp.toString(), new EmptyResp(jsonRes).toString());

    /// 逐个字段检查是否与json.decode()的结果相同
    expect(resp.qwe.asd, jsonRes['qwe']['asd']);
    expect(resp.qwe.zxc, jsonRes['qwe']['zxc']);
    expect(resp.qwe.qaz, jsonRes['qwe']['qaz']);

    /// 检查bean对象toString还原成json字符串后再交给json解析的结果是否与原始字符串相同
    expect(jsonRes, json.decode(resp.toString()));
  });


  test('test fucking lists', () {

    String str = readFromFile('Lists');
    ListsResp resp = new ListsResp(str);
    var jsonRes = json.decode(str);

    /// 测试传入String和json进行解析的结果是否相同
    expect(resp.toString(), new ListsResp(jsonRes).toString());

    /// 逐个字段检查是否与json.decode()的结果相同
    expect(resp.asd[0][0][0], jsonRes['asd'][0][0][0]);
    expect(resp.qwe[0][0][0].zxc, jsonRes['qwe'][0][0][0]['zxc']);
    expect(resp.qaz, jsonRes['qaz']);

    /// 检查bean对象toString还原成json字符串后再交给json解析的结果是否与原始字符串相同
    expect(jsonRes, json.decode(resp.toString()));
});

  test('test ignore map', () {

    String str = readFromFile('IgnoreMap');
    IgnoreMapResp resp = new IgnoreMapResp(str);
    var jsonRes = json.decode(str);

    /// 测试传入String和json进行解析的结果是否相同
    expect(resp.toString(), new IgnoreMapResp(jsonRes).toString());

    /// 逐个字段检查是否与json.decode()的结果相同
    expect(resp.data.wc, jsonRes['data']['wc']);
    expect(resp.data.author, jsonRes['data']['author']);
    expect(resp.data.content, jsonRes['data']['content']);
    expect(resp.data.digest, jsonRes['data']['digest']);
    expect(resp.data.title, jsonRes['data']['title']);
    expect(resp.data.extra.a, jsonRes['data']['extra']['a']);
    expect(resp.data.extra.b, jsonRes['data']['extra']['b']);
    expect(resp.data.extra.c, jsonRes['data']['extra']['c']);
    expect(resp.data.date, jsonRes['data']['date']);

    /// 检查bean对象toString还原成json字符串后再交给json解析的结果是否与原始字符串相同
    expect(jsonRes, json.decode(resp.toString()));
  });


}

String readFromFile(String name) {
  String str = new File('${name}Test.json').readAsStringSync();
  int index1 = str.indexOf('{');
  int index2 = str.indexOf('[');
  index1 = index1 == -1 ? 0: index1;
  index2 = index2 == -1 ? 0: index2;
  return str.substring(min(index1, index2));
}
