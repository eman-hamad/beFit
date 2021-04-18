import 'package:befit_app/UI/Login.dart';
import 'package:befit_app/size_config.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// import 'package:geolocator/geolocator.dart';
import 'package:location/location.dart';

// import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'map.dart';
import 'home.dart';

class Register extends StatefulWidget {
  static String routeName = "/Register";

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  var _formKey = GlobalKey<FormState>();
bool _success ;
  var emailvalue ;
  var passwordvalue ;
  Future<void> _auth() async{
 FirebaseAuth.instance.createUserWithEmailAndPassword(email: emailvalue, password: passwordvalue);
       try {
  UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
    email: emailvalue,
    password: passwordvalue
  );
} on FirebaseAuthException catch (e) {
  
  if (e.code == 'weak-password') {
    
     
    print('The password provided is too weak.');
  } else if (e.code == 'email-already-in-use') {
    print('The account already exists for that email.');
    // Scaffold.of(context).showSnackBar(const SnackBar(
    //   content: Text("The account already exists for that email.")
    // ));
   setState(() {
      _success=false;
   });
   
   
    
   
  }
} catch (e) {
  print(e);
      
}



  }



  Future<void> _submit() async {
    final isValid = _formKey.currentState.validate();
    if (!isValid ) {
      return ;
    }
   

    //  FirebaseAuth.instance.createUserWithEmailAndPassword(
    //    email: emailvalue, password: passwordvalue);
//        try {
//   UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
//     email: emailvalue,
//     password: passwordvalue
//   );
// } on FirebaseAuthException catch (e) {
//   if (e.code == 'weak-password') {
//     print('The password provided is too weak.');
//   } else if (e.code == 'email-already-in-use') {
//     print('The account already exists for that email.');
//   }
// } catch (e) {
//   print(e);
// }


    // _formKey.currentState.save();
    _auth();
    
    // if(!_success){
    //   return;
    // }
    
    
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
        title: Text("Register"),
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
                'asset/register.png',
                width: 100,
                height: 100,
              ),

              //styling
              SizedBox(
                height: getProportionateScreenWidth(context, 0.03),
              ),
              TextFormField(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                decoration: InputDecoration(
                    //  contentPadding: new EdgeInsets.symmetric(vertical: 0.0),
                    contentPadding: EdgeInsets.only(top: 20),
                    border: InputBorder.none,
                    prefixIcon: Padding(
                      // padding: EdgeInsets.all(0.0),
                      padding: EdgeInsets.only(top: 14),
                      child: Icon(
                        Icons.person,
                        color: Colors.grey,
                      ), // icon is 48px widget.
                    ),
                    hintText: 'Name',
                    hintStyle: TextStyle(fontSize: 18.0, color: Colors.grey)),

                // maxLength: 8,

                keyboardType: TextInputType.text,
                onFieldSubmitted: (value) {
                  //Validator
                },
                validator: (value) {
                  if (value.isEmpty) {
                    return 'This field is required';
                  } else if (value.length < 3 ||
                      value.length > 8 ||
                      !RegExp('[a-zA-Z]').hasMatch(value)) {
                    return ' valid Name  should between 3 and 8 characters';
                  }
                  return null;
                },
              ),

              SizedBox(
                height: getProportionateScreenWidth(context, 0.03),
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
                      ), // icon is 48px widget.
                    ),
                    hintText: 'E-Mail',
                    hintStyle: TextStyle(fontSize: 18.0, color: Colors.grey)),
                keyboardType: TextInputType.emailAddress,
                onFieldSubmitted: (value) {
                  //Validator
                },

                onChanged: (value) {
                setState(() {
                  emailvalue = value.trim();
                });
              },
              
                validator: (emailvalue) {
                  if (emailvalue.isEmpty) {
                    return 'This field is required';
                  }
                  if (!emailvalue.contains('@')) {
                    return " valid email should contain '@'";
                  }
                  if (!RegExp(
                    r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
                  ).hasMatch(emailvalue)) {
                    return "Please enter a valid email";
                  }
                  return null;
                },
              ),

              SizedBox(
                height: getProportionateScreenWidth(context, 0.03),
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

              SizedBox(
                height: getProportionateScreenWidth(context, 0.03),
              ),
              TextFormField(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                decoration: InputDecoration(
                    contentPadding: EdgeInsets.only(top: 20),
                    border: InputBorder.none,
                    prefixIcon: Padding(
                      padding: EdgeInsets.only(top: 14),
                      child: Icon(
                        Icons.phone,
                        color: Colors.grey,
                      ), // icon is 48px widget.
                    ),
                    hintText: 'Phone',
                    hintStyle: TextStyle(fontSize: 18.0, color: Colors.grey)),
                keyboardType: TextInputType.phone,
                onFieldSubmitted: (value) {
                  //Validator
                },
                validator: (value) {
                  if (value.isEmpty) {
                    return 'This field is required';
                  }
                  if (!RegExp(
                    r'^01([1-9])?[0-9]{9}$',
                  ).hasMatch(value)) {
                    return ' valid phone number should be 11 digits';
                  }
                  return null;
                },
              ),
              //box styling
              SizedBox(
                height: getProportionateScreenWidth(context, 0.03),
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
                onChanged: (value) {
                setState(() {
                  passwordvalue = value.trim();
                });
              },
                obscureText: true,
                validator: (passwordvalue) {
                  if (passwordvalue.isEmpty) {
                    return 'This field is required';
                  }
                  if (passwordvalue.length < 6) {
                    return 'Password should have at least 6 characters';
                  }

                  

                  return null;
                },
              ),

              SizedBox(
                height: getProportionateScreenWidth(context, 0.1),
              ),
              Text(
                    _success == null || _success ==true ? '': "The account already exists for that email.",
                    style: TextStyle(color: Colors.red),

                  ),
            
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Container(
                  width: 150,
                  
                  child: FloatingActionButton(
                   
                    onPressed: () => {
                      _submit(),
                      // _auth()
                      
                    // FirebaseAuth.instance.createUserWithEmailAndPassword(email: emailvalue, password: passwordvalue)
                    
   


                  
    //               Navigator.push(
    //   context,
    //   MaterialPageRoute(builder: (context) => Home()),
    // ),
              
                      
                      },
                    
                    child: Text("Register",
                        style: TextStyle(color: Colors.white, fontSize: 20)),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30)),
                    backgroundColor: Colors.indigo.shade900,
                  ),
                ),
              ),

              GestureDetector(
                  child: Text("you already have account? Login",
                      style: TextStyle(
                          color: Colors.blue,
                          fontSize: 16,
                          fontWeight: FontWeight.bold)),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Login()),
                    );
                  }),
                  // Text(
                  //   _success == null || _success ==true ? '': "The account already exists for that email.",
                  //   style: TextStyle(color: Colors.red),

                  // ),
            ],
          ),
        ),
      ),
    );
  }
}

