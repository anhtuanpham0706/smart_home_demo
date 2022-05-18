



import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_home_demo/models/WeekData.dart';
import 'package:smart_home_demo/service.dart';

abstract class HomeEvent {
  const HomeEvent();
}

class GetDataWeekEvent extends HomeEvent {
}





class HomeState {
  const HomeState();
}

class GetDataWeekState extends HomeState {
  final List<DienNangTuan> data;
  const GetDataWeekState(this.data);
}

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc({HomeState init = const HomeState()}) :super(init);

  @override
  Stream<HomeState> mapEventToState(HomeEvent event) async* {
    switch (event.runtimeType){
      case GetDataWeekEvent:
        yield* get_week_data(event);
        break;
    }
  }


  Stream<HomeState> get_week_data(GetDataWeekEvent event) async*{
    var data = await getdata_week();
    yield GetDataWeekState(data);
  }
}