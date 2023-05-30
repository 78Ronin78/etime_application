import 'package:etime_application/widgets/ControlButton.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';

class ContactsScreen extends StatefulWidget {
  const ContactsScreen({super.key});

  @override
  State<ContactsScreen> createState() => _ContactsScreenState();
}

class _ContactsScreenState extends State<ContactsScreen> {
  late YandexMapController controller;
  final List<MapObject> mapObjects = [
    PlacemarkMapObject(
        mapId: MapObjectId('target_placemark'),
        point:
            Point(latitude: 56.15004003556735, longitude: 101.64963595097826),
        opacity: 1.0,
        icon: PlacemarkIcon.single(PlacemarkIconStyle(
            scale: 0.1,
            image: BitmapDescriptor.fromAssetImage('assets/applogo.jpg'))))
  ];

  final MapObjectId targetMapObjectId = MapObjectId('target_placemark');
  static final Point _point =
      Point(latitude: 56.15004003556735, longitude: 101.64963595097826);
  final animation = MapAnimation(type: MapAnimationType.smooth, duration: 2.0);

  bool tiltGesturesEnabled = true;
  bool zoomGesturesEnabled = true;
  bool rotateGesturesEnabled = true;
  bool scrollGesturesEnabled = true;
  bool modelsEnabled = true;
  bool nightModeEnabled = false;
  bool fastTapEnabled = false;
  bool mode2DEnabled = false;
  ScreenRect? focusRect;
  MapType mapType = MapType.vector;
  int? poiLimit;

  @override
  Widget build(BuildContext context) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(
            child: YandexMap(
              mapType: mapType,
              poiLimit: poiLimit,
              tiltGesturesEnabled: tiltGesturesEnabled,
              zoomGesturesEnabled: zoomGesturesEnabled,
              rotateGesturesEnabled: rotateGesturesEnabled,
              scrollGesturesEnabled: scrollGesturesEnabled,
              modelsEnabled: modelsEnabled,
              nightModeEnabled: nightModeEnabled,
              fastTapEnabled: fastTapEnabled,
              mode2DEnabled: mode2DEnabled,
              logoAlignment: MapAlignment(
                  horizontal: HorizontalAlignment.left,
                  vertical: VerticalAlignment.bottom),
              focusRect: focusRect,
              mapObjects: mapObjects,
              onMapCreated: (YandexMapController yandexMapController) async {
                controller = yandexMapController;

                final cameraPosition = await controller.getCameraPosition();
                final minZoom = await controller.getMinZoom();
                final maxZoom = await controller.getMaxZoom();

                print('Camera position: $cameraPosition');
                print('Min zoom: $minZoom, Max zoom: $maxZoom');
                controller.moveCamera(
                    CameraUpdate.newCameraPosition(
                        CameraPosition(target: _point)),
                    animation: animation);
              },
              onMapTap: (Point point) async {
                print('Tapped map at $point');

                await controller.deselectGeoObject();
              },
              onMapLongTap: (Point point) => print('Long tapped map at $point'),
              onCameraPositionChanged: (CameraPosition cameraPosition,
                  CameraUpdateReason reason, bool finished) {
                print('Camera position: $cameraPosition, Reason: $reason');

                if (finished) {
                  print('Camera position movement has been finished');
                }
              },
              onObjectTap: (GeoObject geoObject) async {
                print('Tapped object: ${geoObject.name}');

                if (geoObject.selectionMetadata != null) {
                  await controller.selectGeoObject(
                      geoObject.selectionMetadata!.id,
                      geoObject.selectionMetadata!.layerId);
                }
              },
            ),
          ),
          SizedBox(height: 20),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Table(
                    children: <TableRow>[
                      TableRow(children: <Widget>[
                        ControlButton(
                            onPressed: () async {
                              await controller.moveCamera(CameraUpdate.zoomIn(),
                                  animation: animation);
                            },
                            title: 'Приблизить'),
                        ControlButton(
                            onPressed: () async {
                              await controller.moveCamera(
                                  CameraUpdate.zoomOut(),
                                  animation: animation);
                            },
                            title: 'Отдалить'),
                      ]),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Text(
                          'BOOCAMP GAME CLUB | БРАТСК',
                          style: TextStyle(fontSize: 18),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Text(
                          'бульвар Победы, 30',
                          style: TextStyle(fontSize: 14),
                        )
                      ],
                    ),
                  ),
                  Center(
                      child:
                          Text('Режим работы', style: TextStyle(fontSize: 18))),
                  Container(
                    width: MediaQuery.of(context).size.width / 2,
                    child: Center(
                      child: Table(
                        children: <TableRow>[
                          TableRow(children: <Widget>[
                            Text('Пн'),
                            Text('14:00 - 6:00'),
                          ]),
                          TableRow(children: <Widget>[
                            Text('Вт'),
                            Text('14:00 - 6:00'),
                          ]),
                          TableRow(children: <Widget>[
                            Text('Ср'),
                            Text('14:00 - 6:00'),
                          ]),
                          TableRow(children: <Widget>[
                            Text('Чт'),
                            Text('14:00 - 6:00'),
                          ]),
                          TableRow(children: <Widget>[
                            Text('Пт'),
                            Text('14:00 - 6:00'),
                          ]),
                          TableRow(children: <Widget>[
                            Text('Сб'),
                            Text('14:00 - 6:00'),
                          ]),
                          TableRow(children: <Widget>[
                            Text('Вс'),
                            Text('14:00 - 6:00'),
                          ]),
                        ],
                      ),
                    ),
                  ),
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                    Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(25)),
                          color: Color.fromARGB(255, 249, 22, 112),
                        ),
                        margin: EdgeInsets.only(top: 20),
                        height: 56,
                        width: MediaQuery.of(context).size.width,
                        child: TextButton(
                            onPressed: () async {
                              final Uri launchUri =
                                  Uri(scheme: 'tel', path: '8(908)652-77-78');
                              await launch(launchUri.toString());
                            },
                            child: Center(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(right: 8.0),
                                    child: Container(),
                                  ),
                                  Text('Позвонить',
                                      style: TextStyle(color: Colors.white))
                                ],
                              ),
                            ))),
                  ])
                ],
              ),
            ),
          )
        ]);
  }
}
