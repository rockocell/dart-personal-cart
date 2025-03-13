import 'dart:io';
import 'dart:convert';
import 'package:pp_cart_application_1/product.dart';
import 'package:pp_cart_application_1/shopping_mall.dart';

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
    Product product = Product(keys[i], values[i], 0);
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
      //예외 처리
      try {
        mall.addToCart();
      } catch (e) {
        print('입력값이 올바르지 않아요!');
      }
    } else if (input == '3') {
      mall.showTotal();
    } else if (input == '4') {
      mall.exit();
    } else if (input == '6') {
      //예외 처리
      try {
        mall.clearCart();
      } catch (e) {
        print(e);
      }
    } else {
      print('지원하지 않는 기능입니다 ! 다시 시도해 주세요 . .');
    }
  }
}
