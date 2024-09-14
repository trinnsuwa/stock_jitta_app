import 'package:flutter/material.dart';
import 'package:jitta_app/presentation/bloc/stockDetail/stock_detail_bloc.dart';
import 'package:jitta_app/presentation/bloc/stockRanking/ranking_bloc.dart';
import 'package:jitta_app/presentation/pages/home.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:jitta_app/service/graphql_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();
  await Hive.openBox('cacheBox');

  GraphQLClient graphQLClient = GraphQLClient(
    cache: GraphQLCache(),
    link: HttpLink('https://thecollector-staging-l6chkvtlsa-df.a.run.app/'),
  );

  final graphQLService = GraphQLService(client: graphQLClient);

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (context) =>
                StockBloc(graphQLService, Hive.box('cacheBox'))),
        BlocProvider(
            create: (context) =>
                StockDetailBloc(graphQLService: graphQLService)),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Jitta Stock Ranking',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
            seedColor: const Color.fromARGB(255, 7, 104, 183)),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}
