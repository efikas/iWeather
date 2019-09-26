import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:iweather/store/centralStore.dart';
import 'package:iweather/widgets/searchCard.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Forcast extends StatelessWidget {
  Function openSettings;
  var hour;

  Forcast({Key key, @required this.openSettings, @required this.hour}):super(key:key);

  List<Color> _day = [
    Color.fromRGBO(133, 140, 253, 1),
    Color.fromRGBO(169, 167, 249, 1),
    Color.fromRGBO(220, 221, 252, 1),
    Colors.blue[50],
  ];
  List<Color> _night = [
    Color.fromRGBO(34, 35, 79, 1),
    Color.fromRGBO(34, 35, 79, 1),
    Color.fromRGBO(34, 35, 79, 1),
    Color.fromRGBO(85, 87, 144, 1),
    // Color.fromRGBO(73, 73, 128, 1),
    // Color.fromRGBO(73, 73, 128, 1),
  ];


  @override
  Widget build(BuildContext context) {
    final centralState = Provider.of<CentralState>(context);
    Map<String, dynamic> forcast = centralState.forcast;

    
    return Stack(
        children: <Widget>[
          Container(
            height: (MediaQuery.of(context).size.height / 2) + 100,
            child: ClipPath(
              child: Container(
                decoration: new BoxDecoration(
                    gradient: new LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        ...(){
                          return (hour > 6 ) ? (hour < 20) ? _day : _night : _night;
                        }()
                      ]
                    ),
                  ),
              ),
              clipper: InvertedCircleClipper(),
            ),
          ),
          Positioned(
            top: 40,
            child: SearchCard(),
          ),
          Positioned(
            right: 40,
            top: 100,
            child: (){
                  return (hour > 6 ) 
                      ? (hour < 20) ? Image.asset("assets/images/sunny.png", height: 120,) 
                        : Icon(FontAwesomeIcons.moon, color: Colors.yellow.shade700, size: 100,) 
                          : Icon(FontAwesomeIcons.moon, color: Colors.yellow.shade700, size: 100,);
                }()
          ),
          Positioned(
            left: 30,
            top: 170,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(forcast["current"]["temp_c"].toInt().toString(), style: TextStyle(
                      fontSize: 90,
                      color: Colors.white,
                    ),),
                    Padding(
                      padding: EdgeInsets.only(top: 10),
                      child: Row(
                        children: <Widget>[
                          Text("o", style: TextStyle(
                            fontSize: 12,
                            // fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),),
                          Padding(
                            padding: EdgeInsets.only(top: 10),
                            child: Text("C", style: TextStyle(
                                fontSize: 20,
                                color: Colors.white,
                              ),
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
                Text(forcast["location"]["name"], style: TextStyle(
                  fontSize: 30,
                  color: Colors.white,
                ),),
                Text(forcast["current"]["condition"]["text"], style: TextStyle(
                  fontSize: 15,
                  color: Colors.white,
                ),)
              ],
            ),
          ),




          Positioned(
            right: 40,
            top: (MediaQuery.of(context).size.height / 2),
            child: FloatingActionButton(
              backgroundColor: Color.fromRGBO(185, 186, 255, 1),
              onPressed: (){
                openSettings();
              },
              child: Icon(Icons.settings),
            ),
          ),

        ],
      );
  }
}

class InvertedCircleClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    return new Path()
      ..addOval(new Rect.fromCircle(
          center: new Offset((size.width / 2) + 50,  - (size.width - 70)),
          radius: size.width * 2));
      // ..addRect(new Rect.fromLTWH(0.0, 0.0, size.width, size.height))
      // ..fillType = PathFillType.evenOdd;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}