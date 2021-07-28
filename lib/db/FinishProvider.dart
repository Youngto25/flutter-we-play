import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

String TABLE_NAME = "db_finish"; //表名
String ID = "id";
String TYPE = "type";
String COUNT = 'count';
String CREATEDTIME = "createdTime";

class Finish {
  int id;
  String type;
  int count;
  String createdTime;

  Finish(String type, int count, String createTime, int id) {
    this.type = type;
    this.count = count;
    this.createdTime = createTime;
    this.id = id != null ? id : 0;
  }

  getId() {
    return this.id;
  }

  getCount() {
    return this.count;
  }

  getType() {
    return this.type;
  }

  getCreatedTime() {
    return this.createdTime;
  }

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      TYPE: type,
      COUNT: count,
      CREATEDTIME: createdTime
    };
    if (id != null) {
      map[ID] = id;
    }
    if (id == 0) {
      map[ID] = null;
    }
    return map;
  }

  Finish.formMap(Map<String, dynamic> map) {
    id = map[ID];
    type = map[TYPE];
    count = map[COUNT];
    createdTime = map[CREATEDTIME];
  }
}

class FinishProvider {
  Database db;
  Future open() async {
    String databasePath = await getDatabasesPath();
    String path = join(databasePath, TABLE_NAME);
    db = await openDatabase(path, version: 4,
        onCreate: (Database db, int version) async {
      await db.execute('''create table $TABLE_NAME (
        $ID integer primary key autoincrement,
        $TYPE varchar no null,
        $COUNT integer no null,
        $CREATEDTIME varchar no null
      )''');
      debugPrint("init" + "数据库创建成功");
    });
  }

  // 插入数据
  Future<Finish> insert(Finish finish) async {
    finish.id = await db.insert(TABLE_NAME, finish.toMap());
    return finish;
  }

  // 查询数据
  Future<List<Finish>> query(String type) async {
    List<Map> maps = await db.query(TABLE_NAME,
        columns: [TYPE, COUNT, CREATEDTIME, ID],
        where: '$TYPE = ?',
        whereArgs: [type],
        orderBy: "$ID desc");
    List<Finish> list = [];
    maps.forEach((vo) {
      if (vo["type"] != null &&
          vo["count"] != null &&
          vo["createdTime"] != null) {
        Finish finish =
            new Finish(vo["type"], vo["count"], vo["createdTime"], vo["id"]);
        list.add(finish);
      }
    });
    return list;
  }

  // 删除数据
  Future<int> delete(int id) async {
    return await db.delete(TABLE_NAME, where: '$ID = ?', whereArgs: [id]);
  }
}
