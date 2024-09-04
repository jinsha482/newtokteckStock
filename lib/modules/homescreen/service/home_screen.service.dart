import 'dart:convert';

import 'package:flutter/services.dart';

class StockService {

 Stream<Map<String, dynamic>> loadStockDataStream() async* {
 
  String jsonString = await rootBundle.loadString('assets/json/stock_data.json');
  Map<String, dynamic> jsonData = json.decode(jsonString);
  yield jsonData;
}

}
