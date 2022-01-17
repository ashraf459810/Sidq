import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:sidq/features/reverse_serach/domain/usecases/upload_image_use_case.dart';

part 'reverse_serach_event.dart';
part 'reverse_serach_state.dart';

class ReverseSerachBloc extends Bloc<ReverseSerachEvent, ReverseSerachState> {
  final UploadImageUseCase uploadImageUseCase;
  ReverseSerachBloc(this.uploadImageUseCase) : super(ReverseSerachInitial()) {
    on<ReverseSerachEvent>((event, emit) async {
      if (event is UploadImageEvent) {
        emit(Loading());
        var result =
            await uploadImageUseCase.uploadImageUseCase(event.imageLink);

        result.fold((l) => emit(Error(l.error.toString())),
            (r) => emit(UploadImageState(r)));
      }
    });
  }
}
