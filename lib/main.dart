import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ThemeModel>(
      create: (_) => ThemeModel(),
      child: Consumer<ThemeModel>(
        builder: (_, model, __) {
          //Gère le changement de theme sur le système
          var window = WidgetsBinding.instance!.window;
          window.onPlatformBrightnessChanged = () {
            Brightness brightness = window.platformBrightness;
            if(Brightness.light == brightness){ // je sais pas pourquoi c'est inversé mais ok pourquoi pas
              model.toLight();
            } else {
              model.toDark();
            }
          };
          return MaterialApp(
            theme: ThemeData.light(), // Provide light theme.
            darkTheme: ThemeData.dark(), // Provide dark theme.
            themeMode: model.mode, // Decides which theme to show.
            home: Scaffold(
              appBar: AppBar(
                 title: const Text('Light/Dark Theme'),
                leading: GestureDetector(
                  onTap: () {
                    model.toggleMode();
                  },
                  child: Icon(
                    model.icon,
                  )
                )
              ),
              body: const Center(
                  child: Text('Salut')
              ),
            ),
          );
        },
      ),
    );
  }
}

class ThemeModel with ChangeNotifier {
  ThemeMode? mode;
  IconData? icon;
  ThemeModel({this.mode = ThemeMode.light, this.icon = Icons.lightbulb});

  void toLight(){
    mode = ThemeMode.light;
    icon = Icons.lightbulb;
    notifyListeners();
  }

  void toDark(){
    mode = ThemeMode.dark;
    icon = Icons.lightbulb_outline;
    notifyListeners();
  }

  void toggleMode() {
    mode = mode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    icon = icon == Icons.lightbulb ? Icons.lightbulb_outline : Icons.lightbulb;
    notifyListeners();
  }
}

