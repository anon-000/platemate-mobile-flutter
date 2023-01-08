import 'package:flutter/material.dart';

///
/// Created by Auro on 18/10/22 at 5:19 PM
///

class EventPropertyCard extends StatelessWidget {
  final String asset;
  final String title;
  final VoidCallback? onTap;

  const EventPropertyCard(
      {Key? key, this.asset = '', this.title = '', this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 140,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          color: Colors.grey.shade200.withOpacity(0.18),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          children: [
            Expanded(
              // child: SvgPicture.asset(asset),
              child: Image.asset(asset),
            ),
            const SizedBox(height: 5),
            Text(
              "$title",
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 13,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
