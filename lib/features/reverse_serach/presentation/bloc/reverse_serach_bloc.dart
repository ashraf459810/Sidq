import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:sidq/features/reverse_serach/data/model.dart/tineye_model.dart';
import 'package:sidq/features/reverse_serach/domain/usecases/tin_eye_use_case.dart';
import 'package:sidq/features/reverse_serach/domain/usecases/upload_image_use_case.dart';

part 'reverse_serach_event.dart';
part 'reverse_serach_state.dart';

class ReverseSerachBloc extends Bloc<ReverseSerachEvent, ReverseSerachState> {
  final TinyEyeUseCase tinyEyeUseCase ;
  final UploadImageUseCase uploadImageUseCase;
  ReverseSerachBloc(this.uploadImageUseCase, this.tinyEyeUseCase) : super(ReverseSerachInitial()) {
    on<ReverseSerachEvent>((event, emit) async {
      if (event is UploadImageEvent) {
        emit(Loading());
        var result =
            await uploadImageUseCase.uploadImageUseCase(event.imageLink);

        result.fold((l) => emit(Error(l.error.toString())),
            (r) => emit(UploadImageState(r.result!.link!)));
      }
         if (event is TinyEyeEvent) {
        emit(Loading());
        var result =
            await tinyEyeUseCase.tinyEyeUseCase(event.imageUrl, 12);

        result.fold((l) => emit(Error(l.error.toString())),
            (r) => emit(TinyEyeState(r)));
      }

    });
  }
}
