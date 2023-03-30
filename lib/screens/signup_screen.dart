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
                  padding: EdgeInsets.fromLTRB(16.0, 80.0, 16.0, 0.0),
                  child: Column(
                    children: <Widget>[
                      Text("Inscription", style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: Colors.white),
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      Text("Veuillez saisir ces différentes informations, afin que vos listes soient sauvegardées", textAlign: TextAlign.center, style: TextStyle(fontSize: 17, fontWeight: FontWeight.normal, color: Colors.white),
                      ),
                      SizedBox(
                        height: 40.0,
                      ),
                      TextField(
                        decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.black38,
                            hintText: 'Nom d\'utilisateur', hintStyle: TextStyle(color:Colors.white),
                            border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(3.0),
                            borderSide: BorderSide.none,)),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(
                        height: 12.0,
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
                        height: 12.0,
                      ),
                      TextField(
                        controller: _passwordController,
                        decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.black38,
                            hintText: 'Vérification du mot de passe', hintStyle: TextStyle(color:Colors.white),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(3.0),
                              borderSide: BorderSide.none,)),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(
                        height: 70.0,
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
                          Navigator.pushNamed(context, '/home');
                        },
                        style: ButtonStyle(
                        fixedSize: MaterialStateProperty.all<Size>(
                          Size(470, 55),
                        ),
                        textStyle: MaterialStateProperty.all<TextStyle>(
                          TextStyle(fontSize: 17),
                        ),
                        backgroundColor: MaterialStateProperty.all<Color>(
                        Colors.purple,
                        ),
                        foregroundColor: MaterialStateProperty.all<Color>(
                          Colors.white,
                        ),
                        ),
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
    )
    );
  }
}

