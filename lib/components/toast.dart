import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:marsvpn/themes/colors.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class FailureMessage extends StatelessWidget {
  const FailureMessage({super.key, required this.text});
  final String text;

  @override
  Widget build(BuildContext context) {
    final failedSvg = SvgPicture.asset(
      'assets/icons/failed.svg',
      width: 50,
      height: 50,
      colorFilter: ColorFilter.mode(
        Colors.redAccent,
        BlendMode.srcIn,
      ),
    );

    return Container(
      width: 160,
      height: 160,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.0),
        color: CustomColors.background80,
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            failedSvg,
            SizedBox(height: 10),
            Text(
              text,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Colors.redAccent,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}

class SuccessMessage extends StatelessWidget {
  const SuccessMessage({super.key, required this.text});
  final String text;

  @override
  Widget build(BuildContext context) {
    final acceptSvg = SvgPicture.asset(
      'assets/icons/accept.svg',
      width: 50,
      height: 50,
      colorFilter: ColorFilter.mode(
        Colors.greenAccent,
        BlendMode.srcIn,
      ),
    );

    return Container(
      width: 160,
      height: 160,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.0),
        color: CustomColors.background80,
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            acceptSvg,
            SizedBox(height: 10),
            Text(
              text,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Colors.greenAccent,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}

class NoInternetConnectionMessage extends StatelessWidget {
  const NoInternetConnectionMessage({super.key, required text});

  @override
  Widget build(BuildContext context) {
    final noInternetSvg = SvgPicture.asset(
      'assets/icons/no-wifi.svg',
      width: 65,
      height: 65,
      colorFilter: ColorFilter.mode(
        Colors.orangeAccent,
        BlendMode.srcIn,
      ),
    );

    return Container(
      width: 160,
      height: 160,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.0),
        color: CustomColors.background80,
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            noInternetSvg,
            SizedBox(height: 5),
            Text(
              'No Internet\nConnection',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Colors.orangeAccent,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}

class LoadingMessage extends StatefulWidget {
  final String text;

  const LoadingMessage({super.key, this.text = ''});

  @override
  LoadingMessageState createState() => LoadingMessageState();
}

class LoadingMessageState extends State<LoadingMessage>
    with TickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 160,
      height: 160,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.0),
        color: Colors.grey[800], // Replace with your custom color
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SpinKitSquareCircle(
              color: CustomColors.typography,
              size: 50.0,
              controller: _controller,
            ),
            SizedBox(height: 20),
            Text(
              widget.text,
              style: TextStyle(color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}

void showToast(String text, String mode, FToast fToast) async {
  if (mode == "success") {
    fToast.showToast(
      child: SuccessMessage(
        text: text,
      ),
      toastDuration: Duration(seconds: 2),
      gravity: ToastGravity.CENTER,
    );
  } else if (mode == "failure") {
    fToast.showToast(
      child: FailureMessage(
        text: text,
      ),
      toastDuration: Duration(seconds: 2),
      gravity: ToastGravity.CENTER,
    );
  } else if (mode == "noInternet") {
    fToast.showToast(
      child: NoInternetConnectionMessage(
        text: text,
      ),
      toastDuration: Duration(seconds: 4),
      gravity: ToastGravity.CENTER,
    );
  } else if (mode == 'loading') {
    fToast.showToast(
      child: LoadingMessage(
        text: text,
      ),
      toastDuration: Duration(seconds: 60),
      gravity: ToastGravity.CENTER,
    );
  }
}
