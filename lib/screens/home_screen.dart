

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:smart_home_demo/screens/signin_screen.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_charts/sparkcharts.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}
class _SalesData {
  _SalesData(this.year, this.sales);

  final String year;
  final double sales;
}

class _HomeScreenState extends State<HomeScreen> {
  final DBref = FirebaseDatabase.instance.reference();
  int ledStatus = 0;
  bool isLoading = false;
  int temp = 0;
  List<_SalesData> data = [
    _SalesData('MON', 35),
    _SalesData('TUE', 28),
    _SalesData('WED', 34),
    _SalesData('THU', 32),
    _SalesData('SAT', 40),
    _SalesData('SUN', 25),
  ];

  getLEDStatus() async {
    print('setup');
    await DBref.child('Nhiet_do').once().then((DataSnapshot snapshot) =>
    temp = snapshot.value);
    await DBref.child('LED_TEST').once().then((DataSnapshot snapshot) {
      ledStatus = snapshot.value;
      print(ledStatus);
    });
    setState(() {
      isLoading = false;
    });
  }
  @override
  void initState() {
    isLoading = true;
    getLEDStatus();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
        title: Text(
          'IOT App',
          style: TextStyle(fontSize: 18,color: Colors.white),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Center(
            child: Column(
              children: [
                Row(
                  children: [
                    Text('Nhiet do hien tai la:',style: TextStyle(fontSize: 17)),
                    Text(temp.toString(),style: TextStyle(fontSize: 22,color: Colors.amber),),
                    Spacer(),
                    GestureDetector(
                      onTap: (){
                        FirebaseAuth.instance.signOut().then((value) {
                          print("Signed Out");
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) => SignInScreen()));
                        });
                      },
                      child: Container(
                        child: Text('Logout'),
                      ),
                    )
                  ],
                ),
                Center(
                  child: isLoading
                      ? CircularProgressIndicator()
                      : GestureDetector(
                    onTap: (){
                      buttonPressed();
                    },
                        child: SizedBox(
                    height: 70,
                    width: 70,
                    child: SvgPicture.asset('assets/icons/Camera Icon.svg',color: ledStatus== 0 ? Colors.black12 : Colors.amber,),
                  ),
                      ),

                ),

              ],
            ),
          ),
          Column(children: [
            //Initialize the chart widget
            SfCartesianChart(
                primaryXAxis: CategoryAxis(),
                // Chart title
                title: ChartTitle(text: 'Lượng Điện Năng Tiêu Thụ Trong Tuần'),
                // Enable legend
                legend: Legend(isVisible: true),
                // Enable tooltip
                tooltipBehavior: TooltipBehavior(enable: true),
                series: <ChartSeries<_SalesData, String>>[
                  LineSeries<_SalesData, String>(
                      dataSource: data,
                      xValueMapper: (_SalesData sales, _) => sales.year,
                      yValueMapper: (_SalesData sales, _) => sales.sales,
                      name: 'Kw/h',
                      // Enable data label
                      dataLabelSettings: DataLabelSettings(isVisible: true))
                ]),
            Padding(
              padding: const EdgeInsets.only(right: 15,left: 15,top: 10,bottom: 10),
              //Initialize the spark charts widget
              child: SfSparkLineChart.custom(
                //Enable the trackball
                trackball: SparkChartTrackball(
                    activationMode: SparkChartActivationMode.tap),
                //Enable marker
                marker: SparkChartMarker(
                    displayMode: SparkChartMarkerDisplayMode.all),
                //Enable data label
                labelDisplayMode: SparkChartLabelDisplayMode.all,
                xValueMapper: (int index) => data[index].year,
                yValueMapper: (int index) => data[index].sales,
                dataCount: 5,
              ),
            )
          ])

        ],
      ),
    );
  }
  void buttonPressed() {
    print('set_led');
    ledStatus == 0
        ? DBref.child('LED_TEST').set(1)
        : DBref.child('LED_TEST').set(0);
    if (ledStatus == 0) {
      setState(() {
        ledStatus = 1;
      });
    } else {
      setState(() {
        ledStatus = 0;
      });
    }
  }
}
