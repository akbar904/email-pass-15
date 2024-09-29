
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:com.example.simple_app/cubits/auth_cubit.dart';

class HomeScreen extends StatelessWidget {
	@override
	Widget build(BuildContext context) {
		final authCubit = context.read<AuthCubit>();

		return Scaffold(
			appBar: AppBar(
				title: Text('Home Screen'),
			),
			body: Center(
				child: ElevatedButton(
					onPressed: () {
						authCubit.logout();
					},
					child: Text('Logout'),
				),
			),
		);
	}
}
