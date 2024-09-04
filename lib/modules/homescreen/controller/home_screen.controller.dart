import 'package:flutter/material.dart';
import 'package:intl/intl.dart';



class HomeScreenController extends ChangeNotifier{
  TextEditingController searchCtrl = TextEditingController();
  setTime(){
  final DateFormat formatter = DateFormat('d MMMM');
final String formattedDate = formatter.format(DateTime.now());
return formattedDate;
  }

  




  

  

}
