import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pralinen/praline.dart';
import 'package:pralinen/snackbar_display.dart';
import 'package:pralinen/theme_model.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

  return runApp(
    ChangeNotifierProvider<ThemeModel>(
      create: (_) => new ThemeModel(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var appTitle = 'Pralinen-Beipackzettel';
    var customTextTheme = TextTheme(
      headline5: TextStyle(fontSize: 18),
      headline6: TextStyle(fontSize: 18),
      caption: TextStyle(color: Colors.grey),
    );
    return MaterialApp(
      title: appTitle,
      theme: ThemeData(
        brightness: Brightness.light,
        primarySwatch: Colors.lightBlue,
        canvasColor: Colors.lightBlue[50],
        textTheme: customTextTheme,
      ),
      darkTheme:
          ThemeData(brightness: Brightness.dark, textTheme: customTextTheme),
      themeMode: context.watch<ThemeModel>().mode,
      home: MyHomePage(title: appTitle),
    );
  }
}

class MyHomePage extends StatelessWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Center(
              child: SnackBarDisplay(
                msg: "Hier gibt's nichts zu klicken!",
                child: Column(
                  children: [
                    Text(
                      'Die Anti-Rentner-Praline',
                      style: Theme.of(context).textTheme.headline4,
                    ),
                    Text(
                      'b\ündelt die geballte Kraft von Koffein und Ethanol',
                      style: Theme.of(context)
                          .textTheme
                          .subtitle1!
                          .copyWith(fontStyle: FontStyle.italic),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 15),
            Row(
              children: [
                Text('Wer in 2021 hat denn bitte keinen Dark Mode? '),
                Switch(
                  value: context.watch<ThemeModel>().isDark,
                  onChanged: (useDark) =>
                      context.read<ThemeModel>().isDark = useDark,
                ),
              ],
            ),
            Text(
              'Folgende Sorten gibt es:',
              style: Theme.of(context).textTheme.headline5,
            ),
            SizedBox(height: 10),
            Expanded(
              child: Scrollbar(
                isAlwaysShown: true,
                radius: Radius.circular(5),
                child: Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: ListView(
                    children: [
                      Praline(
                        imagePath: 'images/ganache_nougat.jpg',
                        name: 'Classic',
                        nsfd: true,
                        info: 'Feine Ganache gefüllt mit Nougat',
                      ),
                      Praline(
                        imagePath: 'images/ganache_schnaps.jpg',
                        name: 'Express',
                        nsfd: true,
                        info:
                            'Feine Ganache gefüllt mit Kaffeelikör und Espresso',
                      ),
                      Praline(
                        imagePath: 'images/nuss.jpg',
                        name: 'Double Nuss',
                        nsfd: false,
                        isPlacebo: true,
                        info:
                            'Zartbitterschokolade gefüllt mit Nougat und Mandel',
                      ),
                      Praline(
                        imagePath: 'images/schoko_ganache.jpg',
                        name: 'Soft Core',
                        nsfd: true,
                        isPlacebo: false,
                        info:
                            'Zartbitterschokolade gefüllt mit Ganache, dekoriert mit einer Mokkabohne',
                      ),
                      Praline(
                        imagePath: 'images/orange.jpg',
                        name: 'Orange',
                        nsfd: true,
                        isPlacebo: true,
                        info:
                            'Zartbitterschokolade gefüllt mit hausgemachter Orangenmarmelade und Cointreau',
                      ),
                      Praline(
                        imagePath: 'images/schnaps.jpg',
                        name: 'Liquid Power',
                        nsfd: true,
                        info:
                            'Zweierlei Schokolade gefüllt mit einer extra großen Portion Kaffeelikör und Espresso',
                      ),
                      Praline(
                        imagePath: 'images/zweierlei.jpg',
                        name: 'Light',
                        nsfd: false,
                        info: 'Zweierlei Schokolade mit Mokkabohnen',
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: SnackBarDisplay(
                msg: 'Immer diese Leute, die meinen, alles anklicken zu müssen',
                child: Text(
                  'Die Pralinenmanufaktur deines Vertrauens wünscht lange Nächte und alles Gute zum Geburtstag!',
                  style: Theme.of(context).textTheme.subtitle1,
                ),
              ),
            ),
            Divider(),
            AsteriskExplanation(
                nrAsterisks: 1,
                description:
                    'Not Safe For Driving.\nVom Konsum vor oder während dem Führen eines Kraftfahrzeugs wird abgeraten. Die Pralinenmanufaktur weist jegliche Haftung von sich.'),
            SnackBarDisplay(
              msg: 'Die ARP: Light ist auch nur dank den 3% Kaffee in den Mokkabohnen kein Placebo',
              child: AsteriskExplanation(
                  nrAsterisks: 2,
                  description:
                      'Bei den Anti-Rentner-Pralinen Orange und Double Nuss handelt es sich um Placebopräparate ohne Koffein.'),
            ),
          ],
        ),
      ),
    );
  }
}

class AsteriskExplanation extends StatelessWidget {
  const AsteriskExplanation(
      {Key? key, required this.nrAsterisks, required this.description})
      : super(key: key);

  final int nrAsterisks;
  final String description;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 30,
          child: Text(
            '*' * nrAsterisks,
            style: Theme.of(context).textTheme.caption,
          ),
        ),
        Flexible(
          child: Text(
            description,
            style: Theme.of(context).textTheme.caption,
          ),
        )
      ],
    );
  }
}
