import 'package:flutter/material.dart';
import 'package:marsvpn/components/appbar_button.dart';
import 'package:marsvpn/components/custom_app_bar.dart';
import 'package:marsvpn/components/main_view.dart';
import 'package:marsvpn/components/public_icon.dart';
import 'package:marsvpn/controllers/home_controller.dart';
import 'package:get/get.dart';
import 'package:marsvpn/themes/colors.dart';
import 'package:touchable_opacity/touchable_opacity.dart';

class Share extends StatelessWidget {
  Share({super.key});
  final homeController = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: Text('Share'),
        leading: AppBarButton(
          semanticLabel: 'Back Button',
          svgSrc: 'assets/icons/arrow-back.svg',
          onTap: () {
            Get.back();
          },
          isLeftIcon: true,
          svgWidth: 10,
          svgHeight: 16,
        ),
      ),
      body: MainView(
        child: Column(
          children: [
            Header(),
            SizedBox(
              height: 20,
            ),
            Expanded(
                child: ListView(
              children: [ShareIcons()],
            ))
          ],
        ),
      ),
    );
  }
}

class Header extends StatelessWidget {
  const Header({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          PublicIcon(
            svgSrc: 'assets/icons/filled-share.svg',
            svgWidth: 30,
            svgHeight: 35,
          ),
          SizedBox(
            height: 16,
          ),
          SizedBox(
            width: 216,
            child: Text(
              'Tell your friends about our fantastic app',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headlineSmall,
            ),
          ),
        ],
      ),
    );
  }
}

class ShareIcons extends StatelessWidget {
  const ShareIcons({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: 100,
      child: Wrap(
        direction: Axis.horizontal,
        alignment: WrapAlignment.center,
        runAlignment: WrapAlignment.spaceBetween,
        spacing: 18, // Horizontal spacing between icons
        runSpacing: 18, // Vertical spacing between icons
        children: [
          ShareIcon(
            pngSrc: 'assets/icons/instagram.png',
            label: 'Instagram',
          ),
          ShareIcon(
            pngSrc: 'assets/icons/telegram.png',
            label: 'Telegram',
          ),
          ShareIcon(
            pngSrc: 'assets/icons/whatsapp.png',
            label: 'Whatsapp',
          ),
          ShareIcon(
            pngSrc: 'assets/icons/facebook.png',
            label: 'Facebook',
          ),
          ShareIcon(
            pngSrc: 'assets/icons/messages-android.png',
            label: 'Messages',
          ),
          ShareIcon(
            pngSrc: 'assets/icons/twitter.png',
            label: 'X.com',
          ),
        ],
      ),
    );
  }
}

class ShareIcon extends StatelessWidget {
  const ShareIcon({
    super.key,
    required this.pngSrc,
    required this.label,
  });
  final String pngSrc;
  final String label;

  @override
  Widget build(BuildContext context) {
    return TouchableOpacity(
      activeOpacity: 0.85,
      onTap: () {
        print('hello');
      },
      child: Container(
        height: 133,
        width: 133,
        padding: EdgeInsets.symmetric(vertical: 10),
        decoration: ShapeDecoration(
          color: CustomColors.background80,
          shape: RoundedRectangleBorder(
            side: BorderSide(width: 2, color: CustomColors.background60),
            borderRadius: BorderRadius.circular(16),
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                pngSrc,
                width: 48,
                height: 48,
              ),
              SizedBox(
                height: 12,
              ),
              Text(
                label,
                style: Theme.of(context).textTheme.titleSmall,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
