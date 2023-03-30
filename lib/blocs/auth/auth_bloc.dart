import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:untitled1/models/user_model.dart';

import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  AuthBloc() : super(AuthInitialState()) {
    on<LoginEvent>(_onLoginEvent);
    on<RegisterEvent>(_onRegisterEvent);
    on<LogoutEvent>(_onLogoutEvent);
  }

  void _onLoginEvent(LoginEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoadingState());
    try {
      UserCredential userCredential =
      await _auth.signInWithEmailAndPassword(
          email: event.email, password: event.password);
      if (userCredential.user != null) {
        emit(AuthenticatedState(
            user: UserModel(
                id: userCredential.user!.uid,
                email: userCredential.user!.email,
                password: '')));
        print('Authenticated!');
      } else {
        emit(AuthErrorState(errorMessage: 'Invalid credentials'));
      }
    } catch (e) {
      emit(AuthErrorState(errorMessage: e.toString()));
    }
  }

  void _onRegisterEvent(RegisterEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoadingState());
    try {
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(
          email: event.email, password: event.password);
      emit(AuthenticatedState(
          user: UserModel(
              id: userCredential.user!.uid,
              email: userCredential.user!.email,
              password: '')));
      print('Authenticated!');
    } catch (e) {
      emit(AuthErrorState(errorMessage: e.toString()));
    }
  }

  void _onLogoutEvent(LogoutEvent event, Emitter<AuthState> emit) async {
    await _auth.signOut();
    emit(AuthInitialState());
  }
}






