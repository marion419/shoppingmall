import 'dart:io';
import 'shoppingmall.dart';

void main() {
  var shoppingmall=Shoppingmall();
  bool keepShopping=true;

  while(keepShopping){
    print('---------------------------------------------------------------------------------------------------');
    print('[1] 상품 목록 보기 / [2] 장바구니에 담기 / [3] 장바구니 보기 / [4] 프로그램 종료 / [6] 장바구니 편집');
    print('---------------------------------------------------------------------------------------------------');

    int shoppingCmd=int.parse(stdin.readLineSync().toString());

    switch(shoppingCmd){
      case 1:
        shoppingmall.showProducts();
      case 2:
        shoppingmall.addToCart();
      case 3:
        shoppingmall.showTotal();
      case 4:
        print('정말 종료하시겠습니까? YES[5]');
        // 정수가 아닌 값을 입력했을 경우 예외처리
        try{
          if(int.parse(stdin.readLineSync().toString())==5){
            print('이용해 주셔서 감사합니다 ~ 안녕히 가세요 !');
            keepShopping=false;
          }
        }catch(e){
          print('종료하지 않습니다.');
        }
      case 6:
        if(shoppingmall.totalCost==0){
          print('이미 장바구니가 비어있습니다.');
        }
        else {
          print('장바구니를 편집합니다.');
          shoppingmall.resetCart();
        }
    }
  }
}