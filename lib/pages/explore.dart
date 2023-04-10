import 'package:flutter/material.dart';
import 'package:appartement/theme/color.dart';
import 'package:appartement/utils/data.dart';
import 'package:appartement/widgets/broker_item.dart';
import 'package:appartement/widgets/company_item.dart';
import 'package:appartement/widgets/custom_textbox.dart';
import 'package:appartement/widgets/icon_box.dart';
import 'package:appartement/widgets/recommend_item.dart';

class ExplorePage extends StatefulWidget {
  const ExplorePage({Key? key}) : super(key: key);

  @override
  _ExplorePageState createState() => _ExplorePageState();
}

class _ExplorePageState extends State<ExplorePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Explorer",
          style: TextStyle(color: Colors.black),
        ),
        toolbarHeight: 60,
        backgroundColor: appBgColor,
        elevation: 0,
      ),
      body: getBody()
    );
  }

  getHeader() {
    return Container(
        height: 60,
        margin: const EdgeInsets.all(10),
        child: Row(
          children: [
            Expanded(
                child: CustomTextBox(
              hint: "Search",
              prefix: const Icon(Icons.search, color: Colors.grey),
            )),
            const SizedBox(
              width: 10,
            ),
            IconBox(
              child: const Icon(Icons.filter_list_rounded, color: Colors.white),
              bgColor: secondary,
              radius: 10,
            )
          ],
        ));
  }

  getBody() {
    return SingleChildScrollView(
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          getHeader(),
      // const SizedBox(
      //   height: 20,
      // ),
      Container(
        margin: const EdgeInsets.only(left: 15, right: 15),
        child: const Text(
          "Matched Properties",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
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
        child: const Text(
          "Companies",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
        ),
      ),
      const SizedBox(
        height: 20,
      ),
      listCompanies(),
      const SizedBox(
        height: 20,
      ),
      listBrokers(),
      const SizedBox(
        height: 100,
      ),
    ]));
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

  int selectedCategory = 0;
  listCompanies() {
    List<Widget> lists = List.generate(
        companies.length,
        (index) => CompanyItem(
              data: companies[index],
              color: listColors[index % 10],
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

  listBrokers() {
    List<Widget> lists = List.generate(
        brokers.length, (index) => BrokerItem(data: brokers[index]));

    return Container(
      margin: const EdgeInsets.only(right: 15, left: 15),
      child: Column(children: lists),
    );
  }
}
