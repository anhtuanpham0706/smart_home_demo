import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:smart_home_demo/screens/signup_screen.dart';

import '../../constant.dart';

class OtpScreen extends StatefulWidget {
  final String phone;
  const OtpScreen({Key key, this.phone}) : super(key: key);
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<OtpScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  var node1Controller = TextEditingController();
  var node2Controller = TextEditingController();
  var node3Controller = TextEditingController();
  var node4Controller = TextEditingController();
  var node5Controller = TextEditingController();
  var node6Controller = TextEditingController();
  String _verificationId;
  FocusNode pin2FocusNode;
  FocusNode pin3FocusNode;
  FocusNode pin4FocusNode;
  FocusNode pin5FocusNode;
  FocusNode pin6FocusNode;
  double _star = 50.0;
  double _end = 0.0;
  // AnimationController _animationController;
  // Animation _rotationAnimation;
  send_otp(String phone) async {
    await _auth.verifyPhoneNumber(
      phoneNumber: '+84 $phone',
      verificationCompleted: (PhoneAuthCredential credential) {
        print(credential);
      },
      verificationFailed: (FirebaseAuthException e) {
        print(e);
      },
      codeSent: (String verificationId, int resendToken) {
        _verificationId = verificationId;
        print(verificationId);
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        print(verificationId);
      },
    );
  }

  @override
  void initState() {
    send_otp(widget.phone);
    startTimer();
    super.initState();
    pin2FocusNode = FocusNode();
    pin3FocusNode = FocusNode();
    pin4FocusNode = FocusNode();
    pin5FocusNode = FocusNode();
    pin6FocusNode = FocusNode();
  }

  @override
  void dispose() {
    super.dispose();
    pin2FocusNode.dispose();
    pin3FocusNode.dispose();
    pin4FocusNode.dispose();
    pin5FocusNode.dispose();
    pin6FocusNode.dispose();
  }


