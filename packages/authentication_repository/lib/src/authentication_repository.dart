import 'dart:async';

import 'package:authentication_repository/src/token.dart';
import 'package:dio/dio.dart';

enum AuthenticationStatus { unknown, authenticated, unauthenticated }

class AuthenticationRepository {
  Token? token;
  final _controller = StreamController<AuthenticationStatus>();

  Stream<AuthenticationStatus> get status async* {
    await Future<void>.delayed(const Duration(seconds: 1));
    print('from Stream<AuthenticationStatus> get status async* ');
    yield AuthenticationStatus.unauthenticated;
    print('_controller.stream ${_controller.stream.toString()}');
    yield* _controller.stream;
    
  }

  Future<void> logIn({
    required String username,
    required String password,
  }) async {
    final api = 'https://trello.backend.tests.nekidaem.ru/api/v1/users/login/';
    final data = {'username': username, 'password': password};
    final dio = Dio();
    Response response;
    response = await dio.post<dynamic>(api,
        data: data, options: Options(responseType: ResponseType.json));
    print(response.statusCode);
    if (response.statusCode == 200) {
      token = Token(response.data['token']);
      print(token!.token);
      print('token: ${response.data['token']}');
      _controller.add(AuthenticationStatus.authenticated);
    } else {
      return null;
    }
  }

  void logOut() {
    _controller.add(AuthenticationStatus.unauthenticated);
  }

  void dispose() => _controller.close();
}
