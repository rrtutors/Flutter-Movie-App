import 'dart:convert';

import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'movie_details.dart';
import 'reusable_card.dart';
import 'package:swipedetector/swipedetector.dart';
import 'package:http/http.dart' as http;

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

Future<Map> getJson() async {
  var apiKey = 'TMDB_MOVIE_API_KEY';
  var url = 'http://api.themoviedb.org/3/discover/movie?api_key=${apiKey}';
  var response = await http.get(url);
  return json.decode(response.body);
}

class _HomeState extends State<Home> {
  Text title = Text('MovieApp');
  var image_url;
  var movies;
  var overview;
  var movieTitle;
  var releaseDate;
  var voteAverage;

  getMovies() async {
    http.Response response = await http.get(
        'https://api.themoviedb.org/4/movie/550?api_key=TMDB_MOVIE_API_KEY');
    var results = jsonDecode(response.body);
  }

  double sliderPosition = 1.0;

  void getData() async {
    var data = await getJson();

    setState(() {
      movies = data['results'];
      image_url = 'https://image.tmdb.org/t/p/w500/';
      movieTitle = movies[0]['title'];
    });
  }

  @override
  Widget build(BuildContext context) {
    getData();
    getMovies();
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: Icon(Icons.menu),
        centerTitle: true,
        title: title,
        actions: [

          Icon(Icons.search),
          Padding(padding: EdgeInsets.only(left: 18))
        ],
      ),
      backgroundColor: Color(0xFFEEDDFD),
      body: ListView(
        shrinkWrap: true,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Text('Discover'),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SwipeDetector(
                    swipeConfiguration: SwipeConfiguration(
                      horizontalSwipeMinDisplacement: 10
                    ),
                    onSwipeRight: () {

                      setState(() {
                        sliderPosition > 0
                            ? sliderPosition--
                            : sliderPosition = 0;
                        print(" sliderPosition $sliderPosition");
                      });
                    },
                    onSwipeLeft: () {

                      setState(() {
                        print(" sliderPosition $sliderPosition");
                        sliderPosition < 2
                            ? sliderPosition++
                            : sliderPosition = 2;
                      });
                    },
                    child: ReusableCard(
                      height: MediaQuery.of(context).size.height / 3.3,
                      width: MediaQuery.of(context).size.width,
                      cardChild: ClipRRect(
                        borderRadius: BorderRadius.all(
                          Radius.circular(10.0),
                        ),
                        child: Image.network(
                          sliderPosition == 0
                              ? 'https://cdn.pixabay.com/photo/2017/06/18/14/47/bindi-2416039__340.jpg'
                              : (sliderPosition==1)?'https://cdn.pixabay.com/photo/2019/06/06/11/51/jewellery-4255833__340.jpg':'https://cdn.pixabay.com/photo/2020/01/17/19/08/beautiful-indian-woman-4773817__340.jpg',
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  DotsIndicator(

                    dotsCount: 3,
                    position: sliderPosition,
                    decorator: DotsDecorator(
                      activeColor: Colors.black,
                      size: const Size(18.0, 5.0),
                      activeSize: const Size(18.0, 5.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      activeShape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(left: 20, top: 10, bottom: 10),
                child: Text('Trending'),
              ),
              Container(
                margin: EdgeInsets.only(right: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 20, top: 10, bottom: 10),
                      child: Text(
                        'Latest',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ),

                  ],
                ),
              ),
              Container(
                height: MediaQuery.of(context).size.height / 3.0,
                width: MediaQuery.of(context).size.width,
                // color: Colors.blue,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: movies == null ? 0 : movies.length,
                  itemBuilder: (context, i) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                MovieDetails(movie: movies[i]),
                          ),
                        );
                      },
                      child: Container(

                        child: Column(
                          children: [
                            Expanded(
                              child: ReusableCard(
                                // colour: Colors.blue,
                                height: 160,
                                width: 110,
                                cardChild: Image(
                                  image: NetworkImage(
                                    image_url + movies[i]['poster_path'],
                                  ),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Column(
                              children: [
                                Container(
                                  width: 150.0,
                                  child: Column(
                                    children: [
                                      Text(
                                        movies[i]['title'],
                                        overflow: TextOverflow.ellipsis,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.normal,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Text(
                                  movies[i]['release_date']
                                      .toString()
                                      .substring(0, 4),
                                  style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 5),
                                ),
                                Text(
                                  '${movies[i]['vote_average']}⭐',
                                  style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
              Container(
                height: MediaQuery.of(context).size.height / 3.0,
                width: MediaQuery.of(context).size.width,
                // color: Colors.blue,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: movies == null ? 0 : movies.length,
                  itemBuilder: (context, i) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                MovieDetails(movie: movies[i]),
                          ),
                        );
                      },
                      child: Container(

                        child: Column(
                          children: [
                            Expanded(
                              child: ReusableCard(
                                // colour: Colors.blue,
                                height: 160,
                                width: 110,
                                cardChild: Image(
                                  image: NetworkImage(
                                    image_url + movies[i]['poster_path'],
                                  ),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Column(
                              children: [
                                Container(
                                  width: 150.0,
                                  child: Column(
                                    children: [
                                      Text(
                                        movies[i]['title'],
                                        overflow: TextOverflow.ellipsis,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.normal,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Text(
                                  movies[i]['release_date']
                                      .toString()
                                      .substring(0, 4),
                                  style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 5),
                                ),
                                Text(
                                  '${movies[i]['vote_average']}⭐',
                                  style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ), Container(
                height: MediaQuery.of(context).size.height / 3.0,
                width: MediaQuery.of(context).size.width,
                // color: Colors.blue,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: movies == null ? 0 : movies.length,
                  itemBuilder: (context, i) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                MovieDetails(movie: movies[i]),
                          ),
                        );
                      },
                      child: Container(

                        child: Column(
                          children: [
                            Expanded(
                              child: ReusableCard(
                                // colour: Colors.blue,
                                height: 160,
                                width: 110,
                                cardChild: Image(
                                  image: NetworkImage(
                                    image_url + movies[i]['poster_path'],
                                  ),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Column(
                              children: [
                                Container(
                                  width: 150.0,
                                  child: Column(
                                    children: [
                                      Text(
                                        movies[i]['title'],
                                        overflow: TextOverflow.ellipsis,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.normal,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Text(
                                  movies[i]['release_date']
                                      .toString()
                                      .substring(0, 4),
                                  style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 5),
                                ),
                                Text(
                                  '${movies[i]['vote_average']}⭐',
                                  style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _showAlertInfo(BuildContext context) {
    var alert = new AlertDialog(
      title: Text("Info"),
      content: Text("Made With Flutter by MikkyBoy"),
      actions: <Widget>[
        FlatButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text("OK"),
        )
      ],
    );

    showDialog(context: context, builder: (context) => alert);
  }
}