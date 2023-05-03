import 'package:color_palette_generator_app/views/screens/homepage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';
import '../../res/global.dart';

class SelectColor extends StatefulWidget {
  const SelectColor({Key? key}) : super(key: key);

  @override
  State<SelectColor> createState() => _SelectColorState();
}

class _SelectColorState extends State<SelectColor> {
  int currentIndex = 0;
  IconData random = Icons.color_lens_outlined;
  IconData all = Icons.format_color_fill_sharp;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(Global.red, Global.green, Global.blue, 1),
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
                  alignment: const Alignment(-0.7, -0.4),
                  child: Text(
                    "Random Color Generator",
                    style: GoogleFonts.arya(
                      fontSize: 22,
                      fontWeight: FontWeight.w600,
                      color:
                          Global.isDark == false ? Colors.white : Colors.black,
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
                          "Select background Color",
                          style: GoogleFonts.arya(
                            fontSize: 25,
                            fontWeight: FontWeight.w600,
                            color: Global.isDark == false
                                ? Colors.white
                                : Colors.black,
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: GestureDetector(
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
                    ),
                  ],
                ),
                titlePadding: const EdgeInsets.only(left: 20, bottom: 20),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 170),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Expanded(
                      flex: 2,
                      child: Center(
                        child: Text(
                          "Red",
                          style: GoogleFonts.arya(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 9,
                      child: Slider(
                        min: 0,
                        max: 255,
                        divisions: 255,
                        label: '${Global.red.toInt()}',
                        value: Global.red.toDouble(),
                        onChanged: (val) {
                          setState(() {
                            Global.red = val.toInt();
                          });
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: Center(
                        child: Text(
                          "Green",
                          style: GoogleFonts.arya(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 9,
                      child: Slider(
                        min: 0,
                        max: 255,
                        divisions: 255,
                        label: '${Global.green.toInt()}',
                        value: Global.green.toDouble(),
                        onChanged: (val) {
                          setState(() {
                            Global.green = val.toInt();
                          });
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: Center(
                        child: Text(
                          "Blue",
                          style: GoogleFonts.arya(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 9,
                      child: Slider(
                        min: 0,
                        max: 255,
                        divisions: 255,
                        label: '${Global.blue.toInt()}',
                        value: Global.blue.toDouble(),
                        onChanged: (val) {
                          setState(() {
                            Global.blue = val.toInt();
                          });
                        },
                      ),
                    ),
                  ],
                ),
              ],
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
              Get.off(
                () => const HomePage(),
                duration: const Duration(seconds: 2),
                transition: Transition.fadeIn,
                curve: Curves.easeInOut,
              );
            } else if (currentIndex == 1) {
              random = Icons.color_lens_outlined;
              all = Icons.format_color_fill_sharp;
            }
          });
        },
        backgroundColor:
            (Global.isDark) ? const Color(0xffe9e2f1) : const Color(0xff35313f),
        selectedItemColor: (Global.isDark) ? Colors.black : Colors.white,
        unselectedItemColor: Colors.grey.shade600,
        items: [
          BottomNavigationBarItem(
              icon: Icon(random, size: 30), label: 'Random color'),
          BottomNavigationBarItem(icon: Icon(all, size: 30), label: 'Color picker'),
        ],
        currentIndex: 1,
      ),
    );
  }
}
