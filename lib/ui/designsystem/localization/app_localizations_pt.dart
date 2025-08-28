// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Portuguese (`pt`).
class AppLocalizationsPt extends AppLocalizations {
  AppLocalizationsPt([String locale = 'pt']) : super(locale);

  @override
  String get home => 'Home';

  @override
  String get settings => 'Configuraões';

  @override
  String get profile => 'Perfil';

  @override
  String get login => 'Login';

  @override
  String get signup => 'Registrar-se';

  @override
  String get welcome => 'Bem-vindo';

  @override
  String get dont_have_an_account => 'Não possui uma conta?';

  @override
  String get create_an_account => 'Criar uma conta';

  @override
  String get email => 'Email';

  @override
  String get password => 'Senha';

  @override
  String get repeat_password => 'Repetir senha';

  @override
  String get this_field_cant_be_empty_or_blank =>
      'Este campo não pode ser vazio ou em branco';

  @override
  String get this_field_requires_a_valid_email =>
      'Este campo requer um e-mail válido';

  @override
  String get password_mus_be_at_least_characters =>
      'A senha deve ter no minimo 6 caracteres';

  @override
  String get passwords_dont_match => 'As senhas não correspondem';

  @override
  String get logout => 'Sair';

  @override
  String get search => 'Buscar';
}
