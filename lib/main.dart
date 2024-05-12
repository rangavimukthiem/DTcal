// import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'fields.dart';
import 'company_screen.dart';

void main() async {
  var devices = ["emulator-5554,b5e6d0420221"];

  WidgetsFlutterBinding.ensureInitialized();

  await MobileAds.instance.initialize();
  MobileAds.instance
      .updateRequestConfiguration(RequestConfiguration(testDeviceIds: devices));

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Production Calculator',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        textTheme: const TextTheme(
            // ignore: deprecated_member_use
            bodyText1: TextStyle(color: Colors.black87, fontSize: 18)),
        primaryColor: Colors.blue,
        scaffoldBackgroundColor: const Color.fromARGB(255, 44, 64, 118),
        hintColor: const Color.fromARGB(255, 250, 246, 242),
        inputDecorationTheme: InputDecorationTheme(
            fillColor: const Color.fromARGB(255, 125, 183, 240),
            alignLabelWithHint: true,
            labelStyle: const TextStyle(color: Colors.black87, fontSize: 18),
            filled: true,
            floatingLabelBehavior: FloatingLabelBehavior.auto,
            floatingLabelStyle: const TextStyle(
                color: Color.fromARGB(255, 255, 255, 170), fontSize: 22.0),
            floatingLabelAlignment: FloatingLabelAlignment.start,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: BorderSide.none,
            ),
            hintStyle: TextField.materialMisspelledTextStyle),
      ),
      home: const ProductionCalculator(),
    );
  }
}

