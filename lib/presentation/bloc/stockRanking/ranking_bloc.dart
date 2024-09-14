import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:jitta_app/data/model/sector_model.dart';
import 'package:jitta_app/data/model/stock_model.dart';
import 'package:bloc/bloc.dart';
import 'package:jitta_app/presentation/bloc/stockRanking/ranking_event.dart';
import 'package:jitta_app/presentation/bloc/stockRanking/ranking_state.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:jitta_app/service/graphql_service.dart';
import 'package:jitta_app/utils/constants.dart';

class StockBloc extends Bloc<StockEvent, StockState> {
  final GraphQLService graphQLService;
  final Box cacheBox;

  int currentPage = 0;
  bool isLoading = false;
  bool hasMoreData = true;
  String loadMarket = 'TH';

  StockBloc(this.graphQLService, this.cacheBox) : super(StockInitial()) {
    on<FetchStockByRanking>(_onFetchStockByRanking);
    on<LoadMoreStocks>(_onLoadMoreStocks);
  }

  Future<void> _onFetchStockByRanking(
      FetchStockByRanking event, Emitter<StockState> emit) async {
    emit(StockLoading());

    try {
      currentPage = 0;
      hasMoreData = true;
      loadMarket = event.market;

      // final QueryResult result = await client.query(options);
      final Map<String, dynamic>? result = await graphQLService.performQuery(
        stockQuery,
        variables: {
          'market': event.market,
          'sectors': event.sectors,
          'page': event.page,
          'limit': event.limit,
        },
      );

      // if (result.hasException) {
      //   throw result.exception!;
      // }

      final data = result!;
      final stocks = (data['jittaRanking']['data'] as List)
          .map((e) => Stock.fromJson(e))
          .toList();

      final sectors = (data['listJittaSectorType'] as List)
          .map((e) => Sector.fromJson(e))
          .toList();

      final count = data['jittaRanking']['count'];
      hasMoreData = stocks.length < count;

      cacheBox.put('stocks_cache', {
        'stocks': stocks.map((e) => e.toJson()).toList(),
        'sectors': sectors.map((e) => e.toJson()).toList(),
        'count': count,
      });

      emit(StockLoaded(
        stocks: stocks,
        sectors: sectors,
        count: count,
      ));
    } catch (e) {
      final cachedData = cacheBox.get('stocks_cache') as Map<dynamic, dynamic>?;
      if (cachedData != null) {
        final stocks = (cachedData['stocks'] as List)
            .map((e) => Stock.fromJson(e as Map<dynamic, dynamic>))
            .toList();

        final sectors = (cachedData['sectors'] as List)
            .map((e) => Sector.fromJson(e as Map<dynamic, dynamic>))
            .toList();

        final count = cachedData['count'] as int;

        emit(StockLoaded(
          stocks: stocks,
          sectors: sectors,
          count: count,
        ));
      } else {
        emit(const StockError('Failed to load stocks: Please Try Again'));
      }
    }
  }

  Future<void> _onLoadMoreStocks(
      LoadMoreStocks event, Emitter<StockState> emit) async {
    if (isLoading || !hasMoreData) return;
    isLoading = true;

    try {
      currentPage++;
      final QueryOptions options = QueryOptions(
        document: gql(stockQuery),
        variables: {
          'market': loadMarket,
          'sectors': event.sectors,
          'page': currentPage,
          'limit': event.limit,
        },
      );

      final Map<String, dynamic>? result = await graphQLService.performQuery(stockQuery ,variables: {
          'market': loadMarket,
          'sectors': event.sectors,
          'page': currentPage,
          'limit': event.limit,
        },);

      // if (result.hasException) {
      //   throw result.exception!;
      // }

      final data = result!;
      final newStocks = (data['jittaRanking']['data'] as List)
          .map((e) => Stock.fromJson(e))
          .toList();

      final currentState = state;
      if (currentState is StockLoaded) {
        final updatedStocks = List<Stock>.from(currentState.stocks)
          ..addAll(newStocks);

        // อัปเดตข้อมูลใน cache หลังจากโหลดเพิ่มเติมสำเร็จ
        cacheBox.put('stocks_cache', {
          'stocks': updatedStocks.map((e) => e.toJson()).toList(),
          'sectors': currentState.sectors.map((e) => e.toJson()).toList(),
          'count': currentState.count,
        });

        emit(StockLoaded(
          stocks: updatedStocks,
          sectors: currentState.sectors,
          count: currentState.count,
        ));
      }

      hasMoreData = newStocks.length < result['jittaRanking']['count'];
    } catch (e) {
      /// emit stock no internet
      isLoading = false;
    } finally {
      isLoading = false;
    }
  }
}
