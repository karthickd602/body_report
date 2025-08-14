
import '../../../utils/helpers/path_provider.dart';


class TTabBar extends StatelessWidget implements PreferredSizeWidget{
  const TTabBar({
    super.key, required this.tabs,
  });

final List<Widget> tabs;
  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);

    return Material(
      color: dark?TColors.black:TColors.white,
      child: TabBar(
          isScrollable: true,
          indicatorColor: TColors.primary,
          labelColor: dark? TColors.white:TColors.black,
          unselectedLabelColor: TColors.darkGrey,
          tabs:tabs

      ),
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(TDeviceUtils.getAppBarHeight());
}
