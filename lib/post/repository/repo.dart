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

  /* Stream<SelectedTab> get status async* {
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
  }*/

  Future<List<Post>> fetchData(String row, SelectedTab selectedTab) async {
    print('from fetchData');
    final dioClient = Dio();
    final api = 'https://trello.backend.tests.nekidaem.ru/api/v1/cards/$row';
    Response response;
    response = await dioClient.get<String>(api,
        options: Options(
            headers: <String, dynamic>{'Authorization': 'JWT $token'},
            responseType: ResponseType.plain)); /* TODO  to add valid token */

    if (response.statusCode == 200) {
      //  _controller.add(selectedTab);
      print('from fetchData: ${response.statusCode}');
      print('from fetchData:${response.data.runtimeType}');
      print('from fetchData: ${response.data}');
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
