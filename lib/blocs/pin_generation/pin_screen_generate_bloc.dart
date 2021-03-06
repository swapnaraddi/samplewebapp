import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:ydrs_desktop_app/network/models/login/pin_generation_model.dart';
import 'package:ydrs_desktop_app/network/services/login/pin_generation_api.dart';
part 'pin_screen_generate_event.dart';
part 'pin_screen_generate_state.dart';

class PinScreenGenerateBloc
    extends Bloc<PinGenerateScreenEvent, PinGenerateScreenState> {
  PinGenerateResponse pinGenerateResponse;

  ///creating object of model class for pin generation
  PinScreenGenerateBloc(this.pinGenerateResponse)
      : super(PinGenerateScreenState());

  @override
  Stream<PinGenerateScreenState> mapEventToState(
    PinGenerateScreenEvent event,
  ) async* {
    if (event is PinGenerateScreenEvent) {
      ///checking if event is present in Event class
      // print(event.memberId);
      PinGenerateModel pinGenerateModel = await pinGenerateResponse
          .pinGeneratePostApiMethod(event.memberId, event.pin);

      ///storing api response in model class
      // print(pinGenerateModel);
      try {
        if (pinGenerateModel.header.statusCode == "200") {
          ///checking for status code of response.
          // print('Validate Screen');
          yield PinGenerateScreenState(isTrue: true);

          ///if true then navigating to next screen
        } else if (pinGenerateModel.header.statusCode == "406") {
          ///else showing message to user
          // print('ShowSnackbar');
          var statusMsg = pinGenerateModel.header.statusMessage;
          yield PinGenerateScreenState(isTrue: false, statusMsg: statusMsg);
        }
      } catch (exception) {
        // print('Unknown Error:$exception');
      }
    }
  }
}
