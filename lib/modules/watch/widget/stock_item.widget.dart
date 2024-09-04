import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

import 'package:trading/global/constants/styles/colors/colors.dart';
import 'package:trading/global/constants/styles/text_styles/text_styles.dart';


class StockListItem extends StatelessWidget {
  const StockListItem({super.key, required this.stock, required this.onPressed});
  
  final Map<String, dynamic> stock;
  final Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    final String symbol = stock['symbol'];
    final String name = stock['name'];
    final double totalPercentageChange = stock['1m']['totals']['percentage_change']?.toDouble() ?? 0.0;
    final double totalPrice = stock['1m']['totals']['total_close']?.toDouble() ?? 0.0;

    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8),
        color: Colors.transparent, 
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                  flex: 1,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      KStyles().bold18(text: symbol, color: kWhite),
                      Gap(3.h),
                      KStyles().bold11(text: name, color: kGrey),
                    ],
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: totalPercentageChange > 0
                      ? const Icon(Icons.trending_up, color: kGreen, size: 45)
                      : const Icon(Icons.trending_down, color: kRed, size: 45),
                ),
                Expanded(
                  flex: 1,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      KStyles().bold18(text: totalPrice.toString(), color: kWhite),
                      Gap(3.h),
                      KStyles().bold11(
                        text: '${totalPercentageChange.toStringAsFixed(2)}%', 
                        color: totalPercentageChange > 0 ? Colors.green : Colors.red,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const Divider(thickness: 0.1, color: kGrey),
          ],
        ),
      ),
    );
  }
}
