// import 'package:flutter/material.dart';
// import 'package:mvvmexample/viewModel/movie_view_model.dart';


// class MovieList extends StatelessWidget {

//   final List<MovieViewModel> movies;

//   const MovieList({required this.movies});

//   @override
//   Widget build(BuildContext context) {
//     return ListView.builder(
//       itemCount: this.movies.length,
//       itemBuilder: (context, index) {

//         final movie = this.movies[index];

//         return ListTile(
//           contentPadding: EdgeInsets.all(10),
//           leading: Container(
//             decoration: BoxDecoration(
//                 image: DecorationImage(
//                     fit: BoxFit.cover,
//                     image: NetworkImage(movie.poster)
//                 ),
//                 borderRadius: BorderRadius.circular(6)
//             ),
//             width: 50,
//             height: 100,
//           ),
//           title: Text(movie.title),
//         );
//       },
//     );
//   }
// }