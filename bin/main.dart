import 'dart:io';
import 'dart:convert';

class Product {
  String name;
  int price;

  Product(this.name, this.price);
}

class ShoppingMall {
  List<Product> productList = [];
  int totalPrice = 0;
  List<String> totalName = [];

  bool isOpen = true; //쇼핑몰 오픈 여부

  void printProducts() {
    for (Product p in productList) {
      print('${p.name} / ${p.price} 원');
    }
  }

  void addToCart() {
    String inputPName = '';
    int inputDemand = 0;

    List<String> productName = productList.map((p) => p.name).toList();
    List<int> productPrice = productList.map((p) => p.price).toList();

    print('상품 이름을 입력해 주세요!');

    //유효한 상품명을 받을 때까지 반복
    while (true) {
      var input = stdin.readLineSync(encoding: Encoding.getByName('utf-8')!);

      //인풋이 유효한지
      if (input != null) {
        bool isProduct = productName.any((n) => n == input);
        //프로덕트명이 유효한지
        if (isProduct == true) {
          inputPName = input;
          break;
        } else {
          print('입력값이 올바르지 않아요!');
          print('입력 가능한 상품명은 $productName 이에요.');
          continue;
        }
      } else {
        print('입력값이 올바르지 않아요!');
        print('입력 가능한 상품명은 $productName 이에요.');
        continue;
      }
    }

    print('상품 수량을 입력해 주세요!');

    //유효한 수량을 받을 때까지 반복
    while (true) {
      var input = stdin.readLineSync(encoding: Encoding.getByName('utf-8')!);
      //인풋이 유효한지
      if (input != null) {
        //인풋이 정수타입인지
        if (int.tryParse(input) != null) {
          if (int.parse(input) > 0) {
            inputDemand = int.parse(input);
            break;
          } else {
            print('입력값이 올바르지 않아요!');
            print('0개보다 많은 개수의 상품만 담을 수 있어요 !');
            continue;
          }
        } else {
          print('입력값이 올바르지 않아요!');
          print('수량은 1 이상의 정수여야 해요.');
          continue;
        }
      } else {
        print('입력값이 올바르지 않아요!');
        continue;
      }
    }
    totalPrice += productPrice[productName.indexOf(inputPName)] * inputDemand;
    totalName.add(inputPName);
    print('$inputPName $inputDemand개가 장바구니에 담겼습니다!'); //장바구니에 상품 추가 안내 문구 출력력
  }

  void showTotal() {
    //장
    if (totalPrice > 0) {
      print('장바구니에 ${totalName.join(',')}(이)가 담겨있네요. 총 $totalPrice원 입니다!');
    } else {
      print('장바구니가 비어있습니다.');
    }
  }

  void clearCart() {
    print('장바구니를 초기화하시겠습니까?');
    print('[6] : 확인 / [그 외 입력] : 취소');
    var check = stdin.readLineSync(encoding: Encoding.getByName('utf-8')!);
    if (check != null) {
      if (check == '6') {
        if (totalPrice > 0) {
          totalName.clear();
          totalPrice = 0;
          print('장바구니를 초기화합니다.');
        } else {
          print('이미 장바구니가 비어있습니다.');
        }
      } else {
        print('취소했습니다.');
      }
    } else {
      print('지원하지 않는 기능입니다 ! 다시 시도해 주세요 . .');
    }
  }

  void exit() {
    print('정말 종료하시겠습니까?');
    print('[5] : 종료 / [그 외 입력] : 계속');
    var check = stdin.readLineSync(encoding: Encoding.getByName('utf-8')!);
    if (check != null) {
      if (check == '5') {
        print('이용해 주셔서 감사합니다 ~ 안녕히 가세요 !');
        isOpen = false;
      } else {
        print('종료하지 않습니다.');
      }
    } else {}
  }
}

void main() {
  ShoppingMall mall = ShoppingMall();

  /* 이하 for문으로 개선된 기존 코드
  Product shirts = Product('셔츠', 10000);
  Product pants = Product('바지', 20000);
  Product skirt = Product('치마', 30000);
  Product socks = Product('양말', 1000);
  Product shoes = Product('신발', 50000);

  mall.productList.add(shirts);
  mall.productList.add(skirt);
  mall.productList.add(pants);
  mall.productList.add(socks);
  mall.productList.add(shoes);
  */

  Map<String, int> products = {
    '셔츠': 10000,
    '바지': 20000,
    '치마': 30000,
    '양말': 1000,
    '신발': 50000,
  };

  List<String> keys = products.keys.toList();
  List<int> values = products.values.toList();

  for (var i = 0; i < products.length; i++) {
    Product product = Product(keys[i], values[i]);
    mall.productList.add(product);
  }

  while (mall.isOpen) {
    print(
      '----------------------------------------------------------------------------------------------------------------------------',
    );
    print(
      '[1] 상품 목록 보기 / [2] 장바구니에 담기 / [3] 장바구니에 담긴 상품의 총 가격 보기 / [4] 프로그램 종료 / [6] 장바구니 비우기',
    );
    print(
      '----------------------------------------------------------------------------------------------------------------------------',
    );
    var input = stdin.readLineSync(encoding: Encoding.getByName('utf-8')!);

    if (input == '1') {
      mall.printProducts();
    } else if (input == '2') {
      mall.addToCart();
    } else if (input == '3') {
      mall.showTotal();
    } else if (input == '4') {
      mall.exit();
    } else if (input == '6') {
      mall.clearCart();
    } else {
      print('지원하지 않는 기능입니다 ! 다시 시도해 주세요 . .');
    }
  }
}
