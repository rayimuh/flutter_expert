part of 'search_tv_bloc.dart';

abstract class SearchEvent extends Equatable {
  const SearchEvent();

  @override
  List<Object> get props => [];
}

class OnTvQueryChanged extends SearchEvent {
  final String query;
 
  const OnTvQueryChanged(this.query);
 
  @override
  List<Object> get props => [query];
}