import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import 'package:trading/global/constants/styles/colors/colors.dart';
import 'package:trading/global/constants/styles/text_styles/text_styles.dart';
import '../../watch/view/watch_list.view.dart';
import '../controller/home_screen.controller.dart';
import '../service/home_screen.service.dart';
import 'package:fluttertoast/fluttertoast.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final StockService stockService = StockService();
  List<Map<String, dynamic>> watchlist = [];
  String searchQuery = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kWhite.withOpacity(0.1),
      body: Consumer<HomeScreenController>(
        builder: (context, homeCtrl, child) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Gap(70.h),
                  KStyles().bold22(text: 'Stocks', color: kWhite),
                  Gap(2.h),
                  KStyles().bold20(
                    text: homeCtrl.setTime(),
                    color: kGrey,
                  ),
                  Gap(8.h),
                  TextField(
                    showCursor: true,
                    style: const TextStyle(color: kWhite),
                    controller: homeCtrl.searchCtrl,
                    onChanged: (query) {
                      setState(() {
                        searchQuery = query;
                      });
                    },
                    decoration: const InputDecoration(
                      contentPadding: EdgeInsets.all(10),
                      hintText: 'Search...',
                      hintStyle: TextStyle(color: kWhite),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                      ),
                    ),
                  ),
                  Gap(10.h),
                  StreamBuilder<Map<String, dynamic>>(
                    stream: stockService.loadStockDataStream(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (snapshot.hasError) {
                        return Center(child: Text('Error: ${snapshot.error}'));
                      } else if (snapshot.hasData) {
                        Map<String, dynamic> data = snapshot.data!;
                        List<dynamic> stocks = data['stocks'];

                        //! Filter and sort stocks based on searchQuery
                        List<dynamic> filteredAndSortedStocks = stocks
                            .where((stock) {
                              final symbol = stock['symbol'] as String;
                              return symbol.toLowerCase().contains(searchQuery.toLowerCase());
                            })
                            .toList()
                            ..sort((a, b) {
                              final symbolA = a['symbol'] as String;
                              final symbolB = b['symbol'] as String;
                              return symbolA.compareTo(symbolB);
                            });

                        if (filteredAndSortedStocks.isEmpty) {
                          return Center(
                            child: KStyles().med14(
                              text: 'No stocks found for your search.',
                              color: kWhite,
                            ),
                          );
                        }
                        return Column(
                          children: [
                            ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: filteredAndSortedStocks.length,
                              itemBuilder: (context, index) {
                                var stock = filteredAndSortedStocks[index];
                                bool isInWatchlist = watchlist.any((item) => item['symbol'] == stock['symbol']);
                                return ListTile(
                                  title: KStyles().bold17(text: stock['symbol'], color: kWhite),
                                  subtitle: KStyles().bold14(text: stock['name'], color: kGrey),
                                  trailing: IconButton(
                                    icon: Icon(
                                      isInWatchlist ? Icons.remove : Icons.add,
                                      color: isInWatchlist ? kRed : kGreen,
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        if (isInWatchlist) {
                                          watchlist.removeWhere((item) => item['symbol'] == stock['symbol']);
                                        } else if (watchlist.length < 2) {
                                          watchlist.add(stock);
                                        } else {
                                          Fluttertoast.showToast(
                                            msg: "You can only add up to 2 stocks to the watchlist.",
                                            toastLength: Toast.LENGTH_SHORT,
                                            gravity: ToastGravity.TOP,
                                            timeInSecForIosWeb: 1,
                                            backgroundColor: kWhite,
                                            textColor: kBlack,
                                            fontSize: 16.0,
                                          );
                                        }
                                      });
                                    },
                                  ),
                                );
                              },
                            ),
                          ],
                        );
                      } else {
                        return Center(child: KStyles().med14(text: 'No data available', color: kWhite));
                      }
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: ElevatedButton(
          onPressed: () {
            if (watchlist.isNotEmpty) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => WatchlistScreen(watchlist: watchlist),
                ),
              );
            }
          },
          child: KStyles().med14(text: 'View Watchlist (${watchlist.length}/2)'),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
