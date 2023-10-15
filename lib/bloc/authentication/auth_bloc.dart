import 'package:bloc/bloc.dart';
import 'package:flutter_application_1/bloc/authentication/auth_state.dart';
import 'package:flutter_application_1/bloc/authentication/auth_event.dart';
import 'package:flutter_application_1/data/repository/authentication_repository.dart';
import 'package:flutter_application_1/di/di.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final IAthuRepository _repository = locator.get();

  AuthBloc() : super(AuthIinitiateState()) {
    on<AuthLoginRequestEvent>(
      (event, emit) async {
        emit(AuthLoadingState());
        var respons = await _repository.login(event.username, event.password);
        emit(AuthResponseState(respons));
      },
    );
  }
}
