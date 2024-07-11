import 'package:book_app/modules/books/page/book_page.dart';
import 'package:book_app/modules/home/page/home_page.dart';
import 'package:book_app/modules/profiile/pages/profile_page.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';
part 'bottom_navigator.g.dart';

class BottomNavigatorController = _BottomNavigatorControllerBase with _$BottomNavigatorController;

abstract class _BottomNavigatorControllerBase with Store {
  
  @observable
  int _currentIndex = 0;

  @computed
  int get currentIndex => _currentIndex;

  @action
  set currentIndex(int value){
     switch (value) {
      case 0: 
        Modular.to.navigate('/initial${HomePage.route}');
        break;
      case 1: 
        Modular.to.pushNamed('/initial${BookPage.rota}');
        break;
      case 2:
        break;
      case 3:
        break;
      case 4:
        Modular.to.pushNamed('/initial${ProfilePage.route}/');
        break;
    }
    _currentIndex = value;
  }
}