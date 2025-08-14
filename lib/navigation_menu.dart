import 'package:curved_labeled_navigation_bar/curved_navigation_bar.dart';
import 'package:curved_labeled_navigation_bar/curved_navigation_bar_item.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import 'features/dashboard/dashboard_page.dart';
import 'features/profile/profile_page.dart';
import 'utils/constants/path_provider.dart';


class NavigationMenu extends StatelessWidget {
  const NavigationMenu({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(NavigationController());
    final darkMode = THelperFunctions.isDarkMode(context);
    return Scaffold(
      bottomNavigationBar: Obx(
        () => CurvedNavigationBar(
            // height: 80.0,
            index: controller.selectedIndex.value,

            // elevation: 0,
            // selectedIndex: controller.selectedIndex.value,
            backgroundColor: darkMode ? TColors.black : TColors.white,
            buttonBackgroundColor: TColors.primary,
            animationCurve: Curves.easeInOut,
            animationDuration: const Duration(milliseconds: 600),
            color:
                darkMode ? TColors.primary.withOpacity(0.1) : TColors.primary,
            onTap: (index) {
              controller.selectedIndex.value = index;
            },
            items: const [
              CurvedNavigationBarItem(
                  child: Icon(
                    Iconsax.home,
                    color: Colors.white,
                  ),
                  label: 'Home',
                  labelStyle: TextStyle(color: Colors.white)),

              CurvedNavigationBarItem(
                  child: Icon(
                    Iconsax.user,
                    color: Colors.white,
                  ),
                  label: 'Profile',
                  labelStyle: TextStyle(color: Colors.white)),
            ]),
      ),
      body: Obx(() => controller.screens[controller.selectedIndex.value]),
    );
  }
}

class NavigationController extends GetxController {
  final Rx<int> selectedIndex = 0.obs;

  final screens = [
    DashboardPage(),
    ProfilePage(),
    // const HomeScreen(),
    // const StoreScreen(),
    // const FavoriteScreen(),
    // const SettingScreen(),
  ];
}
