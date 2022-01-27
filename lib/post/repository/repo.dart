import 'dart:async';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:rxdart/rxdart.dart';

import '../models/post.dart';

enum SelectedTab { voidd, tab, secondTab, thirdTab, fourthTab }

class Repository {
  Repository(this.token);

  final dynamic token;

  final _controller = BehaviorSubject<SelectedTab>();

  Stream<SelectedTab> get status async* {
    await Future<void>.delayed(const Duration(seconds: 1));
    print(
'from Stream<SelectedTab> get status async* before "yield SelectedTab.voidd"');
    yield SelectedTab.voidd;
    print(
        'after yield _controller.stream value: ' 
        '${_controller.stream.valueOrNull}');
    print('controller.isClosed: ${_controller.isClosed}');
    yield* _controller.stream;
    print(
        'after yield*_controller.stream value: '
        '${_controller.stream.valueOrNull}');
  }

  Future<List<Post>> childWidgetData() async {
    print('from childWidgetData');
    final dioClient = Dio();
    final api = 'https://trello.backend.tests.nekidaem.ru/api/v1/cards/?row=0';
    Response response;
    response = await dioClient.get<String>(api,
        options: Options(headers: <String, dynamic>{
          'Authorization':
              'JWT $token'
        }, responseType: ResponseType.plain)); /* TODO  to add valid token */

    if (response.statusCode == 200) {
      _controller.add(SelectedTab.tab);
      print('from childWidgetData: ${response.statusCode}');
      print('from childWidgetData:${response.data.runtimeType}');
      print('from childWidgetData: ${response.data}');
      final body = json.decode(response.data.toString()) as List;
      return body.map((dynamic json) {
        return Post(
          id: json['id'] as int,
          text: json['text'] as String,
        );
      }).toList();
    }
    throw Exception('error fetching posts');
  }

  Future<List<Post>> childWidgetTwoData() async {
    print('from childWidgetTwoData');
    final dioClient = Dio();
    final api = 'https://trello.backend.tests.nekidaem.ru/api/v1/cards/?row=1';
    Response response;
    response = await dioClient.get<String>(api,
        options: Options(headers: <String, dynamic>{
          'Authorization':
              'JWT $token'
        }, responseType: ResponseType.plain)); /* TODO  to add valid token */

    if (response.statusCode == 200) {
      _controller.add(SelectedTab.secondTab);
      print('from childWidgetTwoData: ${response.statusCode}');
      print('from childWidgetTwoData:${response.data.runtimeType}');
      print('from childWidgetTwoData: ${response.data}');
      final body = json.decode(response.data.toString()) as List;
      return body.map((dynamic json) {
        return Post(
          id: json['id'] as int,
          text: json['text'] as String,
        );
      }).toList();
    }
    throw Exception('error fetching posts');
  }

  Future<List<Post>> childWidgetThreeData() async {
    print('from childWidgetThreeData');
    final dioClient = Dio();
    final api = 'https://trello.backend.tests.nekidaem.ru/api/v1/cards/?row=2';
    Response response;
    response = await dioClient.get<String>(api,
        options: Options(headers: <String, dynamic>{
          'Authorization':
              'JWT $token'
        }, responseType: ResponseType.plain)); /* TODO  to add valid token */

    if (response.statusCode == 200) {
      _controller.add(SelectedTab.thirdTab);
      print('from childWidgetThreeData: ${response.statusCode}');
      print('from childWidgetThreeData:${response.data.runtimeType}');
      print('from childWidgetThreeData: ${response.data}');
      final body = json.decode(response.data.toString()) as List;
      return body.map((dynamic json) {
        return Post(
          id: json['id'] as int,
          text: json['text'] as String,
        );
      }).toList();
    }
    throw Exception('error fetching posts');
  }

  Future<List<Post>> childWidgetFourData() async {
    print('from childWidgetFourData');
    final dioClient = Dio();
    final api = 'https://trello.backend.tests.nekidaem.ru/api/v1/cards/?row=3';
    Response response;
    response = await dioClient.get<String>(api,
        options: Options(headers: <String, dynamic>{
          'Authorization':
              'JWT $token'
        }, responseType: ResponseType.plain)); /* TODO  to add valid token */

    if (response.statusCode == 200) {
      _controller.add(SelectedTab.fourthTab);
      print('from childWidgetFourData: ${response.statusCode}');
      print('from childWidgetFourData:${response.data.runtimeType}');
      print('from childWidgetFourData: ${response.data}');
      final body = json.decode(response.data.toString()) as List;
      return body.map((dynamic json) {
        return Post(
          id: json['id'] as int,
          text: json['text'] as String,
        );
      }).toList();
    }
    throw Exception('error fetching posts');
  }

  void dispose() {
    if (_controller.hasError) {
      _controller.close();
    }
  }
}
