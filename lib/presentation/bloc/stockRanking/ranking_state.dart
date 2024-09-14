import 'package:equatable/equatable.dart';
import 'package:jitta_app/data/model/sector_model.dart';
import 'package:jitta_app/data/model/stock_model.dart';

abstract class StockState extends Equatable {
  const StockState();

  @override
  List<Object> get props => [];
}

class StockInitial extends StockState {}

class StockLoading extends StockState {}

class StockLoaded extends StockState {
  final List<Stock> stocks;
  final List<Sector> sectors;
  final int count;

  const StockLoaded({
    required this.stocks,
    required this.sectors,
    required this.count,
  });

  @override
  List<Object> get props => [stocks, sectors, count];
}

class StockError extends StockState {
  final String message;

  const StockError(this.message);

  @override
  List<Object> get props => [message];
}
