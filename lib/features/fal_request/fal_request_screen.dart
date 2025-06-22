import 'package:flutter/material.dart';
import '../chat/chat_screen.dart';

// Kahve Falı Renkleri
const Color kahveKoyu = Color(0xFF4B2E2E);
const Color kahveKrem = Color(0xFFF3E3D3);
const Color kahveAltin = Color(0xFFFFD700);

// Aşk Falı Renkleri
const Color askPembe = Color(0xFFFFB6C1);
const Color askPastelMor = Color(0xFFC9A0DC);
const Color askBeyaz = Color(0xFFFFFFFF);

// Tarot Falı Renkleri
const Color tarotLacivert = Color(0xFF1E1A35);
const Color tarotAltin = Color(0xFFFFD700);

// İskambil Falı Renkleri
const Color iskambilKirmizi = Color(0xFF8B0000);
const Color iskambilSiyah = Color(0xFF000000);
const Color iskambilGri = Color(0xFFD3D3D3);

class FalRequestScreen extends StatelessWidget {
  final String falType;
  const FalRequestScreen({Key? key, required this.falType}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    switch (falType) {
      case 'Kahve Falı':
        return KahveFaliFlow();
      case 'Aşk Falı':
        return AskFaliFlow();
      case 'Tarot':
        return TarotFaliFlow();
      case 'İskambil':
        return IskambilFaliFlow();
      default:
        return Scaffold(
          appBar: AppBar(title: Text(falType)),
          body: const Center(child: Text('Fal ekranı bulunamadı.')),
        );
    }
  }
}

// 1. Kahve Falı - Aşamalı Akış
class KahveFaliFlow extends StatefulWidget {
  @override
  State<KahveFaliFlow> createState() => _KahveFaliFlowState();
}

class _KahveFaliFlowState extends State<KahveFaliFlow> {
  int step = 0;
  String? fincanPhoto;
  String? tabakPhoto;
  String? ruhHali;
  String? aciklama;
  List<String> etiketler = [];
  final TextEditingController aciklamaController = TextEditingController();
  final List<String> ruhHalleri = ['Mutlu', 'Endişeli', 'Yorgun', 'Heyecanlı', 'Kararsız'];
  final List<String> tumEtiketler = ['Aşk', 'İş', 'Para', 'Sağlık'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kahveKoyu,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text('Kahve Falı', style: TextStyle(color: kahveAltin)),
        iconTheme: const IconThemeData(color: kahveAltin),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: _buildStep(),
      ),
    );
  }

  Widget _buildStep() {
    switch (step) {
      case 0:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text('Fincan fotoğrafı yükle (zorunlu)', style: TextStyle(color: kahveAltin, fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            _photoUploadButton('Fincan Fotoğrafı', true, (path) => setState(() => fincanPhoto = path)),
            const SizedBox(height: 24),
            const Text('Tabak fotoğrafı yükle (opsiyonel)', style: TextStyle(color: kahveAltin)),
            const SizedBox(height: 12),
            _photoUploadButton('Tabak Fotoğrafı', false, (path) => setState(() => tabakPhoto = path)),
            const Spacer(),
            ElevatedButton(
              onPressed: fincanPhoto != null ? () => setState(() => step = 1) : null,
              style: ElevatedButton.styleFrom(
                backgroundColor: kahveAltin,
                foregroundColor: kahveKoyu,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              ),
              child: const Text('Devam'),
            ),
          ],
        );
      case 1:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text('Ruh halini seç (isteğe bağlı)', style: TextStyle(color: kahveAltin)),
            const SizedBox(height: 12),
            Wrap(
              spacing: 10,
              children: ruhHalleri.map((h) => ChoiceChip(
                label: Text(h),
                selected: ruhHali == h,
                selectedColor: kahveAltin,
                labelStyle: TextStyle(color: ruhHali == h ? kahveKoyu : kahveAltin),
                backgroundColor: kahveKrem,
                onSelected: (_) => setState(() => ruhHali = h),
              )).toList(),
            ),
            const Spacer(),
            ElevatedButton(
              onPressed: () => setState(() => step = 2),
              style: ElevatedButton.styleFrom(
                backgroundColor: kahveAltin,
                foregroundColor: kahveKoyu,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              ),
              child: const Text('Devam'),
            ),
          ],
        );
      case 2:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text('Sorunu veya merak ettiğin konuyu yaz', style: TextStyle(color: kahveAltin)),
            const SizedBox(height: 12),
            TextField(
              controller: aciklamaController,
              maxLines: 2,
              style: const TextStyle(color: kahveKoyu),
              decoration: InputDecoration(
                filled: true,
                fillColor: kahveKrem,
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                hintText: 'Örn: Aşk hayatımda ne olacak?',
                hintStyle: const TextStyle(color: kahveKoyu),
              ),
              onChanged: (v) => aciklama = v,
            ),
            const SizedBox(height: 24),
            const Text('Etiket seç (isteğe bağlı)', style: TextStyle(color: kahveAltin)),
            const SizedBox(height: 8),
            Wrap(
              spacing: 10,
              children: tumEtiketler.map((e) => FilterChip(
                label: Text(e),
                selected: etiketler.contains(e),
                selectedColor: kahveAltin,
                labelStyle: TextStyle(color: etiketler.contains(e) ? kahveKoyu : kahveAltin),
                backgroundColor: kahveKrem,
                onSelected: (selected) {
                  setState(() {
                    if (selected) {
                      etiketler.add(e);
                    } else {
                      etiketler.remove(e);
                    }
                  });
                },
              )).toList(),
            ),
            const Spacer(),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ChatScreen(falType: 'Kahve Falı'),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: kahveAltin,
                foregroundColor: kahveKoyu,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              ),
              child: const Text('Fal Gönder'),
            ),
          ],
        );
      default:
        return const SizedBox();
    }
  }

  Widget _photoUploadButton(String label, bool required, Function(String) onPicked) {
    return GestureDetector(
      onTap: () {
        // TODO: Fotoğraf seçme işlemi
        onPicked('dummy_path');
      },
      child: Container(
        height: 100,
        decoration: BoxDecoration(
          color: kahveKrem,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: kahveAltin, width: 2),
        ),
        child: Center(
          child: Text(label, style: TextStyle(color: kahveKoyu, fontWeight: FontWeight.bold)),
        ),
      ),
    );
  }
}

