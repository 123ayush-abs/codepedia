import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:info_popup/info_popup.dart';
import 'package:http/http.dart' as http;
import './constant.dart';
import './contestdetails.dart';
class Contets {
  final String? name;
  final String? urll;
  final String? start_time;
  final String? end_time;
  final String? duration;
  final String? site;
  final String? in_24_hours;
  final String? status;
  Contets({
    this.name,
    this.urll,
    this.start_time,
    this.end_time,
    this.duration,
    this.site,
    this.in_24_hours,
    this.status,
  });
}

class Apii extends StatefulWidget {
  @override
  State<Apii> createState() => _ApiiState();
}

class _ApiiState extends State<Apii> {
  // EVENT ADD KRNE K LOGIC
  String finalword2 = "";
  String searchedplatform = "";
  Color customwhite = const Color.fromARGB(255, 237, 237, 237);
  Future<List<Contets>> getRequest() async {
    String url = "https://kontests.net/api/v1/all";
    final response = await http.get(Uri.parse(url));
    var responseData = json.decode(response.body);
    var rdd = responseData as List<dynamic>;
    // var currentstatusdata = [];
    var currentstatusdata = [];
    String finalword = finalword2.replaceAll(" ", "");
    if (finalword.isNotEmpty && finalword.toLowerCase() == "hackerrank") {
      rdd.forEach((element) {
        if (element["site"] == "HackerRank") currentstatusdata.add(element);
      });
    } else if (finalword.isNotEmpty &&
        finalword.toLowerCase() == "hackerearth") {
      rdd.forEach((element) {
        if (element["site"] == "HackerEarth") currentstatusdata.add(element);
      });
    } else if (finalword.isNotEmpty && finalword.toLowerCase() == "leetcode") {
      rdd.forEach((element) {
        if (element["site"] == "LeetCode") currentstatusdata.add(element);
      });
    } else if (finalword.isNotEmpty && finalword.toLowerCase() == "codechef") {
      rdd.forEach((element) {
        if (element["site"] == "CodeChef") currentstatusdata.add(element);
      });
    } else if (finalword.isNotEmpty &&
        finalword.toLowerCase() == "codeforces") {
      rdd.forEach((element) {
        if (element["site"] == "CodeForces") currentstatusdata.add(element);
      });
    } else if (finalword.isNotEmpty && finalword.toLowerCase() == "atcoder") {
      rdd.forEach((element) {
        if (element["site"] == "AtCoder") currentstatusdata.add(element);
      });
    } else if (finalword.isNotEmpty && finalword.toLowerCase() == "kickstart") {
      rdd.forEach((element) {
        if (element["site"] == "Kick Start") currentstatusdata.add(element);
      });
    } else {
      rdd.forEach((element) {
        currentstatusdata.add(element);
      });
    }
    List<Contets> contest = [];
    for (var i = 1; i < currentstatusdata.length; ++i) {
      Contets user = Contets(
          name: currentstatusdata[i]["name"],
          urll: currentstatusdata[i]["url"],
          start_time: currentstatusdata[i]["start_time"],
          end_time: currentstatusdata[i]["end_time"],
          duration: currentstatusdata[i]["duration"],
          site: currentstatusdata[i]["site"],
          in_24_hours: currentstatusdata[i]["in_24_hours"],
          status: currentstatusdata[i]["status"]);

      // image_link: responseData["data"][i]["image_link"]);
      contest.add(user);
    }

    return contest;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(left: 20, top: 50, right: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CircleAvatar(
                  backgroundColor: Colors.transparent,
                  child: Image.asset(
                    'assets/gamer.png',
                    // height: 40,
                  ),
                  radius: 40.0,
                ),
                SizedBox(
                  width: 20,
                ),
                InfoPopupWidget(
                  contentTitle:
                      "Web app to showcase various contest of coding platforms!!",
                  arrowTheme: InfoPopupArrowTheme(
                    color: Colors.pink,
                    arrowDirection: ArrowDirection.up,
                  ),
                  contentTheme: InfoPopupContentTheme(
                    infoContainerBackgroundColor: Colors.black,
                    infoTextStyle: TextStyle(color: Colors.white),
                    contentPadding: const EdgeInsets.all(8),
                    contentBorderRadius: BorderRadius.all(Radius.circular(10)),
                    infoTextAlign: TextAlign.center,
                  ),
                  child: Icon(
                    Icons.info,
                    size: 20,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
            Text("Hey Buddy,", style: kHeadingextStyle),
            // SizedBox(height: 20),

            Text("Find all contest here", style: kSubheadingextStyle),
            SizedBox(
              height: 6,
            ),
            TextField(
              textAlign: TextAlign.center,
              onChanged: (value) => searchedplatform = value,
              cursorColor: Colors.indigo,
              decoration: InputDecoration(
                filled: true,
                fillColor: customwhite,
                contentPadding:
                    EdgeInsets.symmetric(vertical: 15.0, horizontal: 15),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide(width: 0.8),
                ),
                hintText: "Search platform(e.g.HackerRank)",
                hintStyle: TextStyle(
                  fontFamily: "fnn",
                  fontSize: 10,
                ),
                suffixIcon: GestureDetector(
                  onTap: () {
                    setState(() {
                      finalword2 = searchedplatform;
                    });
                    // finalword = searchedplatform;
                  },
                  child: Icon(
                    Icons.search,
                    size: 25,
                    color: Colors.green,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 6,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "All Contest",
                  style: TextStyle(
                    fontFamily: 'fnn',
                    fontSize: 20,
                    // color: Colors.red,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),

            Expanded(
              child: Container(
                padding: EdgeInsets.all(16.0),
                child: FutureBuilder(
                  future: getRequest(),
                  builder: (BuildContext ctx, AsyncSnapshot snapshot) {
                    if (snapshot.data == null) {
                      return Container(
                        child: Center(
                          child: CircularProgressIndicator(),
                        ),
                      );
                    } else {
                      return Expanded(
                        child: ListView.builder(
                            //physics: ClampingScrollPhysics(),
                            physics: BouncingScrollPhysics(),
                            itemCount: snapshot.data.length,
                            itemBuilder: (ctx, index) {
                              var dur =
                                  double.parse(snapshot.data[index].duration);
                              var fdur = dur ~/ 60.0;
                              var tempstatus = snapshot.data[index].status;
                              String? resstatus;
                              if (tempstatus == "BEFORE") {
                                resstatus = "Upcoming";
                              } else {
                                resstatus = "Ongoing";
                              }
                              var upcome = snapshot.data[index].in_24_hours;
                              bool? check1;
                              if (upcome == "Yes") {
                                check1 = true;
                              } else {
                                check1 = false;
                              }
                              return Container(
                                // width: double.infinity,
                                // height: double.infinity,
                                margin: EdgeInsets.all(12),
                                padding: EdgeInsets.only(top: 30, bottom: 30),
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
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    ListTile(
                                      title: Text(
                                        snapshot.data[index].name,
                                        style: TextStyle(
                                          fontSize: 16.0,
                                          fontFamily: 'fnn',
                                        ),
                                      ),
                                      subtitle: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          Text(
                                            "Platform : " +
                                                snapshot.data[index].site,
                                            style: TextStyle(
                                              fontSize: 15,
                                              fontFamily: 'fnn',
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          Text(
                                            "Start Time : " +
                                                snapshot.data[index].start_time
                                                    .toString()
                                                    .substring(0, 10),
                                            style: TextStyle(
                                              fontSize: 14.0,
                                              fontFamily: 'fnn',
                                            ),
                                          ),
                                          Text(
                                            "End Time : " +
                                                snapshot.data[index].end_time
                                                    .toString()
                                                    .substring(0, 10),
                                            style: TextStyle(
                                              fontSize: 14.0,
                                              fontFamily: 'fnn',
                                            ),
                                          ),
                                          Text(
                                            "Status : " + resstatus,
                                            style: TextStyle(
                                              fontSize: 14.0,
                                              fontFamily: 'fnn',
                                            ),
                                          ),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          if (check1)
                                            Center(
                                              child: Container(
                                                width: 200,
                                                padding: EdgeInsets.only(
                                                    top: 10, bottom: 10),
                                                decoration: BoxDecoration(
                                                  color: Colors.redAccent[200],
                                                  //color: Colors.orangeAccent[200],
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          27.0),
                                                  boxShadow: const [
                                                    BoxShadow(
                                                      blurRadius: 4.0,
                                                      offset: Offset(-4, -4),
                                                      color: Colors.white30,
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
                                                    "Within 24 Hours!!",
                                                    style: TextStyle(
                                                      fontSize: 15,
                                                      fontFamily: 'fnn',
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          SizedBox(
                                            height: 8,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: [
                                              CircleAvatar(
                                                backgroundColor:
                                                    Colors.transparent,
                                                radius: 20,
                                                backgroundImage: AssetImage(
                                                  "assets/arrow.png",
                                                ),
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                      onTap: () {
                                        var namm = snapshot.data[index].name;
                                        var ul = snapshot.data[index].urll;
                                        var st =
                                            snapshot.data[index].start_time;
                                        var et = snapshot.data[index].end_time;
                                        var dur = snapshot.data[index].duration;
                                        var ste = snapshot.data[index].site;
                                        var in24 =
                                            snapshot.data[index].in_24_hours;
                                        var stas = snapshot.data[index].status;

                                        Navigator.of(context).push(
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    ContestDetail(
                                                      name: namm,
                                                      urll: ul,
                                                      start_time: st,
                                                      end_time: et,
                                                      duration: dur,
                                                      site: ste,
                                                      in_24_hours: in24,
                                                      status: stas,
                                                    )));
                                      },
                                    ),
                                  ],
                                ),
                              );
                            }),
                      );
                    }
                    // else
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
