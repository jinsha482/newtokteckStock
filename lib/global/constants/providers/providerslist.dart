
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:trading/modules/homescreen/controller/home_screen.controller.dart';

List<SingleChildWidget>providersList = [
  
   ChangeNotifierProvider(create: (_) => HomeScreenController()),
   ];