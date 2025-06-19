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

  final String? hintText;
  final String? labelText;
  final int maxLines;
  final TextInputType? keyboardType;
  final bool obscureText;
  final Function(String)? onChanged;
  final TextEditingController? controller;
  final bool isDate;

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(), 
      firstDate: DateTime(1900), 
      lastDate: DateTime(2100),
    );
    if (picked != null && controller != null) {
      controller!.text = "${picked.year}-${picked.month.toString().padLeft(2, '0')}-${picked.day.toString().padLeft(2, '0')}";
      if (onChanged != null) {
        onChanged!(controller!.text);
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
      readOnly: isDate, // نمنع المستخدم من الكتابة اليدوية إذا كان حقل تاريخ
      onTap: isDate ? () => _selectDate(context) : null,
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

