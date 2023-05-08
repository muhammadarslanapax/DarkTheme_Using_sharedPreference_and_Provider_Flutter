import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled7/provider/themeprovider.dart';
import 'package:untitled7/utils/routes_name.dart';
import 'package:untitled7/views/botom_nav/bottom_nav.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(providers: [
      ChangeNotifierProvider(create: (_)=>ThemeProvider())
    ],
        child:Builder(builder: (BuildContext context) {
          final provider =  Provider.of<ThemeProvider>(context);
         return MaterialApp(
           debugShowCheckedModeBanner: false,
            home: BottomNav(),
            themeMode: provider.themeMode,
           darkTheme: ThemeData(
             brightness: Brightness.dark,
           ),
           theme: ThemeData(

             primarySwatch: Colors.red
           ),
           // onGenerateInitialRoutes: ,
           // initialRoute: ,
          );
        },)

    );

  }
}

