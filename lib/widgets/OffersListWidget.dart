import 'package:etime_application/models/offers_model.dart';
import 'package:etime_application/screens/OfferDetailScreen.dart';
import 'package:flutter/material.dart';

class OfferListWidget extends StatefulWidget {
  const OfferListWidget({super.key});

  @override
  State<OfferListWidget> createState() => _OfferListWidgetState();
}

class _OfferListWidgetState extends State<OfferListWidget> {
  List<OffersModel> offersList = [
    OffersModel(
      title: 'Временные Постоянные',
      shortDescription:
          'VR 2 = 3. Покупаешь 2 часа VR — третий час получаешь в подарок 🎁. Акция действует бессрочно',
      description:
          'VR 2 = 3. Покупаешь 2 часа VR — третий час получаешь в подарок 🎁. Акция действует бессрочн',
      banner: 'assets/offers/offer_vr.jpg',
    ),
    OffersModel(
      title: 'Акция для именинников',
      shortDescription:
          'Если ты приходишь в свой день рождения как минимум с 2 друзьями, то играешь бесплатно! 😏',
      description:
          'Условия: \n -- Ты и твои друзья приобретаете одинаковое количество времени и играете вместе. \n -- Имениннику необходимо предъявить паспорт (для лиц младше 14 лет — свидетельство о рождении) или водительское удостоверение. ФОТОГРАФИИ ДОКУМЕНТОВ НЕ ПРИНИМАЮТСЯ. \n -- Акция действует 5 дней: в день рождения, два дня до и два дня после дня рождения.',
      banner: 'assets/offers/offer_birth_day.jpg',
    ),
    OffersModel(
      title: 'Рейтинг активности',
      shortDescription:
          'В группе действует система рейтинга активности — практически за любую активность ты можешь получить ЁКойны, которые впоследствии обменять на пакет времени в клубе.',
      description:
          'ЁКойны начисляются за любые действия в группе: \n -- За вступление в группу — 25 ЁКойнов \n -- За лайк на пост — 2 ЁКойна, а если лайк поставлен в числе 5 первых — 3 ЁКойна \n -- За комментарии к постам, видео, обсуждениям — по 5 ЁКойнов \n За голосование в опросах — 5 ЁКойнов \n -- За подписку или продление VK Donut — 100 ЁКойнов. \n \n Но действуют и ограничения: \n -- ЁКойны начисляются за активность ТОЛЬКО под 15 последними постами. \n -- При отписке от группы — все ЁКойны участника обнуляются \n -- Под одним постом учитывается только 2 комментария от одного человека и комментарии, идущие подряд от одного человека, считаются как 1 комментарий. \n -- Минимальная длина комментария — 3 слова. Комментарии в виде стикеров и других вложений — не учитываются. \n \n ❗ Главное условие для участия — наличие активного аккаунта в клубе. \n Подробная информация об условиях начисления, количестве ЁКойнов на балансе доступна в личном кабинете рейтинга активности 😉',
      banner: 'assets/offers/offer_rating.jpg',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        physics: NeverScrollableScrollPhysics(),
        scrollDirection: Axis.vertical,
        itemCount: offersList.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => OfferDetailScreen(
                              title: offersList[index].title,
                              description: offersList[index].description,
                              image: offersList[index].banner,
                              chortDescription:
                                  offersList[index].shortDescription,
                            )));
                  },
                  child: Column(
                    children: [
                      Container(
                        height: 300,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          image: DecorationImage(
                            scale: 1.0,
                            fit: BoxFit.fill,
                            image: AssetImage(offersList[index].banner),
                          ),
                        ),
                      ),
                      Text(
                        offersList[index].title,
                        style: TextStyle(
                            color: Color.fromARGB(255, 249, 22, 112),
                            fontWeight: FontWeight.bold,
                            fontSize: 24),
                      ),
                      Text(offersList[index].shortDescription),
                      Divider(
                        color: Color.fromARGB(255, 10, 13, 66),
                        thickness: 2,
                      )
                    ],
                  ),
                ),
              ],
            ),
          );
        });
  }
}
