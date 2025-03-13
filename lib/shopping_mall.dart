import 'dart:io';
import 'dart:convert';
import 'product.dart';

class ShoppingMall {
  List<Product> productList = [];
  int totalPrice = 0;
  List<String> totalName = []; //이후 지우기

  bool isOpen = true; //쇼핑몰 오픈 여부

  //전체 상품 이름 리스트, 가격 리스트
  List<String> pName = [];
  List<int> pPrice = [];
  List<int> pAmount = [];

  void printProducts() {
    for (Product p in productList) {
      print('${p.name} / ${p.price} 원');
    }
  }

  void addToCart() {
    String name = '';
    int demand = 0;

    //인덱스 사용을 위해 모든 상품 이름, 가격을 각각 리스트화
    pName = productList.map((p) => p.name).toList();
    pPrice = productList.map((p) => p.price).toList();

    print('상품 이름을 입력해 주세요!');

    //유효한 상품명을 받을 때까지 반복
    while (true) {
      var input = stdin.readLineSync(encoding: Encoding.getByName('utf-8')!);
      bool isProduct = pName.any((n) => n == input);

      //프로덕트명이 유효한지
      if (input != null && isProduct == true) {
        name = input;
        break;
      } else {
        print('입력값이 올바르지 않아요!');
        print('입력 가능한 상품명은 $pName 이에요.');
        continue;
      }
    }

    print('상품 수량을 입력해 주세요!');

    //유효한 수량을 받을 때까지 반복
    while (true) {
      var input = stdin.readLineSync(encoding: Encoding.getByName('utf-8')!);

      //인풋이 정수타입인지
      if (input != null && int.tryParse(input) != null) {
        if (int.parse(input) > 0) {
          demand = int.parse(input);
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
    }

    //입력받은 상품의 가격 확인
    int price = pPrice[pName.indexOf(name)];

    //입력받은 상품 수량 적용
    (productList.firstWhere((n) => n.name == name)).amount += demand;

    //장바구니에 상품 추가 안내 문구 출력
    print('$name $demand개, ${price * demand}원이 장바구니에 담겼습니다!');
  }

  void showTotal() {
    //인덱스 사용을 위해 모든 상품 이름, 가격을 각각 리스트화
    pName = productList.map((p) => p.name).toList();
    pPrice = productList.map((p) => p.price).toList();
    pAmount = productList.map((p) => p.amount).toList();

    //장바구니 수량이 1 이상인 상품이 하나라도 있는지
    if (pAmount.any((n) => n > 0)) {
      totalPrice = 0; //totalPrice 초기화
      print('장바구니 목록');
      for (int i = 0; i < pName.length; i++) {
        if (pPrice[i] * pAmount[i] > 0) {
          print(
            '${pName[i]}  :  ${pAmount[i]}개  ,  ${pPrice[i] * pAmount[i]}원',
          );
          totalPrice += pPrice[i] * pAmount[i];
        } else {
          continue;
        }
      }
      print('총 금액은 $totalPrice원 입니다!');
    } else {
      print('장바구니가 비어있습니다.');
    }
  }

  void clearCart() {
    print('장바구니를 초기화하시겠습니까?');
    print('[6] : 확인 / [그 외 입력] : 취소');
    var check = stdin.readLineSync(encoding: Encoding.getByName('utf-8')!);

    if (check != null && check == '6') {
      if (totalPrice == 0) {
        throw Exception('이미 장바구니가 비어있습니다.');
      }

      // 모든 Product의 amount를 0으로 초기화
      for (var product in productList) {
        product.amount = 0;
      }
      totalPrice = 0;
      print('장바구니를 초기화합니다.');
    } else {
      print('취소했습니다.');
    }
  }

  void exit() {
    print('정말 종료하시겠습니까?');
    print('[5] : 종료 / [그 외 입력] : 계속');
    var check = stdin.readLineSync(encoding: Encoding.getByName('utf-8')!);

    if (check != null && check == '5') {
      print('이용해 주셔서 감사합니다 ~ 안녕히 가세요 !');
      isOpen = false;
    } else {
      print('종료하지 않습니다.');
    }
  }
}
