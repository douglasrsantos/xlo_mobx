import 'package:mobx/mobx.dart';
import 'package:xlo_mobx/models/address.dart';
import 'package:xlo_mobx/models/category.dart';
import 'package:xlo_mobx/stores/cep_store.dart';
part 'create_store.g.dart';

class CreateStore = _CreateStoreBase with _$CreateStore;

abstract class _CreateStoreBase with Store {
  ObservableList images = ObservableList();

  @computed
  bool get imagesValid => images.isNotEmpty;
  String? get imagesError {
    if (imagesValid) {
      return null;
    } else {
      return 'Insira Imagens';
    }
  }

  @observable
  String title = '';

  @action
  void setTitle(String value) => title = value;

  @computed
  bool get titleValid => title.length >= 6;
  String? get titleError {
    if (titleValid) {
      return null;
    } else if (title.isEmpty) {
      return 'Campo Obrigatório';
    } else {
      return 'Título Muito Curto';
    }
  }

  @observable
  String description = '';

  @action
  void setDescription(String value) => description = value;

  @computed
  bool get descriptionValid => description.length >= 10;
  String? get descriptionError {
    if (descriptionValid) {
      return null;
    } else if (description.isEmpty) {
      return 'Campo Obrigatório';
    } else {
      return 'Descrição Muito Curta';
    }
  }

  @observable
  Category? category;

  @action
  void setCategory(Category value) => category = value;

  @computed
  bool get categoryValid => category != null;
  String? get categoryError {
    if (categoryValid) {
      return null;
    } else {
      return 'Campo  Obrigatório';
    }
  }

  CepStore cepStore = CepStore();

  @computed
  Address? get address => cepStore.address;
  bool get addressValid => address != null;
  String? get addressError {
    if (addressValid) {
      return null;
    } else {
      return 'Campo Obrigatório';
    }
  }

  @observable
  String priceText = '';

  @action
  void setPrice(String value) => priceText = value;

  @computed
  num? get price {
    if (priceText.contains(',')) {
      return num.tryParse(priceText.replaceAll(RegExp('[^0-9]'), ''))! / 100;
    } else {
      return num.tryParse(priceText);
    }
  }

  bool get priceValid => price != null && price! <= 9999999;
  String? get priceError {
    if (priceValid) {
      return null;
    } else if (priceText.isEmpty) {
      return 'Campo obrigatório';
    } else {
      return 'Preço inválido';
    }
  }

  @observable
  bool hidePhone = false;

  @action
  void setHidePhone(bool? value) => hidePhone = value!;

  @computed
  bool get formValid =>
      imagesValid &&
      titleValid &&
      descriptionValid &&
      categoryValid &&
      addressValid &&
      priceValid;

  void sendPressed() {
    if (!formValid) {
      _send;
    } else {
      null;
    }
  }

  void _send() {}
}
