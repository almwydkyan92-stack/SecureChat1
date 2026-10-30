import 'package:flutter/material.dart';

void main() => runApp(const SulookApp());

const forest = Color(0xFF174F3B);
const green = Color(0xFF2E7658);
const cream = Color(0xFFF7F5ED);
const paleGreen = Color(0xFFE7F0E8);

class SulookApp extends StatelessWidget {
  const SulookApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'سُلوك',
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: cream,
        colorScheme: ColorScheme.fromSeed(seedColor: forest, primary: forest, surface: cream),
        fontFamily: 'Roboto',
        appBarTheme: const AppBarTheme(backgroundColor: cream, foregroundColor: forest, elevation: 0),
      ),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedIndex = 0;
  final pages = const ['الرئيسية', 'الأذكار', 'المسبحة', 'التقارير'];

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          titleSpacing: 18,
          title: const Row(children: [
            CircleAvatar(radius: 20, backgroundColor: paleGreen, child: Icon(Icons.spa_rounded, color: forest, size: 25)),
            SizedBox(width: 10),
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text('سُلوك', style: TextStyle(fontSize: 21, fontWeight: FontWeight.w800, color: forest)),
              Text('رحلة يومية نحو الأفضل', style: TextStyle(fontSize: 11, color: green)),
            ]),
          ]),
          actions: [IconButton(onPressed: () => _openPage('الإعدادات'), icon: const Icon(Icons.settings_outlined)), const SizedBox(width: 6)],
        ),
        body: SafeArea(child: ListView(
          padding: const EdgeInsets.fromLTRB(18, 8, 18, 22),
          children: [
            Container(
              padding: const EdgeInsets.all(22),
              decoration: BoxDecoration(color: forest, borderRadius: BorderRadius.circular(24)),
              child: const Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Row(children: [Icon(Icons.wb_sunny_outlined, color: Color(0xFFDCE9D6), size: 20), SizedBox(width: 8), Text('مساحة هادئة لبداية أفضل', style: TextStyle(color: Color(0xFFDCE9D6), fontSize: 13))]),
                SizedBox(height: 18),
                Text('فَاذْكُرُونِي أَذْكُرْكُمْ', style: TextStyle(color: Colors.white, fontSize: 27, height: 1.7, fontWeight: FontWeight.w700)),
                SizedBox(height: 7),
                Text('سورة البقرة · الآية 152', style: TextStyle(color: Color(0xFFDCE9D6), fontSize: 12)),
                SizedBox(height: 18),
                Text('راقب يومك، أصلح سلوكك، وازدد قربًا من الله.', style: TextStyle(color: Colors.white, fontSize: 13, height: 1.6)),
              ]),
            ),
            const SizedBox(height: 24),
            const Text('رحلتك اليوم', style: TextStyle(fontSize: 19, fontWeight: FontWeight.w800, color: forest)),
            const SizedBox(height: 12),
            Row(children: [
              Expanded(child: _FeatureCard(icon: Icons.menu_book_rounded, title: 'الأذكار', subtitle: 'أذكارك اليومية', onTap: () => _openPage('الأذكار'))),
              const SizedBox(width: 11),
              Expanded(child: _FeatureCard(icon: Icons.touch_app_rounded, title: 'المسبحة', subtitle: 'سبّح واذكر الله', onTap: () => _openPage('المسبحة'))),
            ]),
            const SizedBox(height: 11),
            Row(children: [
              Expanded(child: _FeatureCard(icon: Icons.track_changes_rounded, title: 'سلوكي اليوم', subtitle: 'تابع عاداتك', onTap: () => _openPage('سلوكي اليوم'))),
              const SizedBox(width: 11),
              Expanded(child: _FeatureCard(icon: Icons.insights_rounded, title: 'التقارير', subtitle: 'راجع تقدمك', onTap: () => _openPage('التقارير'))),
            ]),
            const SizedBox(height: 22),
            Container(
              padding: const EdgeInsets.all(17),
              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20), border: Border.all(color: const Color(0xFFE7E6DC))),
              child: const Row(children: [
                CircleAvatar(backgroundColor: paleGreen, child: Icon(Icons.favorite_border_rounded, color: forest)),
                SizedBox(width: 12),
                Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text('خطوة صغيرة تصنع فرقًا', style: TextStyle(color: forest, fontWeight: FontWeight.w700, fontSize: 14)),
                  SizedBox(height: 4), Text('ابدأ اليوم بنية طيبة، ولا تُحمّل نفسك فوق طاقتها.', style: TextStyle(color: Colors.black54, fontSize: 12, height: 1.5)),
                ])),
              ]),
            ),
          ],
        )),
        bottomNavigationBar: NavigationBar(
          backgroundColor: Colors.white,
          indicatorColor: paleGreen,
          selectedIndex: selectedIndex,
          onDestinationSelected: (i) {
            setState(() => selectedIndex = i);
            if (i != 0) _openPage(pages[i]);
          },
          destinations: const [
            NavigationDestination(icon: Icon(Icons.home_outlined), selectedIcon: Icon(Icons.home_rounded), label: 'الرئيسية'),
            NavigationDestination(icon: Icon(Icons.menu_book_outlined), label: 'الأذكار'),
            NavigationDestination(icon: Icon(Icons.radio_button_unchecked), label: 'المسبحة'),
            NavigationDestination(icon: Icon(Icons.bar_chart_rounded), label: 'التقارير'),
          ],
        ),
      ),
    );
  }

  void _openPage(String name) {
    if (name == 'الرئيسية') return;
    Navigator.of(context).push(MaterialPageRoute(builder: (_) => SimpleFeaturePage(title: name)));
  }
}

class _FeatureCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;
  const _FeatureCard({required this.icon, required this.title, required this.subtitle, required this.onTap});

  @override
  Widget build(BuildContext context) => Material(
    color: Colors.white,
    borderRadius: BorderRadius.circular(20),
    child: InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(20), border: Border.all(color: const Color(0xFFE7E6DC))),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Container(width: 43, height: 43, decoration: BoxDecoration(color: paleGreen, borderRadius: BorderRadius.circular(14)), child: Icon(icon, color: forest, size: 24)),
          const SizedBox(height: 13),
          Text(title, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w800, color: forest)),
          const SizedBox(height: 4),
          Text(subtitle, style: const TextStyle(fontSize: 11, color: Colors.black54)),
        ]),
      ),
    ),
  );
}

class SimpleFeaturePage extends StatelessWidget {
  final String title;
  const SimpleFeaturePage({super.key, required this.title});
  @override
  Widget build(BuildContext context) => Directionality(
    textDirection: TextDirection.rtl,
    child: Scaffold(
      appBar: AppBar(title: Text(title, style: const TextStyle(fontWeight: FontWeight.w800))),
      body: Center(child: Padding(padding: const EdgeInsets.all(28), child: Column(mainAxisSize: MainAxisSize.min, children: [
        const Icon(Icons.construction_rounded, size: 52, color: green),
        const SizedBox(height: 16),
        Text('قسم $title', style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w800, color: forest)),
        const SizedBox(height: 8),
        const Text('تم تجهيز مكان هذه الصفحة، وسنضيف وظائفها الفعلية في المرحلة التالية.', textAlign: TextAlign.center, style: TextStyle(height: 1.6, color: Colors.black54)),
      ]))),
    ),
  );
}
