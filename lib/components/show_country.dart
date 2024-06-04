import 'package:flutter/material.dart';
import 'package:flag/flag.dart';
import 'package:marsvpn/components/server_detail.dart';
import '../utils/utils.dart';

class ShowCountry extends StatelessWidget {
  const ShowCountry(
      {super.key,
      required this.isoCode,
      this.locationNum,
      this.ping,
      this.city,
      this.tunnelled = false});
  final String isoCode;
  final int? locationNum;
  final int? ping;
  final String? city;
  final bool tunnelled;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Flag.fromString(
            isoCode,
            flagSize: FlagSize.size_4x3,
            height: 32,
            width: 50,
            borderRadius: 10,
          ),
          SizedBox(
            width: 10,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                getCountryName(isoCode),
                style: Theme.of(context).textTheme.titleMedium,
              ),
              SizedBox(height: 8),
              (locationNum != null)
                  ? Text('$locationNum Locations',
                      style: Theme.of(context).textTheme.bodySmall)
                  : ServerDetail(ping: ping, city: city, tunnelled:tunnelled),
            ],
          )
        ],
      ),
    );
  }
}