// 2. Aşk Falı - Aşamalı Akış
class AskFaliFlow extends StatefulWidget {
  @override
  State<AskFaliFlow> createState() => _AskFaliFlowState();
}

class _AskFaliFlowState extends State<AskFaliFlow> {
  int step = 0;
  String? iliskiDurumu;
  String? bilgiTipi;
  String? aciklama;
  final TextEditingController aciklamaController = TextEditingController();
  final List<String> bilgiTipleri = ['Ayrılık', 'Yeni ilişki', 'Eski sevgili', 'Ruh eşi', 'Sadakat'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: askPembe,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text('Aşk Falı', style: TextStyle(color: askPastelMor)),
        iconTheme: const IconThemeData(color: askPastelMor),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: _buildStep(),
      ),
    );
  }

  Widget _buildStep() {
    switch (step) {
      case 0:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text('İlişkiniz var mı?', style: TextStyle(color: askPastelMor, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _selectButton('Evet', iliskiDurumu == 'Evet', () => setState(() => iliskiDurumu = 'Evet')),
                const SizedBox(width: 24),
                _selectButton('Hayır', iliskiDurumu == 'Hayır', () => setState(() => iliskiDurumu = 'Hayır')),
              ],
            ),
            const Spacer(),
            ElevatedButton(
              onPressed: iliskiDurumu != null ? () => setState(() => step = 1) : null,
              style: ElevatedButton.styleFrom(
                backgroundColor: askPastelMor,
                foregroundColor: askBeyaz,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              ),
              child: const Text('Devam'),
            ),
          ],
        );
      case 1:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text('Ne hakkında bilgi almak istiyorsunuz?', style: TextStyle(color: askPastelMor)),
            const SizedBox(height: 16),
            Wrap(
              spacing: 12,
              children: bilgiTipleri.map((b) => ChoiceChip(
                label: Text(b),
                selected: bilgiTipi == b,
                selectedColor: askPastelMor,
                labelStyle: TextStyle(color: bilgiTipi == b ? askBeyaz : askPastelMor),
                backgroundColor: askBeyaz,
                onSelected: (_) => setState(() => bilgiTipi = b),
              )).toList(),
            ),
            const Spacer(),
            ElevatedButton(
              onPressed: bilgiTipi != null ? () => setState(() => step = 2) : null,
              style: ElevatedButton.styleFrom(
                backgroundColor: askPastelMor,
                foregroundColor: askBeyaz,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              ),
              child: const Text('Devam'),
            ),
          ],
        );
      case 2:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text('Sorunuzu yazabilirsiniz', style: TextStyle(color: askPastelMor)),
            const SizedBox(height: 12),
            TextField(
              controller: aciklamaController,
              maxLines: 2,
              style: const TextStyle(color: askPastelMor),
              decoration: InputDecoration(
                filled: true,
                fillColor: askBeyaz,
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                hintText: 'Örn: Eski sevgilim geri dönecek mi?',
                hintStyle: const TextStyle(color: askPastelMor),
              ),
              onChanged: (v) => aciklama = v,
            ),
            const Spacer(),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ChatScreen(falType: 'Aşk Falı'),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: askPastelMor,
                foregroundColor: askBeyaz,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              ),
              child: const Text('Fal Gönder'),
            ),
          ],
        );
      default:
        return const SizedBox();
    }
  }

  Widget _selectButton(String label, bool selected, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
        decoration: BoxDecoration(
          color: selected ? askPastelMor : askBeyaz,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: askPastelMor, width: 2),
        ),
        child: Text(label, style: TextStyle(color: selected ? askBeyaz : askPastelMor, fontWeight: FontWeight.bold)),
      ),
    );
  }
}

