import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:hive/hive.dart';
import 'package:jitta_app/utils/constants.dart';

import 'sector_event.dart';
import 'sector_state.dart';

class SectorBloc extends Bloc<SectorEvent, SectorState> {
  final GraphQLClient client;
  final Box cacheBox;

  SectorBloc(this.client, this.cacheBox) : super(SectorInitial()) {
    on<FetchSectors>(_onFetchSectors);
  }

  void _onFetchSectors(FetchSectors event, Emitter<SectorState> emit) async {
    emit(SectorLoading());

    try {
      final QueryResult result = await client.query(QueryOptions(
        document: gql(sectorsQuery),
      ));

      if (result.hasException) {
        throw result.exception!;
      }

      final List<String> sectors = (result.data?['listJittaSectorType'] as List)
          .map((e) => e['name'].toString())
          .toList();
      await cacheBox.put('sectors', sectors);

      emit(SectorLoaded(sectors));
    } catch (e) {
      final List<String> cachedSectors = cacheBox.get('sectors', defaultValue: <String>[]);
      if (cachedSectors.isNotEmpty) {
        emit(SectorLoaded(cachedSectors));
      } else {
        emit(SectorError('Failed to load sectors: Check your internet'));
      }
    }
  }
}
