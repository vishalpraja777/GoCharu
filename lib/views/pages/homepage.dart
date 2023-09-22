import 'package:flutter/material.dart';
import 'package:follow_dp/constants/constants.dart';
import 'package:follow_dp/views/widgets/feed_links.dart';
import 'package:follow_dp/views/widgets/navigation_drawer_custom.dart';

class Homepage extends StatelessWidget {
  const Homepage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Face Roja",
          style: TextStyle(color: Colors.white),
        ),
      ),
      drawer: NavigationDrawerCustom(),
      body: Column(
        children: [
          Text(
            "Links",
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          const FeedLinks()
        ],
      ),
    );
  }
}
