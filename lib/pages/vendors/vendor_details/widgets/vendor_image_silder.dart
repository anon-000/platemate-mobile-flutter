import 'package:carousel_slider/carousel_slider.dart';
import 'package:event_admin/widgets/my_image.dart';
import 'package:flutter/material.dart';

///
/// Created by Auro on 07/11/22 at 1:07 AM
///

class VendorImageSlider extends StatelessWidget {
  final List<String> data;
  const VendorImageSlider(this.data, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // List<String> banners = [
    //   'https://i.pinimg.com/originals/b9/27/1b/b9271b8356c0e07fac2126e25dfe4343.jpg',
    //   'https://png.pngtree.com/thumb_back/fh260/background/20190223/ourmid/pngtree-female-doctor-minimalist-medical-background-structure-image_66164.jpg',
    //   'https://image.shutterstock.com/image-photo/smiling-multiethnic-doctors-nurses-using-260nw-1873888222.jpg',
    //   'https://i.pinimg.com/originals/37/35/48/3735481ab7c60abd7c800a4e150f08c4.jpg',
    //   'https://i.pinimg.com/originals/80/9c/44/809c44c528b340bcb26e302d2466569e.jpg',
    // ];
    return CarouselSlider.builder(
        itemCount: data.length,
        itemBuilder: (context, index, realindex) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
            child: PhysicalModel(
              elevation: 5,
              color: Color(0xffE5E5E5),
              borderRadius: BorderRadius.circular(15),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: MyImage(
                  data[index],
                  fit: BoxFit.cover,
                ),
              ),
            ),
          );
        },
        options: CarouselOptions(
          aspectRatio: 16 / 10,
          autoPlay: true,
          height: 200,
          viewportFraction: 0.45,
        ));
  }
}
