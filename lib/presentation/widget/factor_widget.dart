import 'package:flutter/material.dart';
import 'package:jitta_app/data/model/stockDetail/factor_model.dart';

class JittaFactorsWidget extends StatelessWidget {
  final FactorItem factors;

  JittaFactorsWidget({required this.factors});

  @override
  Widget build(BuildContext context) {
    final factorValues = factors;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
          child: Text(
            'Jitta Factor',
            style: TextStyle(
              color: Colors.black,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        _buildFactorRow(factorValues.growth),
        _buildFactorRow(factorValues.recent),
        _buildFactorRow(factorValues.financial),
        _buildFactorRow(factorValues.returns),
        _buildFactorRow(factorValues.management),
      ],
    );
  }

  Widget _buildFactorRow(FactorValue factor) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            factor.name,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.normal,
              color: Colors.black,
            ),
          ),
          Row(
            children: [
              Expanded(
                child: LinearProgressIndicator(
                  value: factor.value / 100,
                  backgroundColor: Colors.grey[800],
                  color: _getColorByLevel(factor.level),
                ),
              ),
              const SizedBox(width: 10),
              Text(
                factor.value.toString(),
                style: const TextStyle(color: Colors.black),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Color _getColorByLevel(String level) {
    switch (level) {
      case 'HIGH':
        return Colors.green;
      case 'MEDIUM':
        return Colors.blueAccent;
      case 'LOW':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }
}
