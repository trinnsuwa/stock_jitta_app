import 'package:flutter/material.dart';
import 'package:jitta_app/data/model/stockDetail/line_model.dart';
import 'package:jitta_app/data/model/stockDetail/monthly_price_model.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class GraphWidget extends StatefulWidget {
  final MonthlyPrice scoreData;
  final Line lineData;
  const GraphWidget(
      {super.key, required this.scoreData, required this.lineData});
  @override
  State<GraphWidget> createState() => _GraphWidgetState();
}

class _GraphWidgetState extends State<GraphWidget> {
  @override
  Widget build(BuildContext context) {
    final List<PriceItem> scoreDataList = widget.scoreData.values!;

    return SfCartesianChart(
      primaryXAxis: const CategoryAxis(
        interval: 1,
      ),
      legend: const Legend(isVisible: true),
      tooltipBehavior: TooltipBehavior(enable: true),
      series: <CartesianSeries>[
        LineSeries<PriceItem, dynamic>(
          dataSource: scoreDataList,
          xValueMapper: (PriceItem sales, _) => '${sales.year}-${sales.month}|',
          yValueMapper: (PriceItem sales, _) =>
              double.parse(sales.value.toStringAsFixed(2)),
          name: 'Price',
          color: Colors.blue,
        ),
      ],
    );
  }
}
