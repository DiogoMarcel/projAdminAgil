import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:squad_scrum/Telas/menu_principal.dart';

void main() {
  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MenuPrincipal(),
      localizationsDelegates: GlobalMaterialLocalizations.delegates,
      supportedLocales: [Locale('pt', 'BR')],
    ),
  );
}

