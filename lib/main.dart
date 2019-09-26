import 'dart:async';
import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:provider/provider.dart';
import 'package:iweather/widgets/forcast.dart';
import 'package:iweather/widgets/forcastList.dart';
import 'package:iweather/store/centralStore.dart';
import 'package:geolocator/geolocator.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
        ChangeNotifierProvider(builder: (_) => CentralState()),
      ],
      child: MaterialApp(
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: MaterialApp(
          home: MyHomePage(),
        ),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  dynamic centralState;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  StreamSubscription<Position> positionStream;
  PersistentBottomSheetController controller;
  var _hour = new DateTime.now().hour;
  Color _dayColor = Color.fromRGBO(185, 186, 255, 1);
  Color _nightColor = Color.fromRGBO(34, 35, 79, 1);

  @override
  void initState() {
    super.initState();

    startTimeout();
  }

  @override
  void dispose(){
    positionStream.cancel();

    super.dispose();
  }

  void handleTimeout() async {
   centralState = Provider.of<CentralState>(context);

    //populate the seaarch prediction dropdown
    centralState.loadCities();

    // var _location = new Location();

    // GeolocationStatus geolocationStatus  = await Geolocator().checkGeolocationPermissionStatus();
    // var currentLocation;

    // if(geolocationStatus == GeolocationStatus.granted){
    //   currentLocation = await Location().getLocation();

    //   // List<Placemark> placemark = await Geolocator().placemarkFromCoordinates(currentLocation.latitude, currentLocation.longitude);
    //   // print(placemark[0].subLocality);

    // }


    // Position position = await Geolocator().getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    // print(position);
    centralState.getForcast("Abuja");


    //get phone geolocation
    // var geolocator = Geolocator();
    // var locationOptions = LocationOptions(accuracy: LocationAccuracy.high, timeInterval: 1);

      // geolocator.getPositionStream(locationOptions).listen(
      //   (Position position) async{
      //     print("lllllllllllslskddjjdjddjdnddb");
      //       // print(position == null ? 'Unknown' : position.latitude.toString() + ', ' + position.longitude.toString());
      //       // List<Placemark> placemark = await Geolocator().placemarkFromCoordinates(52.2165157, 6.9437819);
      //       // print(placemark[0].subLocality);
      //   });
  }


  startTimeout() async {
    var duration = const Duration(seconds: 5);
    return new Timer(duration, handleTimeout);
  }

  void _closeBottomSheet() {
    if (controller != null) {
      controller.close();
      controller = null;
    }
  }

  void _openBottomSheet(){
     controller = _scaffoldKey.currentState.showBottomSheet((context) => _bottomSheet(context));
  }

  @override
  Widget build(BuildContext context) {
    centralState = Provider.of<CentralState>(context);

    return Scaffold(
      key: _scaffoldKey,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            (centralState.forcast != null && centralState.forcast["current"] != null) ? Forcast(openSettings: _openBottomSheet, hour: _hour) : SizedBox(),
            (centralState.forcast != null && centralState.forcast["forecast"]["forecastday"] != null) ? ForcastList() : SizedBox(),
          ],
        ),
      )
    );
  }

  Widget _bottomSheet(BuildContext context){
    return Container(
      decoration: new BoxDecoration(
        color: new Color.fromRGBO(0, 0, 0, 0.3) // Specifies the background color and the opacity
      ),
      height:MediaQuery.of(context).size.height,
      child: Padding(
        padding: EdgeInsets.only(top: 150),
        child: Column(
            children: <Widget>[
              Container(
                width: double.infinity,
                height: 60,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: (_hour > 6 ) ? (_hour < 20) ? _dayColor : _nightColor : _nightColor,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(12.0),
                    topRight: Radius.circular(12.0),
                  ),
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.0),
                  child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text("Settings", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
                    InkWell(
                      onTap: (){
                      _closeBottomSheet();
                      },
                      child: Icon(Icons.close, color: Colors.redAccent,),
                    ),
                  ],
                ),
                )
              ),
            
            Container(
              height: MediaQuery.of(context).size.height - 210,
              color: Colors.white,
              child: SingleChildScrollView(
                child: Container(
                  height: 900,
                  child: ListView(
                    children: ListTile.divideTiles(
                        context: context,
                        tiles: [
                      ListTile(
                        leading: Icon(Icons.notifications_active),
                        title: Text("Notification"),
                        subtitle: Text("Send Notification", style: TextStyle(fontSize: 12.0),),
                        // trailing: Switch(
                        //     value: settingsState.notification,
                        //     onChanged: (bool newValue){
                        //       settingsState.notification = newValue;
                        // }),
                      ),
                      ListTile(
                        leading: Icon(Icons.location_on),
                        title: Text("Default Location"),
                        onTap: (){
                          
                        },
                      ),
                      ListTile(
                        leading: Icon(Icons.question_answer),
                        title: Text("Rating"),
                        onTap: (){
                        },
                      ),
                    ]).toList(),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
