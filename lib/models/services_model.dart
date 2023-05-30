class ServicesModel {
  String title = ''; //Название услуги
  String image = ''; //путь к изображению улуги
  String description = ''; // описание услуги
  String banner = ''; //путь к изображению баннера услуги
  String url = ''; //ссылка
  bool isOffer = false; //логическая переменная для проверки акции это или нет
  bool isPrice = false; //логическая переменная для проверки цена это или нет

  ServicesModel(
      {this.title = '',
      this.image = '',
      this.description = '',
      this.banner = '',
      this.url = '',
      this.isOffer = false,
      this.isPrice = false});
}
