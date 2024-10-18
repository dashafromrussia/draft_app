class Lapa{
  String getLapa(){
    return 'u lapa toje';
  }
}

class BodyCat{
  String printBody(String lapa){
    return lapa;
  }
  String testStr(String d){
    return "dt";
  }
}

class Cat{
  final BodyCat bodyCat;
  final Lapa lapa;
  const Cat(this.bodyCat,this.lapa);

  String printCat(){
    String lapka = lapa.getLapa();
    print(lapka);
    String catty = bodyCat.printBody(lapka);
    print(catty);
    return "&&&$catty";
  }
  String getTestingData(String ex){
    String data = ex==""?"yes":"no";
    bodyCat.testStr(data);
    return "aaa";
  }
}