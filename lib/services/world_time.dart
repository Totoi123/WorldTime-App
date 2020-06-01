import 'package:http/http.dart';
import 'dart:convert';
import 'package:intl/intl.dart';

class WorldTime{

  String location; // location name for the UI
  String time; //the time in that location
  String flag; // url to an asset flag icon
  String url; // this the location url for api endpoints
  bool isDaytime; // true or false if day time or not

  WorldTime({this.location, this.time, this.flag, this.url});

  Future<void> getTime()async{

    try{
      // make request
      Response response = await get('http://worldtimeapi.org/api/timezone/$url');
      Map data = jsonDecode(response.body);
      // print(data);

      // get properties from data

      String datetime = data['datetime'];
      String offsethour = data['utc_offset'].substring(1,3);
      String offsetmin = data['utc_offset'].substring(4,6);
      //print(datetime);
      //print(offsethour);
      //print(offsetmin);

      // create date time object

      DateTime now = DateTime.parse(datetime);
      now = now.add(Duration(hours: int.parse(offsethour), minutes: int.parse(offsetmin)));

      // set the time property
      isDaytime = now.hour > 6 && now.hour < 18 ? true : false;
      time = DateFormat.jm().format(now);



    }
    catch(e){
      print('Caught error: $e');
      time = 'could not get time data';
    }

    }


}

