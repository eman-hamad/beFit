import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:location/location.dart';
import 'home.dart';
import 'map.dart';

class Login extends StatefulWidget {
  static String routeName = "/Login";

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  var _formKey = GlobalKey<FormState>();

  void _submit() {
    final isValid = _formKey.currentState.validate();
    if (!isValid) {
      return;
    }
    _formKey.currentState.save();
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Home()),
    );
  }

  @override
  initState() {
    super.initState();
    getCurrentUserLocation();
  }

  double userLongitude;
  double userLatitude;

  getCurrentUserLocation() async {
    dynamic currentLocation = LocationData;

    var error;

    var location = new Location();

    try {
      currentLocation = await location.getLocation();
      userLatitude = currentLocation.latitude;
      userLongitude = currentLocation.longitude;
      print(userLongitude);
      print(userLatitude);
    } on PlatformException catch (e) {
      if (e.code == 'PERMISSION_DENIED') {
        error = 'Permission denied';
      }
      currentLocation = null;
    }
  }

  var ispressed = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text("Login"),
        backgroundColor: Colors.indigo.shade900,
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              Image.asset(
                'asset/login.png',
                width: 1600,
                height: 160,
              ),
              SizedBox(
                height: MediaQuery.of(context).size.width * 0.1,
              ),
              TextFormField(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                decoration: InputDecoration(
                    contentPadding: EdgeInsets.only(top: 20),
                    border: InputBorder.none,
                    prefixIcon: Padding(
                      padding: EdgeInsets.only(top: 14),
                      child: Icon(
                        Icons.email,
                        color: Colors.grey,
                      ),
                    ),
                    hintText: 'E-Mail',
                    hintStyle: TextStyle(fontSize: 18.0, color: Colors.grey)),
                keyboardType: TextInputType.emailAddress,
                onFieldSubmitted: (value) {},
                validator: (value) {
                  if (value.isEmpty) {
                    return 'This field is required';
                  }
                  if (!value.contains('@')) {
                    return " valid email should contain '@'";
                  }
                  if (!RegExp(
                    r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
                  ).hasMatch(value)) {
                    return "Please enter a valid email";
                  }
                  return null;
                },
              ),
              SizedBox(
                height: MediaQuery.of(context).size.width * 0.03,
              ),
              TextFormField(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                decoration: InputDecoration(
                    contentPadding: EdgeInsets.only(top: 20),
                    border: InputBorder.none,
                    prefixIcon: Padding(
                      padding: EdgeInsets.only(top: 14),
                      child: Icon(
                        Icons.lock,
                        color: Colors.grey,
                      ),
                    ),
                    hintText: 'Password',
                    hintStyle: TextStyle(fontSize: 18.0, color: Colors.grey)),
                maxLength: 10,
                keyboardType: TextInputType.text,
                onFieldSubmitted: (value) {},
                obscureText: true,
                validator: (value) {
                  if (value.isEmpty) {
                    return 'This field is required';
                  }
                  if (value.length < 5) {
                    return 'Password should have at least 5 characters';
                  }

                  return null;
                },
              ),
              TextFormField(
                readOnly: true,

                autovalidateMode: AutovalidateMode.onUserInteraction,
                decoration: InputDecoration(
                    contentPadding: EdgeInsets.only(top: 20),
                    border: InputBorder.none,
                    prefixIcon: Padding(
                      padding: EdgeInsets.only(top: 14),
                      child: GestureDetector(
                        onTap: getCurrentUserLocation,
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Mapscreen(
                                        latitude: userLatitude,
                                        longitude: userLongitude)));

                            setState(() {
                              ispressed = true;
                            });
                          },
                          child: Icon(
                            // onPressed: () => {
                            //   Navigator.push(
                            //       context,
                            //       MaterialPageRoute(
                            //           builder: (context) => Mapscreen(
                            //               latitude: userLatitude,
                            //               longitude: userLongitude))),
                            //   setState(() {
                            //     ispressed = true;
                            //   }),
                            // },
                            Icons.location_on,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                    ),
                    hintText: 'Location',
                    hintStyle: TextStyle(fontSize: 18.0, color: Colors.grey)),

                keyboardType: TextInputType.streetAddress,
                onFieldSubmitted: (value) {
                  //Validator
                },
                // validator: (ispressed) {

                //   if (ispressed != true) {
                //     return 'use Gps to take a valid location !';
                //   }
                //   return null;
                // },
              ),
              Padding(
                padding: const EdgeInsets.all(14.0),
                child: Container(
                  // padding: EdgeInsets.only(bottom:102),
                  width: 150,

                  child: FloatingActionButton(
                    onPressed: () => {
                      _submit(),
                    },
                    child: Text("Login",
                        style: TextStyle(color: Colors.white, fontSize: 20)),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30)),
                    backgroundColor: Colors.indigo.shade900,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
