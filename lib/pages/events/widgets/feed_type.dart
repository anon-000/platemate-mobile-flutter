import 'package:event_admin/app_configs/app_decorations.dart';
import 'package:flutter/material.dart';

///
/// Created by Auro on 16/10/22 at 1:46 PM
///

class FeedType extends StatelessWidget {
  final bool me;
  final int? type;
  final Function(int v)? onChanged;

  const FeedType({Key? key, this.type, this.onChanged, this.me = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: (me ? [1, 2, 3] : [1, 2])
          .map(
            (e) => Expanded(
              flex: e == 3 ? 5 : 4,
              child: Padding(
                padding: EdgeInsets.only(right: e == 3 ? 0 : 10),
                child: InkWell(
                  onTap: () {
                    onChanged!.call(e);
                  },
                  child: Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 12,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      gradient: type == e ? AppDecorations.purpleGrad : null,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      "${e == 1 ? "Posts" : e == 2 ? "Photos" : "Write a Post"}",
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 13,
                        color: type == e ? Colors.white : Colors.black,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          )
          .toList(),
      // spacing: 16,
      // runSpacing: 16,
    );
  }
}
