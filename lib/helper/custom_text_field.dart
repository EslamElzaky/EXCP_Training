// import 'package:flutter/material.dart';

// class CostumFormTextField extends StatelessWidget {
//   CostumFormTextField(
//       {super.key,this.maxLines=1,
//       this.labelText,
//       this.keyboardType,
//       this.hintText,
//       this.onChanged,
//       this.obscureText = false});
//   String? hintText;
//   String? labelText;
//   final int maxLines;
//    final dynamic keyboardType;

//   bool obscureText;
//   Function(String)? onChanged;
//   @override
//   Widget build(BuildContext context) {
//     return TextFormField(
//       keyboardType: keyboardType,
//       maxLines:maxLines,
//       cursorColor:Colors.white ,
//       obscureText: obscureText,
//       validator: (data) {
//         if (data!.isEmpty) {
//           return 'Fiald is requierd';
//         }
//       },
//       onChanged: onChanged,
//       decoration: InputDecoration(

//           labelText: labelText,
//           hintText: hintText,
//           hintStyle: TextStyle(
//             color: Colors.white,
//           ),
//           enabledBorder: OutlineInputBorder(

//               borderSide: BorderSide(color: Colors.white),
//               borderRadius: BorderRadius.circular(16)),
//           border:
//               OutlineInputBorder(borderSide: BorderSide(color: Colors.white)),
//           focusedBorder: OutlineInputBorder(
//             borderSide: BorderSide(color: Colors.white),
//             borderRadius: BorderRadius.circular(16),
//           )),
//     );
//   }
// }
import 'package:flutter/material.dart';

class CostumFormTextField extends StatelessWidget {
  CostumFormTextField({
    super.key,
    this.maxLines = 1,
    this.labelText,
    this.keyboardType,
    this.hintText,
    this.onChanged,
    this.obscureText = false,
    this.controller,
    this.isDate = false,
  });

  String? hintText;
  String? labelText;
  int maxLines;
  TextInputType? keyboardType;
  bool obscureText;
  Function(String)? onChanged;
  TextEditingController? controller;
  bool isDate;

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
        if (controller != null) {
          controller!.text = formatted;
        }

        // 6. نمررها عبر onChanged لو موجود
        if (onChanged != null) {
          onChanged!(formatted);
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      maxLines: maxLines,
      cursorColor: Colors.white,
      obscureText: obscureText,
      readOnly: isDate,
      onTap: isDate ? () => _selectDateTime(context) : null,
      validator: (data) {
        if (data == null || data.isEmpty) {
          return 'Field is required';
        }
        return null;
      },
      onChanged: onChanged,
      decoration: InputDecoration(
        labelText: labelText,
        hintText: hintText,
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
