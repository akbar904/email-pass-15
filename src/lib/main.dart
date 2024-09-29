
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'cubits/login_cubit.dart';
import 'cubits/auth_cubit.dart';
import 'screens/login_screen.dart';
import 'screens/home_screen.dart';

void main() {
	runApp(MyApp(
		loginCubit: LoginCubit(),
		authCubit: AuthCubit(),
	));
}

class MyApp extends StatelessWidget {
	final LoginCubit loginCubit;
	final AuthCubit authCubit;

	MyApp({required this.loginCubit, required this.authCubit});

	@override
	Widget build(BuildContext context) {
		return MultiBlocProvider(
			providers: [
				BlocProvider<LoginCubit>.value(value: loginCubit),
				BlocProvider<AuthCubit>.value(value: authCubit),
			],
			child: MaterialApp(
				home: BlocBuilder<AuthCubit, AuthState>(
					builder: (context, state) {
						if (state is Authenticated) {
							return HomeScreen();
						} else {
							return LoginScreen();
						}
					},
				),
			),
		);
	}
}
