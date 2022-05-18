
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:smart_home_demo/models/WeekData.dart';
import 'package:smart_home_demo/screens/home_page/home_bloc.dart';
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
  int max = 0;
  int min = 0;
  final HomeBloc _homebloc = HomeBloc();




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
    await DBref.child('test_led/led_01').once().then((DataSnapshot snapshot) {
      ledStatus = snapshot.value;
      print(ledStatus);
    });
    setState(() {
      isLoading = false;
    });
  }
  List<DienNangTuan> week_data = [];
  @override
  void initState() {
    getdata();
    // stream.listen((DatabaseEvent event) {
    //   print('Event Type: ${event.type}'); // DatabaseEventType.value;
    //   print('Snapshot: ${event.snapshot}'); // DataSnapshot
    // });
    _homebloc.listen((state) {
      if(state is GetDataWeekState){
        setState(() {
          week_data = state.data;
        });
      }
    });
    isLoading = true;
    getLEDStatus();
    find_min();
    find_max();
    super.initState();
  }
  void getdata(){
    _homebloc.add(GetDataWeekEvent());
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.indigo,
      appBar: AppBar(
        centerTitle: true,
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
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text('Nhiệt Độ trong nhà:',style: TextStyle(fontSize: 17,color: Colors.white)),
                        ),
                        Text(temp.toString(),style: TextStyle(fontSize: 22,color: Colors.amber),),
                      ],
                    ),

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
                        child: Text('Logout',style: TextStyle(fontSize: 15,color: Colors.white),),
                      ),
                    )
                  ],
                ),
                Center(
                  child: Text('Bóng đèn phòng khách',style: TextStyle(fontSize: 17,color: Colors.white),),
                ),
                SizedBox(
                  height: 20,
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
                    child: SvgPicture.asset('assets/icons/icon_light.svg',color: ledStatus== 0 ? Colors.blueGrey : Colors.amber,),
                  ),
                      ),

                ),

              ],
            ),
          ),
          SizedBox(
            height: 20,
          ),

          Column(children: [
            //Initialize the chart widget
            Container(
              color: Colors.white,
              child: SfCartesianChart(
                  primaryXAxis: CategoryAxis(),
                  // Chart title
                  title: ChartTitle(text: 'Lượng Điện Năng Tiêu Thụ Trong Tuần '),
                  // Enable legend
                  legend: Legend(isVisible: true),
                  // Enable tooltip
                  tooltipBehavior: TooltipBehavior(enable: true),
                  series: <ChartSeries<DienNangTuan, String>>[
                    LineSeries<DienNangTuan, String>(
                        dataSource: week_data,
                        xValueMapper: (DienNangTuan week_data, _) => week_data.ngay,
                        yValueMapper: (DienNangTuan week_data, _) => week_data.chiSo,
                        name: 'Kw/h',
                        // Enable data label
                        dataLabelSettings: DataLabelSettings(isVisible: true))
                  ]),
            ),
            // Padding(
            //   padding: const EdgeInsets.only(right: 15,left: 15,top: 10,bottom: 10),
            //   //Initialize the spark charts widget
            //   child: SfSparkLineChart.custom(
            //     //Enable the trackball
            //     trackball: SparkChartTrackball(
            //         activationMode: SparkChartActivationMode.tap),
            //     //Enable marker
            //     marker: SparkChartMarker(
            //         displayMode: SparkChartMarkerDisplayMode.all),
            //     //Enable data label
            //     labelDisplayMode: SparkChartLabelDisplayMode.all,
            //     xValueMapper: (int index) => data[index].year,
            //     yValueMapper: (int index) => data[index].sales,
            //     dataCount: 6,
            //   ),
            // )
          ]),
          // Row(
          //   children: [
          //     Text(max.toString(),style: TextStyle(fontSize: 17,color: Colors.white),),
          //     Spacer(),
          //     Text(min.toString(),style: TextStyle(fontSize: 17,color: Colors.white),)
          //   ],
          // ),

        ],
      ),
    );
  }
  void find_max(){
    int i =0;
    for (i = 0; i < week_data.length; i++) {
      if(week_data[i].chiSo >= max){
        setState(() {
          max = week_data[i].chiSo;
        });
      }
    }
  }
  void find_min(){
    int i =0;
    for (i = 0; i < week_data.length; i++) {
      if(week_data[i].chiSo <= min){
        setState(() {
          min = week_data[i].chiSo;
        });
      }
    }
  }
  
  void buttonPressed() {
    print('set_led');
    ledStatus == 0
        ? DBref.child('test_led/led_01').set(1)
        : DBref.child('test_led/led_01').set(0);
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
