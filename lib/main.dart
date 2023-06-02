import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:heroicons/heroicons.dart';
import 'package:sizer/sizer.dart';
import 'package:uang_kita/screens/daftar_pengeluaran_screen.dart';
import 'package:uang_kita/screens/daftar_tagihan_screen.dart';

FlutterLocalNotificationsPlugin notificationsPlugin =
    FlutterLocalNotificationsPlugin();

const AndroidInitializationSettings initializationSettingsAndroid =
    AndroidInitializationSettings('app_icon');

const InitializationSettings initializationSettings =
    InitializationSettings(android: initializationSettingsAndroid);

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await notificationsPlugin.initialize(initializationSettings);

  runApp(const UangKitaApp());
}

class UangKitaApp extends StatefulWidget {
  const UangKitaApp({super.key});

  @override
  State<StatefulWidget> createState() => _UangKitaAppState();
}

class _UangKitaAppState extends State<UangKitaApp> {
  int _currentIndex = 0;

  final _screens = [
    const DaftarPengeluaranScreen(),
    const DaftarTagihanScreen(),
  ];

  void onDidReceiveNotificationResponse(
      NotificationResponse notificationResponse) async {
    final String? payload = notificationResponse.payload;
    if (notificationResponse.payload != null) {
      debugPrint('notification payload: $payload');
    }
    await Navigator.push(
      context,
      MaterialPageRoute<void>(builder: (context) => const UangKitaApp()),
    );
  }

  BottomNavigationBarItem _buildNavbarItem(HeroIcons icon, String label) {
    return BottomNavigationBarItem(
        icon: HeroIcon(icon),
        label: label,
        activeIcon: HeroIcon(
          icon,
          style: HeroIconStyle.solid,
        ));
  }

  BottomNavigationBar _buildNavbar() {
    return BottomNavigationBar(
      currentIndex: _currentIndex,
      onTap: (value) {
        setState(() {
          _currentIndex = value;
        });
      },
      items: [
        _buildNavbarItem(HeroIcons.home, 'Beranda'),
        _buildNavbarItem(HeroIcons.banknotes, 'Tagihan'),
      ],
    );
  }

  void callNotification() async {
    const AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails('your channel id', 'your channel name',
            channelDescription: 'your channel description',
            importance: Importance.max,
            priority: Priority.high,
            ticker: 'ticker');
    const NotificationDetails notificationDetails =
        NotificationDetails(android: androidNotificationDetails);
    await notificationsPlugin.show(
        0, 'plain title', 'plain body', notificationDetails,
        payload: 'item x');
  }

  @override
  void initState() {
    super.initState();
    callNotification();
  }

  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, deviceType) {
        return MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            primarySwatch: Colors.blue,
            fontFamily: 'PlusJakartaSans',
            textTheme: TextTheme(
              displayLarge: TextStyle(fontSize: 32.sp),
              displayMedium: TextStyle(fontSize: 28.sp),
              displaySmall: TextStyle(fontSize: 24.sp),
              bodyLarge: TextStyle(fontSize: 20.sp),
              bodyMedium: TextStyle(fontSize: 18.sp),
              bodySmall: TextStyle(fontSize: 16.sp),
              labelLarge: TextStyle(fontSize: 14.sp),
              labelMedium: TextStyle(fontSize: 12.sp),
              labelSmall: TextStyle(fontSize: 10.sp),
            ),
          ),
          home: Scaffold(
            body: SafeArea(child: _screens[_currentIndex]),
            bottomNavigationBar: _buildNavbar(),
          ),
        );
      },
    );
  }
}
