

import 'package:dartz/dartz.dart';

abstract class AuthState {}

class AuthIinitiateState extends AuthState {}

class AuthLoadingState extends AuthState {}

class AuthResponseState extends AuthState {
  Either<String, String> respons;
  AuthResponseState(this.respons);
}
