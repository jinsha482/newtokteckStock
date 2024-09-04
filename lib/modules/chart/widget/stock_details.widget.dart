import 'package:flutter/material.dart';
import 'package:trading/global/constants/styles/colors/colors.dart';


class StockDetailsWidget extends StatelessWidget {
  const StockDetailsWidget({super.key,required this.text,required this.value});
final String text;
final String value;
  @override
  Widget build(BuildContext context) {
    return 
     Text.rich(
            TextSpan(
              text: '$text - ',style: const TextStyle(fontSize: 17,fontWeight: FontWeight.bold,color: kWhite),
              children: <InlineSpan>[
                TextSpan(
                  text: value,
                  style: const TextStyle(fontSize: 15,fontWeight: FontWeight.bold,color: kGrey),
                )
              ]
            )
          );
    
  }
}