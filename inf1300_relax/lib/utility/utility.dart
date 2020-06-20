import 'package:inf1300_relax/i18n/app_localizations.dart';
class Utility {

  String escolheHumor(int humor){
    String ret;
    switch(humor){ 
      case 0:{
        ret = "N/A";
      } 
      break;    
      case 1:{
        ret = "😔";
      }
      break;

      case 2:{
        ret = "😶";
      }
      break;

      case 3:{
        ret = "😑";
      }
      break;

      case 4:{
        ret = "🙂";
      }
      break;

      case 5:{
        ret = "😁";
      }
      break;
      
    }
    return ret;
  }

  String escolheDiaSemana(int dia, context){
    String ret;
    switch(dia){
      case 0:{
        ret = AppLocalizations.of(context).translate('domingo');
      }
      break;
      
      case 1:{
        ret = AppLocalizations.of(context).translate('segunda');
      }
      break;

      case 2:{
        ret = AppLocalizations.of(context).translate('terca');
      }
      break;

      case 3:{
        ret = AppLocalizations.of(context).translate('quarta');
      }
      break;

      case 4:{
        ret = AppLocalizations.of(context).translate('quinta');
      }
      break;

      case 5:{
        ret = AppLocalizations.of(context).translate('sexta');
      }
      break;

      case 6:{
        ret = AppLocalizations.of(context).translate('sabado');
      }
      break;
    }
    return ret;
  }


}