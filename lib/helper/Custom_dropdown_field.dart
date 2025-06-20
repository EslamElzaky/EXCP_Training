import 'package:excp_training/constant.dart';
import 'package:flutter/material.dart';

class CustomDropdownField extends StatelessWidget {
  CustomDropdownField({
    super.key,
    required this.items,
    required this.labelText,
    this.onChanged,
    this.value,
  });

  final List<String> items;
  final String? value;
  final String labelText;
  final Function(String?)? onChanged;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      dropdownColor: kPrimarycolor,
      validator: (data) {
        if (data!.isEmpty) {
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
      onChanged: onChanged,
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
