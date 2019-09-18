import 'package:flutter/material.dart';
import 'package:iweather/widgets/forcastListTile.dart';

class ForcastList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height / 2,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          children: <Widget>[
            ForcastListTile(day: "Mon", weatherStatus: 'sunny', weatherReadings: [26, 12]),
            ForcastListTile(day: "Tue", weatherStatus: 'night', weatherReadings: [27, 11]),
            ForcastListTile(day: "Wed", weatherStatus: 'sunnyCloundy', weatherReadings: [26, 14]),
            ForcastListTile(day: "Thu", weatherStatus: 'cloudyMoon', weatherReadings: [23, 12]),
            ForcastListTile(day: "Fri", weatherStatus: 'raining', weatherReadings: [15, 9]),
          ],
        ),
      ),
      
    );
  }
}