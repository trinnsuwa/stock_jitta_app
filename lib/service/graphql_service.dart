import 'package:graphql_flutter/graphql_flutter.dart';

class GraphQLService {
  final GraphQLClient client;

  GraphQLService({required this.client});

  Future<Map<String,dynamic>?> performQuery(String query, {Map<String, dynamic>? variables}) async {
    final options = QueryOptions(
      document: gql(query),
      variables: variables ?? {},
    );
    QueryResult queryResult = await client.query(options);

    return queryResult.data;
  }
}