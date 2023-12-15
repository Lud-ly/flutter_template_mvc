import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
import '../libs/tools_lib.dart';

class PasswordField extends StatefulWidget {
  bool _passwordVisible = false;
  TextEditingController controller;
  TextEditingController? passwordToConfirm;
  PasswordField(this.controller, {Key? key, this.passwordToConfirm})
      : super(key: key);

  @override
  State<PasswordField> createState() => _PasswordFieldState();
}

class _PasswordFieldState extends State<PasswordField> {
  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(maxWidth: 500),
      child: TextFormField(
        decoration: InputDecoration(
          icon: const Icon(Icons.lock),
          hintText: "password",
          labelText: widget.passwordToConfirm != null
              ? "passwordConfirmation"
              : "password",
          suffixIcon: IconButton(
            icon: Icon(
              widget._passwordVisible ? Icons.visibility : Icons.visibility_off,
              color: COLOR_PRIMARY(context),
            ),
            onPressed: () {
              setState(() {
                widget._passwordVisible = !widget._passwordVisible;
              });
            },
          ),
        ),
        validator: widget.passwordToConfirm == null
            ? (String? value) {
                return (value != null && value.length < 8)
                    ? "invalidPassword"
                    : null;
              }
            : (String? value) {
                return (value != null &&
                        value != widget.passwordToConfirm!.text)
                    ? "passwordsNotIdentical"
                    : null;
              },
        obscureText: !widget._passwordVisible,
        controller: widget.controller,
      ),
    );
  }
}
