import 'package:equatable/equatable.dart';
import 'package:jitta_app/data/model/stockDetail/stock_detail_model.dart';

abstract class StockDetailState extends Equatable {
  const StockDetailState();

  @override
  List<Object?> get props => [];
}

class StockDetailInitial extends StockDetailState {}

class StockDetailLoading extends StockDetailState {}

class StockDetailLoaded extends StockDetailState {
  final StockDetail stock;

  const StockDetailLoaded({required this.stock});

  @override
  List<Object?> get props => [stock];
}

class StockDetailError extends StockDetailState {
  final String message;

  const StockDetailError(this.message);

  @override
  List<Object?> get props => [message];
}
