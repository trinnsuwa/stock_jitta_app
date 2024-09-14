import 'package:flutter/material.dart';
import 'package:jitta_app/presentation/bloc/stockDetail/stock_detail_bloc.dart';
import 'package:jitta_app/presentation/bloc/stockDetail/stock_detail_event.dart';
import 'package:jitta_app/presentation/bloc/stockRanking/ranking_bloc.dart';
import 'package:jitta_app/presentation/bloc/stockRanking/ranking_event.dart';
import 'package:jitta_app/presentation/bloc/sector/sector_bloc.dart';
import 'package:jitta_app/presentation/bloc/sector/sector_event.dart';
import 'package:jitta_app/presentation/widget/sector_dropdown.dart';
import 'package:jitta_app/presentation/pages/stock/stock_list.dart';
import 'package:jitta_app/utils/constants.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String selectedMarket = 'TH';

  @override
  void initState() {
    context
        .read<StockBloc>()
        .add(FetchStockByRanking(market: selectedMarket, page: 0, limit: 10));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Column(
        children: [
          Center(
            child: Padding(
              padding: EdgeInsets.only(top: 80.0),
              child: Text(
                'Jitta Stock Ranking',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Row(
            children: [
              SectorDropdown(),
            ],
          ),
          StockListPage()
        ],
      ),
    );
  }
}
