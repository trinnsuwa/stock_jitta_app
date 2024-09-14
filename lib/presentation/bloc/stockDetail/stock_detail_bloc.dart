import 'package:bloc/bloc.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:jitta_app/data/model/stockDetail/stock_detail_model.dart';
import 'package:jitta_app/presentation/bloc/stockDetail/stock_detail_event.dart';
import 'package:jitta_app/presentation/bloc/stockDetail/stock_detail_state.dart';
import 'package:jitta_app/service/graphql_service.dart';
import 'package:jitta_app/utils/constants.dart';

class StockDetailBloc extends Bloc<StockDetailEvent, StockDetailState> {
  final GraphQLService graphQLService;

  StockDetailBloc({required this.graphQLService})
      : super(StockDetailInitial()) {
    on<FetchStockDetail>(_onFetchStockDetail);
  }

  Future<void> _onFetchStockDetail(
      FetchStockDetail event, Emitter<StockDetailState> emit) async {
    emit(StockDetailLoading());

    final QueryOptions options = QueryOptions(
      document: gql(stockDetailQuery),
      variables: {
        'stockId': event.stockId,
        'id': event.id,
      },
      fetchPolicy: FetchPolicy.cacheFirst, // Check cache first
    );

    try {
      final Map<String, dynamic>? result = await graphQLService.performQuery(
        stockDetailQuery,
        variables: {
          'stockId': event.stockId,
          'id': event.id,
        },
      );
      var data = result!['stock'];
      StockDetail stock = StockDetail.fromJson(data);
      emit(StockDetailLoaded(stock: stock));

      graphQLService.client.writeQuery(
        options.asRequest,
        data: result,
      );
    } catch (e) {
      final cachedResult = await graphQLService.client.query(
        QueryOptions(
          document: gql(stockDetailQuery),
          variables: {
            'stockId': event.stockId,
            'id': event.id,
          },
          fetchPolicy: FetchPolicy.cacheOnly,
        ),
      );

      emit(const StockDetailError(
          'Failed to fetch stock details: Please try again later.'));

      if (cachedResult.data != null) {
        final data = cachedResult.data!['stock'];
        final stock = StockDetail.fromJson(data);
        emit(StockDetailLoaded(stock: stock));
      } else {
        emit(const StockDetailError(
            'Failed to fetch stock details: Please try again later.'));
      }
    }
  }
}
