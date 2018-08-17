import 'dart:convert' show json;

class RegionResp {

  int code;
  int ttl;
  String message;
  Data data;

  RegionResp.fromParams({this.code, this.ttl, this.message, this.data});

  factory RegionResp(jsonStr) => jsonStr == null ? null : jsonStr is String ? new RegionResp.fromJson(json.decode(jsonStr)) : new RegionResp.fromJson(jsonStr);

  RegionResp.fromJson(jsonRes) {
    code = jsonRes['code'];
    ttl = jsonRes['ttl'];
    message = jsonRes['message'];
    data = jsonRes['data'] == null ? null : new Data.fromJson(jsonRes['data']);
  }

  @override
  String toString() {
    return '{"code": $code,"ttl": $ttl,"message": ${message != null?'${json.encode(message)}':'null'},"data": $data}';
  }
}

class Data {

  List<Arch> archives;
  Page page;

  Data.fromParams({this.archives, this.page});

  Data.fromJson(jsonRes) {
    archives = jsonRes['archives'] == null ? null : [];

    for (var archivesItem in archives == null ? [] : jsonRes['archives']){
            archives.add(archivesItem == null ? null : new Arch.fromJson(archivesItem));
    }

    page = jsonRes['page'] == null ? null : new Page.fromJson(jsonRes['page']);
  }

  @override
  String toString() {
    return '{"archives": $archives,"page": $page}';
  }
}

class Page {

  int count;
  int num;
  int size;

  Page.fromParams({this.count, this.num, this.size});

  Page.fromJson(jsonRes) {
    count = jsonRes['count'];
    num = jsonRes['num'];
    size = jsonRes['size'];
  }

  @override
  String toString() {
    return '{"count": $count,"num": $num,"size": $size}';
  }
}

class Arch {

  int aid;
  int attribute;
  int copyright;
  int ctime;
  int duration;
  int pubdate;
  int state;
  int tid;
  int videos;
  String desc;
  String dynamic;
  String pic;
  String title;
  String tname;
  Owner owner;
  Rights rights;
  Stat stat;

  Arch.fromParams({this.aid, this.attribute, this.copyright, this.ctime, this.duration, this.pubdate, this.state, this.tid, this.videos, this.desc, this.dynamic, this.pic, this.title, this.tname, this.owner, this.rights, this.stat});

  Arch.fromJson(jsonRes) {
    aid = jsonRes['aid'];
    attribute = jsonRes['attribute'];
    copyright = jsonRes['copyright'];
    ctime = jsonRes['ctime'];
    duration = jsonRes['duration'];
    pubdate = jsonRes['pubdate'];
    state = jsonRes['state'];
    tid = jsonRes['tid'];
    videos = jsonRes['videos'];
    desc = jsonRes['desc'];
    dynamic = jsonRes['dynamic'];
    pic = jsonRes['pic'];
    title = jsonRes['title'];
    tname = jsonRes['tname'];
    owner = jsonRes['owner'] == null ? null : new Owner.fromJson(jsonRes['owner']);
    rights = jsonRes['rights'] == null ? null : new Rights.fromJson(jsonRes['rights']);
    stat = jsonRes['stat'] == null ? null : new Stat.fromJson(jsonRes['stat']);
  }

  @override
  String toString() {
    return '{"aid": $aid,"attribute": $attribute,"copyright": $copyright,"ctime": $ctime,"duration": $duration,"pubdate": $pubdate,"state": $state,"tid": $tid,"videos": $videos,"desc": ${desc != null?'${json.encode(desc)}':'null'},"dynamic": ${dynamic != null?'${json.encode(dynamic)}':'null'},"pic": ${pic != null?'${json.encode(pic)}':'null'},"title": ${title != null?'${json.encode(title)}':'null'},"tname": ${tname != null?'${json.encode(tname)}':'null'},"owner": $owner,"rights": $rights,"stat": $stat}';
  }
}

class Stat {

  int aid;
  int coin;
  int danmaku;
  int favorite;
  int his_rank;
  int like;
  int now_rank;
  int reply;
  int share;
  int view;

  Stat.fromParams({this.aid, this.coin, this.danmaku, this.favorite, this.his_rank, this.like, this.now_rank, this.reply, this.share, this.view});

  Stat.fromJson(jsonRes) {
    aid = jsonRes['aid'];
    coin = jsonRes['coin'];
    danmaku = jsonRes['danmaku'];
    favorite = jsonRes['favorite'];
    his_rank = jsonRes['his_rank'];
    like = jsonRes['like'];
    now_rank = jsonRes['now_rank'];
    reply = jsonRes['reply'];
    share = jsonRes['share'];
    view = jsonRes['view'];
  }

  @override
  String toString() {
    return '{"aid": $aid,"coin": $coin,"danmaku": $danmaku,"favorite": $favorite,"his_rank": $his_rank,"like": $like,"now_rank": $now_rank,"reply": $reply,"share": $share,"view": $view}';
  }
}

class Rights {

  int bp;
  int download;
  int elec;
  int hd5;
  int movie;
  int no_reprint;
  int pay;

  Rights.fromParams({this.bp, this.download, this.elec, this.hd5, this.movie, this.no_reprint, this.pay});

  Rights.fromJson(jsonRes) {
    bp = jsonRes['bp'];
    download = jsonRes['download'];
    elec = jsonRes['elec'];
    hd5 = jsonRes['hd5'];
    movie = jsonRes['movie'];
    no_reprint = jsonRes['no_reprint'];
    pay = jsonRes['pay'];
  }

  @override
  String toString() {
    return '{"bp": $bp,"download": $download,"elec": $elec,"hd5": $hd5,"movie": $movie,"no_reprint": $no_reprint,"pay": $pay}';
  }
}

class Owner {

  int mid;
  String face;
  String name;

  Owner.fromParams({this.mid, this.face, this.name});

  Owner.fromJson(jsonRes) {
    mid = jsonRes['mid'];
    face = jsonRes['face'];
    name = jsonRes['name'];
  }

  @override
  String toString() {
    return '{"mid": $mid,"face": ${face != null?'${json.encode(face)}':'null'},"name": ${name != null?'${json.encode(name)}':'null'}}';
  }
}

