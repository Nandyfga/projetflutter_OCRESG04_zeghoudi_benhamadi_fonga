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
      body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/fond.png'),
              fit: BoxFit.cover,
        ),
      ),
      child: BlocProvider(
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
                  padding: EdgeInsets.fromLTRB(16.0, 80.0, 16.0, 0.0),
                  child: Column(
                   // mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text("Bienvenue !", style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold, color: Colors.white),
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      Container(
                        width: 250,
                        child: Text("Veuillez vous connecter ou créer un nouveau compte pour utiliser l\'application.", textAlign: TextAlign.center,
                          style: TextStyle(fontSize:20 , fontWeight: FontWeight.normal, color: Colors.white),
                        ),
                      ),
                      SizedBox (
                        height: 24.0,
                      ),
                      TextField(
                        controller: _emailController,
                        decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.black38,
                            hintText: 'E-mail', hintStyle: TextStyle(color:Colors.white),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(3.0),
                              borderSide: BorderSide.none,)),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(
                        height: 12.0,
                      ),
                      TextField(
                        controller: _passwordController,
                        decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.black38,
                            hintText: 'Mot de passe', hintStyle: TextStyle(color:Colors.white),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(3.0),
                              borderSide: BorderSide.none,)),
                        obscureText: true,
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(
                        height: 50.0,
                      ),
                      ElevatedButton(
                        onPressed: () async {
                          BlocProvider.of<AuthBloc>(context).add(LoginEvent(
                              email: _emailController.text,
                              password: _passwordController.text));
                        },
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                            Colors.purple,
                          ),
                          foregroundColor: MaterialStateProperty.all<Color>(
                            Colors.white,
                          ),
                          fixedSize: MaterialStateProperty.all<Size>(
                            Size(470, 55),
                          ),
                          textStyle: MaterialStateProperty.all<TextStyle>(
                            TextStyle(fontSize: 17),
                          ),
                        ),
                        child: Text('Se connecter'),
                      ),
                      SizedBox(
                        height: 15.0,
                      ),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/signup');
                        },
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                            Colors.transparent,
                          ),
                          fixedSize: MaterialStateProperty.all<Size>(
                            Size(470, 55),
                          ),
                          textStyle: MaterialStateProperty.all<TextStyle>(
                            TextStyle(fontSize: 17),
                          ),
                          side: MaterialStateProperty.all<BorderSide>(
                            BorderSide(
                              color: Colors.purple,
                            ),
                          ),
                        ),
                        child: Text('Créer un nouveau compte', style: TextStyle(
                          color: Colors.white),
                      ),
                      ),
                      SizedBox(
                        height: 120.0,
                      ),
                      GestureDetector(
                        child: Text("Mot de passe oublié", style: TextStyle(
                            decoration: TextDecoration.underline,
                            color: Colors.grey,
                          ),
                        ),
                        onTap: () {
                        },
                      )
                    ],
                  ),
                );
              }
            },
          ),
        ),
      ),
    )
    );
  }
}



