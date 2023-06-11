import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(viewportFraction: 0.8);
  }
  List category = [
    {"icon": "assets/images/headset.png", "name": "Headset"},
    {"icon": "assets/images/keyboard.png", "name": "Keyboard"},
    {"icon": "assets/images/mouse.png", "name": "Mouse"},
    {"icon": "assets/images/chair.png", "name": "Chair"},
    {"icon": "assets/images/speaker.png", "name": "Speaker"}
  ];

  List categoryData = [
    {"icon": "assets/images/pant.jpg", "name": "Pant", "price": '1500'},
    {"icon": "assets/images/sari1.png", "name": "Sari", "price": '2500'},
    {"icon": "assets/images/pant2.webp", "name": "Pant", "price": '3500'},
    {"icon": "assets/images/sari1.png", "name": "Sari", "price": '1500'},
    {"icon": "assets/images/pant3.webp", "name": "Pant", "price": '3500'},
    {"icon": "assets/images/sari1.png", "name": "Sari", "price": '6500'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          CarouselSlider(
            items: [
              Container(
                margin: EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5.0),
                    image: DecorationImage(
                    // image: NetworkImage("https://cdn.pixabay.com/photo/2017/01/08/13/58/cube-1963036__340.jpg"),
                      image: AssetImage("assets/images/banner.jpg"),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  image: DecorationImage(
                    image: AssetImage("assets/images/banner2.webp"),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ],
            options: CarouselOptions(
              height: 150.0,
              enlargeCenterPage: true,
              autoPlay: true,
              aspectRatio: 16 / 9,
              autoPlayCurve: Curves.fastOutSlowIn,
              enableInfiniteScroll: true,
              autoPlayAnimationDuration: Duration(milliseconds: 200),
              viewportFraction: 1,
            ),
          ),
          const Padding(
            padding: EdgeInsets.all(15.0),
            child: Text("Category",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15.0)),
          ),

          SizedBox(
            height: 100,
            child: ListView.separated(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                separatorBuilder: (context, index) {
                  return Container(
                    width: 10,
                  );
                },
                itemCount: category.length,
                itemBuilder: (context, index) {
                  return Card(
                    child: Column(children: [
                      SizedBox(
                          height: 70,
                          width: 100,
                          child: Image.asset(category[index]["icon"])),
                      Text(category[index]["name"]),
                    ]),
                  );
                }),
          ),


          SizedBox(
            child: ListView.separated(
                shrinkWrap: true,
                separatorBuilder: (context, index) {
                  return Container(width: 10);
                },
                itemCount: categoryData.length,
                itemBuilder: (context, index) {
                  return Card(
                      child: Column(children: [
                    SizedBox(
                        height: 100,
                        child: Image.asset(
                          categoryData[index]["icon"],
                          fit: BoxFit.cover,
                        )),
                    Text(categoryData[index]["name"]),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(categoryData[index]["price"]),
                        const Text('Free Delivery')
                      ],
                    )
                  ]));
                }),
          )
        ],
      ),
    );
  }
}
