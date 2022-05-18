import 'package:flutter/material.dart';
import 'package:smart_home_demo/reusable_widgets/reusable_widget.dart';
import 'package:smart_home_demo/screens/otp/otp_screen.dart';
import 'package:smart_home_demo/utils/color_utils.dart';



class InputPhoneScreen extends StatefulWidget {
  const InputPhoneScreen({Key key}) : super(key: key);

  @override
  State<InputPhoneScreen> createState() => _InputPhoneScreenState();
}

class _InputPhoneScreenState extends State<InputPhoneScreen> {
  TextEditingController _phoneTextController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          "Reset Password",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
      body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
              gradient: LinearGradient(colors: [
                hexStringToColor("CB2B93"),
                hexStringToColor("9546C4"),
                hexStringToColor("5E61F4")
              ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
          child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.fromLTRB(20, 120, 20, 0),
                child: Column(
                  children: <Widget>[
                    const SizedBox(
                      height: 20,
                    ),
                    reusableTextField("Enter your phone", Icons.person_outline, false,
                        _phoneTextController),
                    const SizedBox(
                      height: 20,
                    ),
                    GestureDetector(
                      onTap: (){
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => OtpScreen(phone: _phoneTextController.text,)),
                        );
                      },
                      child: Container(
                      child: Text('Tiếp tục'),
                      ),
                    )
                  ],
                ),
              ))),
    );
  }
}
