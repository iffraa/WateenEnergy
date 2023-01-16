import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:wateen_energy/screens/alarm_screen.dart';
import 'package:wateen_energy/screens/filter_screen.dart';
import 'package:wateen_energy/screens/oandm_screen.dart';
import 'package:wateen_energy/screens/performance_screen.dart';
import 'package:wateen_energy/screens/login_screen.dart';
import 'package:wateen_energy/screens/reporting_screen.dart';
import 'package:wateen_energy/screens/site_detail_screen.dart';
import 'package:wateen_energy/screens/site_screen.dart';
import 'package:wateen_energy/utils/alarm_list_cn.dart';
import 'package:wateen_energy/utils/bottom_nav_index_cn.dart';
import 'package:wateen_energy/utils/site_list_cn.dart';
import 'package:wateen_energy/utils/colour.dart';
import 'package:wateen_energy/widgets/date_range_picker.dart';

Future<void> main() async {
  await GetStorage.init();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => BottomNavIndexCN()),
        ChangeNotifierProvider<SiteListCN>(create: (_) => SiteListCN()),
        ChangeNotifierProvider<AlarmListCN>(create: (_) => AlarmListCN()),

      ],
      child: const MyApp(),
    ),
  );}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return   ResponsiveSizer(
        builder: (context, orientation, screenType) {
          return MaterialApp(
              title: 'Flutter Demo',
              theme: ThemeData(
                textTheme: GoogleFonts.robotoTextTheme(
                  Theme
                      .of(context)
                      .textTheme,
                ),
                //  tabBarTheme: const TabBarTheme(indicator: UnderlineTabIndicator( // color for indicator (underline)
                //    borderSide: BorderSide(color: Colour.tealColor))),
                //  unselectedWidgetColor: AppColors.logoColor,
                  colorScheme: ColorScheme.fromSwatch(
                  primarySwatch: themeColor, accentColor: AppColors.darkBlue)
                  .copyWith(secondary: AppColors.darkBlue),
              ).copyWith(),
              home:  PerformanceScreen(),
              builder: EasyLoading.init(),
              routes: {
                PerformanceScreen.routeName: (ctx) => PerformanceScreen(),
                SiteDetailScreen.routeName: (ctx) => SiteDetailScreen(),
                LoginScreen.routeName: (ctx) => LoginScreen(),
                SiteScreen.routeName: (ctx) => SiteScreen(),
                OnMScreen.routeName: (ctx) => OnMScreen(),
                AlarmsScreen.routeName: (ctx) => AlarmsScreen(),
                FilterScreen.routeName: (ctx) => FilterScreen(),
                ReportingScreen.routeName: (ctx) => ReportingScreen(),

              }
          );
        }
    );
  }

}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  static const routeName = '/home';

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

const MaterialColor themeColor = const MaterialColor(
  0xff000000,
  const <int, Color>{
    200: const Color(0xff3899D5),
    300: const Color(0xff3899D5),
    400: const Color(0xff3899D5),
    500: const Color(0xff3899D5),
    600: const Color(0xff3899D5),
    700: const Color(0xff3899D5),
  },
);

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Invoke "debug painting" (press "p" in the console, choose the
          // "Toggle Debug Paint" action from the Flutter Inspector in Android
          // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
          // to see the wireframe for each widget.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
