import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ForcastListTile extends StatelessWidget {
  String day;
  String weatherIcon;
  List weatherReadings;

  ForcastListTile({Key key, 
                @required this.day, 
                @required this. weatherIcon, 
                @required this.weatherReadings}): assert(day != null),
                                                  assert(weatherIcon != null),
                                                  assert(weatherReadings != null),
                                                  super(key: key);
  // Map<String, dynamic> weatherIcons = {
  //   "sunny": Icon(Icons.wb_sunny, color: Colors.yellow.shade600, ),
  //   "raining": Icon(FontAwesomeIcons.cloudRain, color: Colors.grey.shade300, ),
  //   "cloudy": Icon(FontAwesomeIcons.cloud, color: Colors.grey.shade300, ),
  //   "cloudyMoonRainy": Icon(FontAwesomeIcons.cloudMoonRain, color: Colors.grey.shade300, ),
  //   "cloudyMoon": Icon(FontAwesomeIcons.cloudMoon, color: Colors.grey.shade300, ),
  //   "sunnyCloundy": Icon(FontAwesomeIcons.cloudSun, color: Colors.yellow.shade700, ),
  //   "sunnyCloundyRainy": Icon(FontAwesomeIcons.cloudSunRain, color: Colors.yellow.shade600, ),
  //   "night": Icon(FontAwesomeIcons.moon, color: Colors.yellow.shade600, ),
  // };
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Text(day, style: TextStyle(
        fontWeight: FontWeight.bold, 
        color: Colors.black54),),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          SizedBox(),

          SizedBox(
            height: 40,
            child:  CachedNetworkImage(
              imageUrl: "http:\/\/" + weatherIcon.split("\/\/")[1],
            ),
          ),
          Row(
            children: <Widget>[
              Text(weatherReadings[0].toString(), style: TextStyle(
                color: Colors.black54,
              ),),
              Padding(
                padding: EdgeInsets.only(top: 5),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text("o", style: TextStyle(
                      fontSize: 10,
                      // fontWeight: FontWeight.bold,
                      color: Colors.black54,
                    ),),
                    Padding(
                      padding: EdgeInsets.only(top: 20, bottom: 10),
                      child: SizedBox(),
                    )
                  ],
                ),
              ),
              Text(" / ", style: TextStyle(
                color: Colors.black54,
              ),),
              Text(weatherReadings[1].toString(), style: TextStyle(
                color: Colors.black54,
              ),),
              Padding(
                padding: EdgeInsets.only(top: 5),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text("o", style: TextStyle(
                      fontSize: 10,
                      // fontWeight: FontWeight.bold,
                      color: Colors.black54,
                    ),),
                    Padding(
                      padding: EdgeInsets.only(top: 5, bottom: 10),
                      child: Text("C", style: TextStyle(
                          fontSize: 12,
                          color: Colors.black54,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ],
      ) 
    );
  }
}