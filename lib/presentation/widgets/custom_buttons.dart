import 'package:flutter/material.dart';
import 'package:task/constants/app_colors.dart';

import 'custom_text.dart';

class CSizedButton extends StatelessWidget {
  final String text;
  final double? textSize;
  final EdgeInsets contentPadding;
  final double marginH;
  final double marginV;
  final Color? color;
  final Color? textColor;
  final double? width;
  final double? height;
  final double? imageWidth;
  final double? imageHeight;
  final double? circularRadius;
  final String? leadingImage;
  final IconData? leadingIcon;
  final String? trailingImage;
  final IconData? trailingIcon;
  final void Function()? onPressed;

  const CSizedButton({
    super.key,
    required this.text,
    this.textSize,
    this.contentPadding = EdgeInsets.zero,
    this.marginH = 0.0,
    this.marginV = 0.0,
    this.onPressed,
    this.width,
    this.height,
    this.color,
    this.textColor,
    this.leadingImage,
    this.trailingImage,
    this.leadingIcon,
    this.trailingIcon,
    this.imageWidth,
    this.imageHeight,
    this.circularRadius,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      margin: EdgeInsets.symmetric(horizontal: marginH, vertical: marginV),
      child: Material(
        borderRadius: BorderRadius.circular(circularRadius??10),
        clipBehavior: Clip.antiAlias,
        color: color ?? Theme.of(context).primaryColor,
        elevation: 2,
        child: InkWell(
          onTap: onPressed,
          child: Container(
            height: height,
            width: width,
            constraints: BoxConstraints(minHeight: height??50),
            // width: 100,
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (trailingImage != null || leadingImage != null || leadingIcon != null || trailingIcon != null)
                  SizedBox(
                    height: imageHeight ?? 30,
                    width: imageWidth ?? 30,
                    child: Column(
                      children: [
                        if (leadingImage != null)
                          Image.asset(leadingImage!, fit: BoxFit.fill),
                        if (leadingIcon != null)
                          Icon(leadingIcon!),
                        if (leadingImage == null && trailingImage != null)
                          Image.asset(trailingImage!, fit: BoxFit.fill, color: Colors.transparent,),
                        if (leadingIcon == null && trailingIcon != null)
                          Icon(trailingIcon!, color: Colors.transparent),
                      ],
                    ),
                  ),
                if (trailingImage != null || leadingImage != null || leadingIcon != null || trailingIcon != null)
                  const SizedBox(width: 10.0),
                Flexible(
                  child: Padding(
                    padding: contentPadding,
                    child: CText(
                      text,
                      maxLines: 2,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: textColor ?? Colors.white,
                        overflow: TextOverflow.ellipsis,
                        fontSize: textSize??20,
                      ),
                    ),
                  ),
                ),
                if (trailingImage != null || leadingImage != null || leadingIcon != null || trailingIcon != null)
                  const SizedBox(width: 10.0),
                if (trailingImage != null || leadingImage != null || leadingIcon != null || trailingIcon != null)
                  SizedBox(
                    height: imageHeight ?? 30,
                    width: imageWidth ?? 30,
                    child: Column(
                      children: [
                        if (trailingImage != null)
                          Image.asset(trailingImage!, fit: BoxFit.fill),
                        if (trailingIcon != null)
                          Icon(trailingIcon!),
                        if (trailingImage == null && leadingImage != null)
                          Image.asset(leadingImage!, fit: BoxFit.fill, color: Colors.transparent,),
                        if (trailingIcon == null && leadingIcon != null)
                          Icon(leadingIcon!, color: Colors.transparent),
                      ],
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}