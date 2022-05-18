
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:smart_home_demo/models/device.dart';
import 'package:smart_home_demo/models/device_dao.dart';

class TestFirebaseScreen extends StatefulWidget {
   TestFirebaseScreen({Key key}) : super(key: key);
  final deviceDao = DeviceDao();


  @override
  State<TestFirebaseScreen> createState() => _TestFirebaseScreenState();
}

class _TestFirebaseScreenState extends State<TestFirebaseScreen> {
  ScrollController _scrollController = ScrollController();
  final _deviceRef = FirebaseDatabase.instance.reference();

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) => _scrollToBottom());
    return Scaffold(
      appBar: AppBar(
        title: Text('Text List Device'),
      ),
      body: Column(
        children: [
          _getDeviceList(),
          GestureDetector(
            onTap: (){
              _sendMessage();
            },
            child: Container(
              child: Text('send device'),

            ),
          ),
        ],
      ),
    );
  }
  void _sendMessage() {

      final device = Device(name: 'Fan',
          image: 'assets/images/air_conditioner1.png',state: 1,button: 'assets/images/button_on_off.png');
      widget.deviceDao.saveDevice(device);

      setState(() {});

  }
  Widget _getDeviceList() {
    return Expanded(
      child: FirebaseAnimatedList(
        controller: _scrollController,
        query: widget.deviceDao.getDeviceQuery(),
        itemBuilder: (context, snapshot, animation, index) {
          final json = snapshot.value as Map<dynamic, dynamic>;
          dynamic key = snapshot.key;
          final device = Device.fromJson(json);
          return Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(15)),
                color: device.state == 0 ? Colors.white54: Colors.blue,
                border: Border.all(
                  width: 2,
                  color: Colors.black12,
                )
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    SizedBox(
                      height: 100,
                      width: 120,
                      child: Image.asset(device.image.toString()),
                    ),
                    Spacer(),
                    GestureDetector(
                      onTap: (){
                        setState(() {
                          if(device.state == 0){
                            _deviceRef.child('device/$key/state').set(1);
                          } else {
                            _deviceRef.child('device/$key/state').set(0);
                          }

                        });
                      },
                      child: SizedBox(
                        height: 40,
                        width: 40,
                        child: Image.asset(device.button.toString(),
                          color: device.state == 0 ? Colors.black : Colors.indigo,),
                      ),
                    ),
                    SizedBox(width: 10,)
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(device.name.toString(),style: TextStyle(fontSize: 15,color: Colors.black,fontWeight: FontWeight.bold),),
                )


              ],
            ),

          );
        },
      ),
    );
  }

  void _scrollToBottom() {
    if (_scrollController.hasClients) {
      _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
    }
  }

}
