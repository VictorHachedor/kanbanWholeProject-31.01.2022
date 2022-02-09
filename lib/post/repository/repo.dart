import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:hive/hive.dart';
import 'package:rxdart/rxdart.dart';

import '../models/post.dart';

enum SelectedTab { voidd, tab, secondTab, thirdTab, fourthTab }

class Repository {
  Repository(this.token);

  final dynamic token;

  final _controller = BehaviorSubject<SelectedTab>();

  Future<List<Post>> fetchData(String row, SelectedTab selectedTab) async {
    print('from fetchData');
    var box = Hive.box<dynamic>('bodyData');
    var bodyData = <dynamic>[];
    final dioClient = Dio();
    final api = 'https://trello.backend.tests.nekidaem.ru/api/v1/cards/';
    Response response;
    try {
      print('repo from try block');
      response = await dioClient.get<dynamic>(api,
          options: Options(
              headers: <String, dynamic>{'Authorization': 'JWT $token'},
              responseType: ResponseType.plain));

      if (response.statusCode == 200) {
        print('from fetchData: ${response.statusCode}');
        print('from fetchData:${response.data.runtimeType}');
        print('from fetchData: ${response.data}');
        final body = json.decode(response.data.toString()) as List;
        print('RUNTYPE BODY ${body.runtimeType}');
         await addPosts(body, box);
      }
    } catch (e) {
      print('No Internet: $e');
    }
    print('repo after try block');
    var dataFromHive = box.toMap().values.toList();
    if (dataFromHive.isEmpty) {
      bodyData.add('empty');
    }
    bodyData = dataFromHive;
    print(bodyData);
    return bodyData.map((dynamic json) {
      return Post(
        row: json['row'] as String,
        id: json['id'] as int,
        text: json['text'] as String,
      );
    }).toList();
  }

List<Post> returnBodyData(List<dynamic> bodyData){
return bodyData.map((dynamic json) {
      return Post(
        row: json['row'] as String,
        id: json['id'] as int,
        text: json['text'] as String,
      );
    }).toList();
}

void selectedPosts(List<dynamic> bodyData, int row) {
    for (var i = 0; i < bodyData.length; i++) {
      if (bodyData[i].row == row) {
        bodyData.add(bodyData[i]);
      }
    }
  }


  Future addPosts(dynamic body, Box box) async {
    print('repo from addPosts');
    await box.clear();
    for (var data in body) {
      await box.add(data);
    }
  }

  void dispose() {
    _controller.close();
  }
}