class ProductionCalculator extends StatefulWidget {
  const ProductionCalculator({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _ProductionCalculatorState createState() => _ProductionCalculatorState();
}

class _ProductionCalculatorState extends State<ProductionCalculator> {
  @override
  void initState() {
    super.initState();
    initBannerAd();
  }

  late BannerAd bannerAd;
  bool isAdLoaded = false;
  bool isAdRemoved = false;
  var adUnitId = "ca-app-pub-3940256099942544/9214589741";
  initBannerAd() {
    bannerAd = BannerAd(
        size: AdSize.banner,
        adUnitId: adUnitId,
        listener: BannerAdListener(
          onAdLoaded: (ad) {
            setState(() {
              isAdLoaded = true;
            });
          },
          onAdClosed: (ad) {
            setState(() {
              isAdRemoved = true;
            });
          },
          onAdFailedToLoad: (ad, error) {
            ad.dispose();
          },
        ),
        request: const AdRequest());
    bannerAd.load();
  }

  TextEditingController smvController = TextEditingController();
  TextEditingController quantityController = TextEditingController();
  TextEditingController changeOverController = TextEditingController();
  TextEditingController measurementController = TextEditingController();
  TextEditingController otherDowntimeController = TextEditingController();

  double smv = 0.0;
  double quantity = 0.0;
  double changeOverTime = 0.0;
  double measurementIssueTime = 0.0;
  double otherDowntimes = 0.0;
  double production = 0.0;
  // ignore: non_constant_identifier_names
  double production_eighty = 0.0;
  double todayTarget = 0.0;
  double downtime = 0.0;
  double knittedTime = 0.0;
  // ignore: non_constant_identifier_names
  double brakedown_time = 0.0;
  // ignore: non_constant_identifier_names
  double hidden_downtime = 0.0;

  void updateSMV(double value) {
    setState(() {
      smv = value;
      // Recalculate other variables dependent on SMV if needed
    });
  }

  void updateQTY(double value) {
    setState(() {
      quantity = value;
      // Recalculate other variables dependent on SMV if needed
    });
  }

  void updateCOT(double value) {
    setState(() {
      changeOverTime = value;
      // Recalculate other variables dependent on SMV if needed
    });
  }

  void updateMIT(double value) {
    setState(() {
      measurementIssueTime = value;
      // Recalculate other variables dependent on SMV if needed
    });
  }

  void updateODT(double value) {
    setState(() {
      otherDowntimes = value;
      // Recalculate other variables dependent on SMV if needed
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(kToolbarHeight),
          child: AppBar(
              title: const Center(child: Text('Downtime Calculator')),
              elevation: 10.0,
              backgroundColor: const Color.fromARGB(255, 14, 114, 160),
              titleTextStyle: const TextStyle(
                  color: Color.fromARGB(255, 181, 222, 236), fontSize: 30.0),
              actions: [
                IconButton(
                  icon: const Icon(
                    Icons.workspaces,
                    color: Colors.amber,
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const CompanyScreen()),
                    );
                  },
                )
              ]),
        ),
        bottomNavigationBar: !isAdRemoved && isAdLoaded
            ? SizedBox(
                height: bannerAd.size.height.toDouble(),
                width: bannerAd.size.width.toDouble(),
                child: AdWidget(ad: bannerAd))
            : null,
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(10.0),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
            CustomTextField(
              controller: smvController,
              label: 'SMV',
              operation: "SMV",
              updateSMV: updateSMV,
              updateODT: updateODT,
              updateCOT: updateCOT,
              updateMIT: updateMIT,
              updateQTY: updateQTY,
              calculate: calculations(),
            ),
            CustomTextField(
              controller: quantityController,
              label: 'Quantity',
              operation: "QTY",
              updateSMV: updateSMV,
              updateODT: updateODT,
              updateCOT: updateCOT,
              updateMIT: updateMIT,
              updateQTY: updateQTY,
              calculate: calculations(),
            ),
            CustomTextField(
              controller: changeOverController,
              label: 'Change Over Time',
              operation: "COT",
              updateSMV: updateSMV,
              updateODT: updateODT,
              updateCOT: updateCOT,
              updateMIT: updateMIT,
              updateQTY: updateQTY,
              calculate: calculations(),
            ),
            CustomTextField(
              controller: measurementController,
              label: 'Measurement Issue Time',
              operation: "MIT",
              updateSMV: updateSMV,
              updateODT: updateODT,
              updateCOT: updateCOT,
              updateMIT: updateMIT,
              updateQTY: updateQTY,
              calculate: calculations(),
            ),
            CustomTextField(
              controller: otherDowntimeController,
              label: 'Other Downtimes',
              operation: "ODT",
              updateSMV: updateSMV,
              updateODT: updateODT,
              updateCOT: updateCOT,
              updateMIT: updateMIT,
              updateQTY: updateQTY,
              calculate: calculations(),
            ),
            const SizedBox(height: 20.0),
            Container(
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.only(
                  left: 50.0, right: 50.0, top: 10.0, bottom: 10.0),
              margin:
                  const EdgeInsets.symmetric(vertical: 10, horizontal: 10.0),
              decoration: BoxDecoration(
                  color: Colors.blue,
                  border: Border.all(),
                  borderRadius: BorderRadius.circular(10)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Padding(
                            padding: EdgeInsets.all(3),
                            child: Text("100% Production")),
                        Padding(
                          padding: const EdgeInsets.all(3),
                          child: Text(production.toStringAsFixed(2)),
                        ),
                      ]),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Padding(
                            padding: EdgeInsets.all(3),
                            child: Text("80% Production")),
                        Padding(
                          padding: const EdgeInsets.all(3),
                          child: Text(production_eighty.toStringAsFixed(2)),
                        ),
                      ]),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Padding(
                            padding: EdgeInsets.all(3),
                            child: Text("Today Target")),
                        Padding(
                          padding: const EdgeInsets.all(3),
                          child: Text(todayTarget.toStringAsFixed(2)),
                        ),
                      ]),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Padding(
                            padding: EdgeInsets.all(3),
                            child: Text("Known downtime")),
                        Padding(
                          padding: const EdgeInsets.all(3),
                          child: Text(brakedown_time.toStringAsFixed(2)),
                        ),
                      ]),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Padding(
                            padding: EdgeInsets.all(3),
                            child: Text("Total Down Time")),
                        Padding(
                          padding: const EdgeInsets.all(3),
                          child: Text(downtime.toStringAsFixed(2)),
                        ),
                      ]),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Padding(
                            padding: EdgeInsets.all(3),
                            child: Text("Hidden downtime")),
                        Padding(
                          padding: const EdgeInsets.all(3),
                          child: Text(hidden_downtime.toStringAsFixed(2)),
                        ),
                      ]),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Padding(
                            padding: EdgeInsets.all(3),
                            child: Text("Knitted Time")),
                        Padding(
                          padding: const EdgeInsets.all(3),
                          child: Text(knittedTime.toStringAsFixed(2)),
                        ),
                      ]),
                ],
              ),
            ),
          ]),
        ));
  }

  calculations() {
    double production = 720 / smv;
    double productionEighty = production * 0.8;
    double todayTarget =
        (720 - (changeOverTime + measurementIssueTime + otherDowntimes)) / smv;
    double brakedownTime =
        changeOverTime + measurementIssueTime + otherDowntimes;
    double hiddenDowntime = (720 - (quantity * smv) - brakedownTime);
    double downtime = (720 - smv * quantity);
    double knittedTime = smv * quantity;

    // Update state to display results
    setState(() {
      this.production = production;
      // ignore: unnecessary_this
      this.production_eighty = productionEighty;
      this.todayTarget = todayTarget;
      this.downtime = downtime;
      this.knittedTime = knittedTime;
      brakedown_time = brakedownTime;
      hidden_downtime = hiddenDowntime;
    });
  }
}
