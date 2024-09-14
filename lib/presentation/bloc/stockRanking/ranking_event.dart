import 'package:equatable/equatable.dart';

abstract class StockEvent extends Equatable {
  const StockEvent();

  @override
  List<Object> get props => [];
}

class FetchStockByRanking extends StockEvent {
  final String market;
  final String? sectors;
  final int? page;
  final int? limit;

  const FetchStockByRanking({
    required this.market,
    this.sectors,
    this.page,
    this.limit,
  });

  @override
  List<Object> get props => [market];
}

class LoadMoreStocks extends StockEvent {
  final String? sectors;
  final int? limit;

  const LoadMoreStocks({
    this.sectors,
    this.limit,
  });

  @override
  List<Object> get props => [];
}
