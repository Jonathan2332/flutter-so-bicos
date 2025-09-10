// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SbTextFormField extends StatelessWidget {

  final TextEditingController? controller;
  final bool enabled;
  final Widget? label;
  final Widget? icon;
  final Widget? suffixIcon;
  final Widget? hint;
  final bool obscureText;
  final List<TextInputFormatter>? inputFormatters;
  final String? Function(String? text)? validator;
  final void Function(String? text)? onSaved;
  final void Function(String? text)? onChanged;

  const SbTextFormField({
    super.key,
    this.controller,
    this.enabled = true,
    this.label,
    this.icon,
    this.suffixIcon,
    this.hint,
    this.obscureText = false,
    this.inputFormatters,
    this.validator,
    this.onSaved,
    this.onChanged,
  });
  
  @override
  Widget build(BuildContext context) => TextFormField(
    enabled: enabled,
    controller: controller,
    autovalidateMode: AutovalidateMode.onUserInteraction,
    decoration: InputDecoration(label: label, icon: icon, suffixIcon: suffixIcon, hint: hint),
    obscureText: obscureText,
    inputFormatters: inputFormatters,
    validator: validator,
    onSaved: onSaved,
    onChanged: onChanged,
  );
}
