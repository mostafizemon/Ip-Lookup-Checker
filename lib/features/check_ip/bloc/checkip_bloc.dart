import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:bloc/bloc.dart';
import 'package:ip_lookup_check/features/check_ip/models/ip_lookup_model.dart';
import 'package:meta/meta.dart';

part 'checkip_event.dart';
part 'checkip_state.dart';

class CheckipBloc extends Bloc<CheckipEvent, CheckipState> {
  CheckipBloc() : super(CheckipInitial()) {
    on<FetchIpLookupEvent>(_fetchIpLookupEvent);
  }

  FutureOr<void> _fetchIpLookupEvent(
    FetchIpLookupEvent event,
    Emitter<CheckipState> emit,
  ) async {
    var client = http.Client();
    try {
      emit(CheckipLoading());
      var response = await client.post(
        Uri.parse(
          "https://ip-lookup-check.p.rapidapi.com/?ip=${event.ipAddress}",
        ),
        headers: {
          'Content-Type': 'application/json',
          'X-RapidAPI-Key':
              '7112593aa9mshe446ee575a35388p196027jsn6becb03fe943',
          'X-RapidAPI-Host': 'ip-lookup-check.p.rapidapi.com',
        },
      );
      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        emit(
          CheckipLoaded(
            ipAddress: event.ipAddress,
            responseData: IpLookupModel.fromJson(jsonData),
          ),
        );
      } else {
        emit(
          CheckipError(
            ipAddress: event.ipAddress,
            message: "Failed to load ip data",
          ),
        );
      }
    } catch (e) {
      emit(CheckipError(ipAddress: event.ipAddress, message: e.toString()));
    } finally {
      client.close();
    }
  }
}
