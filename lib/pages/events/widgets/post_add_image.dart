import 'package:event_admin/app_configs/app_colors.dart';
import 'package:event_admin/widgets/dotted_border.dart';
import 'package:flutter/material.dart';

///
/// Created by Auro on 18/10/22 at 8:15 PM
///

class ImageAddSection extends StatelessWidget {
  final VoidCallback? onAdd;
  final Function(int i)? onRemove;
  final List<dynamic> imageList;

  ImageAddSection(this.imageList, {this.onAdd, this.onRemove});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GridView.builder(
          padding: const EdgeInsets.only(bottom: 4, top: 4),
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: imageList.length + 1,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4,
            childAspectRatio: 0.8,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
          ),
          itemBuilder: (BuildContext context, int index) {
            if (index == imageList.length) {
              return InkWell(
                borderRadius: BorderRadius.circular(5),
                onTap: onAdd,
                child: Center(
                  child: Container(
                    clipBehavior: Clip.antiAlias,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade200.withOpacity(0.18),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    // height: 70,
                    width: double.infinity,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.add,
                          color: Colors.grey.shade200.withOpacity(0.5),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          "Add Photos",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 10,
                            color: Colors.grey.shade200.withOpacity(0.5),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            } else {
              return Container(
                clipBehavior: Clip.antiAlias,
                child: Stack(
                  children: [
                    Positioned.fill(
                      child: imageList[index] is String
                          ? Image.network(
                              imageList[index],
                              fit: BoxFit.cover,
                            )
                          : Image.file(
                              imageList[index],
                              fit: BoxFit.cover,
                            ),
                    ),
                    Positioned(
                      right: 6,
                      top: 5,
                      child: InkWell(
                        onTap: () {
                          onRemove!.call(index);
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Icon(
                            Icons.close,
                            size: 20,
                            color: AppColors.grey,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                ),
              );
            }
          },
        ),
      ],
    );
  }
}
