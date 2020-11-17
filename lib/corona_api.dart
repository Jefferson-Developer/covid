//
// import 'package:atividade_elder9/database_helper.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert' as convert;
//
// class EnderecosApi {
//   static Future<Contact> getEndereco(
//       {String uf, String cidade, String logadouro}) async {
//     String url = "https://viacep.com.br/ws/$uf/$cidade/$logadouro/json/";
//
//     List<Contact> enderecos = [];
//
//     try {
//       http.Response responde = await http.get(url);
//       if (responde.statusCode == 200) {
//         Map<String, dynamic> map = convert.jsonDecode(responde.body);
//         List<dynamic> maps = convert.jsonDecode(responde.body);
//         enderecos = maps.map((e) => Contact.fromJson(e)).toList();
//         return Contact.fromJson(map);
//       }
//     } catch (e) {
//       print(e);
//     }
//   }
//
//   static Future<List<Enderecos>> allEnderecos(
//       {String uf, String cidade, String logadouro}) async {
//     String url = "https://viacep.com.br/ws/$uf/$cidade/$logadouro/json/";
//     List<Enderecos> endereco = [];
//     try {
//       http.Response response = await http.get(url);
//       List<dynamic> maps = convert.jsonDecode(response.body);
//       endereco = maps.map((e) => Enderecos.fromJson(e)).toList();
//     } catch (e) {}
//     return endereco;
//   }
// }
