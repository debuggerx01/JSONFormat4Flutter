import 'dart:convert';

class ${className} {
  $loop$
  ${variableType} ${variableName}
  $loop$


  ${className}(jsonStr) {
    var json = JSON.decode(jsonStr);
    $loop
    ${variableName} json['${variableName}'];
    $loop
  }

  @override
  String toString() {
    return '{"code": $code, "msg": ${msg != null?'"$msg"':'null'}, "rs": $rs}';
  }

}

class ActivityPage {
  int totalRow;
  int pageNumber;
  bool firstPage;
  bool lastPage;
  int totalPage;
  int pageSize;
  List<Activity> list;

  ActivityPage(jsonRes) {
    totalRow = jsonRes['totalRow'];
    pageNumber = jsonRes['pageNumber'];
    firstPage = jsonRes['firstPage'];
    lastPage = jsonRes['lastPage'];
    totalPage = jsonRes['totalPage'];
    pageSize = jsonRes['pageSize'];
    list = new List();
    for (var activity in jsonRes['list']) {
      list.add(new Activity(activity));
    }
  }

  @override
  String toString() {
    return '{"totalRow": $totalRow, "pageNumber": $pageNumber, "firstPage": $firstPage, "lastPage": $lastPage, "totalPage": $totalPage, "pageSize": $pageSize, "list": $list}';
  }

}

class Activity {
  int comment_num;
  String preface;
  String show_time;
  String create_time;
  String cover_pic;
  String end_time;
  String title;
  int type;
  int is_show;
  String recomm_time;
  int hasVote;
  int is_del;
  int id;
  int is_recomm;
  int approve_num;
  int is_approve;

  Activity(jsonRes) {
    comment_num = jsonRes['comment_num'];
    preface = jsonRes['preface'];
    show_time = jsonRes['show_time'];
    create_time = jsonRes['create_time'];
    cover_pic = jsonRes['cover_pic'];
    end_time = jsonRes['end_time'];
    title = jsonRes['title'];
    type = jsonRes['type'];
    is_show = jsonRes['is_show'];
    recomm_time = jsonRes['recomm_time'];
    hasVote = jsonRes['hasVote'];
    is_del = jsonRes['is_del'];
    id = jsonRes['id'];
    is_recomm = jsonRes['is_recomm'];
    approve_num = jsonRes['approve_num'];
    is_approve = jsonRes['is_approve'];
  }

  @override
  String toString() {

    return '{"comment_num": $comment_num, "preface": ${preface != null?'"$preface"':'null'}, "show_time": ${show_time != null?'"$show_time"':'null'}, "create_time": ${create_time != null?'"$create_time"':'null'}, "cover_pic": ${cover_pic != null?'"$cover_pic"':'null'}, "end_time": ${end_time != null?'"$end_time"':'null'}, "title": ${title != null?'"$title"':'null'}, "type": $type, "is_show": $is_show, "recomm_time": ${recomm_time != null?'"$recomm_time"':'null'}, "hasVote": $hasVote, "is_del": $is_del, "id": $id, "is_recomm": $is_recomm, "approve_num": $approve_num, "is_approve": $is_approve}';
  }

}