import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'evento.dart';
import 'usuario_screen.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart'; // Adicionado para buscar o endereço

class EventoScreen extends StatefulWidget {
  @override
  _EventoScreenState createState() => _EventoScreenState();
}

class _EventoScreenState extends State<EventoScreen> {
  final MapController _mapController = MapController();
  int _selectedIndex = 1;
  LatLng? _currentPosition;
  String? _currentAddress = 'Buscando endereço...';

  final List<Evento> eventos = [
    // Lista de eventos pré-definidos
    Evento(
      nome: 'Pagode do Periclão',
      data: 'Sábado, 21 de Setembro de 2024',
      local: 'Orla da Concha Acústica Brasília',
      imagem: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS0glFzLD1hDgn6JMhzP_c48O08n15TA5oABg&s',
      coordenadas: LatLng(-15.7801, -47.9292),
    ),
    Evento(
      nome: 'Show do safadao',
      data: 'Sábado, 28 de Setembro de 2024',
      local: 'Teatro Nacional de Brasília',
      imagem: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSZchFPGWAbFBFuoEfm-WMLs8Xx2Lkgz1Yi3g&s',
      coordenadas: LatLng(-15.7805, -47.9295),
    ),
    Evento(
      nome: 'Festival de vila mix',
      data: 'Domingo, 29 de Setembro de 2024',
      local: 'Parque da Cidade',
      imagem: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT-JD1JtuyyEBm_d97mRAJbxgUZ4wTPwmdTxg&s',
      coordenadas: LatLng(-15.7803, -47.9293),
    ),
    Evento(
      nome: 'Cultural Brasília: Arte e Música',
      data: 'Sábado, 5 de Outubro de 2024',
      local: 'Esplanada dos Ministérios',
      imagem: 'https://i.ytimg.com/vi/o1dYy0Zuz5o/hq720.jpg?sqp=-oaymwEhCK4FEIIDSFryq4qpAxMIARUAAAAAGAElAADIQj0AgKJD&rs=AOn4CLA94FzUK4mKBrLGFDnna6jS-tYVEA',
      coordenadas: LatLng(-15.7741, -47.9292),
    ),
    Evento(
      nome: 'Feira Gastronômica do Cerrado',
      data: 'Domingo, 6 de Outubro de 2024',
      local: 'Praça dos Três Poderes',
      imagem: 'teste',
      coordenadas: LatLng(-15.7802, -47.9299),
    ),
    Evento(
      nome: 'Exposição de Arte Contemporânea',
      data: 'Sexta, 11 de Outubro de 2024',
      local: 'Museu Nacional',
      imagem: 'https://i.ytimg.com/vi/o1dYy0Zuz5o/hq720.jpg?sqp=-oaymwEhCK4FEIIDSFryq4qpAxMIARUAAAAAGAElAADIQj0AgKJD&rs=AOn4CLA94FzUK4mKBrLGFDnna6jS-tYVEA',
      coordenadas: LatLng(-15.7850, -47.9293),
    ),
    Evento(
      nome: 'Festival Internacional de Cinema',
      data: 'Quinta, 17 de Outubro de 2024',
      local: 'Cine Brasília',
      imagem: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSQ9j8azvCDmJjiw2tXVxYiOzMDMi2wmudRtQ&s',
      coordenadas: LatLng(-15.7825, -47.9301),
    ),
    Evento(
      nome: 'Conferência de Tecnologia e Inovação',
      data: 'Terça, 22 de Outubro de 2024',
      local: 'Centro de Convenções Ulysses Guimarães',
      imagem: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRFpgtCEY2lIDS2RxtVfKv-5_rAdZNhfI4tIQ&s',
      coordenadas: LatLng(-15.7872, -47.9294),
    ),
    Evento(
      nome: 'Show da Banda Z',
      data: 'Sábado, 26 de Outubro de 2024',
      local: 'Estádio Mané Garrincha',
      imagem: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSUmwG35rtJyJhGXxh0Zc_W0iNQZZ1eJvsbXQ&s',
      coordenadas: LatLng(-15.7865, -47.9295),
    ),
  ];


