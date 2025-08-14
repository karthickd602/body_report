// import 'package:flutter/material.dart';
// import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
// import 'package:iconsax/iconsax.dart';
// import 'package:s_store/features/personalization/controllers/user_controller.dart';
//
// import '../../../utils/constants/colors.dart';
// import '../../../utils/constants/image_strings.dart';
// import '../images/t_circular_image.dart';
// import '../loaders/shimmers/shimmer.dart';
//
// class TUserProfileTile extends StatelessWidget {
//   const TUserProfileTile({
//     super.key, required this.onPressed,
//   });
//
//   final VoidCallback onPressed;
//   @override
//   Widget build(BuildContext context) {
//     final controller = UserController.instance;
//     final userdetails = controller.user.value;
//     return ListTile(
//       leading:  Obx(
//         (){
//             final networkImage = controller.user.value.profilePicture;
//             final image = networkImage.isNotEmpty?networkImage:TImages.user;
//
//             return controller.imageUploading.value?const TShimmerEffect(width: 50, height: 50,radius: 50):TCircularImage(image:image,width: 50,height: 50,isNetworkImage: networkImage.isNotEmpty,);
//           }
//       ),
//       title: Text(
//         userdetails.fullname,
//         style: Theme.of(context)
//             .textTheme
//             .headlineSmall
//             ?.apply(color: TColors.white),
//       ),
//       subtitle: Text(
//         userdetails.email,
//         style: Theme.of(context).textTheme.bodyMedium?.apply(color: TColors.white),
//       ),
//       trailing: IconButton(
//         onPressed: onPressed,
//         icon: const Icon(
//           Iconsax.edit,
//           color: TColors.white,
//         ),
//       ),
//     );
//   }
// }
