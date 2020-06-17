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

  String escolheDiaSemana(int dia){
    String ret;
    switch(dia){
      case 0:{
        ret = "Domingo";
      }
      break;
      
      case 1:{
        ret = "Segunda";
      }
      break;

      case 2:{
        ret = "Terça";
      }
      break;

      case 3:{
        ret = "Quarta";
      }
      break;

      case 4:{
        ret = "Quinta";
      }
      break;

      case 5:{
        ret = "Sexta";
      }
      break;

      case 6:{
        ret = "Sábado";
      }
      break;
    }
    return ret;
  }


}