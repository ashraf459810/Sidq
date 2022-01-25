import 'dart:collection';
import 'dart:developer';

import 'package:sidq/core/network/network_info.dart';
import 'package:sidq/core/remote_data_function/http_methods.dart';
import 'package:sidq/features/report_fake_news/data/model/ticket_request_model.dart';

abstract class AddTicketRemoteData {
  Future<void> addTicket (TicketRequestBody ticketRequestBody);
}

class AddTicketRemoteDataImp implements AddTicketRemoteData{
  final NetworkFunctions networkFunctions;
  final NetworkInf networkInf;

  AddTicketRemoteDataImp(this.networkFunctions, this.networkInf);

  @override
  Future<void> addTicket(TicketRequestBody ticketRequestBody) async {
    log(ticketRequestBodyToJson(ticketRequestBody));
   return await  networkFunctions.postMethod(body: ticketRequestBodyToJson(ticketRequestBody),
     url: '/Client/Ticket/Create', baseurl: networkInf.baseUrl);
  }
}