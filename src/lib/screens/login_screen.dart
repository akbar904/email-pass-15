
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:com.example.simple_app/cubits/login_cubit.dart';

class LoginScreen extends StatelessWidget {
	@override
	Widget build(BuildContext context) {
		return Scaffold(
			appBar: AppBar(
				title: Text('Login'),
			),
			body: BlocListener<LoginCubit, LoginState>(
				listener: (context, state) {
					if (state is LoginStateError) {
						ScaffoldMessenger.of(context).showSnackBar(
							SnackBar(content: Text(state.message)),
						);
					}
				},
				child: Padding(
					padding: const EdgeInsets.all(16.0),
					child: Column(
						mainAxisAlignment: MainAxisAlignment.center,
						children: [
							TextField(
								key: Key('emailField'),
								decoration: InputDecoration(labelText: 'Email'),
								onChanged: (value) {
									context.read<LoginCubit>().emailChanged(value);
								},
							),
							TextField(
								key: Key('passwordField'),
								obscureText: true,
								decoration: InputDecoration(labelText: 'Password'),
								onChanged: (value) {
									context.read<LoginCubit>().passwordChanged(value);
								},
							),
							SizedBox(height: 20),
							ElevatedButton(
								onPressed: () {
									final email = context.read<LoginCubit>().state.email;
									final password = context.read<LoginCubit>().state.password;
									context.read<LoginCubit>().login(email, password);
								},
								child: Text('Login'),
							),
						],
					),
				),
			),
		);
	}
}
