import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jitta_app/presentation/bloc/stockRanking/ranking_bloc.dart';
import 'package:jitta_app/presentation/bloc/stockRanking/ranking_event.dart';
import 'package:jitta_app/presentation/bloc/sector/sector_bloc.dart';
import 'package:jitta_app/presentation/bloc/sector/sector_event.dart';
import 'package:jitta_app/presentation/bloc/sector/sector_state.dart';
import 'package:jitta_app/utils/constants.dart';

class SectorDropdown extends StatefulWidget {
  const SectorDropdown({super.key});

  @override
  _SectorDropdownState createState() => _SectorDropdownState();
}

class _SectorDropdownState extends State<SectorDropdown> {
  String? selectedSector;
  String selectedMarket = 'TH';

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      child: Row(
        children: [
          DropdownButton<String>(
            value: selectedMarket,
            items: marketsCountry.entries.map((entry) {
              return DropdownMenuItem<String>(
                value: entry.key,
                child: Text(entry.value),
              );
            }).toList(),
            onChanged: (newValue) {
              setState(() {
                selectedMarket = newValue!;
              });
              context.read<StockBloc>().add(FetchStockByRanking(
                  market: selectedMarket, page: 0, limit: 10, sectors: selectedSector));
            },
          ),
          DropdownButton<String>(
            value: selectedSector,
            hint: const Text('All Sector'),
            items: sector.entries.map((entry) {
              return DropdownMenuItem<String>(
                value: entry.key,
                child: Text(entry.value),
              );
            }).toList(),
            onChanged: (value) {
              setState(() {
                selectedSector = value;
              });
              context.read<StockBloc>().add(FetchStockByRanking(
                    market: selectedMarket,
                    page: 0,
                    limit: 10,
                    sectors: selectedSector,
                  ));
            },
          ),
        ],
      ),
    );
  }
}
