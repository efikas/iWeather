import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:iweather/store/centralStore.dart';
import 'package:iweather/widgets/searchCard.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Forcast extends StatelessWidget {
  var _hour = new DateTime.now().hour;

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

    
    return Stack(
        children: <Widget>[
          Container(
            height: (MediaQuery.of(context).size.height / 2) + 70,
            child: ClipPath(
              child: Container(
                decoration: new BoxDecoration(
                    gradient: new LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        ...(){
                          return (_hour > 6 ) ? (_hour < 20) ? _day : _night : _night;
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
                  return (_hour > 6 ) 
                      ? (_hour < 20) ? Image.asset("assets/images/sunny.png", height: 120,) 
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
                    Text("20", style: TextStyle(
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
                Text("Karachi", style: TextStyle(
                  fontSize: 30,
                  color: Colors.white,
                ),),
                Text("Clear", style: TextStyle(
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
              onPressed: (){},
              child: Icon(Icons.arrow_forward_ios),
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