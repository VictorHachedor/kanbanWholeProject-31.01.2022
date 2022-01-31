import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'repository/repo.dart';
import 'screens/Appoo_screen.dart';

class PostMain extends StatelessWidget {
const PostMain({Key? key}) : super(key: key);

  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => const PostMain());
  }

  @override
  Widget build(BuildContext context) {
    final tokenPoPa = context.select(
      (AuthenticationRepository auth) => auth.token,
    );
    final dynamic tokenFin = tokenPoPa!.token;
    return Scaffold(
      body: MyAppoo(repository: Repository(tokenFin)),
    );
  }
}
