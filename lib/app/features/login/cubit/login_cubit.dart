import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit()
      : super(const LoginState(
          errorMessage: '',
        ));

  Future<void> start() async {
    emit(const LoginState(
      errorMessage: '',
    ));
  }

  Future<void> signIn({
    required email,
    required password,
  }) async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
    } catch (error) {
      emit(const LoginState(
        errorMessage: 'Błąd rejestracji',
      ));
    }
  }

  Future<void> logIn({
    required email,
    required password,
  }) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } catch (error) {
      emit(const LoginState(
        errorMessage: 'Błąd logowania',
      ));
    }
  }
}
