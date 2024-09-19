import 'package:flutter/material.dart';
import 'package:mShop_Seller/extentions/app_colors.dart';
import 'app_font.dart';

class CustomTextFields extends StatefulWidget {
  final TextEditingController? controller;
  final String? labelText;
  final String? helperText;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final bool? visible;
  final bool? readOnly;
  final TextInputType? keyboredType;
  final bool? enable;
  final String? Function(String?)? validator;

  const CustomTextFields(
      {Key? key,
      this.controller,
      this.labelText,
        this.readOnly = false,
        this.helperText,
        this.validator,
      this.suffixIcon,
      this.visible = false,
      this.prefixIcon,
      this.keyboredType = TextInputType.text, this.enable=true})
      : super(key: key);

  @override
  _CustomTextFieldsState createState() => _CustomTextFieldsState();
}

class _CustomTextFieldsState extends State<CustomTextFields> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          color: Theme.of(context).brightness == Brightness.light  ? Color(0xffffffff) : Colors.black,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade300.withOpacity(0.5),
              //color: const Color(0x290bab0d),
              offset: Offset(0, 3),
              blurRadius: 6,
            ),
          ],
        ),
        child: TextFormField(
          controller: widget.controller,
          cursorColor: Colors.black,
          keyboardType: widget.keyboredType,
          obscureText: widget.visible!,
          enabled: widget.enable,
          readOnly: widget.readOnly!,
          validator: widget.validator == null ? null : widget.validator,
          decoration: new InputDecoration(
            border: InputBorder.none,
            focusedBorder: InputBorder.none,
            enabledBorder: InputBorder.none,
            errorBorder: InputBorder.none,
            helperText: widget.helperText,
            disabledBorder: InputBorder.none,
            contentPadding:
                EdgeInsets.only(left: 15, bottom: 11, top: 11, right: 15),
            labelText: widget.labelText,
            //  hintText: '+923331234567',
            suffixIcon: widget.suffixIcon,
            hintStyle: TextStyle(color: Theme.of(context).brightness == Brightness.light  ? AppColors.textColor : AppColors.textColor),
            prefixIcon: widget.prefixIcon,
            labelStyle: TextStyle(
              fontFamily: AppFonts.segoeui,
              fontSize: 13,
              color: Theme.of(context).brightness == Brightness.light  ? AppColors.textColor : AppColors.textColor,
              //const Color(0xff1e1e1e),
            ),
          ),
        ),
      ),
    );
  }
}
