import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:untitled1/blocs/auth/auth_bloc.dart';
import 'package:untitled1/blocs/auth/auth_event.dart';
import 'package:untitled1/blocs/auth/auth_state.dart';


final TextEditingController _emailController = TextEditingController();
final TextEditingController _passwordController = TextEditingController();

class SignupScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Signup'),
      ),
      backgroundColor: Colors.white, // Ajout de la propriété backgroundColor
      body: BlocProvider(
        create: (context) => AuthBloc(),
        child: BlocListener<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is AuthErrorState) {
              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text(state.errorMessage)));
            } else if (state is AuthenticatedState) {
              Navigator.pushNamed(context, '/home');
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
                          try {
                            UserCredential userCredential = await FirebaseAuth
                                .instance
                                .createUserWithEmailAndPassword(
                                email: _emailController.text,
                                password: _passwordController.text);
                            BlocProvider.of<AuthBloc>(context).add(
                                RegisterEvent(
                                    email: _emailController.text,
                                    password: _passwordController.text));
                          } on FirebaseAuthException catch (e) {
                            if (e.code == 'weak-password') {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      content:
                                      Text('The password is too weak.')));
                            } else if (e.code == 'email-already-in-use') {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      content: Text(
                                          'The account already exists for that email.')));
                            }
                          } catch (e) {
                            ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text(e.toString())));
                          }
                        },
                        child: Text('S\'inscrire'),
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

