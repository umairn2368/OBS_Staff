import 'package:flutter/material.dart';
// import 'package:mvvmexample/services/web_service.dart';
// import 'package:mvvmexample/viewModel/movie_view_model.dart';

class UserListViewModel extends ChangeNotifier {

  List<UserListViewModel> movies = List<UserListViewModel>.empty();

  Future<void> fetchUser(String keyword) async {

  //   final results = await Webservice().fetchMovies(keyword);
  //   this.movies = results.map((item) => MovieViewModel(movie: item)).toList();
    notifyListeners();
  }
}
