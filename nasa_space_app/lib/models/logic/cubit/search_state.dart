part of 'search_cubit.dart';

@immutable
abstract class SearchState {}

class SearchInitial extends SearchState {}
class SearchLoading extends SearchState{}
class Searchdone extends SearchState{
  final List<Content> contents ;
  Searchdone({required this.contents});
}
class SearchEmpry extends SearchState{}
class SearchFail extends SearchState{}
