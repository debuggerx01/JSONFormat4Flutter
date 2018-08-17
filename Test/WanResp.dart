import 'dart:convert' show json;

class WanResp {

  int errorCode;
  String errorMsg;
  List<Data> data;

  WanResp.fromParams({this.errorCode, this.errorMsg, this.data});

  factory WanResp(jsonStr) =>
      jsonStr == null ? null : jsonStr is String ? new WanResp.fromJson(json.decode(jsonStr)) : new WanResp.fromJson(
          jsonStr);

  WanResp.fromJson(jsonRes) {
    errorCode = jsonRes['errorCode'];
    errorMsg = jsonRes['errorMsg'];
    data = jsonRes['data'] == null ? null : [];

    for (var dataItem in data == null ? [] : jsonRes['data']) {
      data.add(dataItem == null ? null : new Data.fromJson(dataItem));
    }
  }

  @override
  String toString() {
    return '{"errorCode": $errorCode,"errorMsg": ${errorMsg != null
        ? '${json.encode(errorMsg)}'
        : 'null'},"data": $data}';
  }
}

class Data {

  int courseId;
  int id;
  int order;
  int parentChapterId;
  int visible;
  String name;
  List<Children> children;

  Data.fromParams({this.courseId, this.id, this.order, this.parentChapterId, this.visible, this.name, this.children});

  Data.fromJson(jsonRes) {
    courseId = jsonRes['courseId'];
    id = jsonRes['id'];
    order = jsonRes['order'];
    parentChapterId = jsonRes['parentChapterId'];
    visible = jsonRes['visible'];
    name = jsonRes['name'];
    children = jsonRes['children'] == null ? null : [];

    for (var childrenItem in children == null ? [] : jsonRes['children']) {
      children.add(childrenItem == null ? null : new Children.fromJson(childrenItem));
    }
  }

  @override
  String toString() {
    return '{"courseId": $courseId,"id": $id,"order": $order,"parentChapterId": $parentChapterId,"visible": $visible,"name": ${name !=
        null ? '${json.encode(name)}' : 'null'},"children": $children}';
  }
}

class Children {

  int courseId;
  int id;
  int order;
  int parentChapterId;
  int visible;
  String name;
  List<dynamic> children;

  Children.fromParams(
      {this.courseId, this.id, this.order, this.parentChapterId, this.visible, this.name, this.children});

  Children.fromJson(jsonRes) {
    courseId = jsonRes['courseId'];
    id = jsonRes['id'];
    order = jsonRes['order'];
    parentChapterId = jsonRes['parentChapterId'];
    visible = jsonRes['visible'];
    name = jsonRes['name'];
    children = jsonRes['children'] == null ? null : [];

    for (var childrenItem in children == null ? [] : jsonRes['children']) {
      children.add(childrenItem);
    }
  }

  @override
  String toString() {
    return '{"courseId": $courseId,"id": $id,"order": $order,"parentChapterId": $parentChapterId,"visible": $visible,"name": ${name !=
        null ? '${json.encode(name)}' : 'null'},"children": $children}';
  }
}

