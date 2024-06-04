import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:marsvpn/themes/colors.dart';
import 'package:touchable_opacity/touchable_opacity.dart';

class VipButton extends StatelessWidget {
  const VipButton({super.key});

  @override
  Widget build(BuildContext context) {
    return TouchableOpacity(
      activeOpacity: 0.8,
      onTap: () {
        Get.toNamed('/vip');
      },
      child: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment(1.00, 0.00),
            end: Alignment(-1, 0),
            colors: [
              CustomColors.goldGradientStart,
              CustomColors.goldGradientEnd,
            ],
          ),
          color: Theme.of(context).colorScheme.secondary,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Center(
          child: Container(
            width: 26,
            height: 20,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(2.0),
            ),
            child: Center(
              child: Text(
                'VIP',
                style: TextStyle(
                    color: Theme.of(context).colorScheme.secondary,
                    fontSize: 12,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
