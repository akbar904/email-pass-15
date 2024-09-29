
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:com.example.simple_app/main.dart';

class MockLoginCubit extends MockCubit<LoginState> implements LoginCubit {}
class MockAuthCubit extends MockCubit<AuthState> implements AuthCubit {}

void main() {
	group('Main App Initialization', () {
		late MockLoginCubit loginCubit;
		late MockAuthCubit authCubit;

		setUp(() {
			loginCubit = MockLoginCubit();
			authCubit = MockAuthCubit();
		});

		testWidgets('App starts with LoginScreen', (WidgetTester tester) async {
			await tester.pumpWidget(MyApp(
				loginCubit: loginCubit,
				authCubit: authCubit,
			));

			expect(find.byType(LoginScreen), findsOneWidget);
		});
	});

	group('LoginScreen Widget', () {
		testWidgets('Displays email and password fields and login button', (WidgetTester tester) async {
			await tester.pumpWidget(MaterialApp(home: LoginScreen()));

			expect(find.byType(TextField), findsNWidgets(2));
			expect(find.text('Login'), findsOneWidget);
		});
	});

	group('HomeScreen Widget', () {
		testWidgets('Displays logout button', (WidgetTester tester) async {
			await tester.pumpWidget(MaterialApp(home: HomeScreen()));

			expect(find.text('Logout'), findsOneWidget);
		});
	});
}
