import 'package:flutter/material.dart';
import 'reusable_card.dart';
import 'package:swipedetector/swipedetector.dart';

class MovieDetails extends StatefulWidget {
  final movie;
  const MovieDetails({Key key, this.movie});
  @override
  _MovieDetailsState createState() => _MovieDetailsState();
}

class _MovieDetailsState extends State<MovieDetails> {
  var image_url = 'https://image.tmdb.org/t/p/w500/';
  @override
  Widget build(BuildContext context) {
    print(widget.movie);
    return Scaffold(
      backgroundColor: Color(0xFFEEDDFD),
      body: Column(
        children: [
          SwipeDetector(
            onSwipeDown: () {
              Navigator.pop(context);
            },
            child: Container(
              alignment: Alignment.center,
              child: new Container(
                width: 400.0,
                height: MediaQuery.of(context).size.height / 2,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                image: DecorationImage(
                  image: NetworkImage(
                    image_url + widget.movie['poster_path'],
                  ),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Expanded(
            child: Container(
              // height: MediaQuery.of(context).size.height / 2.59,
              child: ListView(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          ReusableCard(
                            cardChild: Padding(
                              padding: const EdgeInsets.only(
                                left: 10.0,
                                top: 3.0,
                                bottom: 3.0,
                                right: 10.0,
                              ),
                              child: Text(
                                'Action',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                            ),
                          ),
                          ReusableCard(
                            cardChild: Padding(
                              padding: const EdgeInsets.only(
                                left: 10.0,
                                top: 3.0,
                                bottom: 3.0,
                                right: 10.0,
                              ),
                              child: Text(
                                'Comedy',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                            ),
                          ),
                          ReusableCard(
                            cardChild: Padding(
                              padding: const EdgeInsets.only(
                                left: 10.0,
                                top: 3.0,
                                bottom: 3.0,
                                right: 10.0,
                              ),
                              child: Text(
                                'Horror',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 15.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'An entire universe. Once and for all',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                            Padding(
                                padding: EdgeInsets.symmetric(vertical: 10.0)),
                            Text('Overview'),
                            Padding(
                                padding: EdgeInsets.symmetric(vertical: 10.0)),
                            Column(
                              children: [
                                Text(
                                  widget.movie['overview'],
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}