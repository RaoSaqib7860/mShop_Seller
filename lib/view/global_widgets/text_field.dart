import 'package:flutter/material.dart';

import '../../extentions/app_colors.dart';
import 'app_font.dart';

class CustomTextFields extends StatefulWidget {
  final TextEditingController? controller;
  final String? labelText;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final bool? visible;
  final TextInputType? keyboredType;
  final bool? enable;
  final bool? readOnly;
  final String? Function(String?)? validator;
  final int? max_length;
  final double? padding;
  final Function(String)? onchaged;
  const CustomTextFields(
      {Key? key,
      this.controller,
      this.labelText,
      this.suffixIcon,
      this.readOnly = false,
      this.visible = false,
      this.prefixIcon,
      this.keyboredType = TextInputType.text,
      this.enable = true,
      this.onchaged = null,
      this.validator = null,
      this.max_length,
      this.padding = 20})
      : super(key: key);

  @override
  _CustomTextFieldsState createState() => _CustomTextFieldsState();
}

class _CustomTextFieldsState extends State<CustomTextFields> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: widget.padding!),
      child: Container(
        child: TextFormField(
          controller: widget.controller,
          cursorColor: Colors.black,
          keyboardType: widget.keyboredType,
          obscureText: widget.visible!,
          readOnly: widget.readOnly!,
          enabled: widget.enable,
          maxLength: widget.max_length,
          onChanged: widget.onchaged,
          validator: widget.validator == null ? null : widget.validator,
          decoration: new InputDecoration(
              border: UnderlineInputBorder(
                borderSide: BorderSide(width: 0.7, color: Colors.black26),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(width: 0.7, color: Colors.black26),
              ),
              errorBorder: UnderlineInputBorder(
                borderSide: BorderSide(width: 0.7, color: Colors.red),
              ),
              disabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(width: 0.7, color: Colors.black26),
              ),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(width: 0.7, color: Colors.black26),
              ),
              contentPadding:
                  EdgeInsets.only(left: 5, bottom: 11, top: 11, right: 5),
              labelText: widget.labelText,
              suffixIcon: widget.suffixIcon,
              prefixIcon: widget.prefixIcon,
              labelStyle: TextStyle(
                fontFamily: AppFonts.segoeui,
                fontSize: 13,
                color: Theme.of(context).brightness == Brightness.light
                    ? Colors.black
                    : AppColors.textColor,
              ),
              hintStyle: TextStyle(
                color: Theme.of(context).brightness == Brightness.light
                    ? Colors.black
                    : AppColors.textColor,
              )),
        ),
      ),
    );
  }
}
