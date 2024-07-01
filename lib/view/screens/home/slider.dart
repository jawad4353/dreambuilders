import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../utilis/app_colors.dart';

class ImageSlider extends StatefulWidget {
  const ImageSlider({super.key});

  @override
  _ImageSliderState createState() => _ImageSliderState();
}

class _ImageSliderState extends State<ImageSlider> {
  List<String> imageUrls = [];
  int currentIndex = 0;
  late PageController _pageController;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    fetchImageUrls();
  }

  void fetchImageUrls() async {
    final FirebaseStorage storage = FirebaseStorage.instance;
    List<String> urls = [];

    try {
      final ListResult result = await storage.ref('home').listAll();
      for (Reference ref in result.items) {
        String imageUrl = await ref.getDownloadURL();
        urls.add(imageUrl);
      }
      setState(() {
        imageUrls = urls;
        isLoading = false;
      });
      startSlider();
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      print('Error fetching image URLs: $e');
    }
  }

  void startSlider() {
    Future.delayed(const Duration(seconds: 5)).then((_) {
      if (mounted && imageUrls.isNotEmpty) {
        setState(() {
          currentIndex = (currentIndex + 1) % imageUrls.length;
        });
        _pageController.animateToPage(
          currentIndex,
          duration: const Duration(milliseconds: 500),
          curve: Curves.ease,
        );
        startSlider();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:   AppColors.white,
      body: Center(
        child: isLoading
            ? const Center(child: CircularProgressIndicator())
            : imageUrls.isEmpty
            ? const Center(child: Text('No images available'))
            : PageView.builder(
                      controller: _pageController,
                      itemCount: imageUrls.length,
                      itemBuilder: (context, index) {
            return Column(
              children: [
                Container(
                  height: 1.sh*0.22,
                  width: 1.sw*0.9,
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(
                    color:AppColors.primary,
                    borderRadius: BorderRadius.circular(8)
                  ),
                  child: Opacity(
                    opacity: 0.5,
                    child: Image.network(
                      imageUrls[index],
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Container(
                  height: 30.h,
                    child: buildDots(index)),
              ],
            );
                      },
                    ),
      ),
    );
  }
  Widget buildDots(_currentPage) {
    return SizedBox(
      height: 30.h,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(
          3, // Replace with the actual number of images
              (index) => Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              width: 10,
              height: 10,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: _currentPage == index ? AppColors.primary: AppColors.greyB2AFAF,
              ),
            ),
          ),
        ),
      ),
    );
  }
  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
}
