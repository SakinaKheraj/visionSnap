import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/detect_items.dart';
import 'detection_event.dart';
import 'detection_state.dart';

/// Detection BLoC - manages detection state
/// Flow:
/// 1. Receives events from UI
/// 2. Calls use cases to process
/// 3. Emits new states to UI

class DetectionBloc extends Bloc<DetectionEvent, DetectionState> {
  final DetectItems detectItems;

  DetectionBloc({required this.detectItems}) : super(DetectionInitial()) {
    on<DetectItemsEvent>(_onDetectItems);
    on<LoadDetectedItemsEvent>(_onLoadDetectedItems);
  }

  /// Handle DetectItemsEvent
  ///
  /// Steps:
  /// 1. Emit loading state
  /// 2. Call detect items use case
  /// 3. Emit success or error state

  Future<void> _onDetectItems(
    DetectItemsEvent event,
    Emitter<DetectionState> emit,
  ) async {
    print('Detection Started');
    emit(DetectionLoading());

    final result = await detectItems(
      DetectItemsParams(imageUrl: event.imageUrl, uploadId: event.uploadId),
    );

    result.fold(
      (failure) {
        print('Detection Failed: ${failure.msg}');
        emit(DetectionError(failure.msg));
      },
      (result) {
        print('Detection Success: ${result.items.length} items');
        emit(DetectionSuccess(result));
      },
    );
  }

  Future<void> _onLoadDetectedItems(
    LoadDetectedItemsEvent event,
    Emitter<DetectionState> emit,
  ) async {
    emit(const DetectionError('Not Implemented Yet'));
  }
}
