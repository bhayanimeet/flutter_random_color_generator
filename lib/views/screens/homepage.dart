import 'dart:math';
import 'package:color_palette_generator_app/views/screens/allcolors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../controllers/google_ads_controller.dart';
import '../../controllers/json_controller.dart';
import '../../res/global.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  JsonController jsonController = Get.put(JsonController());
  Random r = Random();

  @override
  void initState() {
    super.initState();
    jsonController.fetchData();
  }

  int currentIndex = 0;
  IconData random = Icons.color_lens_sharp;
  IconData all = Icons.format_color_fill_outlined;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 160,
            toolbarHeight: 80,
            pinned: true,
            automaticallyImplyLeading: false,
            backgroundColor: Colors.transparent,
            flexibleSpace: Container(
              decoration: BoxDecoration(
                borderRadius:
                    const BorderRadius.vertical(bottom: Radius.circular(25)),
                color: (Global.isDark == false)
                    ? const Color(0xff35313f)
                    : const Color(0xffe9e2f1),
              ),
              child: FlexibleSpaceBar(
                expandedTitleScale: 1,
                background: Align(
                  alignment: const Alignment(-0.6, -0.4),
                  child: Text(
                    "Random Color Generator",
                    style: GoogleFonts.arya(
                      fontSize: 25,
                      fontWeight: FontWeight.w600,
                      color: Global.isDark == false
                          ? Colors.white
                          : Colors.black,
                    ),
                  ),
                ),
                title: Row(
                  children: [
                    Expanded(
                      flex: 11,
                      child: SizedBox(
                        height: 50,
                        width: 200,
                        child: Text(
                          "Random Color",
                          style: GoogleFonts.arya(
                            fontSize: 30,
                            fontWeight: FontWeight.w600,
                            color: Global.isDark == false
                                ? Colors.white
                                : Colors.black,
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child: Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              Get.changeThemeMode(
                                (Get.isDarkMode == true)
                                    ? ThemeMode.light
                                    : ThemeMode.dark,
                              );
                              setState(() {
                                Global.isDark = !Global.isDark;
                              });
                            },
                            child: const Icon(Icons.light_mode_outlined),
                          ),
                          const SizedBox(width: 15),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                jsonController.jsonModel.i1.value =
                                    r.nextInt(1301);
                              });
                            },
                            child: const Icon(Icons.refresh),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                titlePadding: const EdgeInsets.only(left: 20, bottom: 20),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: jsonController.jsonModel.res.length,
              itemBuilder: (context, i) {
                if (jsonController.jsonModel.i1.value <= 1000) {
                  i = jsonController.jsonModel.i1.value++;
                }
                return Column(
                  children: [
                    Container(
                      height: 60,
                      width: MediaQuery.of(context).size.width,
                      margin:
                          const EdgeInsets.only(left: 20, right: 20, top: 20),
                      decoration: BoxDecoration(
                        color: Color(int.parse(
                            jsonController.jsonModel.res[i]["hex"])),
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 3,
                            spreadRadius: 1,
                            offset: const Offset(1, 1),
                            color: Colors.grey.shade500,
                          ),
                        ],
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: (val) {
          setState(() {
            currentIndex = val;
            if (currentIndex == 0) {
              random = Icons.color_lens_sharp;
              all = Icons.format_color_fill_outlined;
            } else if (currentIndex == 1) {
              if (AdHelper.adHelper.interstitialAd != null) {
                AdHelper.adHelper.interstitialAd!.show();
                AdHelper.adHelper.loadInterstitialAd();
              }
              random = Icons.color_lens_outlined;
              all = Icons.format_color_fill_sharp;
              Get.off(
                () => const SelectColor(),
                duration: const Duration(seconds: 2),
                transition: Transition.fadeIn,
                curve: Curves.easeInOut,
              );
            }
          });
        },
        backgroundColor: (Global.isDark)
            ? const Color(0xffe9e2f1)
            : const Color(0xff35313f),
        selectedItemColor: (Global.isDark) ? Colors.black : Colors.white,
        unselectedItemColor: Colors.grey.shade600,
        items: [
          BottomNavigationBarItem(
              icon: Icon(random, size: 30), label: 'Random color'),
          BottomNavigationBarItem(icon: Icon(all, size: 30), label: 'Color picker'),
        ],
        currentIndex: 0,
      ),
    );
  }
}
