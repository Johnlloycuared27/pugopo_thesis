import 'package:flutter/material.dart';
import 'package:thesis_auth/src/styles/textfield.dart';

class AppTextField extends StatefulWidget {
  final String hintText;
  final IconData materialIcon;
  final TextInputType? textInputType;
  final void Function(String) onChanged;
  final String errorText;
  final String? initialText;

  AppTextField(
      {required this.hintText,
      required this.materialIcon,
      this.textInputType,
      required this.onChanged,
      required this.errorText,
      this.initialText});

  @override
  _AppTextFieldState createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  late TextEditingController _controller;

  @override
  void initState() {
    _controller = TextEditingController();
    if (widget.initialText != null) _controller.text = widget.initialText!;

    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: TextFieldStyles.textBoxHorizontal,
          vertical: TextFieldStyles.textBoxVertical),
      child: TextField(
        keyboardType: widget.textInputType,
        cursorColor: TextFieldStyles.cursorColor,
        style: TextFieldStyles.text,
        textAlign: TextFieldStyles.textAlign,
        decoration: TextFieldStyles.materialDecoration(
            widget.hintText, widget.materialIcon, widget.errorText),
        onChanged: widget.onChanged,
        controller: _controller,
      ),
    );
  }
}
