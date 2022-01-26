import 'package:sidq/core/network/network_info.dart';
import 'package:sidq/core/remote_data_function/http_methods.dart';
import 'package:sidq/features/report_fake_news/data/model/ticket_request_model.dart';
import 'package:sidq/features/report_fake_news/data/remote_data/add_ticket.dart';

abstract class AddVoteRemoteData {
  Future<void> addVote (String newsId, bool vote);
}



class AddVoteRemoteDataImp implements AddVoteRemoteData {
  final NetworkFunctions networkFunctions;
  final NetworkInf networkInf ;

  AddVoteRemoteDataImp(this.networkFunctions, this.networkInf);

  @override
  Future<void> addVote(String newsId, bool vote) async {
      return await networkFunctions.postMethod(body: {"newsId" : newsId,
      "isTrue" : vote
    },
      url: '/Client/Vote/Create', baseurl: networkInf.baseUrl);
  }
}

