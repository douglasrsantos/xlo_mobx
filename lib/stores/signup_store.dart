import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';
import 'package:xlo_mobx/helpers/extensions.dart';
import 'package:xlo_mobx/models/user.dart';
import 'package:xlo_mobx/repositories/user_repository.dart';
import 'package:xlo_mobx/stores/user_manager_store.dart';

part 'signup_store.g.dart';

class SignupStore = _SignupStore with _$SignupStore;

abstract class _SignupStore with Store {

  //validação nome
  @observable
  String? name;

  @action
  void setName(String value) => name = value;

  @computed
  bool get nameValid => name != null && name!.length  >= 6;
  // ignore: body_might_complete_normally_nullable
  String? get nameError {
    if (name != null) {
      if (nameValid) {
        return null;
      } else if (name == null || name!.isEmpty) {
        return 'Campo obrigatório';
      } else {
        return 'Nome muito curto';
      }
    }
  }

  //validação e-mail
  @observable
  String? email;

  @action
  void setEmail(String value) => email = value;

  @computed
  bool? get emailValid => email != null && email!.isEmailValid();
  // ignore: body_might_complete_normally_nullable
  String? get emailError {
    if (email != null) {
      if (emailValid!) {
        return null;
      } else if (email == null || email!.isEmpty) {
        return 'Campo obrigatório';
      } else {
        return 'E-mail inválido';
      }
    }
  }

  //validação telefone
  @observable
  String? phone;
  
  @action
  void setPhone(String value) => phone = value;

  @computed
  bool get phoneValid => phone != null && phone!.length  >= 14;
  // ignore: body_might_complete_normally_nullable
  String? get phoneError {
    if (phone != null) {
      if (phoneValid) {
        return null;
      } else if (phone!.isEmpty) {
        return 'Campo obrigatório';
      } else {
        return 'Celular Inválido';
      }
    }
  }

  //validação senha
  @observable
  String? pass1;

  @action
  void setPass1(String value) => pass1 = value;

  @computed
  bool get pass1Valid => pass1 != null && pass1!.length  >= 6;
  // ignore: body_might_complete_normally_nullable
  String? get pass1Error {
    if (pass1 != null) {
      if (pass1Valid) {
        return null;
      } else if (pass1!.isEmpty) {
        return 'Campo obrigatório';
      } else {
        return 'Senha Inválida';
      }
    }
  }

  //validação confirmação senha
  @observable
  String? pass2;

  @action
  void setPass2(String value) => pass2 = value;

  @computed
  bool get pass2Valid => pass2 != null && pass2 == pass1;
  // ignore: body_might_complete_normally_nullable
  String? get pass2Error {
    if (pass2 != null) {
      if (pass2Valid) {
        return null;
      } else {
        return 'Senhas não coincidem';
      }
    }
  }

  //validação do formulário completo através do botão
  @computed
  bool get isFormValid => nameValid && emailValid! && phoneValid && pass1Valid && pass2Valid;

  //validação do botão
  @computed
  dynamic get signUpPressed => (isFormValid && !loading) ? _signUp : null;

  @observable
  bool loading = false;

  @observable
  String? error;

  @action
  setError(String value) => error = value;

  @action
  Future<void> _signUp() async {
    loading = true;

    final user = User(
      name: name,
      email: email,
      phone: phone,
      pasword: pass1,
    );

    try {
      final resultUser = await UserRepository().signUp(user);
      GetIt.I<UserManagerStore>().setUser(resultUser);
    }  catch(e) {
      setError(e.toString());
    }

    loading = false;
  }

}