  void nextField(String value, FocusNode focusNode) {
    if (value.length == 1) {
      focusNode.requestFocus();
    }
  }
  void signInWithPhoneNumber(String smscode) async {
    try {
      final AuthCredential credential = PhoneAuthProvider.credential(
        verificationId: _verificationId,
        smsCode: smscode,
      );
      final User user = (await _auth.signInWithCredential(credential)).user;
      print("Successfully signed in UID: ${user.uid}");
      if(user.uid != null){
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => SignUpScreen()));
      }
    } catch (e) {
      print("Failed to sign in: " + e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.cyanAccent,
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        title: Text('Xác Thực số điện thoại',style: TextStyle(fontSize: 17,color: Colors.white),),
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 40,),
           Padding(
             padding: const EdgeInsets.only(left: 20,right: 20),
             child: Text('Vui lòng nhập mã số được giử đến số ${widget.phone}'
                  ,style: TextStyle(
                      fontSize: 18
                      , color: Colors.black
                  ),),
           ),
            SizedBox(height: 5,),
            Form(
              child: Column(
                children: [
                  SizedBox(height: 20,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 50,
                        child: TextFormField(
                          controller: node1Controller,
                          autofocus: true,
                          obscureText: true,
                          style: TextStyle(fontSize: 20),
                          keyboardType: TextInputType.number,
                          textAlign: TextAlign.center,
                          decoration: otpInputDecoration,
                          onChanged: (value) {
                            nextField(value, pin2FocusNode);
                          },
                        ),
                      ),
                      SizedBox(width: 5),
                      SizedBox(
                        width: 50,
                        child: TextFormField(
                          controller: node2Controller,
                          focusNode: pin2FocusNode,
                          obscureText: true,
                          style: TextStyle(fontSize: 20),
                          keyboardType: TextInputType.number,
                          textAlign: TextAlign.center,
                          decoration: otpInputDecoration,
                          onChanged: (value) {
                            nextField(value, pin3FocusNode);
                          },
                        ),
                      ),
                      SizedBox(width: 5),
                      SizedBox(
                        width: 50,
                        child: TextFormField(
                          controller: node3Controller,
                          focusNode: pin3FocusNode,
                          obscureText: true,
                          style: TextStyle(fontSize: 20),
                          keyboardType: TextInputType.number,
                          textAlign: TextAlign.center,
                          decoration: otpInputDecoration,
                          onChanged: (value) {
                            nextField(value, pin4FocusNode);
                          },
                        ),
                      ),
                      SizedBox(width: 5),
                      SizedBox(
                        width: 50,
                        child: TextFormField(
                          controller: node4Controller,
                          focusNode: pin4FocusNode,
                          obscureText: true,
                          style: TextStyle(fontSize: 20),
                          keyboardType: TextInputType.number,
                          textAlign: TextAlign.center,
                          decoration: otpInputDecoration,
                          onChanged: (value) {
                            nextField(value, pin5FocusNode);
                          },
                        ),
                      ),
                      SizedBox(width: 5),
                      SizedBox(
                        width: 50,
                        child: TextFormField(
                          controller: node5Controller,
                          focusNode: pin5FocusNode,
                          obscureText: true,
                          style: TextStyle(fontSize: 20),
                          keyboardType: TextInputType.number,
                          textAlign: TextAlign.center,
                          decoration: otpInputDecoration,
                          onChanged: (value) {
                            nextField(value, pin6FocusNode);
                          },
                        ),
                      ),
                      SizedBox(width: 5),
                      SizedBox(
                        width: 50,
                        child: TextFormField(
                          controller: node6Controller,
                          focusNode: pin6FocusNode,
                          obscureText: true,
                          style: TextStyle(fontSize: 20),
                          keyboardType: TextInputType.number,
                          textAlign: TextAlign.center,
                          decoration: otpInputDecoration,
                          onChanged: (value) {
                            if (value.length == 1) {
                              pin6FocusNode.unfocus();
                              // Then you need to check is the code is correct or not
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 50,),
                  // buildTimer(),
                  Text('${start}s'),
                  SizedBox(height: 5,),
                  Container(
                    height: 55,
                    width: 250,
                    color: Colors.red,
                    child: TextButton(
                      onPressed: () async{
                        var node1 = node1Controller.text;
                        var node2 = node2Controller.text;
                        var node3 = node3Controller.text;
                        var node4 = node4Controller.text;
                        var node5 = node5Controller.text;
                        var node6 = node6Controller.text;
                        String smscode = '${node1}${node2}${node3}${node4}${node5}${node6}';
                        signInWithPhoneNumber(smscode);
                        // final PhoneAuthCredential phoneAuthCredential =
                        //  PhoneAuthProvider.credential(
                        //      verificationId: _verificationId, smsCode: '${node1}+${node2}+${node3}+${node4}+${node5}+${node6}');
                        //  // signInWithPhoneAuthCredential(phoneAuthCredential);
                      },
                      child: Text('Xác Thực', style: TextStyle(
                          color: Colors.white, fontSize: 20
                      ),),
                    ),
                  ),
                  SizedBox(height: 40,),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        startTimer();
                        start = 50;
                      });
                    },
                    child: Text(
                      'Gửi lại mã',
                      style: TextStyle(decoration: TextDecoration.underline,
                          fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
  int start = 50;
  bool wait = false;

  void startTimer() {
    const onsec = Duration(seconds: 1);
    Timer _timer = Timer.periodic(onsec, (timer) {
      if (start == 0) {
        setState(() {
          timer.cancel();
          wait = false;
        });
      } else {
        setState(() {
          start--;
        });
      }
    });
  }
  Row buildTimer() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TweenAnimationBuilder(
          tween: Tween(begin: _star, end: _end),
          onEnd: (){
            setState(() {
            });
          },
          duration: Duration(seconds: 10),
          builder: (_, dynamic value, child) => Text(
            "${value.toInt()}s",
            style: TextStyle(color: Colors.black),
          ),
        ),
      ],
    );
  }
}