import 'package:flutter/material.dart';
import 'package:pralinen/hero_animation.dart';
import 'package:pralinen/snackbar_display.dart';
import 'package:pralinen/theme_model.dart';
import 'package:provider/provider.dart';

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
          PhotoHero(
            photo: imagePath,
            width: 120,
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) {
                  return Scaffold(
                    appBar: AppBar(
                      title: Text("ARP: " + name),
                    ),
                    body: Center(
                      child: Container(
                        padding: EdgeInsets.all(10),
                        child: PhotoHero(
                          photo: imagePath,
                          width: 700,
                          onTap: () => Navigator.of(context).pop(),
                        ),
                      ),
                    ),
                  );
                },
              ));
            },
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: SnackBarDisplay(
                msg: 'Aufs Bild klicken zum vergrößern',
                duration: const Duration(seconds: 1),
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
          ),
        ],
      ),
    );
  }
}
