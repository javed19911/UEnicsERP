import 'dart:io';

import 'package:UEnicsERP/res/color.dart';
import 'package:UEnicsERP/ui/master_page/master_activity.dart';
import 'package:UEnicsERP/data/repository/service_locator.dart';
import 'package:file_saver/file_saver.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_strategy/url_strategy.dart';

import 'data/AppDataManager.dart';
import 'data/local/hive_init.dart';
import 'multiLanguage/lanuages/language.dart';
import 'multiLanguage/localization_delegate.dart';
import 'res/string/Strings.dart';
import 'route_generator.dart';
// import 'ui/login/login_activity.dart';
// import 'ui/login/login_vm.dart';
//
// import 'dart:io';
//
// import 'package:pdf/widgets.dart' as pw;
//
// import 'dart:typed_data';
//
// import 'package:pdf/pdf.dart';
// import 'package:printing/printing.dart';

void main() async {
  await initHive();
  setupLocator();
  setPathUrlStrategy();
  runApp(MyApp());

  // final pdf = pw.Document();
  //
  // pdf.addPage(
  //   pw.Page(
  //     build: (pw.Context context) => pw.Center(
  //       child: pw.Text('Hello World!'),
  //     ),
  //   ),
  // );

  // final file = File('example.pdf');
  // await file.writeAsBytes(await pdf.save());
}

// class MyApp extends StatelessWidget {
//   const MyApp(this.title, {Key? key}) : super(key: key);
//
//   final String title;
//
//   void saveFile() async {
//     await FileSaver.instance.saveFile(
//         "File", await _generatePdf(PdfPageFormat.a4, title), "pdf",
//         mimeType: MimeType.PDF);
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     saveFile();
//
//     return MaterialApp(
//       home: Scaffold(
//         appBar: AppBar(title: Text(title)),
//         body: PdfPreview(
//           build: (format) => _generatePdf(format, title),
//         ),
//       ),
//     );
//   }
//
//   Future<Uint8List> _generatePdf(PdfPageFormat format, String title) async {
//     final pdf = pw.Document(version: PdfVersion.pdf_1_5, compress: true);
//     final font = await PdfGoogleFonts.nunitoExtraLight();
//
//     pdf.addPage(
//       pw.Page(
//         pageFormat: format,
//         build: (context) {
//           return pw.Column(
//             children: [
//               pw.SizedBox(
//                 width: double.infinity,
//                 child: pw.FittedBox(
//                   child: pw.Text(title, style: pw.TextStyle(font: font)),
//                 ),
//               ),
//               pw.SizedBox(height: 20),
//               pw.Flexible(child: pw.FlutterLogo())
//             ],
//           );
//         },
//       ),
//     );
//
//     return pdf.save();
//   }
// }

class MyApp extends StatefulWidget {
  static String createdPrivacyPolicy = 'privacy_policy';
  static String createdTermsOfUses = 'terms_of_uses';

  static void setLocale(BuildContext context, Locale newLocale) {
    var state = context.findAncestorStateOfType<_MyAppState>();
    state?.setLocale(newLocale);
  }

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Locale? _locale;
  AppDataManager _dataManager = AppDataManager();

  void setLocale(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }

  void didChangeDependencies() async {
    _dataManager.getSelectedLanguage().then((locale) {
      setState(() {
        _locale = locale;
      });
    });
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: Strings.app_name,
      theme: ThemeData(
        textTheme: GoogleFonts.latoTextTheme(
          Theme.of(context).textTheme,
        ).apply(bodyColor: CustomColors.graySofi()),
        // scaffoldBackgroundColor: CustomColors.bgColor,
        scaffoldBackgroundColor: Colors.white70,
        brightness: Brightness.light,
        primaryColor: CustomColors.primaryColor,
        // primaryColorDark: CustomColors.primaryColor,
        canvasColor: CustomColors.secondaryColor,
        // primaryColorDark: CustomColors.p,
        // accentColor: const Color(0xFFFFAD32),
      ),
      initialRoute: '/',
      onGenerateRoute: RouteGenerator.generateRoute,
      // home: ChangeNotifierProvider(
      //   create: (context) => vmLogin(),
      //   child: LoginActivity(),
      // ),
      locale: _locale,
      supportedLocales: [
        Locale('en'),
        Locale('hi'),
        Locale('mr'),
        Locale('kn')
      ],
      localizationsDelegates: [
        AppLocalizationDelegate(),
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      localeResolutionCallback: (locale, supportedLocales) {
        for (var supportedLocale in supportedLocales) {
          if (supportedLocale.languageCode == locale?.languageCode) {
            return supportedLocale;
          }
        }
        return supportedLocales.first;
      },
    );
  }
}

Future updateDialog(BuildContext context, {bool forceUpdate = false}) {
  return showDialog(
      context: context,
      barrierDismissible: !forceUpdate,
      builder: (context) {
        return WillPopScope(
          onWillPop: () async {
            return !forceUpdate;
          },
          child: AlertDialog(
            contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(4))),
            content: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                !forceUpdate
                    ? Align(
                        alignment: Alignment.centerRight,
                        child: CircleAvatar(
                          backgroundColor: Colors.black38,
                          radius: 14,
                          child: IconButton(
                            padding: EdgeInsets.zero,
                            icon: Icon(Icons.clear),
                            color: Colors.white,
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          ),
                        ),
                      )
                    : SizedBox(
                        height: 1,
                      ),
                Text(
                  Platform.isIOS
                      ? Language.of(context).updateAvailableOnAppStore
                      : Language.of(context).updateAvailableOnPlayStore,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: CustomColors.graySofi(),
                    fontSize: 22,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  Language.of(context).pleaseUpdateYourAppForTheLatestFeatures,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: CustomColors.graySofi(),
                      fontSize: 15,
                      fontWeight: FontWeight.w300),
                ),
                SizedBox(height: 16),
                updateBtn(context)
              ],
            ),
          ),
        );
      });
}

Widget updateBtn(BuildContext context) {
  return Container(
    child: MaterialButton(
      padding: EdgeInsets.symmetric(vertical: 10),
      minWidth: MediaQuery.of(context).size.width,
      color: CustomColors.darkGreen(),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
      child: Text(
        Language.of(context).update,
        style: TextStyle(
            color: Colors.white, fontSize: 14, fontWeight: FontWeight.normal),
      ),
      onPressed: () async {
        String url =
            'https://play.google.com/store/apps/details?id=com.praman.pramantrading';
        if (Platform.isIOS) {
          //TODO add app store link
          url = 'itms://itunes.apple.com/app/apple-store/id1567339745?mt=8';
        }

        if (await canLaunch(url)) {
          await launch(url);
        } else {
          throw 'Could not launch $url';
        }
        Navigator.pop(context);
      },
    ),
  );
}

extension HexColor on Color {
  /// String is in the format "aabbcc" or "ffaabbcc" with an optional leading "#".
  static Color fromHex(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }

  /// Prefixes a hash sign if [leadingHashSign] is set to `true` (default is `true`).
  String toHex({bool leadingHashSign = true}) => '${leadingHashSign ? '#' : ''}'
      '${alpha.toRadixString(16).padLeft(2, '0')}'
      '${red.toRadixString(16).padLeft(2, '0')}'
      '${green.toRadixString(16).padLeft(2, '0')}'
      '${blue.toRadixString(16).padLeft(2, '0')}';
}
