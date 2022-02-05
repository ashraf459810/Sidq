import 'package:sidq/core/network/network_info.dart';
import 'package:sidq/core/remote_data_function/http_methods.dart';
import 'package:sidq/features/home/data/models/search_params_model.dart';
import 'package:sidq/features/review_tickets/data/models/tickets_response_model.dart';

abstract class GetTicketsRemoteData {
   Future <dynamic> getTickers(int ?type);
}


class GetTicketsRemoteDataImp implements GetTicketsRemoteData {

  final NetworkFunctions networkFunctions;
  final NetworkInf networkInf ;

  GetTicketsRemoteDataImp(this.networkFunctions, this.networkInf);

  @override
  Future getTickers(int? type) async {
    var response = await networkFunctions.postMethod(body: searchParamsModelToJson( SearchParamsModel(pageLength: 1000,pageNumber: 0,orderDescending: true,type: type)),
      url: '/Client/Ticket/FilterDatatable', baseurl: networkInf.baseUrl);
    return ticketsResponseModelFromJson(response);
  }
}
