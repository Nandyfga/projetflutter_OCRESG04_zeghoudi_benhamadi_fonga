import 'package:equatable/equatable.dart';
import 'package:untitled1/models/user_model.dart';

abstract class AuthState extends Equatable {
  @override
  List<Object> get props => [];
}

class AuthInitialState extends AuthState {}

class AuthLoadingState extends AuthState {}

class AuthenticatedState extends AuthState {
  final UserModel user;

  AuthenticatedState({required this.user});

  @override
  List<Object> get props => [user];
}

class AuthErrorState extends AuthState {
  final String errorMessage;

  AuthErrorState({required this.errorMessage});

  @override
  List<Object> get props => [errorMessage];
}


