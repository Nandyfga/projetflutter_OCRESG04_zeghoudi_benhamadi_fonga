import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled1/blocs/auth/auth_bloc.dart';
import 'package:untitled1/blocs/auth/auth_event.dart';
import 'package:untitled1/blocs/auth/auth_state.dart';

class LoginScreen extends StatefulWidget {
  @override
  LoginScreenState createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: BlocProvider(
        create: (context) => AuthBloc(),
        child: BlocListener<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is AuthErrorState) {
              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text(state.errorMessage)));
            } else if (state is AuthenticatedState) {
              print('Utilisateur authentifié');
              Navigator.pushNamedAndRemoveUntil(context, '/home', (_) => false);
            }
          },
          child: BlocBuilder<AuthBloc, AuthState>(
            builder: (context, state) {
              if (state is AuthLoadingState) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                return Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      TextField(
                        controller: _emailController,
                        decoration: InputDecoration(hintText: 'Email'),
                      ),
                      SizedBox(
                        height: 12.0,
                      ),
                      TextField(
                        controller: _passwordController,
                        decoration: InputDecoration(hintText: 'Password'),
                        obscureText: true,
                      ),
                      SizedBox(
                        height: 24.0,
                      ),
                      ElevatedButton(
                        onPressed: () async {
                          BlocProvider.of<AuthBloc>(context).onLogin(
                            _emailController.text,
                            _passwordController.text,
                          );
                        },
                        child: Text('Se connecter'),
                      ),
                      SizedBox(
                        height: 12.0,
                      ),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/signup');
                        },
                        child: Text('Créer un nouveau compte'),
                      ),
                    ],
                  ),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}



