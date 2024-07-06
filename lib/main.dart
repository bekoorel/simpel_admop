import 'package:flutter/material.dart';

import 'package:google_mobile_ads/google_mobile_ads.dart';

import 'modul.dart';

final AdWidget adWidget = AdWidget(ad: myBanner);
final Container adContainer = Container(
  alignment: Alignment.center,
  color: Colors.black,
  width: myBanner.size.width.toDouble(),
  height: myBanner.size.height.toDouble(),
  child: adWidget,
);

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  MobileAds.instance.initialize();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(debugShowCheckedModeBanner: false, home: Ad());
  }
}

class Ad extends StatefulWidget {
  const Ad({super.key});

  @override
  State<Ad> createState() => _AdState();
}

class _AdState extends State<Ad> {
  @override
  void initState() {
    getPostById();
    myBanner.load();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            body: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
            flex: 1,
            child: SizedBox(
              width: 500.0,
              child: adContainer,
            )),
        FutureBuilder(
            future: getPostById(),
            builder: ((context, snapshot) {
              if (snapshot.hasData) {
                return Expanded(
                  flex: 9,
                  child: SizedBox(
                      width: 500.0,
                      child: ListView.builder(
                          itemCount: snapshot.data!.length,
                          itemBuilder: ((context, index) {
                            return Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(40),
                                color: Colors.black,
                              ),
                              margin: const EdgeInsets.all(2.0),
                              height: 100.0,
                              width: 100.0,
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text(
                                    "${snapshot.data![index].name}   ",
                                    style: const TextStyle(
                                        color: Colors.white, fontSize: 20),
                                  ),
                                  Text("${snapshot.data![index].webpages}",
                                      style: const TextStyle(
                                          color: Colors.amber, fontSize: 15))
                                ],
                              ),
                            );
                          }))),
                );
              }
              return const CircularProgressIndicator();
            }))
      ],
    )));
  }
}

final BannerAd myBanner = BannerAd(
  adUnitId: 'ca-app-pub-3940256099942544/6300978111',
  size: AdSize.banner,
  request: const AdRequest(),
  listener: const BannerAdListener(),
);
