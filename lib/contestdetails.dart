import 'dart:math';
import 'package:add_2_calendar/add_2_calendar.dart';
import 'package:flutter/material.dart';
import './constant.dart';
import 'dart:core';
import 'package:url_launcher/url_launcher.dart';
import 'package:intl/intl.dart';
import 'package:add_2_calendar/add_2_calendar.dart';

class ContestDetail extends StatelessWidget {
  Color customwhite = const Color.fromARGB(255, 237, 237, 237);
  String? name;
  String? urll;
  String? start_time;
  String? end_time;
  String? duration;
  String? site;
  String? in_24_hours;
  String? status;
  ContestDetail({
    this.name,
    this.urll,
    this.start_time,
    this.end_time,
    this.duration,
    this.site,
    this.in_24_hours,
    this.status,
  });

  // const ContestDetail({super.key});

  @override
  Widget build(BuildContext context) {
    String ampm;
    String stime = start_time.toString().substring(11, 16);

    int hrr = int.parse(stime.substring(0, 2));
    int finalhrr = hrr + 5;
    // print(finalhrr);
    int minn = int.parse(stime.substring(3, 5));
    minn += 30;
    //print(minn);
    if (minn >= 60) {
      int qt = minn ~/ 60;
      int fmin = minn - 60;
      finalhrr += qt;
      minn = fmin;
    }
    if (finalhrr <= 12 || finalhrr == 24) {
      ampm = "AM";
    } else {
      ampm = "PM";
    }
    String codecheftimes = "";
    String finalsttime = "";
    String finalendtime = "";
    if (site == "CodeChef") {
      // finalsttime = start_time.toString().substring(0, 11);
      // finalendtime = end_time.toString().substring(0, 11);
      String tf = start_time.toString().substring(0, 11) +
          "T" +
          start_time.toString().substring(11, 19) +
          ".000Z";

      start_time = tf.replaceAll(" ", "");
      String tfend = end_time.toString().substring(0, 11) +
          "T" +
          end_time.toString().substring(11, 19) +
          ".000Z";

      end_time = tfend.replaceAll(" ", "");
      finalsttime = start_time.toString().substring(0, 10);
      finalendtime = end_time.toString().substring(0, 10);
    } else {
      finalsttime = start_time.toString().substring(0, 10);
      finalendtime = end_time.toString().substring(0, 10);
    }

    //String eventstart=finalsttime.toString().

    String durrr = duration.toString();
    double days = double.parse(durrr);
    double finda = days / 86400.0;
    int finaldays = finda.toInt();
    int pkkafinalday;
    if (finaldays == 0) {
      pkkafinalday = 1;
    } else {
      pkkafinalday = finaldays;
    }
    String imp;
    bool sttt;
    String checkst;
    if (status == "CODING") {
      checkst = "Ongoing";
      sttt = true;
    } else {
      checkst = "Upcoming";
      sttt = false;
    }
    bool lee = false;
    if (site == "LeetCode") {
      lee = true;
    }
    String xx = duration.toString();
    double dd = double.parse(xx) / 86400.0;
    var finalday = dd.toInt();
    // var dd = int.parse(duration);
    if (site == "LeetCode") {
      imp = "assets/leet.png";
    } else if (site == "CodeChef") {
      imp = "assets/code.png";
    } else if (site == "CodeForces" || site == "CodeForces::Gym") {
      imp = "assets/forces.png";
    } else if (site == "TopCoder") {
      imp = "assets/top.png";
    } else if (site == "AtCoder") {
      imp = "assets/atcoder.png";
    } else if (site == "CS Academy") {
      imp = "assets/cs.png";
    } else if (site == "HackerRank") {
      imp = "assets/rank.png";
    } else if (site == "HackerEarth") {
      imp = "assets/earth.png";
    } else if (site == "Toph") {
      imp = "assets/topph.png";
    } else {
      imp = "assets/kick.png";
    }
    return Scaffold(
        body: Center(
      child: Container(
        padding: EdgeInsets.only(top: 5),
        width: 300,
        height: 530,
        decoration: BoxDecoration(
          //    color: Colors.purpleAccent[100],
          color: customwhite,
          borderRadius: BorderRadius.circular(20.0),
          boxShadow: const [
            BoxShadow(
              blurRadius: 4.0,
              offset: Offset(-4, -4),
              color: Colors.white38,
            ),
            BoxShadow(
              blurRadius: 3.0,
              offset: Offset(8, 8),
              color: Colors.black12,
            ),
          ],
        ),
        child: Expanded(
          child: Column(
            //mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CircleAvatar(
                backgroundImage: AssetImage(imp),
                radius: 40,
                backgroundColor: lee ? Colors.black : Colors.transparent,
              ),
              SizedBox(
                height: 8,
              ),
              Text(
                "$site",
                style: TextStyle(
                  fontSize: 25,
                  fontFamily: "fnn",
                  fontWeight: FontWeight.bold,
                  color: Colors.redAccent,
                ),
              ),
              SizedBox(
                height: 8,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Center(
                  child: Text(
                    "$name ",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 13,
                      fontFamily: "fnn",
                      fontWeight: FontWeight.bold,
                      color: Colors.indigoAccent,
                    ),
                    //style: kSubheadingextStyle,
                  ),
                ),
              ),
              SizedBox(
                height: 8,
              ),
              Text(
                "Start Date: " + finalsttime,
                style: kSubheadingextStyle,
              ),
              SizedBox(
                height: 8,
              ),
              Text(
                "End Date: " + finalendtime,
                style: kSubheadingextStyle,
              ),
              SizedBox(
                height: 8,
              ),
              Text(
                // "time" + minn.toString(),
                "Duration: " + pkkafinalday.toString() + " days",
                style: kSubheadingextStyle,
              ),
              SizedBox(
                height: 8,
              ),
              Text(
                "Status: " + checkst,
                style: TextStyle(
                  fontFamily: "fnn",
                  fontSize: 14,
                  color: sttt ? Colors.greenAccent : Colors.redAccent,
                  height: 2,
                ),
                // style: kSubheadingextStyle,
              ),
              SizedBox(
                height: 8,
              ),
              GestureDetector(
                onTap: _launchURL,
                child: Container(
                  width: 200,
                  height: 40,
                  decoration: BoxDecoration(
                    //    color: Colors.purpleAccent[100],
                    color: Colors.redAccent[100],
                    borderRadius: BorderRadius.circular(20.0),
                    boxShadow: const [
                      BoxShadow(
                        blurRadius: 4.0,
                        offset: Offset(-4, -4),
                        color: Colors.white38,
                      ),
                      BoxShadow(
                        blurRadius: 3.0,
                        offset: Offset(8, 8),
                        color: Colors.black12,
                      ),
                    ],
                  ),
                  child: Center(
                    child: Text(
                      "Go To Contest",
                      style: TextStyle(
                        fontFamily: "fnn",
                        fontSize: 15,
                        color: Colors.deepPurpleAccent[200],
                        height: 2,
                      ),
                      //style: kSubheadingextStyle,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 8,
              ),
              GestureDetector(
                onTap: null,
                child: Container(
                  width: 200,
                  height: 40,
                  decoration: BoxDecoration(
                    //    color: Colors.purpleAccent[100],
                    color: Colors.deepPurple,
                    borderRadius: BorderRadius.circular(20.0),
                    boxShadow: const [
                      BoxShadow(
                        blurRadius: 4.0,
                        offset: Offset(-4, -4),
                        color: Colors.white38,
                      ),
                      BoxShadow(
                        blurRadius: 3.0,
                        offset: Offset(8, 8),
                        color: Colors.black12,
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.timer,
                        size: 17,
                        color: Colors.white,
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Center(
                        child: Text(
                          "Starting at: " +
                              finalhrr.toString() +
                              ":" +
                              minn.toString() +
                              " $ampm",
                          style: TextStyle(
                            fontFamily: "fnn",
                            fontSize: 13,
                            color: Colors.white,
                            height: 2,
                          ),
                          //style: kSubheadingextStyle,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 8,
              ),
              GestureDetector(
                onTap: () {
                  
                    final Event event = Event(
                      title: name.toString(),
                      description: site.toString(),
                      location: 'Online',
                      startDate:
                          DateTime.parse(start_time.toString()).toLocal(),
                      endDate: DateTime.parse(end_time.toString()).toLocal(),
                      androidParams: AndroidParams(
                        emailInvites: [
                          "sarafayush130@gmail.com"
                        ], // on Android, you can add invite emails to your event.
                      ),
                    );
                    Add2Calendar.addEvent2Cal(
                      event,
                    );
                  
            
                },
                child: Container(
                  width: 200,
                  height: 40,
                  decoration: BoxDecoration(
                    //    color: Colors.purpleAccent[100],
                    color: customwhite,
                    borderRadius: BorderRadius.circular(20.0),
                    boxShadow: const [
                      BoxShadow(
                        blurRadius: 4.0,
                        offset: Offset(-4, -4),
                        color: Colors.white38,
                      ),
                      BoxShadow(
                        blurRadius: 3.0,
                        offset: Offset(8, 8),
                        color: Colors.black12,
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.calendar_today_outlined,
                        size: 17,
                        color: Colors.redAccent,
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Center(
                        child: Text(
                          "Set Reminder",
                          style: TextStyle(
                            fontFamily: "fnn",
                            fontSize: 14,
                            color: Colors.black,
                            height: 2,
                          ),
                          //style: kSubheadingextStyle,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    ));
  }

  _launchURL() async {
    String url = urll.toString();
    var uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      throw 'Could not launch $url';
    }
  }
}