// 3. Tarot Falı - Aşamalı Akış
class TarotFaliFlow extends StatefulWidget {
  @override
  State<TarotFaliFlow> createState() => _TarotFaliFlowState();
}

class _TarotFaliFlowState extends State<TarotFaliFlow> {
  int step = 0;
  List<int> selectedCards = [];
  String? tema;
  String? aciklama;
  final TextEditingController aciklamaController = TextEditingController();
  final List<String> temalar = ['Aşk', 'İş', 'Genel'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: tarotLacivert,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text('Tarot Falı', style: TextStyle(color: tarotAltin)),
        iconTheme: const IconThemeData(color: tarotAltin),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: _buildStep(),
      ),
    );
  }

  Widget _buildStep() {
    switch (step) {
      case 0:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text('Tema seç', style: TextStyle(color: tarotAltin)),
            const SizedBox(height: 16),
            Wrap(
              spacing: 12,
              children: temalar.map((t) => ChoiceChip(
                label: Text(t),
                selected: tema == t,
                selectedColor: tarotAltin,
                labelStyle: TextStyle(color: tema == t ? tarotLacivert : tarotAltin),
                backgroundColor: Colors.white,
                onSelected: (_) => setState(() => tema = t),
              )).toList(),
            ),
            const Spacer(),
            ElevatedButton(
              onPressed: tema != null ? () => setState(() => step = 1) : null,
              style: ElevatedButton.styleFrom(
                backgroundColor: tarotAltin,
                foregroundColor: tarotLacivert,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              ),
              child: const Text('Devam'),
            ),
          ],
        );
      case 1:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text('3 kart seç', style: TextStyle(color: tarotAltin)),
            const SizedBox(height: 16),
            SizedBox(
              height: 110,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 7,
                itemBuilder: (context, index) {
                  final isSelected = selectedCards.contains(index);
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        if (isSelected) {
                          selectedCards.remove(index);
                        } else if (selectedCards.length < 3) {
                          selectedCards.add(index);
                        }
                      });
                    },
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      margin: const EdgeInsets.symmetric(horizontal: 8),
                      width: 70,
                      decoration: BoxDecoration(
                        color: isSelected ? tarotAltin : tarotLacivert,
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(color: tarotAltin, width: 2),
                      ),
                      child: Center(
                        child: Text(
                          'K${index + 1}',
                          style: TextStyle(
                            color: isSelected ? tarotLacivert : tarotAltin,
                            fontWeight: FontWeight.bold,
                            fontSize: 22,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            const Spacer(),
            ElevatedButton(
              onPressed: selectedCards.length == 3 ? () => setState(() => step = 2) : null,
              style: ElevatedButton.styleFrom(
                backgroundColor: tarotAltin,
                foregroundColor: tarotLacivert,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              ),
              child: const Text('Devam'),
            ),
          ],
        );
      case 2:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text('Niyetini veya sorunu yaz', style: TextStyle(color: tarotAltin)),
            const SizedBox(height: 12),
            TextField(
              controller: aciklamaController,
              maxLines: 2,
              style: const TextStyle(color: tarotAltin),
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                hintText: 'Örn: Kariyerimde ne olacak?',
                hintStyle: const TextStyle(color: tarotAltin),
              ),
              onChanged: (v) => aciklama = v,
            ),
            const Spacer(),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ChatScreen(falType: 'Tarot'),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: tarotAltin,
                foregroundColor: tarotLacivert,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              ),
              child: const Text('Fal Gönder'),
            ),
          ],
        );
      default:
        return const SizedBox();
    }
  }
}

