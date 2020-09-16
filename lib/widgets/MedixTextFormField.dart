import 'package:flutter/material.dart';
import 'package:medix/constants/theme.dart';

class MedixTextFormField extends StatelessWidget {
  final Function onChange, validator;
  final String labelText;
  final String id;
  final Widget prefixIcon;
  final Function onTap;
  final bool autovalidate, showCursor, enableInteractiveSelection, obscureText;
  final TextInputType keyboardType;
  final TextEditingController controller;
  final TextCapitalization textCapitalization;

  const MedixTextFormField({
    this.id,
    this.onChange,
    this.labelText,
    this.prefixIcon,
    this.onTap,
    this.validator,
    this.autovalidate = false,
    this.keyboardType = TextInputType.text,
    this.controller,
    this.showCursor = true,
    this.enableInteractiveSelection = true,
    this.obscureText = false,
    this.textCapitalization =  TextCapitalization.none,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: TextFormField(
        textCapitalization: textCapitalization,
        obscureText: obscureText,
        enableInteractiveSelection: enableInteractiveSelection,
        showCursor: showCursor,
        controller: controller,
        keyboardType: keyboardType,
        autovalidate: autovalidate,
        validator: validator,
        onTap: onTap,
        style: TextStyle(color: Colors.blueAccent),
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.blueAccent,
            ),
          ),

          errorBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.redAccent,
            ),
          ),
          labelText: labelText,
          labelStyle: TextStyle(color: Colors.blueAccent),
          prefixIcon: prefixIcon,
//              hintText: hintText,
          hintStyle: TextStyle(color: Colors.blueAccent),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: secondaryColor(context),
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.blueAccent),
          ),
        ),
        onChanged: (text) {
          onChange(id, text);
        },
      ),
    );
  }
}