  Evento? _eventoSelecionado;

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  Future<void> _getCurrentLocation() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }
    if (permission == LocationPermission.deniedForever) return;

    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    setState(() {
      _currentPosition = LatLng(position.latitude, position.longitude);
      _mapController.move(_currentPosition!, 15.0);
    });

    _getAddressFromLatLng(position); // Chama a função para buscar o endereço a partir das coordenadas
  }

  Future<void> _getAddressFromLatLng(Position position) async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(position.latitude, position.longitude);
      Placemark place = placemarks[0];
      setState(() {
        _currentAddress = "${place.street}, ${place.subLocality} - ${place.locality} - ${place.administrativeArea}";
      });
    } catch (e) {
      setState(() {
        _currentAddress = "Endereço não encontrado";
      });
    }
  }

  void _onItemTapped(int index) {
    if (index == 2) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => UsuarioScreen()),
      );
    }
    setState(() {
      _selectedIndex = index;
    });
  }

  void _mostrarDetalhesEvento(Evento evento) {
    setState(() {
      _eventoSelecionado = evento;
    });
  }

  void _fecharCartao() {
    setState(() {
      _eventoSelecionado = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        title: Row(
          children: [
            Icon(Icons.location_on, color: Colors.black),
            SizedBox(width: 5),
            Expanded(
              child: Text(
                _currentAddress ?? 'Endereço não encontrado', // Exibe o endereço atual
                style: TextStyle(color: Colors.black),
              ),
            ),
          ],
        ),
      ),
      body: Stack(
        children: [
          FlutterMap(
            mapController: _mapController,
            options: MapOptions(
              center: _currentPosition ?? LatLng(-15.7801, -47.9292),
              zoom: 15.0,
              onTap: (tapPosition, point) {
                FocusScope.of(context).unfocus();
                setState(() {
                  _eventoSelecionado = null;
                });
              },
            ),
            children: [
              TileLayer(
                urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                subdomains: ['a', 'b', 'c'],
              ),
              MarkerLayer(
                markers: eventos.map((evento) {
                  return Marker(
                    point: evento.coordenadas,
                    builder: (ctx) => GestureDetector(
                      onTap: () => _mostrarDetalhesEvento(evento),
                      child: const Icon(
                        Icons.location_pin,
                        color: Colors.green,
                        size: 40,
                      ),
                    ),
                  );
                }).toList(),
              ),
              if (_currentPosition != null)
                MarkerLayer(
                  markers: [
                    Marker(
                      point: _currentPosition!,
                      builder: (ctx) => const Icon(
                        Icons.my_location,
                        color: Colors.blue,
                        size: 40,
                      ),
                    ),
                  ],
                ),
            ],
          ),
          if (_eventoSelecionado != null)
            Positioned(
              bottom: 50,
              left: 16,
              right: 16,
              child: Card(
                elevation: 4,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              _eventoSelecionado!.nome,
                              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                          ),
                          IconButton(
                            icon: Icon(Icons.close),
                            onPressed: _fecharCartao,
                          ),
                        ],
                      ),
                      SizedBox(height: 4),
                      Text(
                        _eventoSelecionado!.data,
                        style: TextStyle(color: Colors.grey[700]),
                      ),
                      SizedBox(height: 4),
                      Text(
                        _eventoSelecionado!.local,
                        style: TextStyle(color: Colors.grey[700]),
                      ),
                      SizedBox(height: 16),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8.0),
                        child: Image.network(
                          _eventoSelecionado!.imagem,
                          width: double.infinity,
                          height: 200,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          Positioned(
            top: 100,
            right: 16,
            child: Column(
              children: [
                FloatingActionButton(
                  onPressed: () {
                    setState(() {
                      _mapController.move(_mapController.center, _mapController.zoom + 1);
                    });
                  },
                  child: Icon(Icons.add),
                ),
                SizedBox(height: 8),
                FloatingActionButton(
                  onPressed: () {
                    setState(() {
                      _mapController.move(_mapController.center, _mapController.zoom - 1);
                    });
                  },
                  child: Icon(Icons.remove),
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Início',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.map),
            label: 'Mapa',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Perfil',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
