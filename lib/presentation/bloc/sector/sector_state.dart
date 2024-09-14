import 'package:equatable/equatable.dart';

abstract class SectorState extends Equatable{

    @override
  List<Object> get props => [];
}

class SectorInitial extends SectorState {}

class SectorLoading extends SectorState {}

class SectorLoaded extends SectorState {
  final List<String> sectors;
  SectorLoaded(this.sectors);

  @override
  List<Object> get props => [sectors];
}

class SectorError extends SectorState {
  final String message;
  SectorError(this.message);
}