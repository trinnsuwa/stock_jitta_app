import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:jitta_app/presentation/bloc/stockRanking/ranking_bloc.dart';
import 'package:jitta_app/presentation/bloc/stockRanking/ranking_event.dart';
import 'package:jitta_app/presentation/bloc/stockRanking/ranking_state.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:jitta_app/service/graphql_service.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:hive/hive.dart';

import 'ranking_bloc_test.mocks.dart';

// Mock classes
class MockBox extends Mock implements Box {}

@GenerateMocks([GraphQLService, GraphQLClient])
void main() {
  late StockBloc stockBloc;
  late MockGraphQLService mockService;
  late MockGraphQLClient mockClient;
  late MockBox mockCacheBox;

  setUp(() {
    mockClient = MockGraphQLClient();
    mockService = MockGraphQLService(mockClient: mockClient);
    mockCacheBox = MockBox();
    stockBloc = StockBloc(mockService, mockCacheBox);
  });
  test('initial state is StockInitial', () {
    expect(stockBloc.state, StockInitial());
  });

  blocTest<StockBloc, StockState>(
    'emits [StockLoading, StockError] when FetchStockByRanking fails',
    build: () {
      return stockBloc;
    },
    act: (bloc) => bloc.add(
      const FetchStockByRanking(market: 'AAA', sectors: '',)),
    expect: () => [
      StockLoading(),
      const StockError('Failed to load stocks: Please Try Again'),
    ],
  );
}
