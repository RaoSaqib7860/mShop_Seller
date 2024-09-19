import 'package:flutter/material.dart';
import 'package:google_translator/google_translator.dart';

import '../extentions/app_colors.dart';
import 'app_font.dart';

class CustomTextFieldsDecorated extends StatefulWidget {
  final String? title;
  final TextEditingController? controller;
  final String? labelText;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final bool? visible;
  final Function(String?)? onchange;
  final bool? show_title;
  final String? initial_text;
  final int? maxline;
  final TextInputType? textInputType;
  final int? minimum_line;
  final String? hint;
  final String? Function(String?)? validator;
  const CustomTextFieldsDecorated(
      {Key? key,
      this.controller,
      this.labelText,
      this.suffixIcon,
      this.visible = false,
      this.prefixIcon,
      required this.title,
      this.onchange,
      this.show_title = true,
      this.initial_text,
      this.maxline = 3,
      this.textInputType = TextInputType.multiline,
      this.minimum_line = 1,
      this.hint = '',
      this.validator})
      : super(key: key);

  @override
  _CustomTextFieldsDecoratedState createState() =>
      _CustomTextFieldsDecoratedState();
}

class _CustomTextFieldsDecoratedState extends State<CustomTextFieldsDecorated> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Visibility(
          visible: widget.show_title!,
          child: Padding(
            padding: const EdgeInsets.only(left: 13),
            child: Text(
              '${widget.title}',
              style: TextStyle(
                  color: Theme.of(context).brightness == Brightness.light
                      ? Colors.black.withOpacity(0.8)
                      : Colors.grey,
                  //Colors.black.withOpacity(0.8),
                  fontFamily: AppFonts.segoeui),
            ).translate(),
          ),
        ),
        Visibility(
          child: SizedBox(height: 5),
          visible: widget.show_title!,
        ),
        Container(
          child: widget.initial_text == null
              ? TextFormField(
                  controller: widget.controller,
                  cursorColor: Colors.black,
                  keyboardType: widget.textInputType,
                  obscureText: widget.visible!,
                  maxLines: widget.maxline,
                  minLines: widget.minimum_line,
                  textInputAction:
                      widget.maxline == 1 ? null : TextInputAction.newline,
                  onChanged: widget.onchange,
                  initialValue: widget.initial_text,
                  validator: widget.validator == null ? null : widget.validator,
                  decoration: InputDecoration(
                      border: UnderlineInputBorder(
                        borderSide:
                            BorderSide(width: 0.7, color: Colors.black26),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide:
                            BorderSide(width: 0.7, color: Colors.black26),
                      ),
                      errorBorder: UnderlineInputBorder(
                        borderSide: BorderSide(width: 0.7, color: Colors.red),
                      ),
                      disabledBorder: UnderlineInputBorder(
                        borderSide:
                            BorderSide(width: 0.7, color: Colors.black26),
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide:
                            BorderSide(width: 0.7, color: Colors.black26),
                      ),
                      labelStyle: TextStyle(
                        fontFamily: AppFonts.segoeui,
                        fontSize: 13,
                        color: Theme.of(context).brightness == Brightness.light
                            ? Colors.black
                            : AppColors.textColor,
                      ),
                      contentPadding: EdgeInsets.only(
                          left: 15, bottom: 11, top: 11, right: 15),
                      hintText: widget.labelText,
                      suffixIcon: widget.suffixIcon,
                      prefixIcon: widget.prefixIcon,
                      hintStyle: TextStyle(
                          color:
                              Theme.of(context).brightness == Brightness.light
                                  ? Colors.black
                                  : AppColors.textColor,
                          fontSize: 12)),
                )
              : TextFormField(
                  controller: widget.controller,
                  cursorColor: Colors.black,
                  keyboardType: widget.textInputType,
                  obscureText: widget.visible!,
                  minLines: widget.minimum_line,
                  maxLines: widget.maxline,
                  validator: widget.validator == null ? null : widget.validator,
                  textInputAction:
                      widget.maxline == 1 ? null : TextInputAction.newline,
                  onChanged: widget.onchange,
                  initialValue: widget.initial_text,
                  decoration: InputDecoration(
                      border: UnderlineInputBorder(
                        borderSide:
                            BorderSide(width: 0.7, color: Colors.black26),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide:
                            BorderSide(width: 0.7, color: Colors.black26),
                      ),
                      errorBorder: UnderlineInputBorder(
                        borderSide: BorderSide(width: 0.7, color: Colors.red),
                      ),
                      disabledBorder: UnderlineInputBorder(
                        borderSide:
                            BorderSide(width: 0.7, color: Colors.black26),
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide:
                            BorderSide(width: 0.7, color: Colors.black26),
                      ),
                      contentPadding: EdgeInsets.only(
                          left: 5, bottom: 11, top: 11, right: 5),
                      hintText: widget.labelText,
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
                          color:
                              Theme.of(context).brightness == Brightness.light
                                  ? Colors.black
                                  : AppColors.textColor,
                          fontSize: 12)),
                ),
        ),
      ],
    );
  }
}
