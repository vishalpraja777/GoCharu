import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:follow_dp/constants/constants.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:url_launcher/url_launcher.dart';

class FeedLinks extends StatefulWidget {
  const FeedLinks({super.key});

  @override
  State<FeedLinks> createState() => _FeedLinksState();
}

class _FeedLinksState extends State<FeedLinks> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initInterstitialAd();
  }

  late InterstitialAd interstitialAd;

  bool isAdLoaded = false;
  bool isLaunch = false;

  var launchUrlLink = '';

  var testAdUnit = "ca-app-pub-3940256099942544/1033173712"; // test id
  var realAdUnit = "ca-app-pub-1926900948788493/1947756542"; // real id

  initInterstitialAd() {
    InterstitialAd.load(
        adUnitId: testAdUnit,
        request: const AdRequest(),
        adLoadCallback: InterstitialAdLoadCallback(onAdLoaded: (ad) {
          print("Test Init");
          interstitialAd = ad;
          setState(() {
            isAdLoaded = true;
          });
          interstitialAd.fullScreenContentCallback =
              FullScreenContentCallback(onAdDismissedFullScreenContent: (ad) {
            ad.dispose();
            setState(() {
              isLaunch = true;
            });
            _launchUrl(launchUrlLink);
            print("Test Dismiss");

            // Navigator.pushNamed(context, "testpage");
            setState(() {
              isAdLoaded = false;
            });
          }, onAdFailedToShowFullScreenContent: (ad, error) {
            ad.dispose();
            print("Test Failed");

            setState(() {
              isAdLoaded = false;
            });
          });
        }, onAdFailedToLoad: (error) {
          print("Test Failed1");

          interstitialAd.dispose();
        }));
  }

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
                    onTap: () async {
                      setState(() {
                        launchUrlLink = documentSnapshot["link"];
                      });
                      isLaunch = false;
                      await initInterstitialAd();
                      if (isAdLoaded) {
                        await interstitialAd.show();
                      } else {
                        _launchUrl(launchUrlLink);
                        // Fluttertoast.showToast(msg: "Loading... Try again");
                      }
                      // if (isLaunch) {
                      //   _launchUrl(documentSnapshot["link"]);
                      // }
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
