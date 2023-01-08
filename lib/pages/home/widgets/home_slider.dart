import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:event_admin/widgets/my_image.dart';

///
/// Created by Auro on 18/01/22 at 9:43 pm
///

class HomeSlider extends StatelessWidget {
  const HomeSlider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<String> banners = [
      'https://i.pinimg.com/originals/b9/27/1b/b9271b8356c0e07fac2126e25dfe4343.jpg',
      'https://png.pngtree.com/thumb_back/fh260/background/20190223/ourmid/pngtree-female-doctor-minimalist-medical-background-structure-image_66164.jpg',
      'https://image.shutterstock.com/image-photo/smiling-multiethnic-doctors-nurses-using-260nw-1873888222.jpg',
      'https://i.pinimg.com/originals/37/35/48/3735481ab7c60abd7c800a4e150f08c4.jpg',
      'https://i.pinimg.com/originals/80/9c/44/809c44c528b340bcb26e302d2466569e.jpg',
    ];
    return CarouselSlider.builder(
        itemCount: banners.length,
        itemBuilder: (context, index, realindex) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
            child: PhysicalModel(
              elevation: 5,
              color: Color(0xffE5E5E5),
              borderRadius: BorderRadius.circular(5),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(5),
                child: MyImage(
                  banners[index],
                  fit: BoxFit.cover,
                ),
              ),
            ),
          );
        },
        options: CarouselOptions(
          aspectRatio: 16 / 9,
          autoPlay: true,
          height: 165,
          viewportFraction: 0.9,
        ));
  }
}
