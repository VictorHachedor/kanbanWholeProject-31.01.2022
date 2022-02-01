import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_login/login/login.dart';
import 'package:formz/formz.dart';

class LoginForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
     final fieldError = context.select(
      (LoginBloc loginBloc) => loginBloc.fieldError,
    );
    final Widget azdc = Text('Error: ${fieldError?.nonFieldErrors}');

    print('from LoginForm: ${fieldError?.nonFieldErrors}');
    print('from azdc $azdc');
    return Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        color: Colors.black,
        child: 
        BlocListener<LoginBloc, LoginState>(
          listener: (context, state) {
            print('from LoginForm in listener: ${fieldError?.nonFieldErrors}');
            if (state.status.isSubmissionFailure) {
              ScaffoldMessenger.of(context)
                ..hideCurrentSnackBar()
                ..showSnackBar(SnackBar(
                 
                  content: 
              fieldError?.nonFieldErrors == null
                        ? const Text('Proccessing')
                        : Text('Error: ${fieldError?.nonFieldErrors}')),
                        );
            }
          },
          child: Align(
            alignment: const Alignment(0, -1 / 3),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _UsernameInput(),
                const Padding(padding: EdgeInsets.all(12)),
                _PasswordInput(),
                const Padding(padding: EdgeInsets.all(12)),
                _LoginButton(),
              ],
            ),
          ),
        ));
  }
}



Future<Text> textDelay(dynamic error) async {
  await Future<dynamic>.delayed(const Duration(seconds: 15));
  return Text('Error: $error');
}

class _UsernameInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      buildWhen: (previous, current) => previous.username != current.username,
      builder: (context, state) {
        return Container(
          width: 365,
          child: TextField(
            textAlign: TextAlign.center,
            style: const TextStyle(color: Colors.white),
            key: const Key('loginForm_usernameInput_textField'),
            onChanged: (username) =>
                context.read<LoginBloc>().add(LoginUsernameChanged(username)),
            decoration: InputDecoration(
              border: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(40))),
              enabledBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(40)),
                borderSide: BorderSide(width: 1, color: Colors.grey),
              ),
              focusedBorder: const OutlineInputBorder(
                  borderSide: BorderSide(width: 2, color: Color(0xFF64FFDA)),
                  borderRadius: BorderRadius.all(Radius.circular(40))),
              hintText: 'Enter your username',
              hintStyle: const TextStyle(color: Colors.grey),
              errorText:
                  state.username.invalid ? 'Minimum is 4 characters' : null,
              contentPadding: const EdgeInsets.all(5),
            ),
          ),
        );
      },
    );
  }
}

class _PasswordInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      buildWhen: (previous, current) => previous.password != current.password,
      builder: (context, state) {
        return Container(
          width: 365,
          child: TextField(
            textAlign: TextAlign.center,
            style: const TextStyle(color: Colors.white),
            obscureText: true,
            key: const Key('loginForm_passwordInput_textField'),
            onChanged: (password) =>
                context.read<LoginBloc>().add(LoginPasswordChanged(password)),
            decoration: InputDecoration(
              border: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(40))),
              enabledBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(40)),
                borderSide: BorderSide(width: 1, color: Colors.grey),
              ),
              focusedBorder: const OutlineInputBorder(
                  borderSide: BorderSide(width: 2, color: Color(0xFF64FFDA)),
                  borderRadius: BorderRadius.all(Radius.circular(40))),
              hintText: 'Enter your password',
              hintStyle: const TextStyle(color: Colors.grey),
              errorText:
                  state.password.invalid ? 'Minimum is 8 characters' : null,
              contentPadding: const EdgeInsets.all(5),
            ),
          ),
        );
      },
    );
  }
}

class _LoginButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {
        return state.status.isSubmissionInProgress
            ? const CircularProgressIndicator()
            : ElevatedButton(
                key: const Key('loginForm_continue_raisedButton'),
                child: const Text('Log in',
                    style: TextStyle(fontSize: 17, color: Colors.black54)),
                style: ButtonStyle(
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25.0),
                    )),
                    fixedSize: MaterialStateProperty.all<Size>(
                      const Size(365.0, 50.0),
                    ),
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.tealAccent)),
                onPressed: state.status.isValidated
                    ? () {
                        context.read<LoginBloc>().add(const LoginSubmitted());
                      }
                    : null,
              );
      },
    );
  }
}
