import 'package:flutter/material.dart';
import 'package:trading/global/constants/styles/colors/colors.dart';
import 'package:trading/global/constants/styles/text_styles/text_styles.dart';
import 'package:trading/modules/watch/widget/stock_item.widget.dart';

import '../../chart/view/chart_screen.view.dart';

class WatchlistScreen extends StatelessWidget {
  final List<Map<String, dynamic>> watchlist;

  const WatchlistScreen({super.key, required this.watchlist});

  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: kWhite.withOpacity(0.1),
      appBar: AppBar(backgroundColor: kBlack.withOpacity(0.1),centerTitle: true,
        title: KStyles().bold21(text:'Watchlist',color: kWhite),leading: IconButton(onPressed: (){
          Navigator.pop(context);
        }, icon: const Icon(Icons.arrow_back_ios,color: kWhite,)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: ListView.builder(
          itemCount: watchlist.length,
          itemBuilder: (context, index) {
            var stock = watchlist[index];
           return StockListItem(stock: stock, onPressed: (){
         
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => ChartScreen(
                                          stock: stock,
                                        ),
                                      ),
                                    );
                                  
           });
          },
        ),
      ),
    );
  }
}
