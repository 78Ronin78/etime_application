class ServicesModel {
  String title = ''; //Название услуги
  String image = ''; //путь к изображению улуги
  String description = ''; // описание услуги
  String banner = ''; //путь к изображению баннера услуги

  ServicesModel(
      {this.title = '',
      this.image = '',
      this.description = '',
      this.banner = ''});
}
