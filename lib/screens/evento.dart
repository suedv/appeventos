// lib/evento.dart
import 'package:latlong2/latlong.dart';

class Evento {
  final String nome;
  final String data;
  final String local;
  final String imagem;
  final LatLng coordenadas;

  Evento({
    required this.nome,
    required this.data,
    required this.local,
    required this.imagem,
    required this.coordenadas,
  });
}
