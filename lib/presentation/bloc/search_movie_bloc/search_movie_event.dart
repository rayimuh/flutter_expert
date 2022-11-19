part of 'search_movie_bloc.dart';

abstract class SearchEvent extends Equatable {
  const SearchEvent();

  @override
  List<Object> get props => [];
}

class OnMovieQueryChanged extends SearchEvent {
  final String query;
  const OnMovieQueryChanged(this.query);

  @override
  List<Object> get props => [query];
}


