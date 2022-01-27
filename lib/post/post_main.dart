import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'repository/repo.dart';
import 'screens/Appoo_screen.dart';

/*void main(){
  LicenseRegistry.addLicense(() async* {
    final license = await rootBundle.loadString('google_fonts/Roboto/LICENSE.txt');
    yield LicenseEntryWithLineBreaks(['google_fonts'], license);
    final licenseRubik = await rootBundle.loadString('assets/google_fonts/Rubik_Beastly/OFL.txt');
    yield LicenseEntryWithLineBreaks(['google_fonts'], licenseRubik);
  });
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => MyApp());
  }

  @override
  Widget build(BuildContext context) {
    print('from postMain');
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyAppoo(repository: Repository()),
    );
  }
}*/

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
