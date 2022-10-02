import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:nasa_space_app/models/content.dart';

import '../../../repo/datareposotry.dart';

part 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  SearchCubit() : super(SearchInitial());


    final DataRepo dataRepo = DataRepo();
  List<Content> _contentlist = [];
  List<Content> get contentlist => _contentlist;

  Future<void> getdata(String quiry) async {
    emit(SearchLoading());
    try {
      _contentlist = await dataRepo.data(quiry);
      emit(Searchdone(contents: contentlist));
    } catch (e) {
      debugPrint(e.toString());
      emit(SearchFail());
    }
  }
}

