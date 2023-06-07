import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

Widget primaryInput({
  Function(String? input)? onSaved,
  String? validateText,
  String? hint,
  Widget? prefix,
  Widget? suffix,
  bool error = false,
  bool enabled = true,
  EdgeInsets? contentPadding,
  TextEditingController? controller,
  String? Function(String?)? validator,
  bool obscure = false,
  bool borderBottom = true,
  int? maxLength,
  TextInputType? textInputType,
  List<TextInputFormatter>? inputFormatters,
}) {
  return Container(
    child: TextFormField(
      obscureText: obscure,
      controller: controller,
      enabled: enabled,
      onSaved: onSaved,
      maxLength: maxLength,
      keyboardType: textInputType,
      inputFormatters: inputFormatters,
      validator: validator == null
          ? (input) {
              if (input!.isEmpty) {
                return validateText;
              } else {
                return null;
              }
            }
          : validator,
      autofocus: false,
      style: TextStyle(color: Colors.white),
      decoration: InputDecoration(
          contentPadding: contentPadding != null
              ? contentPadding
              : EdgeInsets.symmetric(vertical: 15),
          errorStyle: TextStyle(color: Colors.red),
          hintText: hint,
          prefixIcon: prefix,
          suffixIcon: suffix,
          counterText: '',
          border: borderBottom
              ? UnderlineInputBorder(
                  borderSide:
                      BorderSide(color: error ? Colors.red : Color(0xFFC5CEE0)))
              : InputBorder.none,
          focusedBorder: borderBottom
              ? UnderlineInputBorder(
                  borderSide:
                      BorderSide(color: error ? Colors.red : Color(0xFFC5CEE0)))
              : InputBorder.none,
          enabledBorder: borderBottom
              ? UnderlineInputBorder(
                  borderSide:
                      BorderSide(color: error ? Colors.red : Color(0xFFC5CEE0)))
              : InputBorder.none,
          hintStyle: TextStyle(color: Colors.grey[600])),
    ),
  );
}
