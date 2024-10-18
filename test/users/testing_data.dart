
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:untitled/injection.dart';
import 'package:untitled/testing_data/cat.dart';



class MockLapa extends Mock implements Lapa {}
class MockBodyCat extends Mock implements BodyCat{}

void main(){
  late MockLapa lapa;
  late MockBodyCat bodyCat;
  late Cat cat;
  setUpAll(() {
    lapa = MockLapa();
    bodyCat = MockBodyCat();
    cat = Cat(bodyCat,lapa);
  });

  tearDownAll(() {
  //  getIt.reset();
  });
  test('cat data', () async {
    // Arrange

    // Stubbing

    when(() => lapa.getLapa()).thenReturn('lapa');
    when(() => bodyCat.printBody(any())).thenReturn('laa');
    // Act
    final result =  cat.printCat();

    // Assert
    expect(result,"&&&laa"
    );
  });
  test('cat testing fun', () async {
    // Arrange

    // Stubbing
    when(() => bodyCat.testStr(any())).thenReturn('aaffaa');
    // Act
    final result =  cat.getTestingData("");

    // Assert
    expect(result,"aaa"
    );
  });
}

