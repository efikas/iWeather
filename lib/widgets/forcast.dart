import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:iweather/store/centralStore.dart';
import 'package:autocomplete_textfield/autocomplete_textfield.dart';

class Forcast extends StatelessWidget {
  TextStyle myStyle = TextStyle(fontFamily: 'Montserrat', fontSize: 15.0);

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String _search;
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
    Color _fieldColor = (_hour < 20) ? Color.fromRGBO(34, 35, 79, 1) : Color.fromRGBO(133, 140, 253, 1);
    final centralState = Provider.of<CentralState>(context);

    final searchTextField = AutoCompleteTextField<String>(
        style: myStyle.copyWith(
          color: _fieldColor
        ),

        keyboardType: TextInputType.text,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: 'Search',
          labelStyle: TextStyle(color: _fieldColor),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(4.0),
            borderSide: new BorderSide(color: Colors.white),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(4)),
            borderSide: BorderSide(width: 1,color: Colors.white),
          ),
          disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(4)),
            borderSide: BorderSide(width: 1,color: Colors.grey),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(4)),
            borderSide: BorderSide(width: 1,color: Colors.white),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(4)),
            borderSide: BorderSide(width: 1,color: Colors.red)
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(4)),
            borderSide: BorderSide(width: 1,color: Colors.redAccent)
          ),
      ),
      suggestions: centralState.cities,
      itemSubmitted: (item) {
        centralState.cityName = item;
      },
      itemSorter: (a, b) {
          return a.compareTo(b);
        },
        itemFilter: (item, query) {
          return item.toLowerCase()
              .startsWith(query.toLowerCase());
        },

      itemBuilder: (context, item) {
        return ListTile(
            title: Text(item,
            style: TextStyle(
              fontSize: 16.0
            ),
          ),
        );
      },
      submitOnSuggestionTap: true,
      clearOnSubmit: false,
      textChanged: (item) {
      },
    );

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
                          return (_hour < 20) ? _day : _night;
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
            child: Container(
              height: 60,
              width: MediaQuery.of(context).size.width,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Card(
                  color: Colors.white,
                  child: Form(
                    key: _formKey,
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 0, vertical: 4),
                      child: searchTextField,
                    ),
                  )
                ),
              )
            ),
          ),
          Positioned(
            right: 40,
            top: 100,
            child: Image.asset("assets/images/sunny.png", height: 120,),
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