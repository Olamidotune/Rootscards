import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    this.controller,
    required this.textInputAction,
    this.textAlign = TextAlign.start,
    required this.hintText,
    this.validator,
    this.onFieldSubmitted,
    this.obscureText = false,
    this.initialValue,
    this.suffixIcon,
    this.suffix,
    this.prefixIcon,
    this.prefix,
    this.maxLength,
    this.focusNode,
    this.value,
    this.counter,
    this.height,
    this.autoCorrect = true,
    this.autoFocus = false,
    this.canRequestFocus = false,
    this.textCapitalization,
    this.onEditingComplete,
    required this.textInputType,
    this.inputFormatters,
  });

  final TextEditingController? controller;
  final TextInputAction? textInputAction;
  final TextAlign? textAlign;
  final String? Function(String?)? validator;
  final ValueChanged<String?>? onFieldSubmitted;
  final bool obscureText;
  final String? initialValue;
  final Widget? suffixIcon;
  final Widget? suffix;
  final String hintText;
  final Widget? prefixIcon;
  final Widget? prefix;
  final int? maxLength;
  final FocusNode? focusNode;
  final String? value;
  final Widget? counter;
  final double? height;
  final bool? autoCorrect;
  final bool? autoFocus;
  final bool? canRequestFocus;
  final TextCapitalization? textCapitalization;
  final VoidCallback? onEditingComplete;
  final TextInputType textInputType;
  final List<TextInputFormatter>? inputFormatters;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: textInputType,
      inputFormatters: inputFormatters,
      controller: controller,
      textInputAction: textInputAction,
      validator: validator,
      obscureText: obscureText,
      maxLength: maxLength,
      decoration: InputDecoration(
        hintText: hintText,
        suffix: suffix,
        suffixIcon: suffixIcon,
        prefix: prefix,
        prefixIcon: prefixIcon,
        contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 25),
        hintStyle: Theme.of(context)
            .textTheme
            .bodySmall!
            .copyWith(color: Colors.black26, fontWeight: FontWeight.bold),
        border: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey.shade200),
          borderRadius: BorderRadius.all(
            Radius.circular(60.w),
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.green),
          borderRadius: BorderRadius.all(
            Radius.circular(
              60.w,
            ),
          ),
        ),
      ),
    );
  }
}
