import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Dummy user data
    final user = {
      'name': 'Kullanıcı Adı',
      'email': 'kullanici@email.com',
      'birth': '1995-04-12',
      'zodiac': 'Koç',
      'photo': null,
    };
    return Scaffold(
      backgroundColor: AppColors.navy,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text('Profilim', style: TextStyle(color: AppColors.gold)),
        iconTheme: const IconThemeData(color: AppColors.gold),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 48,
              backgroundColor: AppColors.gold,
              child: user['photo'] == null
                  ? const Icon(Icons.person, size: 48, color: AppColors.navy)
                  : null,
            ),
            const SizedBox(height: 16),
            Text(user['name'] ?? '', style: const TextStyle(color: AppColors.gold, fontWeight: FontWeight.bold, fontSize: 24)),
            const SizedBox(height: 8),
            Text(user['email'] ?? '', style: const TextStyle(color: AppColors.lightGrey, fontSize: 16)),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.cake, color: AppColors.gold, size: 20),
                const SizedBox(width: 6),
                Text(user['birth'] ?? '', style: const TextStyle(color: AppColors.gold)),
                const SizedBox(width: 18),
                const Icon(Icons.auto_awesome, color: AppColors.gold, size: 20),
                const SizedBox(width: 6),
                Text(user['zodiac'] ?? '', style: const TextStyle(color: AppColors.gold)),
              ],
            ),
            const SizedBox(height: 32),
            ElevatedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.edit, color: AppColors.navy),
              label: const Text('Bilgileri Düzenle'),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.gold,
                foregroundColor: AppColors.navy,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            const Spacer(),
            ElevatedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.logout, color: AppColors.gold),
              label: const Text('Çıkış Yap'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.transparent,
                foregroundColor: AppColors.gold,
                elevation: 0,
                side: const BorderSide(color: AppColors.gold, width: 1.5),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
} 