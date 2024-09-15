import 'package:flutter/material.dart';
import 'package:jitta_app/data/model/stockDetail/stock_detail_model.dart';
import 'package:jitta_app/presentation/bloc/stockDetail/stock_detail_bloc.dart';
import 'package:jitta_app/presentation/bloc/stockDetail/stock_detail_event.dart';
import 'package:jitta_app/presentation/bloc/stockDetail/stock_detail_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jitta_app/presentation/widget/factor_widget.dart';
import 'package:jitta_app/presentation/widget/graph_widget.dart';
import 'package:url_launcher/url_launcher.dart';

class StockDetailPage extends StatefulWidget {
  final int stockId;
  final String id;

  const StockDetailPage({super.key, required this.stockId, required this.id});

  @override
  State<StockDetailPage> createState() => _StockDetailPageState();
}

class _StockDetailPageState extends State<StockDetailPage> {
  bool _showMore = false;
  @override
  void initState() {
    super.initState();
    context
        .read<StockDetailBloc>()
        .add(FetchStockDetail(stockId: widget.stockId, id: widget.id));
  }

  void _toggleShowMore() {
    setState(() {
      _showMore = !_showMore;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Stock Details'),
      ),
      body: BlocBuilder<StockDetailBloc, StockDetailState>(
        builder: (context, state) {
          if (state is StockDetailLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is StockDetailLoaded) {
            final StockDetail stock = state.stock;
            return SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    height: 150,
                    padding: const EdgeInsets.all(12.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Text(
                                  stock.title,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 6),
                              Expanded(
                                child: Text(
                                  stock.id,
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 6),
                              Expanded(
                                child: Text(
                                  'Jitta Ranking #${stock.comparison?.market?.rank} from ${stock.comparison?.market?.member} ',
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          height: 90,
                          padding: const EdgeInsets.all(16.0),
                          decoration: BoxDecoration(
                            color: Colors.lightBlue,
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          child: Column(
                            children: [
                              Text(
                                stock.jitta!.score!.last!.value!
                                    .toStringAsFixed(2),
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 8),
                              const Text(
                                'JITTA SCORE',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                      alignment: Alignment.centerLeft,
                      padding: const EdgeInsets.only(left: 12, bottom: 12),
                      child: Column(
                        children: [
                          stock.price?.latest?.datetime != null
                              ? Text(
                                  'Date: ( ${stock.price?.latest?.datetime} )')
                              : const SizedBox.shrink(),
                          Text(
                              'Latest Price: ${stock.price?.latest?.close} ${stock.priceCurrency}'),
                        ],
                      )),
                  GraphWidget(
                    scoreData: stock.jitta!.monthlyPrice!,
                    lineData: stock.jitta!.line!,
                  ),
                  const SizedBox(
                    height: 20,
                  ),


                  // Jitta Factors
                  stock.jitta!.factor != null
                      ? JittaFactorsWidget(factors: stock.jitta!.factor!.last!)
                      : const SizedBox.shrink(),

                  // Company Info
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Company Info.',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text('Sector',
                                style: TextStyle(fontSize: 12)),
                            Text(stock.sector?.name ?? '',
                                style: const TextStyle(fontSize: 12)),
                          ],
                        ),
                        const Divider(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text('Industry',
                                style: TextStyle(fontSize: 12)),
                            Text(
                              stock.industry ?? '',
                              style: const TextStyle(fontSize: 12),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                        const Divider(),
                        GestureDetector(
                          onTap: () async => {
                            if (await canLaunchUrl(Uri.parse(
                                'https://${stock.company!.link!.first.url}')))
                              {
                                await launchUrl(Uri.parse(
                                    'https://${stock.company!.link!.first.url}'))
                              }
                            else
                              {
                                throw 'Could not launch ${stock.company!.link!.first.url}'
                              }
                          },
                          child: const Padding(
                            padding: EdgeInsets.only(right: 19.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Website',
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.blue,
                                  ),
                                ),
                                Icon(Icons.open_in_new,
                                    color: Colors.blue, size: 16),
                              ],
                            ),
                          ),
                        ),

                        // Company Description
                        Container(
                          padding: const EdgeInsets.only(bottom: 12, top: 16),
                          alignment: Alignment.centerLeft,
                          child: const Text(
                            'Company Description',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 350,
                          child: Text(
                            _showMore
                                ? stock.summary!
                                : '${stock.summary!.substring(0, 100)}...',
                            softWrap: true,
                          ),
                        ),
                        TextButton(
                          onPressed: _toggleShowMore,
                          child: Text(_showMore ? 'Read Less' : 'Read More'),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          } else if (state is StockDetailError) {
            return Center(child: Text(state.message));
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }
}
