import 'package:flutter/material.dart';
import 'package:recipizz/utils/app_theme.dart';

class MyTextField extends StatefulWidget {
  final TextEditingController controllers;
  final String hintText;
  final bool obscureText;
  final String labelText;
  final IconData? prefixIconData;
  final IconData? suffixIconData;
  final TextInputType keyboardType; 

  const MyTextField({
    super.key,
    required this.controllers,
    required this.hintText,
    required this.obscureText,
    required this.labelText,
    required this.keyboardType, 
    this.prefixIconData,
    this.suffixIconData,
  });

  @override
  MyTextFieldState createState() => MyTextFieldState();
}

class MyTextFieldState extends State<MyTextField> {
  bool _passwordVisibility = false;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controllers,
      obscureText: widget.obscureText && !_passwordVisibility,
      keyboardType: widget.keyboardType, 
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        border:  OutlineInputBorder(),
        labelText: widget.labelText,
        labelStyle: TextStyle(color:AppTheme.colors.appBlackColor),
        hintText: widget.hintText,
        hintStyle: const TextStyle(
          color: Colors.black12,
        ),
        prefixIcon: widget.prefixIconData != null ? Icon(widget.prefixIconData) : null,
        suffixIcon: widget.suffixIconData != null
            ? IconButton(
                onPressed: () {
                  setState(() {
                    _passwordVisibility = !_passwordVisibility;
                  });
                },
                icon: Icon(widget.suffixIconData),
              )
            : null,
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter a Username';
        }
        return null;
      },
      autovalidateMode: AutovalidateMode.onUserInteraction,
    );
  }
}
