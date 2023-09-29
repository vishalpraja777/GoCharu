import 'package:flutter/material.dart';
import 'package:follow_dp/views/widgets/feed_links.dart';
import 'package:follow_dp/views/widgets/navigation_drawer_custom.dart';

class Homepage extends StatelessWidget {
  const Homepage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "GO CHARU",
          style: TextStyle(color: Colors.white),
        ),
      ),
      drawer: const NavigationDrawerCustom(),
      body: const Column(
        children: [
          // SizedBox(height: 10),
          // Text(
          //   "Feed",
          //   style: TextStyle(
          //       fontSize: 32, fontWeight: FontWeight.bold, color: primaryColor),
          // ),
          SizedBox(height: 10),
          FeedLinks()
        ],
      ),
    );
  }
}
