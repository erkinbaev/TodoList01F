import 'package:flutter/material.dart';

class SettingsPage extends StatefulWidget{
  final bool isDarkTheme;
  final ValueChanged<bool> onThemeChanged;

  const SettingsPage({super.key, required this.isDarkTheme, required this.onThemeChanged});

  @override
  State<StatefulWidget> createState() => _SettingsPage();
 }

 class _SettingsPage extends State<SettingsPage> {
  late bool value;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    value = widget.isDarkTheme;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Настройки'),
      ),
      body: Column(
        children: [
          Row(
            children: [
              Text("Темная тема"),
              Padding(padding: EdgeInsets.all(40)),
              Switch(
                value: value, 
                onChanged: (v) {
                  setState(() => value = v);
                  widget.onThemeChanged(v);
                }
                )
            ],
          )
        ],
      ),
    );
  }
 }
