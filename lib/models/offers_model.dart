class OffersModel {
  String title = ''; //Наименование акции
  String shortDescription = '';
  String banner = ''; // изображение акции
  String description = ''; // Описание акции
  OffersModel(
      {this.title = '',
      this.shortDescription = '',
      this.banner = '',
      this.description = ''});
}
