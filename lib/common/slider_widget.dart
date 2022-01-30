import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:warranty_track/common/constants.dart';

class SliderWidget extends StatefulWidget {
  final List<String> sliderIma;
  final Function showImagePickerModelSheet;

  const SliderWidget(
      {Key? key,
      required this.sliderIma,
      required this.showImagePickerModelSheet})
      : super(key: key);

  @override
  _SliderWidgetState createState() => _SliderWidgetState();
}

class _SliderWidgetState extends State<SliderWidget> {
  // ignore: unused_field
  late int _current;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return CarouselSlider(
      items: widget.sliderIma.map((i) {
        final int _index =
            widget.sliderIma.indexWhere((element) => element == i);
        return Stack(
          children: [
            Builder(
              builder: (BuildContext context) {
                return Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: getImage(i),
                );
              },
            ),
            Positioned(
              bottom: 10,
              right: 10,
              child: GestureDetector(
                onTap: () {
                  final int _index =
                      widget.sliderIma.indexWhere((element) => element == i);
                  widget.showImagePickerModelSheet(_index);
                },
                child: Container(
                  height: 50,
                  width: 50,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.black38,
                  ),
                  child: const Icon(
                    Icons.edit,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            Positioned(
              top: 10,
              right: 10,
              child: GestureDetector(
                onTap: () {
                  widget.showImagePickerModelSheet(_index);
                },
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  decoration: BoxDecoration(
                    color: Colors.black38,
                    borderRadius: BorderRadius.circular(3),
                  ),
                  child: Text(
                    getImageName(_index),
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      }).toList(),
      options: CarouselOptions(
          height: size.height * 0.35,
          autoPlay: false,
          aspectRatio: 1.0,
          viewportFraction: 1,
          onPageChanged: (index, reason) {
            setState(() {
              _current = index;
            });
          }),
    );
  }

  String getImageName(int index) {
    if (index == 0) {
      return 'Receipt';
    } else if (index == 1) {
      return 'Image';
    } else if (index == 2) {
      return "Seller";
    } else {
      return 'Picture';
    }
  }

  Widget getImage(String url) {
    if (url.contains('http')) {
      return CachedNetworkImage(
        imageUrl: url,
        placeholder: (context, url) => Container(
          color: Colors.black12,
          alignment: Alignment.center,
          child: const CircularProgressIndicator(),
        ),
        errorWidget: (context, url, error) =>
            Image(image: AssetImage(AppImages.noData)),
        fit: BoxFit.cover,
      );
    } else if (url.contains('errerrerr')) {
      return Image(image: AssetImage(AppImages.noData));
    } else {
      return Image.file(
        File(url),
        fit: BoxFit.cover,
      );
    }
  }
}
