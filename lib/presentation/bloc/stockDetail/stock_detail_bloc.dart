import 'package:bloc/bloc.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:jitta_app/data/model/stockDetail/stock_detail_model.dart';
import 'package:jitta_app/presentation/bloc/stockDetail/stock_detail_event.dart';
import 'package:jitta_app/presentation/bloc/stockDetail/stock_detail_state.dart';
import 'package:jitta_app/utils/constants.dart';

class StockDetailBloc extends Bloc<StockDetailEvent, StockDetailState> {
  final GraphQLClient client;

  StockDetailBloc({required this.client}) : super(StockDetailInitial()) {
    on<FetchStockDetail>(_onFetchStockDetail);
  }

  Future<void> _onFetchStockDetail(
      FetchStockDetail event, Emitter<StockDetailState> emit) async {
    emit(StockDetailLoading());

    final QueryOptions options = QueryOptions(
      document: gql(stockDetalQuery),
      variables: {
        'stockId': event.stockId,
        'id': event.id,
      },
      fetchPolicy: FetchPolicy.cacheFirst, // Check cache first
    );

    try {
      final QueryResult result = await client.query(options);

      if (result.hasException) {
        throw result.exception!;
      }

      var data = result.data!['stock'];
      StockDetail stock = StockDetail.fromJson(data);
      emit(StockDetailLoaded(stock: stock));

      client.writeQuery(
        options.asRequest,
        data: result.data!,
      );
    } catch (e) {
      print(e.toString());

      final cachedResult = await client.query(
        QueryOptions(
          document: gql(stockDetalQuery),
          variables: {
            'stockId': event.stockId,
            'id': event.id,
          },
          fetchPolicy: FetchPolicy.cacheOnly,
        ),
      );

      emit(const StockDetailError('Failed to fetch stock details: Please try again later.'));

      if (cachedResult.data != null) {
        final data = cachedResult.data!['stock'];
        final stock = StockDetail.fromJson(data);
        emit(StockDetailLoaded(stock: stock));
      } else {
        emit(const StockDetailError('Failed to fetch stock details: Please try again later.'));
      }
    }
  }
}