
import 'package:flutter_bloc/flutter_bloc.dart';

// Define the states for AuthCubit
abstract class AuthState {}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthLoggedOut extends AuthState {}

// Define the AuthCubit
class AuthCubit extends Cubit<AuthState> {
	AuthCubit() : super(AuthInitial());

	void logout() {
		emit(AuthLoading());
		// Perform logout logic here, e.g., clearing user data, making API calls, etc.
		emit(AuthLoggedOut());
	}
}
