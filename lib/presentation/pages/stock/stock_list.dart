import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jitta_app/presentation/bloc/stockRanking/ranking_bloc.dart';
import 'package:jitta_app/presentation/bloc/stockRanking/ranking_event.dart';
import 'package:jitta_app/presentation/bloc/stockRanking/ranking_state.dart';
import 'package:jitta_app/presentation/pages/stock/stock_detail.dart';

class StockListPage extends StatefulWidget {
  const StockListPage({super.key});

  @override
  State<StockListPage> createState() => _StockListPageState();
}

class _StockListPageState extends State<StockListPage> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        context.read<StockBloc>().add(const LoadMoreStocks(limit: 10));
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StockBloc, StockState>(
      builder: (context, state) {
        if (state is StockLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is StockLoaded) {
          return Expanded(
            child: ListView.builder(
              controller: _scrollController,
              shrinkWrap: true,
              padding: EdgeInsets.zero,
              itemCount: state.stocks.length + 1,
              itemBuilder: (context, index) {
                if (index == state.stocks.length) {
                  return context.read<StockBloc>().hasMoreData
                      ? const Center(child: CircularProgressIndicator())
                      : const SizedBox();
                }
                final stock = state.stocks[index];
                return ListTile(
                  //leading: Text('ts'),
                  title: Text(stock.title ?? ''),
                  subtitle: Text('${stock.id}'),
                  trailing: Text('Rank: ${stock.rank} / ${state.count}'),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => StockDetailPage(stockId: stock.stockId!, id: stock.id),
                      ),
                    );
                  },
                );
              },
            ),
          );
        } else if (state is StockError) {
          return Center(child: Text(state.message));
        }
        return const SizedBox();
      },
    );
  }
}
