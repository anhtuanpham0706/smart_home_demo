class Device {
  String name;
  String image;
  String button;
  int state;
  Device({this.name,this.image,this.state,this.button});




  Device.fromJson(Map<dynamic, dynamic> json)
      : name = json['name'] as String,
        image = json['image'] as String,
        button = json['button'] as String,
        state = json['state'] as int;

  Map<dynamic, dynamic> toJson() => <dynamic, dynamic>{
    'name': name,
    'image': image,
    'button': button,
    'state': state
  };
}



