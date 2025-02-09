import 'package:flutter/material.dart';

class TVShowsDetailsScreen extends StatelessWidget {
  TVShowsDetailsScreen(
      {super.key,
      required this.name,
      required this.path,
      required this.overview,
      required this.firstAirDate,
      required this.language});
  String name;
  String path;
  String overview;
  String firstAirDate;
  String language;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Text('Details'),
      ),
      body: SingleChildScrollView(
          child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 300,
              height: 300,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                image: DecorationImage(
                  image: NetworkImage('https://image.tmdb.org/t/p/w500${path}'),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              name,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 3,
            ),
            Text(
              'First Air Date: ' + firstAirDate,
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.green),
            ),
            SizedBox(
              height: 3,
            ),
            Text(
              'Language: ' + language,
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.green),
            ),
            SizedBox(
              height: 3,
            ),
            Text(
              overview,
              style: TextStyle(
                fontSize: 16,
              ),
            ),
          ],
        ),
      )),
    );
  }
}
