import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:xlo_mobx/components/error_box.dart';
import 'package:xlo_mobx/screens/signup/components/field_title.dart';
import 'package:xlo_mobx/stores/signup_store.dart';

class SignUpScreen extends StatelessWidget {
  SignUpScreen({Key? key}) : super(key: key);

  final SignupStore signupStore = SignupStore();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cadastro'),
        centerTitle: true,
      ),
      body: Container(
        alignment: Alignment.center,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: Card(
              margin: const EdgeInsets.symmetric(horizontal: 32),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              elevation: 8,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Observer(
                      builder: (_){
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          child: ErrorBox(
                            message: signupStore.error,
                          ),
                        );
                      },
                    ),
                    const FieldTitle(
                      title: 'Apelido',
                      subtitle: 'Como aparecerá em seus anúncios',
                    ),
                    Observer(
                      builder: (_){
                        return TextField(
                          enabled: !signupStore.loading,
                          decoration: InputDecoration(
                            border: const OutlineInputBorder(),
                            hintText: 'Exemplo: João S.',
                            isDense: true,
                            errorText: signupStore.nameError,
                          ),
                          onChanged: signupStore.setName,
                        );
                      }
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    const FieldTitle(
                      title: 'E-mail',
                      subtitle: 'Enviaremos um e-mail de confirmação',
                    ),
                    Observer(
                      builder: (_) {
                        return TextField(
                          enabled: !signupStore.loading,
                          decoration: InputDecoration(
                            border: const OutlineInputBorder(),
                            hintText: 'Exemplo: joao@gmail.com',
                            isDense: true,
                            errorText: signupStore.emailError,
                          ),
                          keyboardType: TextInputType.emailAddress,
                          autocorrect: false,
                          onChanged: signupStore.setEmail,
                        );
                      },
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    const FieldTitle(
                      title: 'Celular',
                      subtitle: 'Proteja sua conta',
                    ),
                    Observer(
                      builder: (_){
                        return TextField(
                          enabled: !signupStore.loading,
                          decoration: InputDecoration(
                            border: const OutlineInputBorder(),
                            hintText: '(91) 99999-9999',
                            isDense: true,
                            errorText: signupStore.phoneError,
                          ),
                          keyboardType: TextInputType.phone,
                          onChanged: signupStore.setPhone,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                            TelefoneInputFormatter(),
                          ],
                        );
                      },
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    const FieldTitle(
                      title: 'Senha',
                      subtitle: 'Use letras, números e caracteres especiais',
                    ),
                    Observer(
                      builder: (_){
                        return TextField(
                          enabled: !signupStore.loading,
                          decoration: InputDecoration(
                            border: const OutlineInputBorder(),
                            isDense: true,
                            errorText: signupStore.pass1Error,
                          ),
                          obscureText: true,
                          onChanged: signupStore.setPass1,
                        );
                      },
                    ),
                    const SizedBox(height: 16),
                    const FieldTitle(
                      title: 'Confirmar Senha',
                      subtitle: 'Repita a senha',
                    ),
                    Observer(
                      builder: (_){
                        return TextField(
                          enabled: !signupStore.loading,
                          decoration: InputDecoration(
                            border: const OutlineInputBorder(),
                            isDense: true,
                            errorText: signupStore.pass2Error,
                          ),
                          obscureText: true,
                          onChanged: signupStore.setPass2,
                        );
                      },
                    ),
                    Observer(
                      builder: (_){
                        return Container(
                          height: 40,
                          margin: const EdgeInsets.only(
                            top: 20,
                            bottom: 12,
                          ),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                primary: Colors.orange,
                                onSurface: Colors.orange.withAlpha(120),
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20)),
                                textStyle: const TextStyle(
                                  color: Colors.white,
                                ),
                            ),
                            child: signupStore.loading
                                ? const CircularProgressIndicator(
                              valueColor: AlwaysStoppedAnimation(Colors.white),
                            )
                                : const Text('CADASTRAR'),
                            onPressed: signupStore.signUpPressed,
                          ),
                        );
                      },
                    ),
                    const Divider(color: Colors.black),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: Wrap(
                        alignment: WrapAlignment.center,
                        children: [
                          const Text(
                            'Já tem uma conta? ',
                            style: TextStyle(fontSize: 16),
                          ),
                          GestureDetector(
                            onTap: Navigator.of(context).pop,
                            child: const Text(
                              'Entrar',
                              style: TextStyle(
                                decoration: TextDecoration.underline,
                                color: Colors.purple,
                                fontSize: 16,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
