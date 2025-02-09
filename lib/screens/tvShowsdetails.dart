import 'package:day9_task/model/tv_shows.dart';
import 'package:flutter/material.dart';
import 'package:day9_task/web_service/api_service.dart';

class TVShowsDetailsScreen extends StatelessWidget {
  TVShowsDetailsScreen(
      {super.key,
      required this.id,
      required this.name,
      required this.path,
      required this.overview,
      required this.firstAirDate,
      required this.language});
  int id;
  String name;
  String path;
  String overview;
  String firstAirDate;
  String language;
  late Future<List<tv_show>> recommendations =
      ApiService().getRecommendations(id);
  late Future<List<dynamic>> seasons = ApiService().getSeasons(id);

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
              height: 6,
            ),
            Text(
              "Seasons",
              style: TextStyle(
                  color: Colors.green,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
            FutureBuilder<List<dynamic>>(
                future: seasons,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Text("Error loading Seasons");
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return Text("No Seasons Available");
                  }
                  return Column(
                    children: snapshot.data!.map((season) {
                      return ListTile(
                        title: Text(
                          season['name'],
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        subtitle: Text("Episodes: ${season['episode_count']}"),
                      );
                    }).toList(),
                  );
                }),
            SizedBox(
              height: 6,
            ),
            Text(
              "Recommendations",
              style: TextStyle(
                  color: Colors.green,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
            FutureBuilder<List<tv_show>>(
                future: recommendations,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Text("Error loading recommended shows");
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return Text("No recommendations available");
                  }
                  return Column(
                    children: snapshot.data!.map((show) {
                      return ListTile(
                        leading: Image.network(
                            'https://image.tmdb.org/t/p/w92${show.posterPath}'),
                        title: Text(
                          show.name,
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      );
                    }).toList(),
                  );
                })
          ],
        ),
      )),
    );
  }
}
