import 'package:todo/screens/detail_screen.dart';
import 'package:todo/screens/add_screen.dart';
import 'package:todo/screens/home_screen.dart';
import 'package:get/get.dart';

class RouterConfig {

	static final route = [
		GetPage(name: '/detailScreen', page: () => DetailScreen(), transition: Transition.fade),
		GetPage(name: '/addScreen', page: () => AddScreen(), transition: Transition.rightToLeft),
		GetPage(name: '/homeScreen', page: () => HomeScreen()),
	];
	
}
	