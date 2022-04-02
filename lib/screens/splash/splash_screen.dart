import 'package:flutter/material.dart';
import 'package:smart_home_demo/screens/signin_screen.dart';
import 'package:smart_home_demo/screens/splash/components/splash_content.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({Key key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  int currentPage = 0;
  List<Map<String, String>> splashData = [
    {
      "image": "assets/images/01_SplashScreen1.png"
    },
    {
      "image": "assets/images/01_SplashScreen2.png"
    },
    {
      "image": "assets/images/01_SplashScreen3.png"
    },
  ];
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        width: double.infinity,
        child: Column(
          children: <Widget>[
            Expanded(
              child: PageView.builder(
                onPageChanged: (value) {
                  setState(() {
                    currentPage = value;
                  });
                },
                itemCount: splashData.length,
                itemBuilder: (context, index) => SplashContent(
                  image: splashData[index]["image"],
                ),
              ),
            ),
            Container(
              color: Colors.white,
              child: Row(
                children: <Widget>[
                  SizedBox(width: 30,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: List.generate(
                      splashData.length,
                          (index) => buildDot(index: index),
                    ),
                  ),
                  Spacer(flex: 1),
                  TextButton(onPressed: (){
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SignInScreen()),
                    );
                  }, child: Text('Skip',
                    style: TextStyle(color: Colors.black,fontSize: 20),)),
                  SizedBox(width: 20,),
                ],
              ),
            ),
            SizedBox(height: 20,)
          ],
        ),
      ),
    );
  }




  AnimatedContainer buildDot({int index}) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 200),
      margin: EdgeInsets.only(right: 20),
      height: 12,
      width: currentPage == index ? 12 : 12,
      decoration: BoxDecoration(
        color: currentPage == index ? Color(0xff686795) : Color(0xFFD8D8D8),
        borderRadius: BorderRadius.circular(6),
      ),
    );
  }
}
