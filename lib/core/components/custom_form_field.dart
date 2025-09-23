
import 'package:flutter/material.dart';

import 'color_helper.dart';

typedef MyValidator = String? Function(String?);
typedef OnChange = void Function(String?);
typedef OnTap = void Function();

class CustomFormField extends StatelessWidget {
 final String hintText;
 final MyValidator validator;
 final OnChange? onChange;
 final bool focus;
 final OnTap? onTap;
 final TextEditingController controller;
 final TextInputType keyboardType;
 final IconButton? suffix;
 final Widget? prefix;
 final bool isPassword;
 final FocusNode? focusNode;
  const CustomFormField(
      {super.key,
      required this.hintText,
      required this.validator,
      required this.controller,
      this.prefix,
      this.keyboardType = TextInputType.text,
      this.suffix,
      this.isPassword = false,
      this.focusNode,
        this.onChange,
        this.onTap,
        this.focus = false
      });
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: TextFormField(
        textDirection: TextDirection.rtl,
        autofocus: focus,
        controller: controller,
        onTap: onTap,
        validator: validator,
        keyboardType: keyboardType,
        obscureText: isPassword,
        focusNode: focusNode,
        onChanged: onChange,
        //textDirection: TextDirection,
        style: const TextStyle(color: Color(0xffEDEDED)),
        decoration: InputDecoration(
            suffixIcon: suffix,
            prefixIcon: prefix,
            labelText: hintText,
            labelStyle:  const TextStyle(color: Color(0xffEDEDED)),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
            ),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide:  BorderSide(color: ColorHelper.darkColor)
            ),
            fillColor: const Color(0xff444444),
            filled: true
        ),
      ),
    );
  }
}
