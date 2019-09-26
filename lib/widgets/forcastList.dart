import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:iweather/store/centralStore.dart';
import 'package:iweather/widgets/forcastListTile.dart';

class ForcastList extends StatelessWidget {
List<String> _days = ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"];

Widget _weatherForecast(BuildContext context){
  final centralState = Provider.of<CentralState>(context);
  dynamic forcast = centralState.forcast["forecast"]["forecastday"];

  if(forcast.length > 6) {
    return Container(
      // height: MediaQuery.of(context).size.height / 2,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          children: <Widget>[
            ForcastListTile(
              day: _days[DateTime.parse(forcast[0]["date"].toString()).weekday - 1], 
              weatherIcon: forcast[0]["day"]["condition"]["icon"], 
              weatherReadings: [forcast[0]["day"]["maxtemp_c"], forcast[0]["day"]["mintemp_c"]]
            ),
            ForcastListTile(
              day: _days[DateTime.parse(forcast[1]["date"].toString()).weekday - 1], 
              weatherIcon: forcast[1]["day"]["condition"]["icon"], 
              weatherReadings: [forcast[1]["day"]["maxtemp_c"], forcast[1]["day"]["mintemp_c"]]
            ),
            ForcastListTile(
              day: _days[DateTime.parse(forcast[2]["date"].toString()).weekday - 1], 
              weatherIcon: forcast[2]["day"]["condition"]["icon"], 
              weatherReadings: [forcast[2]["day"]["maxtemp_c"], forcast[2]["day"]["mintemp_c"]]
            ),
            ForcastListTile(
              day: _days[DateTime.parse(forcast[3]["date"].toString()).weekday - 1], 
              weatherIcon: forcast[3]["day"]["condition"]["icon"], 
              weatherReadings: [forcast[3]["day"]["maxtemp_c"], forcast[3]["day"]["mintemp_c"]]
            ),
            ForcastListTile(
              day: _days[DateTime.parse(forcast[4]["date"].toString()).weekday - 1], 
              weatherIcon: forcast[4]["day"]["condition"]["icon"], 
              weatherReadings: [forcast[4]["day"]["maxtemp_c"], forcast[4]["day"]["mintemp_c"]]
            ),
            ForcastListTile(
              day: _days[DateTime.parse(forcast[5]["date"].toString()).weekday - 1], 
              weatherIcon: forcast[5]["day"]["condition"]["icon"], 
              weatherReadings: [forcast[5]["day"]["maxtemp_c"], forcast[5]["day"]["mintemp_c"]]
            ),
            ForcastListTile(
              day: _days[DateTime.parse(forcast[6]["date"].toString()).weekday - 1], 
              weatherIcon: forcast[6]["day"]["condition"]["icon"], 
              weatherReadings: [forcast[6]["day"]["maxtemp_c"], forcast[6]["day"]["mintemp_c"]]
            ),
          ],
        ),
      ),
      
    );
  
  }

  return SizedBox();
}

  @override
  Widget build(BuildContext context) {
    return _weatherForecast(context);
  }
}