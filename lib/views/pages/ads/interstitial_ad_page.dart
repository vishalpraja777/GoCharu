import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class InterstitialAdPage extends StatefulWidget {
  const InterstitialAdPage({super.key});

  @override
  State<InterstitialAdPage> createState() => _InterstitialAdPageState();
}

class _InterstitialAdPageState extends State<InterstitialAdPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initInterstitialAd();
  }

  late InterstitialAd interstitialAd;

  bool isAdLoaded = false;

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
            print("Test Dismiss");

            Navigator.pushNamed(context, "testpage");
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
            onPressed: () async {
              await initInterstitialAd();
              if (isAdLoaded) {
                interstitialAd.show();
              }
              print("Test$isAdLoaded");
              // Navigator.pushNamed(context, "testpage");
            },
            child: Text("Show Ad")),
      ),
    );
  }
}
