import 'package:excp_training/constant.dart';
import 'package:flutter/material.dart';

class CustomDropdownField extends StatelessWidget {
  CustomDropdownField({
    super.key,
     required this.items,
    required this.labelText,
    this.onChanged,
    this.value,
    this.onSaved,
    this.isEnabled = true,
  });

  final List<String> items;
  final bool isEnabled;
  final String? value;
  final String labelText;
  final Function(String?)? onChanged;
  final Function(String?)? onSaved;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      dropdownColor: kPrimarycolor,
      onSaved: onSaved,
      
      validator: (data) {
        if (data?.isEmpty ?? true) {
          return 'Fiald is requierd';
        }
      },
      value: value,
      items: items
          .map((item) => DropdownMenuItem<String>(
                value: item,
                child: Text(item),
              ))
          .toList(),
      onChanged:isEnabled? onChanged : null,
      decoration: InputDecoration(
        
        labelText: labelText,
        hintText: 'select $labelText',
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
          borderRadius: BorderRadius.circular(16),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
          borderRadius: BorderRadius.circular(16),
        ),
      ),
    );
  }
}
