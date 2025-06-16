import 'package:flutter/material.dart';

class CostumFormTextField extends StatelessWidget {
  CostumFormTextField({super.key, this.hintText, this.onChanged ,this.obscureText =false});
  String? hintText;
  bool obscureText;
  Function(String)? onChanged;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      
      obscureText:obscureText ,
      validator: (data) {
        if (data!.isEmpty) {
          return 'Fiald is requierd';
        }
      },
      onChanged: onChanged,
      decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(
            color: Colors.white,
          ),
          enabledBorder:
              OutlineInputBorder(borderSide: BorderSide(color: Colors.white)),
          border:
              OutlineInputBorder(borderSide: BorderSide(color: Colors.white))),
    );
  }
}
