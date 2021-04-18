import 'package:befit_app/UI/Login.dart';
import 'package:befit_app/UI/register.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

class OnboardingScreen extends StatefulWidget {
  static String routeName = "/OnboardingScreen";

  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  SwiperController _controller = SwiperController();
  int _currentIndex = 0;
  final List<String> titles = [
    "Welcome",
    "Be Fit App",
    "Classes in gym",
  ];
  final List<String> subtitles = [
    "Welcome to \n Be FiT  ",
    " APP can booking \n the gym near you",
    "APP can booking classes in gyms "
  ];
  final List<Color> colors = [
    Colors.black38,
    Colors.black45,
    Colors.black54,
  ];
  final List<String> images = [
    "https://ichef.bbci.co.uk/news/976/cpsprodpb/C05C/production/_113744294_gettyimages-1183038884.jpg",
    "https://ichef.bbci.co.uk/news/976/cpsprodpb/C312/production/_115083994_gym2.jpg",
    "https://previews.123rf.com/images/tonobalaguer/tonobalaguer1405/tonobalaguer140500178/28672021-zumba-dance-cardio-people-group-training-at-fitness-gym-workout-exercise.jpg",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Swiper(
            loop: false,
            index: _currentIndex,
            onIndexChanged: (index) {
              setState(() {
                _currentIndex = index;
              });
            },
            controller: _controller,
            pagination: SwiperPagination(
              builder: DotSwiperPaginationBuilder(
                activeColor: Colors.blue,
                activeSize: 20.0,
              ),
            ),
            itemCount: 3,
            itemBuilder: (context, index) {
              return IntroItem(
                  title: titles[index],
                  subtitle: subtitles[index],
                  bg: colors[index],
                  imageUrl: images[index]);
            },
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: FlatButton(
              child: Text(
                "Skip",
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () {
                Navigator.pushReplacement(
                    context, MaterialPageRoute(builder: (context) => Register()));
              },
            ),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: IconButton(
              icon: Icon(
                _currentIndex == 2 ? Icons.check : Icons.arrow_forward,
                color: Colors.white,
              ),
              onPressed: () {
                if (_currentIndex != 2)
                  _controller.next();
                else
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => Register()));
              },
            ),
          )
        ],
      ),
    );
  }
}

class IntroItem extends StatelessWidget {
  final String title;
  final String subtitle;
  final Color bg;
  final String imageUrl;

  const IntroItem(
      {Key key, @required this.title, this.subtitle, this.bg, this.imageUrl})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: bg ?? Theme.of(context).primaryColor,
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: <Widget>[
              const SizedBox(height: 40),
              Text(
                title,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 35.0,
                    color: Colors.white),
              ),
              if (subtitle != null) ...[
                const SizedBox(height: 20.0),
                Text(
                  subtitle,
                  style: TextStyle(color: Colors.white, fontSize: 24.0),
                  textAlign: TextAlign.center,
                ),
              ],
              const SizedBox(height: 40.0),
              Expanded(
                child: Container(
                  margin: const EdgeInsets.only(bottom: 70),
                  width: double.infinity,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20.0),
                    child: Material(
                      elevation: 4.0,
                      child: Image.network(
                        imageUrl,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
