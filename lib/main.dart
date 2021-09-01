import 'package:flutter/material.dart';
import 'package:pralinen/theme_model.dart';
import 'package:provider/provider.dart';

void main() {
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

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Center(
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
            SizedBox(height: 15),
            Row(
              children: [
                Text('Wer in 2021 hat denn bitte keinen Dark Mode? '),
                Switch(
                  value: context.watch<ThemeModel>().isDark,
                  onChanged: (useDark) => context.read<ThemeModel>().isDark =useDark,
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
                            'Zartbitterschokolade gefüllt mit Ganache. Dekoriert mit einer Mokkabohne.',
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
              child: Text(
                'Die Pralinenmanufaktur deines Vertrauens wünscht lange Nächte und alles Gute zum Geburtstag!',
                style: Theme.of(context).textTheme.subtitle1,
              ),
            ),
            Divider(),
            AsteriskExplanation(
                nrAsterisks: 1,
                description:
                    'Not Safe For Driving.\nVom Konsum vor oder während dem Führen eines Kraftfahrzeugs wird abgeraten. Die Pralinenmanufaktur weist jegliche Haftung von sich.'),
            AsteriskExplanation(
                nrAsterisks: 2,
                description:
                    'Bei den Anti-Rentner-Pralinen Orange und Double Nuss handelt es sich um Placebopräparate'),
          ],
        ),
      ),
    );
  }
}

class Praline extends StatelessWidget {
  const Praline(
      {Key? key,
      required this.imagePath,
      required this.name,
      this.info = "",
      this.nsfd = false,
      this.isPlacebo = false})
      : super(key: key);

  final String imagePath;
  final String name;
  final String info;
  final bool nsfd;
  final bool isPlacebo;

  @override
  Widget build(BuildContext context) {
    Color? orangeCardColor = context.watch<ThemeModel>().mode == ThemeMode.dark
        ? Colors.deepOrange[700]
        : Theme.of(context).cardColor; // or Colors.orange[100]
    return Card(
      elevation: 3,
      color: name != 'Orange' ? Theme.of(context).cardColor : orangeCardColor,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            imagePath,
            height: 120,
            width: 120,
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "ARP: ",
                        style: Theme.of(context).textTheme.headline5,
                      ),
                      Text(
                        '$name',
                        style: Theme.of(context).textTheme.headline6,
                      ),
                      Text(
                        isPlacebo ? ' **' : "",
                        style: Theme.of(context).textTheme.caption,
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Text(
                    '$info',
                    style: Theme.of(context).textTheme.bodyText2,
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        nsfd ? "NSFD" : "",
                        textAlign: TextAlign.end,
                      ),
                      Text(nsfd ? '*' : "",
                          style: Theme.of(context).textTheme.caption),
                    ],
                  )
                ],
              ),
            ),
          ),
        ],
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
