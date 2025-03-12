import 'dart:io';
import 'dart:convert';

class Product {
  String name;
  int price;

  Product(this.name, this.price);
}

class ShoppingMall {
  List<Product> productList = [];
  List<Product> cartList = [];
  int totalPrice = 0;

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
  }

  void showTotal() {
    print('장바구니에 $totalPrice원어치를 담으셨네요!');
    print(totalPrice);
  }
}

void main() {
  Product shirts = Product('셔츠', 1000);
  Product pants = Product('바지', 5000);
  Product skirt = Product('치마', 2000);
  Product socks = Product('양말', 5000);
  Product shoes = Product('신발', 5000);

  ShoppingMall mall = ShoppingMall();

  mall.productList.add(shirts);
  mall.productList.add(skirt);
  mall.productList.add(pants);
  mall.productList.add(socks);
  mall.productList.add(shoes);

  bool isOpen = true; //쇼핑몰 상태 관리

  while (isOpen) {
    print(
      '----------------------------------------------------------------------------------------------------',
    );
    print(
      '[1] 상품 목록 보기 / [2] 장바구니에 담기 / [3] 장바구니에 담긴 상품의 총 가격 보기 / [4] 프로그램 종료',
    );
    print(
      '----------------------------------------------------------------------------------------------------',
    );
    var input = stdin.readLineSync(encoding: Encoding.getByName('utf-8')!);

    if (input == '1') {
      mall.printProducts();
    } else if (input == '2') {
      mall.addToCart();
    } else if (input == '3') {
      mall.showTotal();
    } else if (input == '4') {
      print('이용해 주셔서 감사합니다 ~ 안녕히 가세요 !');
      isOpen = false;
    }
  }
}
