import 'dart:async';

import 'package:etime_application/models/services_model.dart';
import 'package:etime_application/screens/ServiceDetailScreen.dart';
import 'package:flutter/material.dart';

class ServicesCarouselWidget extends StatefulWidget {
  const ServicesCarouselWidget({super.key});

  @override
  State<ServicesCarouselWidget> createState() => _ServicesCarouselWidgetState();
}

class _ServicesCarouselWidgetState extends State<ServicesCarouselWidget> {
  int _currentSlide = 0;

  ScrollController _slideController = ScrollController(
    initialScrollOffset: 0,
  );

  List<ServicesModel> servicesList = [
    ServicesModel(
        title: 'Рейтинг активности',
        description:
            'Для просмотра рейтинга нажмите на кнопку ниже, чтобы перейти в приложение активности',
        image: 'assets/rating.jpg',
        banner: 'assets/rating.jpg',
        url: 'https://vk.com/app7012806_-199136310?ref=group_menu',
        isOffer: false,
        isPrice: false),
    ServicesModel(
        title: 'ПРАВИЛА',
        description:
            'Компьютерный клуб "BOOTCAMP" является частным заведением, поэтому администрация вправе отказать в посещении клуба любому клиенту без объяснения причин отказа.\n \n Общие положения\n -- Запрещается нецензурно выражаться, оскорблять других игроков в устной и письменной форме — при жалобах нарушители будут оштрафованы удалением купленного времени.\n -- Запрещается работа двух и более людей за одним компьютером. При скоплении большого количества людей — администратор вправе удалить всех, кроме тех, кто непосредственно находится за компьютером и оплатил игровое время. \n -- Запрещен проход в клуб и игровые комнаты посторонних лиц, а также клиентов клуба без оплаченного времени. Исключение может быть сделано только для самых постоянных клиентов. \n -- Клиент не имеет права изменять настройки операционной системы, устанавливать и удалять программы и игры, осуществлять иное несанкционированное вмешательство в работу компьютера и сети. \n -- Если в результате действий клиента клуб понес материальный ущерб, то клиент обязан полностью компенсировать этот ущерб.\n \n Нарушение правил и техники безопасности \n Администрация клуба имеет право удалить клиента из клуба без возврата денег, при нарушении правил клуба, либо применить штрафные санкции в виде уменьшении приобретённого игрового времени. \n \n Время работы компьютерного клуба \n -- Клуб работает ежедневно с 14:00 до 06:00, за исключением технических дней о которых оповещает администрация клуба. Нахождение посторонних лиц в нерабочее время клуба за компьютерами запрещено. \n -- Лицам до 18 лет разрешается посещать клуб с 14-00 до 22-00. При непредставлении документов (права, паспорт, загранпаспорт) о наличии 18 лет — клиент на ночь не допускается, а предоплата не возвращается. После 22:00 лица до 18 лет могут находится в клубе только при сопровождении родителей (мать/отец) или официальных опекунов. **(при себе необходимо иметь официальные документы, подтверждающие родство) \n -- С 22-00 до 06-00 клуб работает в ночном режиме. Клиенты, оплатившие ночь, находятся в клубе с 22-00 до 06-00. \n \n Бронирование \n -- Бронирование осуществляется по телефону клуба +7 (908) 652-77-78 или личным присутствием. \n При опоздании клиента на забронированное время без предупреждений об опоздании — бронь аннулируется спустя 10 минут. \n \n Личные вещи \n -- Зона клуба (помещение) не является парковкой транспортных средств (велосипеды, самокаты, скейтборды и пр.), лица, пришедшие с транспортными средствами не обслуживаются. \n Администрация не несёт ответственности за личные вещи, оставленные в гардеробе. \n Запрещается класть на столы личные вещи (куртки, сумки, головные уборы и т.д.). \n \n Напитки и еда \n -- Запрещается: принимать пищу находясь за компьютером. \n -- Лицам в алкогольном и/или наркотическом опьянении будет отказано в посещении клуба. \n -- Запрещается курить и распивать алкогольные напитки на территории клуба, за исключением алкоголя, приобретённого на баре. \n -- Разрешено приносить свои безалкогольные напитки не более 1 литра на человека. Алкогольные напитки приобретаются исключительно на баре. Администрация в праве отказать вам в посещении клуба со своими алкогольными напитками. Лицам, не достигшим 18 лет вход в клуб со своими энергетическими напитками запрещается, так же продажа энергетических напитков лицам, не достигшим 18 лет - запрещена. \n \n Курение и парение \n -- Вейпы, одноразовые устройства парения, а также айкосы и иные стредства употребления никотина/табака запрещены к использованию за компьютером. Администратор в праве применить штрафные санкции в виде уменьшения приобретённого игрового времени или произвести завершение сеанса. Допускается использование вейпов, одноразовых устройств парения, и устройств айкос вне игровых комнат (коридоры, ресепшн, бар, курилка). \n -- Курение табачных изделий допускается только в специально отведённом для этого месте (курилка). \n -- Допускается курение кальянов/паровых коктейлей в игровых комнатах при условии, что в комнатах не находятся лица, не достигшие 18 лет, а также при заполнении 100% игровых мест комнаты одной компанией людей, пришедших вместе. В противном случае администратор вправе отказать вам в употреблении кальяна/парового коктейля за игровым местом. \n \n Гигиена \n -- Туалет находится внутри помещения, справляющие нужду на улице лишаются игрового времени и удаляются из клуба. \n Запрещается мусорить в клубе и на прилегающей территории. \n \n Работа администратора и сервис \n -- Клуб не несёт ответственности за функционирование интернет сервисов. \n -- Клиент обязан выполнять указания администратора, касающиеся соблюдения настоящих правил, правил безопасности и технических условий эксплуатации компьютеров. \n -- Администратор обязан оказывать помощь клиенту в случае возникновения технических проблем. Администратор не обязан обучать клиента работе с компьютером, а также работе с конкретными программами и играми. \n \n Права администрации компьютерного клуба и клиента \n --  Настоящие правила могут быть дополнены администрацией клуба. \n -- Оплатив игровое время в нашем компьютерном клубе, вы соглашаетесь с его правилами.',
        image: 'assets/rules.jpg',
        banner: 'assets/rules_banner.jpg',
        url: '',
        isOffer: false,
        isPrice: false),
    ServicesModel(
        title: 'ЦЕНЫ',
        description: '',
        image: 'assets/price_banner_2.jpg',
        banner: 'assets/price_banner_1.jpg',
        url: '',
        isOffer: false,
        isPrice: true),
    ServicesModel(
        title: 'АКЦИИ',
        description: '',
        image: 'assets/offers.jpg',
        banner: 'assets/offers_banner.jpg',
        isOffer: true,
        isPrice: false),
    ServicesModel(
        title: 'КОНФИГУРАЦИИ',
        description:
            'Зона Gaming — 8 компьютеров: \n -- Процессор — Intel(R) Core(TM) i5-10400F \n -- Материнская плата — MSI Z590-A PRO \n -- Оперативная память — 16 GB 3200 MHz HyperX, \n Видеокарта — NVIDIA GeForce GTX 1050 Ti или AMD Radeon RX 5600 XT \n -- Видеокарта — NVIDIA GeForce GTX 1050 Ti или AMD Radeon RX 5600 XT \n -- Монитор — изогнутый MSI 27" Optix 165 Гц \n -- Компьютерная мышь — HyperX Pulsefire CORE \n -- Клавиатура — HyperX Alloy Origins Core TKL — механическая HyperX Red \n -- Коврик — HyperX \n -- Кресло — ZET GAMING Chaos Guard \n \n Зона STRIM: \n -- Процессор —Intel(R) Core(TM) i9-10900F \n -- Материнская плата — MSI MPG Z490 GAMING PLUS \n -- Оперативная память — 32 GB 3600 MHz HyperX \n -- Видеокарта — NVIDIA GeForce RTX 2080 Super \n -- Монитор — AOC 27" 144 Гц \n -- Второй монитор для стрима — Samsung 31.5" 4K \n -- Компьютерная мышь — HyperX Pulsefire Surge RGB \n -- Клавиатура — HyperX Alloy Origins Core TKL RGB - механическая HyperX Red \n -- Коврик — HyperX \n -- Микрофон — HyperX QuadCast \n -- Веб-камера — Logitech StreamCam \n -- Гарнитура — HyperX Cloud Alpha S \n -- Кресло — ZET GAMING Force armor 2000M \n -- Студийный свет — Falcon Eyes KeyLight x2',
        image: 'assets/configs.jpg',
        banner: 'assets/configs_banner.jpg',
        isOffer: false,
        isPrice: false),
    ServicesModel(
        title: 'ИГРЫ',
        description:
            'Друзья, представляем нашу библиотеку. Для некоторых игр предусмотрены клубные аккаунты: если данной игры у вас нет - вы можете воспользоваться нашим аккаунтом. Вводить данные не нужно, запуск игры осуществляется с ярлыка КЛУБНЫЙ АККАУНТ. \n \n Приятной игры! \n -- Atomic Heart (есть клубный аккаунт) — эксклюзивно в зоне STRIM 🔥 \n -- Хогвартс. Наследие (есть клубный аккаунт) — эксклюзивно в зоне STRIM 🔥 \n -- Ведьмак 3: Дикая охота (есть клубный аккаунт) — эксклюзивно в зоне STRIM 🔥 \n -- Albion Online (есть клубные аккаунты) \n -- Apex Legends (есть клубные аккаунты) \n -- Assassin`s Creed Valhalla (есть клубный аккаунт) — эксклюзивно в зоне STRIM 🔥 \n -- Arizona RP \n -- ARK: Survival Evolved \n -- ARK: Survival Of The Fittest \n -- Brawlhalla (есть клубные аккаунты) \n -- Call of Duty: Warzone (есть клубные аккаунты) \n -- Call of Duty: Warzone 2.0 Steam (есть клубные аккаунты) \n -- Call of Duty: Warzone 2.0 Battle.Net (есть клубные аккаунты) \n -- Counter-Strike: Global Offensive (есть клубные аккаунты) (доступны сервера клуба: ClanWar + Public) \n -- Counter-Strike 1.6 (доступны сервера клуба: ClanWar, DeathMatch и Public) \n -- Control (есть клубный аккаунт) — эксклюзивно в зоне STRIM 🔥 \n -- Crossout (есть клубные аккаунты) \n -- Crysis 3 (есть клубный аккаунт) — эксклюзивно в зоне STRIM 🔥 \n -- Cyberpunk 2077 (есть клубные аккаунты) \n -- Deceit (есть клубные аккаунты) \n -- Destiny 2 (есть клубные аккаунты) \n -- Diablo III (есть клубные аккаунты) \n -- Dota 2 (есть клубные аккаунты) \n -- Escape from Tarkov \n -- Fall Guys (есть клубные аккаунты) \n -- Far Cry 5 (есть клубный аккаунт) \n -- Fortnite (есть клубные аккаунты) \n -- Garry`s Mod \n -- Genshin Impact (есть клубные аккаунты) \n -- God of War (есть клубный аккаунт) \n -- Grand Theft Auto V (Steam и Epic Games Store, есть клубные аккаунты) \n -- GTA5 RP \n -- Half Life: Deathmatch (доступен сервер клуба) \n -- Half Life 2: Deathmatch (есть клубные аккаунты и доступен сервер клуба) \n -- Hearthstone (есть клубные аккаунты) \n -- Heroes of the Storm (есть клубные аккаунты) \n -- Horizon: Zero Dawn \n -- League of Legends \n -- Left 4 Dead 2 (есть клубные аккаунты) \n -- Mass Effect: Andromeda (есть клубный аккаунт) — эксклюзивно в зоне STRIM 🔥 \n -- Minecraft TLauncher \n -- Need for Speed: Most Wanted (2005) \n -- NEXT RP \n -- osu! \n -- Overwatch 2 \n -- Paladins (есть клубные аккаунты) \n -- Path of Exile \n -- Phasmophobia (есть клубный аккаунт) \n -- PUBG: BATTLEGROUNDS (есть клубные аккаунты) \n -- Quake III Arena (доступна игра по локальной сети) \n -- Quake III Team Arena (доступна игра по локальной сети) \n -- Quake Champions (есть клубные аккаунты) \n -- Red Dead Redemption 2 \n -- Roblox \n -- Rocket League (есть клубные аккаунты) \n -- Rogue Company (есть клубные аккаунты) \n -- Rumblverse (есть клубные аккаунты) \n -- Rust (есть клубные аккаунты) \n -- StarCraft (есть клубные аккаунты) \n -- StarCraft II (есть клубные аккаунты) \n -- Stray (есть клубный аккаунт) \n -- SUPER PEOPLE \n -- Super Bunny Man (есть клубные аккаунты) \n -- Team Fortress 2 (есть клубные аккаунты) \n -- Terraria \n -- The Forest (есть клубные аккаунты) \n -- The Sims 4 \n -- Tom Clancy`s Rainbow Six Siege (есть клубные аккаунты) \n -- Tom Clancy`s The Division 2 \n -- Unreal Tournament \n -- V Rising \n -- VALORANT \n -- Vampire: The Masquerade - Bloodhunt (есть клубные аккаунты) \n -- Warframe (есть клубные аккаунты) \n -- Watch Dogs 2 (есть клубный аккаунт) — эксклюзивно в зоне STRIM 🔥 \n -- War Thunder (есть клубные аккаунты) \n -- Warface \n -- World of Tanks Blitz RU Lesta \n -- Мир танков RU Lesta \n -- Warcraft III: Reforged \n -- WoW: Wraith of the Lich King Sirus \n -- WoW: Wraith of the Lich King WoWCircle \n -- WoW: Battle for Azeroth WoWCircle \n -- WoW: Dragonflight',
        image: 'assets/games.jpg',
        banner: 'assets/games_banner.jpg',
        isOffer: false,
        isPrice: false),
    ServicesModel(
        title: 'ФОТОГРАФИИ',
        description: '',
        image: 'assets/gallery.jpg',
        banner: 'assets/gallery.jpg',
        isOffer: false,
        isPrice: false),
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        controller: _slideController,
        scrollDirection: Axis.horizontal,
        itemCount: servicesList.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => ServiceDetailScreen(
                              title: servicesList[index].title,
                              description: servicesList[index].description,
                              banner: servicesList[index].banner,
                              image: servicesList[index].image,
                              url: servicesList[index].url,
                              isOffer: servicesList[index].isOffer,
                              isPrice: servicesList[index].isPrice,
                            )));
                  },
                  child: Container(
                    height: 120,
                    width: 215,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      image: DecorationImage(
                        scale: 1.0,
                        fit: BoxFit.fill,
                        image: AssetImage(servicesList[index].image),
                      ),
                    ),
                  ),
                ),
                Text(servicesList[index].title),
              ],
            ),
          );
        });
  }
}
