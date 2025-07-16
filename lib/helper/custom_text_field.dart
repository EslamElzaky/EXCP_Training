import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CostumFormTextField extends StatefulWidget {
  CostumFormTextField({
    super.key,
    this.prefixText,
    this.readOnly = false,
    this.maxLines = 1,
    this.labelText,
    this.keyboardType,
    this.hintText,
    this.onChanged,
    this.obscureText = false,
    this.controller,
    this.isDate = false,
    this.usePassword = false,
    this.onSaved,  this.initialValue,
  });

  final bool usePassword;
  final String? hintText;
  final String? initialValue;
  final String? labelText;
  final String? prefixText;
  final int maxLines;
  final TextInputType? keyboardType;
  bool obscureText;
  final Function(String)? onChanged;
  final TextEditingController? controller;
  final bool isDate;
  final bool readOnly;
  final void Function(String?)? onSaved;

  @override
  State<CostumFormTextField> createState() => _CostumFormTextFieldState();
}

class _CostumFormTextFieldState extends State<CostumFormTextField> {
 
  Future<void> _selectDateTime(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    );

    if (pickedDate != null) {
      final TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
      );

      if (pickedTime != null) {
        final DateTime fullDateTime = DateTime(
          pickedDate.year,
          pickedDate.month,
          pickedDate.day,
          pickedTime.hour,
          pickedTime.minute,
        );

        // ✅ استخدم DateFormat هنا للتنسيق
        final String formatted = DateFormat(
          'yyyy-MM-dd hh:mm a',
        ).format(fullDateTime);

        // شيل التركيز من الحقل
        FocusScope.of(context).unfocus();

        // حدث النص بعد فترة بسيطة
        Future.delayed(const Duration(milliseconds: 100), () {
          if (widget.controller != null) {
            widget.controller!.text = formatted;
          }

          if (widget.onChanged != null) {
            widget.onChanged!(formatted);
          }
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      initialValue: widget.initialValue,
      onSaved: widget.onSaved,
      controller: widget.controller,
      keyboardType: widget.keyboardType,
      maxLines: widget.maxLines,
      cursorColor: Colors.white,
      obscureText: widget.obscureText,
      readOnly: widget.readOnly || widget.isDate,
      onChanged: widget.onChanged,
      onTap: widget.isDate ? () => _selectDateTime(context) : null,
      validator: (data) {
        if (data?.isEmpty ?? true) {
          //لو هوا فاضي يبقي )(صح ونفذ الريترن)
          return 'Field is required';
        }
        return null;
      },

      decoration: InputDecoration(
        prefixText: widget.prefixText,
        labelText: widget.labelText,
        hintText: widget.hintText,
        suffixIcon: widget.usePassword
            ? GestureDetector(
                onTap: () {
                  setState(() {
                    widget.obscureText = !widget.obscureText;
                  });
                },
                child: Icon(
                  widget.obscureText
                      ? Icons.visibility_off
                      : Icons.remove_red_eye,
                  color: Colors.white,
                ),
              )
            : const SizedBox.shrink(),

        hintStyle: const TextStyle(color: Colors.white),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.white),
          borderRadius: BorderRadius.circular(16),
        ),
        border: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.white),
          borderRadius: BorderRadius.circular(16),
        ),
      ),
    );
  }
}
