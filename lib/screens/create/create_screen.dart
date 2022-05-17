import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:xlo_mobx/components/custom_drawer/custom_drawer.dart';
import 'package:xlo_mobx/screens/create/components/images_field.dart';

class CreateScreen extends StatelessWidget {
  const CreateScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    const labelStyle = TextStyle(
      fontWeight: FontWeight.w800,
      color: Colors.grey,
      fontSize: 18,
    );

    const contentPadding = EdgeInsets.fromLTRB(16, 10, 12, 10);

    return Scaffold(
      drawer: CustomDrawer(),
      appBar: AppBar(
        title: const Text('Criar Anúncio'),
        centerTitle: true,
      ),
      body: Card(
        clipBehavior: Clip.antiAlias,
        margin: const EdgeInsets.symmetric(horizontal: 32),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        elevation: 8,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ImagesField(),
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Título *',
                labelStyle: labelStyle,
                contentPadding: contentPadding,
              ),
            ),
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Descrição *',
                labelStyle: labelStyle,
                contentPadding: contentPadding,
              ),
              maxLines: null,
            ),
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Preço *',
                labelStyle: labelStyle,
                contentPadding: contentPadding,
              ),
              keyboardType: TextInputType.number,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
                CentavosInputFormatter(moeda: true),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
