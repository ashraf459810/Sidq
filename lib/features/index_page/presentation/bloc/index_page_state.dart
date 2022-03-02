part of 'index_page_bloc.dart';

abstract class IndexPageState extends Equatable {
  const IndexPageState();  

  @override
  List<Object> get props => [];
}
class IndexPageInitial extends IndexPageState {}


class GetUserIdState extends IndexPageState {
  final String id ;

 const  GetUserIdState(this.id);

}

class Loading extends IndexPageState {
  
}

class Error extends IndexPageState {
  final String error ;

 const  Error(this.error);
}