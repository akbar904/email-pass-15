
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

// Defining the states for LoginCubit
abstract class LoginState extends Equatable {
	const LoginState();

	@override
	List<Object> get props => [];
}

class LoginInitial extends LoginState {}
class LoginLoading extends LoginState {}
class LoginSuccess extends LoginState {}
class LoginFailure extends LoginState {}

// Defining the LoginCubit
class LoginCubit extends Cubit<LoginState> {
	LoginCubit() : super(LoginInitial());

	void login(String email, String password) async {
		try {
			emit(LoginLoading());
			// Simulating network request
			await Future.delayed(Duration(seconds: 2));
			// Fake success condition
			if (email == 'test@example.com' && password == 'password123') {
				emit(LoginSuccess());
			} else {
				emit(LoginFailure());
			}
		} catch (_) {
			emit(LoginFailure());
		}
	}
}
