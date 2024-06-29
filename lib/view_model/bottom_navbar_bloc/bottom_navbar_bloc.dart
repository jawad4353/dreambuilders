import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
part 'bottom_navbar_events.dart';
part 'bottom_navbar_states.dart';
/*
the bottomnavbar index will be changed when we click any item and we will display
corresponding screen so i am managing that using this bloc .We can add event from anywhere to
 change current screen of user .
 */
class BottomNavBarBloc extends Bloc<BottomNavBarEvent, BottomNavBarStates> {
  BottomNavBarBloc() : super(BottomNavBarInitialState()) {
    on<BottomNavBarEvent>((event, emit) async{
      if(event is BottomNavBarChangePageEvent){
        emit(BottomNavBarLoadedState(event.pageIndex));
      }
    });
  }
}
