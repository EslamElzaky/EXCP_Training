import 'dart:ffi';

import 'package:flutter/material.dart';

class CostumFormTextField extends StatelessWidget {
  CostumFormTextField(
      {super.key,this.maxLines=1,
      this.labelText,
      this.keyboardType,
      this.hintText,
      this.onChanged,
      this.obscureText = false});
  String? hintText;
  String? labelText;
  final int maxLines;
   final dynamic keyboardType;

  bool obscureText;
  Function(String)? onChanged;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: keyboardType,
      maxLines:maxLines,
      cursorColor:Colors.white ,
      obscureText: obscureText,
      validator: (data) {
        if (data!.isEmpty) {
          return 'Fiald is requierd';
        }
      },
      onChanged: onChanged,
      decoration: InputDecoration(
        
          labelText: labelText,
          hintText: hintText,
          hintStyle: TextStyle(
            color: Colors.white,
          ),
          enabledBorder: OutlineInputBorder(
            
              borderSide: BorderSide(color: Colors.white),
              borderRadius: BorderRadius.circular(16)),
          border:
              OutlineInputBorder(borderSide: BorderSide(color: Colors.white)),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
            borderRadius: BorderRadius.circular(16),
          )),
    );
  }
}
