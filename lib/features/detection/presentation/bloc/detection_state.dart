import 'package:equatable/equatable.dart';
import '../../domain/entities/detected_item.dart';

/// Base class for all detection states
/// States = how the UI should look

abstract class DetectionState extends Equatable {
  const DetectionState();

  @override
  List<Object?> get props => [];
}

class DetectionInitial extends DetectionState {}

class DetectionLoading extends DetectionState {}

class DetectionSuccess extends DetectionState {
  final DetectionResult result;
  const DetectionSuccess(this.result);

  @override
  List<Object?> get props => [result];

  // helper getters for UI
  int get itemCount => result.items.length;
  bool get hasItems => result.items.isNotEmpty;
}

// Error State
class DetectionError extends DetectionState {
  final String msg;
  const DetectionError(this.msg);

  @override
  List<Object?> get props => [msg];
}
