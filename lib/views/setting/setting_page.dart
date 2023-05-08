
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../provider/themeprovider.dart';

class Setting extends StatefulWidget {
  const Setting({Key? key}) : super(key: key);

  @override
  State<Setting> createState() => _SettingState();
}

class _SettingState extends State<Setting> {
  final List<ThemeMode> _themeModes = [
    ThemeMode.light,
    ThemeMode.dark,
    ThemeMode.system,
  ];


  @override
  Widget build(BuildContext context) {
    final provider =  Provider.of<ThemeProvider>(context);

    return  Scaffold(
      appBar: AppBar(title: Text("Setting page"),),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          RadioListTile<ThemeMode>(
            title: Text("Light mode"),
              value: ThemeMode.light,
              groupValue: provider.themeMode
              , onChanged: provider.setTheme
          ),
          RadioListTile<ThemeMode>(
              title: Text("Dark mode"),
              value: ThemeMode.dark,
              groupValue: provider.themeMode
              , onChanged: provider.setTheme
          ),
          RadioListTile<ThemeMode>(
              title: Text("System mode"),
              value: ThemeMode.system,
              groupValue: provider.themeMode
              , onChanged: provider.setTheme
          ),
          buildSwitch()

        ],

      ),

    );


    // return Column(
    //   mainAxisAlignment: MainAxisAlignment.center,
    //   children: _themeModes
    //       .map(
    //         (themeMode) => Row(
    //       children: [
    //         Expanded(
    //           child: Text(
    //             _getThemeModeTitle(themeMode),
    //           ),
    //         ),
    //         Radio(
    //           value: themeMode,
    //           groupValue: provider.themeMode,
    //           onChanged: (value) {
    //             provider.setTheme(value);
    //           },
    //         ),
    //       ],
    //     ),
    //   )
    //       .toList(),
    // );
  }
  // String _getThemeModeTitle(ThemeMode themeMode) {
  //   switch (themeMode) {
  //     case ThemeMode.light:
  //       return 'Light';
  //     case ThemeMode.dark:
  //       return 'Dark';
  //     case ThemeMode.system:
  //       return 'System Default';
  //     default:
  //       return '';
  //   }
  // }
}

Widget buildSwitch() {
  return Consumer<ThemeProvider>(
    builder: (context, themeProvider, _) => SwitchListTile(
      title: Text(
        themeProvider.themeMode == ThemeMode.light
            ? 'Light Theme'
            : 'Dark Theme',
      ),
      value: themeProvider.themeMode == ThemeMode.dark,
      onChanged: (value) {
        final newThemeMode = value ? ThemeMode.dark : ThemeMode.light;
        themeProvider.setTheme(newThemeMode);
      },
    ),
  );
}

