import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:moengage_cards/moengage_cards.dart' as moeCards;
import 'package:moengage_flutter/moengage_flutter.dart';
import 'package:moengage_geofence/moengage_geofence.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:moengage_inbox/moengage_inbox.dart';

void _onPushClick(PushCampaignData message) {
  print("_onPushClick(): Push click callback from native to flutter. Payload " +
      message.toString());
}

void _onInAppClick(ClickData message) {
  print("This is a inapp click callback from native to flutter. Payload " +
      message.toString());
}

final MoEngageGeofence _moEngageGeofence =
    MoEngageGeofence("OXTAVQZDWWAROL2ESF8FWE8G");

final MoEngageFlutter _moengagePlugin =
    MoEngageFlutter("OXTAVQZDWWAROL2ESF8FWE8G");

final moeCards.MoEngageCards cards =
    moeCards.MoEngageCards("OXTAVQZDWWAROL2ESF8FWE8G");

final MoEngageInbox _moEngageInbox = MoEngageInbox("OXTAVQZDWWAROL2ESF8FWE8G");

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

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

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  @override
  void initState() {
    super.initState();

    //initPlatformState();
    _moengagePlugin.setInAppClickHandler(_onInAppClick);

    // _moengagePlugin.setInAppShownCallbackHandler(_onInAppShown);
    // _moengagePlugin.setInAppDismissedCallbackHandler(_onInAppDismiss);

    //_moengagePlugin.setSelfHandledInAppHandler(_onInAppSelfHandle);
    // _moengagePlugin.setPushClickCallbackHandler(_onPushClick);
    //
    _moengagePlugin.setPushClickCallbackHandler(_onPushClick);

    _moengagePlugin.initialise();
    _moengagePlugin.setUniqueId("AbhiFlutter");
    _moEngageGeofence.startGeofenceMonitoring();

    cards.initialize();

    FirebaseMessaging _firebaseMessaging =
        FirebaseMessaging.instance; // Change here
    _firebaseMessaging.getToken().then((token) {
      print("token is ======> $token");
      //_moengagePlugin.passFCMPushToken(token!);
    });

    // Future<void> _firebaseMessagingBackgroundHandler(
    //     RemoteMessage message) async {
    //   // If you're going to use other Firebase services in the background, such as Firestore,
    //   // make sure you call `initializeApp` before using other Firebase services.
    //   print("Handling a background message: ${message.data}");

    //   _moengagePlugin.passFCMPushPayload(message.data);
    // }

    //_moengagePlugin.setCurrentContext(['wellwell']);
    _moengagePlugin.showInApp();

    // FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    //   print('Got a message whilst in the foreground!');
    //   print('Message data: ${message.data}');

    //   _moengagePlugin.passFCMPushPayload(message.data);

    //   if (message.notification != null) {
    //     print('Message also contained a notification: ${message.notification}');
    //   }
    // });
  }

  void _incrementCounter() {
    print("click===");
    //_moengagePlugin.showInApp();
    // var properties = MoEProperties();
    // properties
    //     .addAttribute("AbhishantEvent", "idk")
    //     .addAttribute("attrInt", 123);
    // _moengagePlugin.trackEvent('Flutter Event', properties);

    //_moengagePlugin.getSelfHandledInApp();
    //inApp();
    cardInit();
  }

  void inApp() {
    print("THis is in InApp");

    _moengagePlugin.setCurrentContext(['abcde']);
    _moengagePlugin.showInApp();
  }

  void cardInit() async {
    print("=====.");
    moeCards.CardsInfo cardsInfo = await cards.getCardsInfo();

    print('This is the cardInfo data');
    print(cardsInfo);

    cards.refreshCards((data) {
      if (data?.hasUpdates == true) {
        print("idk man thi is the data");
        cards.fetchCards().then((data) {
          print("Yhis is the fetch data");
          print(data);
        });
      }
    });

    print("Hahahaha=====>");
    //cards.cardClicked(cardsInfo.cards[0], 1);
    print(cardsInfo.cards);
    // print(cardsInfo.cards[0].template.containers[0].actionList);
    // print(cardsInfo.cards[0].template.kvPairs);
    print("=======>00");
    print(inspect(cardsInfo));
  }

  void inboxInit() async {
    print("==>");
    InboxData? data = await _moEngageInbox.fetchAllMessages();
    print(data?.messages[0].textContent.message);
    print("oooooo======0000");
    _moEngageInbox.trackMessageClicked(data!.messages[0]);
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
        // TRY THIS: Try changing the color here to a specific color (to
        // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
        // change color while the other colors stay the same.
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
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
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          //
          // TRY THIS: Invoke "debug painting" (choose the "Toggle Debug Paint"
          // action in the IDE, or press "p" in the console), to see the
          // wireframe for each widget.
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times hahaha:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
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
