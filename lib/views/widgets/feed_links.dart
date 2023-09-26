import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:follow_dp/constants/constants.dart';
import 'package:follow_dp/controller/crud_crontroller.dart';
import 'package:url_launcher/url_launcher.dart';

class FeedLinks extends StatelessWidget {
  const FeedLinks({super.key});

  _launchUrl(link) async {
    final Uri url = Uri.parse(link);
    if (!await launchUrl(url)) {
      throw Exception('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: StreamBuilder(
        stream: crudController.links.snapshots(),
        builder: (BuildContext context,
            AsyncSnapshot<QuerySnapshot<Object?>> snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  final DocumentSnapshot documentSnapshot =
                      snapshot.data!.docs[index];
                  final url = documentSnapshot["imagelink"].toString();
                  return InkWell(
                    onTap: () {
                      _launchUrl(documentSnapshot["link"]);
                    },
                    child: Container(
                      // width: MediaQuery.of(context).size.width - 100,
                      height: MediaQuery.of(context).size.width * (9 / 16),
                      margin: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 4),
                      // padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.grey[100],
                          image: DecorationImage(
                              image: NetworkImage(url), fit: BoxFit.cover)),
                      // child: ListTile(
                      //   title: Center(
                      //     child: Text(
                      //       documentSnapshot["name"].toString().toUpperCase(),
                      //       style: const TextStyle(
                      //           fontSize: 20,
                      //           color: white,
                      //           fontWeight: FontWeight.bold),
                      //     ),
                      //   ),
                      // subtitle: Text(documentSnapshot["link"]),
                      // ),
                    ),
                  );
                });
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
