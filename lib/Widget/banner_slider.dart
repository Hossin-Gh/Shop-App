import 'package:flutter/material.dart';
import 'package:flutter_application_1/constans/colors.dart';
import 'package:flutter_application_1/data/model/banner.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import 'cached_image.dart';

class BannerSlider extends StatefulWidget {
  final List<Banners> _bannerList;
  const BannerSlider(this._bannerList, {super.key});

  @override
  State<BannerSlider> createState() => _BannerSliderState();
}

class _BannerSliderState extends State<BannerSlider> {
  @override
  Widget build(BuildContext context) {
    var controller = PageController(viewportFraction: 0.9);

    return Stack(
      alignment: AlignmentDirectional.bottomCenter,
      children: [
        SizedBox(
          height: 177,
          child: PageView.builder(
            reverse: true,
            controller: controller,
            itemCount: widget._bannerList.length,
            itemBuilder: ((context, index) {
              return Container(
                margin: const EdgeInsets.symmetric(horizontal: 6),
                child: CachedImageWidget(
                    imageURL: widget._bannerList[index].thumbnail!, radius: 16),
              );
            }),
          ),
        ),
        Positioned(
          bottom: 10,
          child: SmoothPageIndicator(
            textDirection: TextDirection.rtl,
            controller: controller,
            count: 3,
            effect: const ExpandingDotsEffect(
                expansionFactor: 4,
                dotHeight: 6,
                dotWidth: 6,
                dotColor: Colors.white,
                activeDotColor: CustomColor.blue),
          ),
        )
      ],
    );
  }
}
