// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get home => 'Home';

  @override
  String get settings => 'Settings';

  @override
  String get profile => 'Profile';

  @override
  String get login => 'Login';

  @override
  String get signup => 'Sign up';

  @override
  String get welcome => 'Welcome';

  @override
  String get dont_have_an_account => 'Dont have an account?';

  @override
  String get create_an_account => 'Create an account';

  @override
  String get email => 'Email';

  @override
  String get password => 'Password';

  @override
  String get repeat_password => 'Repeat password';

  @override
  String get this_field_cant_be_empty_or_blank =>
      'This field can\'t be empty or blank';

  @override
  String get this_field_requires_a_valid_email =>
      'This field requires a valid email';

  @override
  String get password_mus_be_at_least_characters =>
      'Password must be at least 6 characters long';

  @override
  String get passwords_dont_match => 'Passwords don\'t match';

  @override
  String get logout => 'Logout';

  @override
  String get search => 'Search';
}
