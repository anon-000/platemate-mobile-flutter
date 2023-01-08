import 'package:event_admin/app_configs/app_decorations.dart';
import 'package:flutter/material.dart';

///
/// Created by Auro on 16/10/22 at 1:46 PM
///

class VendorDetailsType extends StatelessWidget {
  final int? type;
  final Function(int v)? onChanged;

  const VendorDetailsType({Key? key, this.type, this.onChanged})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Row(
        children: ([1, 2, 3])
            .map(
              (e) => Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: InkWell(
                    onTap: () {
                      onChanged!.call(e);
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 12,
                      ),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: type == e
                            ? Colors.white
                            : Colors.grey.shade200.withOpacity(0.18),
                        gradient: type == e ? AppDecorations.purpleGrad : null,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Text(
                        "${e == 1 ? "Overview" : e == 2 ? "Packages" : "Reviews"}",
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 13,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}
