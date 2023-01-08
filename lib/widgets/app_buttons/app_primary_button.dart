import 'package:event_admin/app_configs/app_decorations.dart';
import 'package:flutter/material.dart';
import 'package:event_admin/app_configs/environment.dart';

import '../app_loader.dart';

///
/// Created by Sunil Kumar from Boiler plate
///
class AppPrimaryButton extends StatefulWidget {
  const AppPrimaryButton(
      {required this.child,
      Key? key,
      this.onPressed,
      this.height,
      this.width,
      this.color,
      this.shape,
      this.padding,
      this.radius,
      this.gradient = true,
      this.textStyle})
      : super(key: key);

  final ShapeBorder? shape;
  final Widget child;
  final VoidCallback? onPressed;
  final double? height, width, radius;
  final Color? color;
  final EdgeInsets? padding;
  final TextStyle? textStyle;
  final bool gradient;

  @override
  AppPrimaryButtonState createState() => AppPrimaryButtonState();
}

class AppPrimaryButtonState extends State<AppPrimaryButton> {
  bool _isLoading = false;

  void showLoader() {
    setState(() {
      _isLoading = true;
    });
  }

  void hideLoader() {
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return _isLoading
        ? AppProgress(color: Colors.white)
        : Container(
            clipBehavior: Clip.antiAlias,
            decoration: BoxDecoration(
              color: widget.gradient ? null : Colors.white,
              borderRadius: BorderRadius.circular(12),
              gradient: widget.gradient ? AppDecorations.purpleGrad : null,
            ),
            child: ElevatedButton(
              // style: ButtonStyle(
              //   padding: MaterialStateProperty.all(
              //     widget.padding ??
              //         const EdgeInsets.symmetric(vertical: 14, horizontal: 48),
              //   ),
              //   textStyle: MaterialStateProperty.resolveWith(
              //       (Set<MaterialState> states) {
              //     if (states.contains(MaterialState.disabled))
              //       return TextStyle(color: Colors.grey.shade500);

              //     return TextStyle(color: AppColors.brightPrimary);
              //   }),
              //   foregroundColor: MaterialStateProperty.resolveWith<Color?>(
              //     (Set<MaterialState> states) {
              //       if (states.contains(MaterialState.pressed))
              //         return AppColors.brightPrimary.shade800;
              //       else if (states.contains(MaterialState.disabled))
              //         return Colors.grey.shade500;
              //         return AppColors.brightPrimary;
              //     },
              //   )
              // ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.transparent,
                // elevation: MaterialStateProperty.all(3),
                shadowColor: Colors.transparent,

                primary: theme.primaryColor,
                padding: widget.padding ??
                    const EdgeInsets.symmetric(vertical: 16, horizontal: 48),
                textStyle: widget.textStyle ??
                    TextStyle(
                        fontSize: 16,
                        fontFamily: Environment.fontFamily,
                        letterSpacing: 1.4,
                        color: widget.gradient ? Colors.white : Colors.black,
                        fontWeight: FontWeight.w500),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(widget.radius ?? 10),
                ),
              ),
              onPressed: widget.onPressed,
              child: widget.child,
            ),
          );
  }
}
