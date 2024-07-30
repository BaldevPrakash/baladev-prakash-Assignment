import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../color_utils.dart';

class HomerTextInputFieldSmall extends StatelessWidget {
  final String hintText;
  final String labelText;
  final bool isEnable;
  final TextEditingController textController;
  final Function(String text) validationCallBack;
  final Function(String text) onSaveCallBack;
  final Function(String text) onChangedCallBack;
  final bool? filled;
  final Color? fillColor;

  const HomerTextInputFieldSmall({
    Key? key,
    this.isEnable = true,
    required this.hintText,
    required this.labelText,
    required this.textController,
    required this.validationCallBack,
    required this.onSaveCallBack,
    required this.onChangedCallBack,
    this.filled,
    this.fillColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      enabled: isEnable,
      controller: textController,
      autofocus: false,
      keyboardType: TextInputType.text,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      maxLines: 1,
      onSaved: (value) {
        onSaveCallBack(value ?? '');
      },
      onChanged: (value) {
        onChangedCallBack(value);
      },
      style: isEnable == true
          ? textFormFieldTextInterStyle
          : textFormFieldTextGreyInterStyle,
      maxLength: 255,
      decoration: textFormFieldDecoration(
        hintText: hintText,
        textFormFieldHintStyle: textFormFieldHintInterStyle,
        labelText: labelText,
        isEnable: isEnable,
        textFormFieldLabelStyle: textFormFieldLabelInterStyle,
        filled: filled,
        fillColor: fillColor,
      ),
      validator: (value) => validationCallBack(value!),
    );
  }
}

InputDecoration textFormFieldDecoration(
    {required String hintText,
    required TextStyle textFormFieldHintStyle,
    required String labelText,
    required TextStyle textFormFieldLabelStyle,
    required bool isEnable,
    Widget? suffixIcon,
    bool? filled,
    Color? fillColor}) {
  return InputDecoration(
    border: const OutlineInputBorder(
      borderRadius: BorderRadius.all(
        Radius.circular(8),
      ),
    ),
    fillColor: fillColor,
    filled: filled,
    counterText: '',
    suffixIcon: suffixIcon,
    errorBorder: const OutlineInputBorder(
      borderSide: BorderSide(color: kSecondaryError500),
      borderRadius: BorderRadius.all(
        Radius.circular(8),
      ),
    ),
    focusedBorder: const OutlineInputBorder(
      borderSide: BorderSide(color: kWhiteColor),
      borderRadius: BorderRadius.all(
        Radius.circular(8),
      ),
    ),
    enabledBorder: const OutlineInputBorder(
      borderSide: BorderSide(color: kWhiteColor),
      borderRadius: BorderRadius.all(
        Radius.circular(8),
      ),
    ),
    disabledBorder: const OutlineInputBorder(
      borderSide: BorderSide(color: kWhiteColor),
      borderRadius: BorderRadius.all(
        Radius.circular(8),
      ),
    ),
    hintText: hintText,
    hintStyle: textFormFieldHintStyle,
    labelText: labelText,
    labelStyle: textFormFieldLabelStyle,
    contentPadding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
  );
}

/// English Enabled
TextStyle textFormFieldTextInterStyle = GoogleFonts.inter(
    color: kWhiteColor,
    fontSize: 15,
    fontWeight: FontWeight.w600,
    fontStyle: FontStyle.normal);

/// English Disabled

TextStyle textFormFieldTextGreyInterStyle = GoogleFonts.inter(
    color: kWhiteColor,
    fontSize: 15,
    fontWeight: FontWeight.w600,
    fontStyle: FontStyle.normal);

TextStyle textFormFieldLabelInterStyle = GoogleFonts.inter(
    color: kWhiteColor,
    fontSize: 14,
    fontWeight: FontWeight.w400,
    fontStyle: FontStyle.normal);

/// Arabic Enabled - Disabled
TextStyle textFormFieldLabelCairoStyle = GoogleFonts.cairo(
    color: kWhiteColor,
    fontSize: 16,
    fontWeight: FontWeight.w400,
    fontStyle: FontStyle.normal);

TextStyle textFormFieldHintInterStyle = GoogleFonts.inter(
    color: kWhiteColor,
    fontSize: 14,
    fontWeight: FontWeight.w400,
    fontStyle: FontStyle.normal);

///  Arabic Enabled - Disabled

TextStyle textFormFieldHintCairoStyle = GoogleFonts.cairo(
    color: kWhiteColor,
    fontSize: 14,
    fontWeight: FontWeight.w400,
    fontStyle: FontStyle.normal);
