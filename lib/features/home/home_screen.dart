import 'package:flutter/material.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import '../../core/theme/app_colors.dart';
import '../fal_request/fal_request_screen.dart';
import '../profile/profile_screen.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<Map<String, dynamic>> falTypes = [
    {
      "title": "Kahve Falı",
      "icon": Icons.coffee,
      "desc": "Geleceğini kahve telvesinde bul!",
      "color": AppColors.purple,
      "textColor": AppColors.gold,
    },
    {
      "title": "Aşk Falı",
      "icon": Icons.favorite,
      "desc": "Aşk hayatın için ipuçları.",
      "color": AppColors.purple, // Mor arka plan
      "textColor": AppColors.gold,
    },
    {
      "title": "Tarot",
      "icon": Icons.style,
      "desc": "Kartların gücüyle yolunu bul.",
      "color": AppColors.navy,
      "textColor": AppColors.gold,
    },
    {
      "title": "İskambil",
      "icon": Icons.casino,
      "desc": "Kaderini iskambil kartlarıyla öğren.",
      "color": AppColors.lightBlue,
      "textColor": AppColors.navy,
    },
    {
      "title": "Burçlar",
      "icon": Icons.auto_awesome,
      "desc": "Günlük burç yorumunu öğren!",
      "color": Colors.deepPurple,
      "textColor": AppColors.gold,
      "isZodiac": true,
    },
  ];

  int selectedIndex = 0;
  final CardSwiperController _swiperController = CardSwiperController();

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: AppColors.navy,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          "Fal Seç",
          style: TextStyle(
            color: AppColors.gold,
            fontWeight: FontWeight.bold,
            fontSize: 28,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.account_circle, color: AppColors.gold, size: 32),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ProfileScreen()),
              );
            },
          ),
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: height * 0.55,
            width: width * 0.95,
            child: CardSwiper(
              controller: _swiperController,
              cardsCount: falTypes.length,
              isLoop: true,
              numberOfCardsDisplayed: 2,
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 24),
              cardBuilder: (context, index, percentX, percentY) {
                final fal = falTypes[index % falTypes.length];
                if (fal["isZodiac"] == true) {
                  return _buildZodiacCard(context);
                }
                return _buildFalCard(fal, context);
              },
              onSwipe: (previousIndex, currentIndex, direction) {
                setState(() {
                  if (currentIndex != null) {
                    selectedIndex = currentIndex % falTypes.length;
                  }
                });
                return true;
              },
              onUndo: (previousIndex, currentIndex, direction) {
                setState(() {
                  if (currentIndex != null) {
                    selectedIndex = currentIndex % falTypes.length;
                  }
                });
                return true;
              },
            ),
          ),
          const SizedBox(height: 16),
          _buildActionButton(context),
        ],
      ),
    );
  }

  Widget _buildFalCard(Map<String, dynamic> fal, BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(32),
      ),
      elevation: 14,
      color: fal["color"].withOpacity(0.97),
      child: Container(
        width: 340,
        height: 480,
        padding: const EdgeInsets.all(28),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(fal["icon"], size: 72, color: fal["textColor"]),
            Text(
              fal["title"],
              style: TextStyle(
                color: fal["textColor"],
                fontWeight: FontWeight.bold,
                fontSize: 32,
                letterSpacing: 1.2,
              ),
            ),
            Text(
              fal["desc"],
              style: TextStyle(
                color: fal["textColor"].withOpacity(0.85),
                fontSize: 20,
                fontWeight: FontWeight.w400,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildZodiacCard(BuildContext context) {
    final List<Map<String, dynamic>> zodiacs = [
      {"name": "Koç", "icon": Icons.flash_on, "color": Colors.red},
      {"name": "Boğa", "icon": Icons.spa, "color": Colors.green},
      {"name": "İkizler", "icon": Icons.wb_cloudy, "color": Colors.yellow},
      {"name": "Yengeç", "icon": Icons.water, "color": Colors.blue},
      {"name": "Aslan", "icon": Icons.wb_sunny, "color": Colors.orange},
      {"name": "Başak", "icon": Icons.grass, "color": Colors.lightGreen},
      {"name": "Terazi", "icon": Icons.balance, "color": Colors.pink},
      {"name": "Akrep", "icon": Icons.bug_report, "color": Colors.deepPurple},
      {"name": "Yay", "icon": Icons.flight, "color": Colors.purple},
      {"name": "Oğlak", "icon": Icons.terrain, "color": Colors.brown},
      {"name": "Kova", "icon": Icons.ac_unit, "color": Colors.cyan},
      {"name": "Balık", "icon": Icons.pool, "color": Colors.indigo},
    ];
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(32),
      ),
      elevation: 14,
      color: Colors.deepPurple.withOpacity(0.97),
      child: Container(
        width: 340,
        height: 480,
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Icon(Icons.auto_awesome, size: 72, color: AppColors.gold),
            const SizedBox(height: 8),
            const Text(
              "Burçlar",
              style: TextStyle(
                color: AppColors.gold,
                fontWeight: FontWeight.bold,
                fontSize: 32,
                letterSpacing: 1.2,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              "Günlük burç yorumunu öğren!",
              style: TextStyle(
                color: AppColors.gold,
                fontSize: 20,
                fontWeight: FontWeight.w400,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            Expanded(
              child: GridView.count(
                crossAxisCount: 3,
                mainAxisSpacing: 12,
                crossAxisSpacing: 12,
                childAspectRatio: 1,
                physics: const NeverScrollableScrollPhysics(),
                children: zodiacs.map((zodiac) {
                  return GestureDetector(
                    onTap: () {
                      // Burç detay ekranı açılabilir
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: Text(zodiac["name"]),
                          content: Text("Bugünkü ${zodiac["name"]} yorumu: ..."),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(context),
                              child: const Text("Kapat"),
                            ),
                          ],
                        ),
                      );
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: zodiac["color"].withOpacity(0.15),
                        borderRadius: BorderRadius.circular(18),
                        border: Border.all(color: AppColors.gold, width: 1.5),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(zodiac["icon"], color: zodiac["color"], size: 36),
                          const SizedBox(height: 6),
                          Text(zodiac["name"], style: const TextStyle(color: AppColors.gold, fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionButton(BuildContext context) {
    final fal = falTypes[selectedIndex];
    if (fal["isZodiac"] == true) {
      return ElevatedButton(
        onPressed: null,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.deepPurple,
          foregroundColor: AppColors.gold,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(22)),
          elevation: 4,
          padding: const EdgeInsets.symmetric(horizontal: 48, vertical: 18),
          textStyle: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
        child: const Text("Burçlar için Fal Seçilemez"),
      );
    }
    return ElevatedButton(
      onPressed: () {
        final selectedFal = falTypes[selectedIndex];
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => FalRequestScreen(falType: selectedFal["title"]),
          ),
        );
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.gold,
        foregroundColor: AppColors.navy,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(22),
        ),
        elevation: 4,
        padding: const EdgeInsets.symmetric(horizontal: 48, vertical: 18),
        textStyle: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
      ),
      child: Text("${falTypes[selectedIndex]["title"]} için Fal Seç"),
    );
  }
} 