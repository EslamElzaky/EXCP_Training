import 'package:flutter/material.dart';

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
  });
  final bool usePassword;
  final String? hintText;
  final String? labelText;
  final String? prefixText;
  final int maxLines;
  final TextInputType? keyboardType;
  bool obscureText;
  final Function(String)? onChanged;
  final TextEditingController? controller;
  final bool isDate;
  final bool readOnly;

  @override
  State<CostumFormTextField> createState() => _CostumFormTextFieldState();
}

class _CostumFormTextFieldState extends State<CostumFormTextField> {
  Future<void> _selectDateTime(BuildContext context) async {
    // 1. اختار التاريخ
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    );

    if (pickedDate != null) {
      // 2. بعد اختيار التاريخ، نطلب الوقت
      final TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
      );

      if (pickedTime != null) {
        // 3. نجمع التاريخ والوقت
        final DateTime fullDateTime = DateTime(
          pickedDate.year,
          pickedDate.month,
          pickedDate.day,
          pickedTime.hour,
          pickedTime.minute,
        );

        // 4. نحولها لنص بصيغة مناسبة
        final formatted =
            "${fullDateTime.year}-${fullDateTime.month.toString().padLeft(2, '0')}-${fullDateTime.day.toString().padLeft(2, '0')} "
            "${pickedTime.format(context)}";

        // 5. نعرضها في الحقل
        if (widget.controller != null) {
          widget.controller!.text = formatted;
        }

        // 6. نمررها عبر onChanged لو موجود
        if (widget.onChanged != null) {
          widget.onChanged!(formatted);
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      keyboardType: widget.keyboardType,
      maxLines: widget.maxLines,
      cursorColor: Colors.white,
      obscureText: widget.obscureText,
      readOnly: widget.readOnly,
      onTap: widget.isDate ? () => _selectDateTime(context) : null,
      validator: (data) {
        if (data == null || data.isEmpty) {
          return 'Field is required';
        }
        return null;
      },
      onChanged: widget.onChanged,
      decoration: InputDecoration(
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
                    color: Colors.white),
              )
            : SizedBox.shrink(),
        prefixText: widget.prefixText,
        labelText: widget.labelText,
        hintText: widget.hintText,
        hintStyle: TextStyle(color: Colors.white),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
          borderRadius: BorderRadius.circular(16),
        ),
        border: OutlineInputBorder(borderSide: BorderSide(color: Colors.white)),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
          borderRadius: BorderRadius.circular(16),
        ),
      ),
    );
  }
}
