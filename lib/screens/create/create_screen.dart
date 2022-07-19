import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:xlo_mobx/components/custom_drawer/custom_drawer.dart';
import 'package:xlo_mobx/screens/create/components/category_field.dart';
import 'package:xlo_mobx/screens/create/components/cep_field.dart';
import 'package:xlo_mobx/screens/create/components/hide_phone_field.dart';
import 'package:xlo_mobx/screens/create/components/images_field.dart';
import 'package:xlo_mobx/stores/create_store.dart';

class CreateScreen extends StatelessWidget {
  CreateScreen({Key? key}) : super(key: key);

  final CreateStore createStore = CreateStore();

  @override
  Widget build(BuildContext context) {
    const labelStyle = TextStyle(
      fontWeight: FontWeight.w800,
      color: Colors.grey,
      fontSize: 18,
    );

    const contentPadding = EdgeInsets.fromLTRB(16, 10, 12, 10);

    return Scaffold(
      drawer: const CustomDrawer(),
      appBar: AppBar(
        title: const Text('Criar Anúncio'),
        centerTitle: true,
      ),
      body: Container(
        alignment: Alignment.center,
        child: SingleChildScrollView(
          child: Card(
            clipBehavior: Clip.antiAlias,
            margin: const EdgeInsets.symmetric(horizontal: 32),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            elevation: 8,
            child: SingleChildScrollView(
              child: Observer(builder: (context) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ImagesField(createStore),
                    Observer(builder: (_) {
                      return TextFormField(
                        onChanged: createStore.setTitle,
                        decoration: InputDecoration(
                          labelText: 'Título *',
                          labelStyle: labelStyle,
                          contentPadding: contentPadding,
                          errorText: createStore.titleError,
                        ),
                      );
                    }),
                    Observer(builder: (_) {
                      return TextFormField(
                        onChanged: createStore.setDescription,
                        decoration: InputDecoration(
                          labelText: 'Descrição *',
                          labelStyle: labelStyle,
                          contentPadding: contentPadding,
                          errorText: createStore.descriptionError,
                        ),
                        maxLines: null,
                      );
                    }),
                    CategoryField(createStore),
                    CepField(createStore),
                    Observer(builder: (_) {
                      return TextFormField(
                        onChanged: createStore.setPrice,
                        decoration: InputDecoration(
                          errorText: createStore.priceError,
                          labelText: 'Preço *',
                          labelStyle: labelStyle,
                          contentPadding: contentPadding,
                        ),
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                          CentavosInputFormatter(moeda: true),
                        ],
                      );
                    }),
                    HidePhoneField(createStore: createStore),
                    Observer(builder: (_) {
                      return SizedBox(
                        height: 50,
                        child: GestureDetector(
                          onTap: createStore.invalidSendPressed,
                          child: ElevatedButton(
                            onPressed: createStore.sendPressed,
                            child: const Text(
                              'Enviar',
                              style: TextStyle(
                                fontSize: 18,
                              ),
                            ),
                            style: ElevatedButton.styleFrom(
                                primary: Colors.orange,
                                onSurface: Colors.orange.withAlpha(120),
                                tapTargetSize: MaterialTapTargetSize.shrinkWrap),
                          ),
                        ),
                      );
                    }),
                  ],
                );
              }),
            ),
          ),
        ),
      ),
    );
  }
}
