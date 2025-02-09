import 'package:day9_task/web_service/api_service.dart';
import 'package:day9_task/model/tv_shows.dart';
import 'package:day9_task/screens/tvShowsdetails.dart';
import 'package:flutter/material.dart';

class TVShowsListPage extends StatefulWidget {
  const TVShowsListPage({super.key});

  @override
  State<TVShowsListPage> createState() => _TVShowsListPageState();
}

class _TVShowsListPageState extends State<TVShowsListPage> {
  late Future<List<tv_show>> tvShows;
  final ScrollController _scrollController = ScrollController();
  int currentPage = 1;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    tvShows = ApiService().getTVShows(currentPage);
    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
          _scrollController.position.maxScrollExtent) {
        getMoreTVShows();
      } else if (_scrollController.position.pixels <=
          _scrollController.position.minScrollExtent) {
        getBeforeTVShows();
      }
    });
  }

  void getMoreTVShows() {
    setState(() {
      currentPage++;
      tvShows = ApiService().getTVShows(currentPage);
    });
  }

  void getBeforeTVShows() {
    setState(() {
      if (currentPage > 1) {
        currentPage--;
        tvShows = ApiService().getTVShows(currentPage);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber,
        title: Text('TV SHOWS'),
      ),
      body: FutureBuilder<List<tv_show>>(
        future: tvShows,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
                child: CircularProgressIndicator(
              backgroundColor: Colors.blue,
              color: Colors.pink,
            ));
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Exception ${snapshot.error}'),
            );
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(
              child: Text('No Shows avaliable'),
            );
          }
          return ListView.builder(
            controller: _scrollController,
            itemBuilder: (context, index) {
              final tvshow = snapshot.data![index];
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => TVShowsDetailsScreen(
                              name: tvshow.name,
                              path: tvshow.posterPath,
                              overview: tvshow.overview,
                              firstAirDate: tvshow.firstAirDate,
                              language: tvshow.originalLanguage,
                            )),
                  );
                },
                child: Card(
                  margin: EdgeInsets.symmetric(vertical: 6, horizontal: 10),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  child: Row(
                    children: [
                      Container(
                        width: 100,
                        height: 100,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            image: DecorationImage(
                              image: NetworkImage(
                                  'https://image.tmdb.org/t/p/w500${tvshow.posterPath}'),
                              fit: BoxFit.cover,
                            )),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Expanded(
                          child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            tvshow.name,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            tvshow.overview,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          )
                        ],
                      ))
                    ],
                  ),
                ),
              );
            },
            itemCount: snapshot.data!.length,
          );
        },
      ),
    );
  }
}
