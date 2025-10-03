import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import 'package:sa_geolocator_maps/models/location_points.dart';

class MapController {
  final DateFormat _formatar = DateFormat("dd/MM/yyyy - HH:mm:ss");

  //método para pegar a geolocalização do ponto
  Future<LocationPoints> getcurrentLocation() async {
    //solicitara localização atual do dispositivo
    //liberar permissões
    //verificar se o aplicativo possui o serviço de Geolocalização habilitado
    bool serviceEnable = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnable) {
      throw Exception("Sem Acesso ao GPS");
    }
    LocationPermission permission;
    //verificar a permissão de uso do gps
    permission = await Geolocator.checkPermission();
    //por padrãoo, todo novo aplicativo instalado não possui permissão de acesso aos hardwares
    if (permission == LocationPermission.denied) {
      //solicitar o acesso a geolocalização
      permission == await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        throw Exception("Permissão Negada de Acesso ao GPS");
      }
    }
    //Acesso liberado
    Position position = await Geolocator.getCurrentPosition();
    //pear a data e hoa (formata no padrão BR)
    String dataHora = _formatar.format(DateTime.now());
    //criar um OBJ do model
    LocationPoints posicaoAtual = LocationPoints(
      latitude: position.latitude,
      logitude: position.longitude,
      timeStamp: dataHora,
    );
    //devolve o OBJ
    return posicaoAtual;
  }
}
