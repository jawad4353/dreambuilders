import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../utilis/app_constants.dart';
import '../../widgets/custom_appbar.dart';


class ViewPicture extends StatelessWidget {
  final String imageUrl;
  const ViewPicture({super.key, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(56.h),
          child: myAppBar(title: AppConstants.profilePicture, context: context,shouldPop: true)),
   body: InteractiveViewer(
       maxScale: 3,
       minScale: 0.5,
       child: CachedNetworkImage(imageUrl: imageUrl,)),

    );
  }
}
