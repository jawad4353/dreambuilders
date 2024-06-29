import 'dart:typed_data';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dreambuilders/view/screens/profile/view_picture.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import '../../../network_config/firebase_service.dart';
import '../../../utilis/app_colors.dart';
import '../../../utilis/app_constants.dart';
import '../../../utilis/app_images.dart';
import '../../../utilis/app_routes.dart';
import '../../../utilis/app_text_styles.dart';
import '../../../utilis/string_formatting.dart';
import '../../../view_model/profile_bloc/profile_bloc.dart';
import '../../widgets/custom_appbar.dart';


class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);
  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {

   final picker = ImagePicker();
  String ? imageUrl;
  String ? version ;

  @override
  void initState() {
    super.initState();
    context.read<ProfileBloc>().add(const ProfileLoadEvent());
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.white,
        appBar: PreferredSize(
            preferredSize: Size.fromHeight(56.0.h),
            child: myAppBar(title: AppConstants.profile, context: context, shouldPop: false))
       ,
        body:  RefreshIndicator(
          onRefresh: () async {
            context.read<ProfileBloc>().add(const ProfileLoadEvent());
          },
          child: Stack(
            children: [
              BlocBuilder<ProfileBloc,ProfileStates>(
                builder: (context,state) {
                  if(state is ProfileInitialState){
                    return Center(child:  CircularProgressIndicator(color: AppColors.primary,));
                  }
                  if(state is ProfileLoadedState){
                    return  _body(
                      imageUrl:state.myModel.imageUrl ,
                        name: state.myModel.name, designation: state.myModel.designation,
                        userId: state.myModel.uid, registrationDate:state.myModel.registrationDate, email:state.myModel.email);
                  }
                  if(state is ProfileErrorState){
                    EasyLoading.showInfo('Something went wrong');
                    return   _body( imageUrl:'noimage',name: '_', designation: '_', userId: '_', registrationDate: '_', email: '_');
                  }
                  return const SizedBox();
                }
              ),
            ],
          ),
        )
    );
  }


  Widget _body({required String imageUrl,required String name,required String designation,required String userId,required String registrationDate,required String email,}){
    return SingleChildScrollView(
      physics: const AlwaysScrollableScrollPhysics(),
      child: Padding(
        padding:  EdgeInsets.symmetric(horizontal:1.sw>500 ? 1.sw*0.12:1.sw*0.05),
        child: Column(
          children: [
            SizedBox(height: 15.h,),
            _userImage(imageUrl: imageUrl),
            SizedBox(height: 10.h,),
            Padding(
              padding:  EdgeInsets.symmetric(horizontal: 45.h),
              child: Text(StringFormatting.capitalizeAfterSpace(name), style: AppTextStyles.robotoMedium(color: AppColors.grey0E0F10, fontSize: 18.sp, weight: FontWeight.w400),),
            ),
            SizedBox(height: 1.h,),

            Padding(
              padding:  EdgeInsets.symmetric(horizontal: 0.2.sw),
              child: Text(StringFormatting.capitalizeAfterSpace(designation), style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w800, color: AppColors.black191B32),),
            ),
            SizedBox(height: 20.h,),
            _detailBox(email: email, userId: userId, registrationDate: StringFormatting.formatRegistrationDate(date: registrationDate))
          ],
        ),
      ),
    );
  }


  Widget _userImage({required String imageUrl}){
    return Center(
      child: Stack(
        children: [
          InkWell(
            onTap: (){
              Navigator.push(context, MyRoute(ViewPicture(imageUrl:imageUrl)));
            },
            child: Container(
              height: 155.h,
              width: 155.h,
              decoration: BoxDecoration(
                  border: Border.all(color: AppColors.primary.withOpacity(0.1), width: 5),
                  shape: BoxShape.circle
              ),
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: AppColors.primary.withOpacity(0.3), width: 6),
                  shape: BoxShape.circle,
                ),

                child: Container(
                  decoration: BoxDecoration(
                      border: Border.all(color: AppColors.primary, width: 6),
                      shape: BoxShape.circle,
                      image:imageUrl!='noimage' ?  DecorationImage(image:CachedNetworkImageProvider(imageUrl,)  , fit: BoxFit.cover)
                          : DecorationImage(image: Image.asset(AppImages.imgLogo).image, fit: BoxFit.cover)
                  ),
                ),
              ),
            ),
          ),
          Positioned(
              bottom: 0.0,
              right: 5.w,
              child: GestureDetector(
                  onTap: (){
                    _uploadProfilePicture();
                  },
                  child: const Icon(Icons.edit)))
        ],
      ),
    );
  }

  Widget _detailBox({required String userId,required String registrationDate,required String email,}){
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 15.w),
      padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: AppColors.primary.withOpacity(0.1)
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _titleValue(title: AppConstants.userID, value: userId),
          SizedBox(height: 15.h,),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 5.w),
            child: Divider(height: 3.h, color: AppColors.grey0E0F10.withOpacity(0.2),thickness: 1.5),
          ),
          SizedBox(height: 15.h,),
          _titleValue(title:AppConstants.email, value: email ),
          SizedBox(height: 15.h,),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 5.w),
            child: Divider(height: 3.h, color:  AppColors.grey0E0F10.withOpacity(0.2),thickness: 1.5),
          ),
          SizedBox(height: 15.h,),
          _titleValue(title: AppConstants.registrationDate, value: registrationDate),
          SizedBox(height: 15.h,),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 5.w),
            child: Divider(height: 3.h, color:  AppColors.grey0E0F10.withOpacity(0.2),thickness: 1.5),
          ),

        ],
      ),
    );
  }


  Widget _titleValue({title, value}){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: AppTextStyles.robotoMedium(color: AppColors.black191B32, fontSize: 16.sp, weight: FontWeight.w500)),
        SizedBox(height: 7.h,),
        Text(value, style:AppTextStyles.robotoMedium(color: AppColors.primary, fontSize: 15.sp, weight: FontWeight.w500)),
      ],
    );
  }


  _uploadProfilePicture() async {
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);
    if(pickedImage!=null){
      Uint8List bytes=await pickedImage.readAsBytes();
      bool uploaded=await FirebaseAuthService.uploadPictureBytes(bytes,pickedImage.mimeType);
      if(uploaded){
        context.read<ProfileBloc>().add(const ProfileLoadEvent());
      }
    }
  }

}



