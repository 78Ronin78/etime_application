class ProductsModel {
  String title = ''; //Наименование товара
  String image = ''; // изображение товара
  String article = ''; //Артикул товара
  String price = ''; //Стоимость товара
  String description = ''; // Описание товара
  ProductsModel(
      {this.title = '',
      this.image = '',
      this.article = '',
      this.price = '',
      this.description = ''});
}
