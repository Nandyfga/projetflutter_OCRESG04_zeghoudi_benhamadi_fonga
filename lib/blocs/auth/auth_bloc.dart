import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:untitled1/models/user_model.dart';

import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  AuthBloc() : super(AuthInitialState());

  @override
  AuthState get initialState => AuthInitialState();

  @override
  Stream<AuthState> onmapEventToState(AuthEvent event) async* {
    if (event is LoginEvent) {
      yield AuthLoadingState();
      try {
        UserCredential userCredential = await _auth.signInWithEmailAndPassword(
            email: event.email, password: event.password);
        if (userCredential.user != null) {
          yield AuthenticatedState(
              user: UserModel(
                  id: userCredential.user?.uid,
                  email: userCredential.user?.email,
                  password: ""));
          print("Authenticated!");
        } else {
          yield AuthErrorState(errorMessage: "Invalid credentials");
        }
      } catch (e) {
        yield AuthErrorState(errorMessage: e.toString());
      }
    } else if (event is RegisterEvent) {
      yield AuthLoadingState();
      try {
        UserCredential userCredential = await _auth
            .createUserWithEmailAndPassword(
            email: event.email, password: event.password);
        yield AuthenticatedState(
            user: UserModel(
                id: userCredential.user?.uid,
                email: userCredential.user?.email,
                password: ""));
        print("Authenticated!");
      } catch (e) {
        yield AuthErrorState(errorMessage: e.toString());
      }
    } else if (event is LogoutEvent) {
      await _auth.signOut();
      yield AuthInitialState();
    }
  }
  void onLogin(String email, String password) {
    add(LoginEvent(email: email, password: password));
    print('User authenticated');
  }
}