// 4. İskambil Falı - Aşamalı Akış
class IskambilFaliFlow extends StatefulWidget {
  @override
  State<IskambilFaliFlow> createState() => _IskambilFaliFlowState();
}

class _IskambilFaliFlowState extends State<IskambilFaliFlow> {
  int step = 0;
  List<int> selectedCards = [];
  String? konu;
  String? aciklama;
  final TextEditingController aciklamaController = TextEditingController();
  final List<String> konular = ['Aşk', 'Para', 'Sağlık', 'Kariyer'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: iskambilSiyah,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text('İskambil Falı', style: TextStyle(color: iskambilKirmizi)),
        iconTheme: const IconThemeData(color: iskambilKirmizi),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: _buildStep(),
      ),
    );
  }

  Widget _buildStep() {
    switch (step) {
      case 0:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text('Konu seç', style: TextStyle(color: iskambilKirmizi)),
            const SizedBox(height: 16),
            Wrap(
              spacing: 12,
              children: konular.map((k) => ChoiceChip(
                label: Text(k),
                selected: konu == k,
                selectedColor: iskambilKirmizi,
                labelStyle: TextStyle(color: konu == k ? iskambilGri : iskambilKirmizi),
                backgroundColor: iskambilGri,
                onSelected: (_) => setState(() => konu = k),
              )).toList(),
            ),
            const Spacer(),
            ElevatedButton(
              onPressed: konu != null ? () => setState(() => step = 1) : null,
              style: ElevatedButton.styleFrom(
                backgroundColor: iskambilKirmizi,
                foregroundColor: iskambilGri,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              ),
              child: const Text('Devam'),
            ),
          ],
        );
      case 1:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text('Kartlarını seç (3, 5 veya 7 kart)', style: TextStyle(color: iskambilKirmizi)),
            const SizedBox(height: 16),
            SizedBox(
              height: 110,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 7,
                itemBuilder: (context, index) {
                  final isSelected = selectedCards.contains(index);
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        if (isSelected) {
                          selectedCards.remove(index);
                        } else if (selectedCards.length < 7) {
                          selectedCards.add(index);
                        }
                      });
                    },
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      margin: const EdgeInsets.symmetric(horizontal: 8),
                      width: 70,
                      decoration: BoxDecoration(
                        color: isSelected ? iskambilKirmizi : iskambilSiyah,
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(color: iskambilGri, width: 2),
                      ),
                      child: Center(
                        child: Text(
                          'K${index + 1}',
                          style: TextStyle(
                            color: isSelected ? iskambilGri : iskambilKirmizi,
                            fontWeight: FontWeight.bold,
                            fontSize: 22,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            const Spacer(),
            ElevatedButton(
              onPressed: selectedCards.length == 3 || selectedCards.length == 5 || selectedCards.length == 7
                  ? () => setState(() => step = 2)
                  : null,
              style: ElevatedButton.styleFrom(
                backgroundColor: iskambilKirmizi,
                foregroundColor: iskambilGri,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              ),
              child: const Text('Devam'),
            ),
          ],
        );
      case 2:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text('Merak ettiğiniz özel bir şey var mı?', style: TextStyle(color: iskambilKirmizi)),
            const SizedBox(height: 12),
            TextField(
              controller: aciklamaController,
              maxLines: 2,
              style: const TextStyle(color: iskambilKirmizi),
              decoration: InputDecoration(
                filled: true,
                fillColor: iskambilGri,
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                hintText: 'Örn: Sağlığım hakkında ne görüyorsunuz?',
                hintStyle: const TextStyle(color: iskambilKirmizi),
              ),
              onChanged: (v) => aciklama = v,
            ),
            const Spacer(),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ChatScreen(falType: 'İskambil'),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: iskambilKirmizi,
                foregroundColor: iskambilGri,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              ),
              child: const Text('Fal Gönder'),
            ),
          ],
        );
      default:
        return const SizedBox();
    }
  }
} 