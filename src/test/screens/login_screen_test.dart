
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:com.example.simple_app/screens/login_screen.dart';
import 'package:com.example.simple_app/cubits/login_cubit.dart';

// Mocking necessary dependencies
class MockLoginCubit extends MockCubit<LoginState> implements LoginCubit {}

void main() {
	group('LoginScreen Widget Tests', () {
		testWidgets('renders email and password fields and login button', (WidgetTester tester) async {
			await tester.pumpWidget(
				MaterialApp(
					home: BlocProvider<LoginCubit>(
						create: (_) => MockLoginCubit(),
						child: LoginScreen(),
					),
				),
			);

			expect(find.byType(TextField), findsNWidgets(2)); // Email and Password fields
			expect(find.text('Login'), findsOneWidget); // Login button
		});

		testWidgets('shows error message on login failure', (WidgetTester tester) async {
			final mockLoginCubit = MockLoginCubit();
			whenListen(
				mockLoginCubit,
				Stream.fromIterable([LoginState.error('Invalid credentials')]),
				initialState: LoginState.initial(),
			);
		
			await tester.pumpWidget(
				MaterialApp(
					home: BlocProvider<LoginCubit>(
						create: (_) => mockLoginCubit,
						child: LoginScreen(),
					),
				),
			);

			await tester.enterText(find.byType(TextField).first, 'test@example.com');
			await tester.enterText(find.byType(TextField).last, 'password');
			await tester.tap(find.text('Login'));
			await tester.pump();

			expect(find.text('Invalid credentials'), findsOneWidget);
		});
	});

	group('LoginCubit Tests', () {
		late LoginCubit loginCubit;

		setUp(() {
			loginCubit = LoginCubit();
		});

		blocTest<LoginCubit, LoginState>(
			'emits [LoginState.loading(), LoginState.success()] when login is successful',
			build: () => loginCubit,
			act: (cubit) => cubit.login('test@example.com', 'password'),
			expect: () => [
				LoginState.loading(),
				LoginState.success(),
			],
		);

		blocTest<LoginCubit, LoginState>(
			'emits [LoginState.loading(), LoginState.error()] when login fails',
			build: () => loginCubit,
			act: (cubit) => cubit.login('wrong@example.com', 'wrongpassword'),
			expect: () => [
				LoginState.loading(),
				LoginState.error('Invalid credentials'),
			],
		);
	});
}
