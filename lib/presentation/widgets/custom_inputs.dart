import 'package:flutter/material.dart';

import 'custom_text.dart';

class CTextFormField extends StatelessWidget {
  final TextEditingController controller;
  final List<String>? autofillHints;
  final String? Function(String?)? validator;
  final Function()? onChange;
  final String? hintText;
  final String? header;
  final Widget? suffix;

  final int maxLines;
  final TextInputType keyboardType;

  const CTextFormField({
    required this.controller,
    this.autofillHints,
    this.validator,
    this.header,
    this.hintText,
    this.suffix,
    this.onChange,
    this.maxLines = 1,
    super.key,
    this.keyboardType=TextInputType.text,
  });

  @override
  Widget build(BuildContext context) {
    return CInputMaterial(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (header != null)
            Padding(
              padding: const EdgeInsets.fromLTRB(12.0, 10.0, 12.0, 0.0),
              child: CText(
                header!,
                textAlign: TextAlign.start,
                style: const TextStyle(
                  // fontSize: 16,
                ),
              ),
            ),
          Row(
            children: [
              Flexible(
                child: TextFormField(

                  autofillHints: autofillHints,
                  controller: controller,
                  validator: validator,
                  maxLines: maxLines,
                  style: TextStyle(
                    fontSize: 14.0 / MediaQuery.of(context).textScaleFactor,
                  ),
                  decoration: InputDecoration(
                    hintText: hintText,
                    fillColor: Colors.white,
                    contentPadding: const EdgeInsets.all(15.0),
                    enabledBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.transparent),
                      gapPadding: 0,
                    ),
                    focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.transparent),
                      gapPadding: 0,
                    ),

                  ),
                  onChanged: onChange == null ? null : (_) => onChange!(),
                  keyboardType: keyboardType,
                ),
              ),
              if (suffix != null)
                suffix!,
              if (suffix != null)
                const SizedBox(width: 12.0),
            ],
          ),
        ],
      ),
    );
  }
}


class CInputMaterial extends StatelessWidget {
  final Widget child;
  final double? height;
  final double elevation;
  final Color? color;

  final  BorderRadius? borderRadius;
  const CInputMaterial({super.key, required this.child, this.height, this.color, this.borderRadius, this.elevation = 2.0});

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: borderRadius ?? BorderRadius.circular(10.0),
      clipBehavior: Clip.antiAlias,
      color: color ?? Colors.white,
      elevation: elevation,
      child: height == null ? child : SizedBox(
        height: height,
        child: child,
      ),
    );
  }
}
