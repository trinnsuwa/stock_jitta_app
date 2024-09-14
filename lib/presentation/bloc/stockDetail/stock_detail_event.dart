import 'package:equatable/equatable.dart';

abstract class StockDetailEvent extends Equatable {
  const StockDetailEvent();

  @override
  List<Object?> get props => [];
}

class FetchStockDetail extends StockDetailEvent {
  final int stockId;
  final String id;

  const FetchStockDetail({required this.stockId, required this.id});

  @override
  List<Object?> get props => [stockId, id];
}
