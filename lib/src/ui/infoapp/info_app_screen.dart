import 'package:flutter/material.dart';
import 'package:get_version/get_version.dart';
import 'package:flutter/services.dart';

class InfoAppScreen extends StatefulWidget {
  @override
  _InfoAppScreenState createState() => _InfoAppScreenState();
}

class _InfoAppScreenState extends State<InfoAppScreen> {
  String versionName = "1.0.1";

  @override
  void initState() {
    getVersionApp();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ListView(
            children: <Widget>[
              Image.asset(
                "assets/images/img_logo_512.png",
                width: 72.0,
                height: 72.0,
              ),
              Padding(
                padding: EdgeInsets.only(
                  top: 4.0,
                ),
              ),
              SizedBox(
                width: double.infinity,
                child: Text(
                  "Food Recipe",
                  textAlign: TextAlign.center,
                  style: Theme
                      .of(context)
                      .textTheme
                      .title,
                ),
              ),
              Center(
                child: Text(
                  versionName,
                  style: Theme
                      .of(context)
                      .textTheme
                      .subtitle,
                ),
              ),
              SizedBox(
                width: double.infinity,
                child: Text(
                  "Aplikasi yang menyajikan informasi resep makanan dari seluruh dunia",
                  textAlign: TextAlign.center,
                  style: Theme
                      .of(context)
                      .textTheme
                      .subtitle,
                ),
              ),
              Padding(padding: EdgeInsets.only(top: 16.0)),
              Container(
                width: double.infinity,
                height: 1.0,
                color: Colors.grey,
              ),
              Padding(padding: EdgeInsets.only(top: 16.0)),
              Text(
                "Developer",
                style: Theme
                    .of(context)
                    .textTheme
                    .headline,
                textAlign: TextAlign.center,
              ),
              Padding(padding: EdgeInsets.only(top: 8.0)),
              Center(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(900.0),
                  child: Container(
                    width: 128.0,
                    height: 128.0,
                    child: Image.asset("assets/images/img_yudi_setiawan.jpeg"),
                  ),
                ),
              ),
              Padding(padding: EdgeInsets.only(top: 8.0)),
              Center(
                child: Text(
                  "Yudi Setiawan",
                  style: Theme
                      .of(context)
                      .textTheme
                      .headline
                      .merge(
                    TextStyle(fontSize: 20.0),
                  ),
                ),
              ),
              Center(
                child: Text(
                  "Software Developer\n specialize in Android development",
                  textAlign: TextAlign.center,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 20.0),
              ),
              Text(
                "API Service",
                style: Theme
                    .of(context)
                    .textTheme
                    .headline,
                textAlign: TextAlign.center,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Center(
                  child: Image.asset("assets/images/img_logo_themealdb.png"),
                ),
              ),
              Center(
                child: Text(
                  "An open source database of Recipes from around the world",
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  getVersionApp() async {
      try {
        versionName = await GetVersion.projectVersion;
        setState(() {});
      } on PlatformException {
        versionName = "1.0.1";
      }
  }
}
