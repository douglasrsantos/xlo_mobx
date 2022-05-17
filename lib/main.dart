import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
import 'package:xlo_mobx/screens/base/base_screen.dart';
import 'package:xlo_mobx/stores/page_store.dart';
import 'package:xlo_mobx/stores/user_manager_store.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeParse();
  setupLocators();
  runApp(const MyApp());
}

//cria um singleton, ou seja, o PageStore a ser chamado no app será somente esse
void setupLocators() {
  GetIt.I.registerSingleton(PageStore());
  GetIt.I.registerSingleton(UserManagerStore());
}

Future<void> initializeParse() async {
  //inicializando o Parse
  await Parse().initialize(
    'akkdOKHtT7ipPE39MuZRUIG7AyUrA9B0QEPPmYyK', // App ID
    'https://parseapi.back4app.com/', //Parse API Address
    clientKey: '5urugT5HboSq2WnG8iy9UqDc60DSjcHXBawU6g46',
    autoSendSessionId: true,
    debug: true,
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'XLO MobX',
      theme: ThemeData(
        primaryColor: Colors.purple,
        primarySwatch: Colors.purple,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        scaffoldBackgroundColor: Colors.purple,
        backgroundColor: Colors.purple,
        appBarTheme: const AppBarTheme(
          elevation: 0,
          backgroundColor: Colors.purple,
        ),
        textSelectionTheme: const TextSelectionThemeData(
          cursorColor: Colors.orange,
          selectionColor: Colors.orange,
          selectionHandleColor: Colors.orange,
        ),

      ),
      home: BaseScreen(),
    );
  }
}