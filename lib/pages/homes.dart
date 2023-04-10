import 'package:appartement/model/Appartement.dart';
import 'package:appartement/pages/details_appartement.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:appartement/theme/color.dart';
import 'package:appartement/utils/data.dart';
import 'package:appartement/widgets/category_item.dart';
import 'package:appartement/widgets/custom_image.dart';
import 'package:appartement/widgets/custom_textbox.dart';
import 'package:appartement/widgets/icon_box.dart';
import 'package:appartement/widgets/property_item.dart';
import 'package:appartement/widgets/recent_item.dart';
import 'package:appartement/widgets/recommend_item.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: getHeader(),
      //   toolbarHeight: 60,
      //   backgroundColor: appBgColor,
      //   elevation: 0,
      // ),
      body: CustomScrollView(
      slivers: <Widget>[
        SliverAppBar(
          backgroundColor: appBgColor,
          pinned: true,
          snap: true,
          floating: true,
          title: getHeader(),
        ),
        SliverToBoxAdapter(child: getBody())
      ],
    ),
    );
  }

  getHeader() {
    return Container(
      padding: const EdgeInsets.all(20),
      // color: Colors.red,
      height: 81,
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    "Hello!",
                    style: TextStyle(
                        color: darker,
                        fontSize: 14,
                        fontWeight: FontWeight.w500),
                  ),
                  Text(
                    "Sangvaleap",
                    style: TextStyle(
                        color: Colors.black87,
                        fontSize: 17,
                        fontWeight: FontWeight.w600),
                  ),
                ],
              ),
              CustomImage(
                profile,
                width: 35,
                height: 35,
                trBackground: true,
                borderColor: primary,
                radius: 10,
              ),
            ],
          ),
        ],
      ),
    );
  }

  getBody() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // const SizedBox(
          //   height: 15,
          // ),
          // Padding(
          //   padding: const EdgeInsets.only(left: 15, right: 15),
          //   child: Row(
          //     children: [
          //       Expanded(
          //           child: CustomTextBox(
          //         hint: "Search",
          //         prefix: const Icon(Icons.search, color: Colors.grey),
          //       )),
          //       const SizedBox(
          //         width: 10,
          //       ),
          //       IconBox(
          //         bgColor: secondary,
          //         radius: 10,
          //         child: const Icon(Icons.filter_list_rounded,
          //             color: Colors.white),
          //       )
          //     ],
          //   ),
          // ),
          const SizedBox(
            height: 20,
          ),
          Container(
            margin: const EdgeInsets.only(left: 0),
            child: listCategories(),
          ),
          const SizedBox(
            height: 20,
          ),
          Container(
            margin: const EdgeInsets.only(left: 15, right: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text(
                  "Popular",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                ),
                Text(
                  "See all",
                  style: TextStyle(fontSize: 14, color: darker),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          listPopulars(),
          const SizedBox(
            height: 20,
          ),
          Container(
            margin: const EdgeInsets.only(left: 15, right: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text(
                  "Recommended",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                ),
                Text(
                  "See all",
                  style: TextStyle(fontSize: 14, color: darker),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          listRecommended(),
          const SizedBox(
            height: 20,
          ),
          Container(
            margin: const EdgeInsets.only(left: 15, right: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text(
                  "Recent",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                ),
                Text(
                  "See all",
                  style: TextStyle(fontSize: 14, color: darker),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          // listRecent(),
          const SizedBox(
            height: 100,
          ),
        ],
      ),
    );
  }

  int selectedCategory = 0;
  listCategories() {
    List<Widget> lists = List.generate(
        categories.length,
        (index) => CategoryItem(
              data: categories[index],
              selected: index == selectedCategory,
              onTap: () {
                setState(() {
                  selectedCategory = index;
                });
              },
            ));
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.only(bottom: 5, left: 15),
      child: Row(children: lists),
    );
  }

  listPopulars() {
    return StreamBuilder<List<Appartement>>(
        stream: Appartement().getAppartements(),
        builder: (context, snapshot) {
          if (snapshot.hasData && snapshot.data != null) {
            return CarouselSlider(
                options: CarouselOptions(
                  height: 240,
                  enlargeCenterPage: true,
                  disableCenter: true,
                  viewportFraction: .8,
                ),
                items: List.generate(
                    snapshot.data!.length,
                    (index) => InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => DetailsAppartement(
                                  appartement: snapshot.data![index]),
                            ),
                          );
                        },
                        child:
                            PropertyItem(appartement: snapshot.data![index]))));
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        });
  }

  listRecommended() {
    List<Widget> lists = List.generate(
        recommended.length, (index) => RecommendItem(data: recommended[index]));

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.only(bottom: 5, left: 15),
      child: Row(children: lists),
    );
  }

  // listRecent() {
  //   List<Widget> lists = List.generate(
  //       recents.length, (index) => RecentItem(data: recents[index]));

  //   return SingleChildScrollView(
  //     scrollDirection: Axis.horizontal,
  //     padding: const EdgeInsets.only(bottom: 5, left: 15),
  //     child: Row(children: lists),
  //   );
  // }
}
