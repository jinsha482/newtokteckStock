import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

import 'package:trading/global/constants/styles/colors/colors.dart';
import 'package:trading/global/constants/styles/text_styles/text_styles.dart';
import 'package:trading/modules/chart/widget/chart.widget.dart';
import 'package:trading/modules/chart/widget/stock_details.widget.dart';


class ChartScreen extends StatelessWidget {
  const ChartScreen({super.key, required this.stock});

  final Map<String, dynamic> stock;

  @override
  Widget build(BuildContext context) {
   
    return DefaultTabController(initialIndex: 0,
      length: 3,
      child: Scaffold(
        backgroundColor: kWhite.withOpacity(0.1),
        appBar: AppBar(leading: IconButton(onPressed: (){
          Navigator.pop(context);
        }, icon:const Icon(Icons.arrow_back_ios,color: kWhite,)),
          backgroundColor: kBlack.withOpacity(0.1),
          centerTitle: true,
          title: KStyles().bold20(
           text:'Chart Screen',
            color: kWhite,
          ),
          bottom:  TabBar(
            labelStyle: const TextStyle(fontSize: 17, fontWeight: FontWeight.w600),
            indicatorColor: kWhite,
            unselectedLabelColor: kGrey,
            dividerColor: Colors.transparent,
            automaticIndicatorColorAdjustment: false,
            padding: const EdgeInsets.only(bottom: 20, top: 7),
            labelColor: kWhite,
            overlayColor: MaterialStatePropertyAll(kWhite.withOpacity(0.2)),
            tabs: const [
              Tab(text: '1D'),
              Tab(text: '1W'),
              Tab(text: '1M'),
            ],
          ),
        ),
        body: TabBarView(physics: const BouncingScrollPhysics(),
          children: [
            buildChart(stock['1d']['data'],stock['1d']['totals']['total_close'],stock['1d']['totals']['percentage_change'],stock['symbol'],stock['name'],true,stock['1d']['totals']['total_open'],stock['1d']['totals']['total_low'],stock['1d']['totals']['total_high'],stock['1d']['totals']['total_volume']),
            buildChart(stock['1w']['data'],stock['1w']['totals']['total_close'],stock['1w']['totals']['percentage_change'],stock['symbol'],stock['name'],false,stock['1w']['totals']['total_open'],stock['1w']['totals']['total_low'],stock['1w']['totals']['total_high'],stock['1w']['totals']['total_volume']),
            buildChart(stock['1m']['data'],stock['1m']['totals']['total_close'],stock['1m']['totals']['percentage_change'],stock['symbol'],stock['name'],false,stock['1m']['totals']['total_open'],stock['1m']['totals']['total_low'],stock['1m']['totals']['total_high'],stock['1m']['totals']['total_volume']),
          ],
        ),
      ),
    );
  }

 Widget buildChart(List<dynamic> data,double price,double percentageChange,String name,String symbol,bool isOneDay,double openVal,double lowVal,double highVal,int volval) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 10.0),
    child: Column(
      children: [
        Gap(10.h),
       KStyles().bold20(text:'$symbol $name',color: kWhite),
       Gap(5.h),
        Row(mainAxisAlignment: MainAxisAlignment.center,
          children: [
          KStyles().bold20(text: price.toString(),color: kWhite),
          KStyles().bold14(text:' (${percentageChange.toString()}% )  ',
          color: percentageChange > 0 ? Colors.green : Colors.red),
         percentageChange > 0 ? 
          const Icon(Icons.trending_up,color: kGreen, ) :
          const Icon(Icons.trending_down,color: kRed,),
        ],), 
        Gap(20.h),
        ChartContent(data: data,isOneDay: isOneDay,),
        Gap(10.h),
         Column(crossAxisAlignment:CrossAxisAlignment.start,children: [
          Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(flex: 1,
                child: StockDetailsWidget(text: 'open', value: openVal.toString())),
              Gap(20.w),
              Expanded(flex: 1,
                child: StockDetailsWidget(text: 'volume', value: volval.toString())),
            ],
          ),
          Gap(3.h),
            Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(flex: 1,
                child: StockDetailsWidget(text: 'high', value: highVal.toString())),
               Gap(20.w),
              Expanded(flex: 1,
                child: StockDetailsWidget(text: 'low', value: lowVal.toString())),
            ],
          ),
        ],)
      ],
    ),
  )
;
 }
}