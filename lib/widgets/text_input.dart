import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:medtrack/constants/app_constants.dart';

class TextInputField extends StatefulWidget {
  @override
  _TextInputFieldState createState() => _TextInputFieldState();

  final TextEditingController? controller;
  final FormFieldValidator<String>? validator;
  final bool? obscure;
  final bool? readOnly;
  final VoidCallback onTap;

  //final Function onSaved;
  final FormFieldSetter<String>? onSaved;
  final VoidCallback? onEditingCompleted;
  final TextInputType? keyboardType;
  final ValueChanged<String>? onChanged;
  final int? maxLength;
  final bool? isMulti;
  final bool? autofocus;
  final bool? enabled;
  final String? errorText;
  final String? label;
  final Widget? suffix;
  final Widget? prefix;

  const TextInputField(
      {Key? key,
      this.controller,
      this.validator,
      this.keyboardType = TextInputType.text,
      this.obscure = false,
      required this.onTap,
      required this.onSaved,
      this.isMulti = false,
      this.readOnly = false,
      this.autofocus = false,
      this.errorText,
      required this.label,
      this.suffix,
      this.prefix,
      this.enabled = true,
      this.onEditingCompleted,
      this.onChanged,
      this.maxLength})
      : super(key: key);
}

class _TextInputFieldState extends State<TextInputField> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 12),
      child: TextFormField(
          onChanged: widget.onChanged,
          onEditingComplete: widget.onEditingCompleted,
          autofocus: widget.autofocus!,
          minLines: widget.isMulti! ? 3 : 1,
          maxLines: widget.isMulti! ? null : 1,
          onTap: widget.onTap,
          onSaved: widget.onSaved,
          enabled: widget.enabled,
          readOnly: widget.readOnly!,
          obscureText: widget.obscure!,
          keyboardType: widget.keyboardType,
          maxLength: widget.maxLength,
          controller: widget.controller,
          decoration: InputDecoration(
            hintText: widget.label,
            isDense: true,
            counterText: "",
            errorText: widget.errorText,
            prefixIcon: widget.prefix,
            suffixIcon: widget.suffix,
            fillColor: null,
            //AppConstants.textEditBackground, filled: true,
            contentPadding: const EdgeInsets.fromLTRB(16, 25, 25, 12),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
            floatingLabelBehavior: FloatingLabelBehavior.always,
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
              borderSide: BorderSide(
                color: AppConstants.lineColor,
              ),
            ),

            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
              borderSide: BorderSide(
                color: AppConstants.lineColor,
                width: 2.0,
              ),
            ),
          ),
          validator: widget.validator),
    );
  }
}
