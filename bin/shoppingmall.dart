import 'dart:io';
import 'product.dart';

class InputException implements Exception{
  String? messasge;
  InputException(this.messasge);
}

class Shoppingmall {
  Map<String?, int?> productMap={};
  Map<String?, int?> cartMap={};
  var cartSet=<Product>{};
  int totalCost=0;

  Shoppingmall(){
    totalCost=0;
    var shirts=Product('shirts', 45000);
    var dress=Product('dress',30000);
    var tShirts=Product('t-shirts', 35000);
    var shorts=Product('shorts', 38000);
    var socks=Product('socks', 5000);
    // ignore: unused_local_variable
    Map<String?, int?> cartMap={};
    productMap.addAll({shirts.name : shirts.cost, dress.name : dress.cost , tShirts.name : tShirts.cost, shorts.name : shorts.cost, socks.name:socks.cost});
  }

  void showProducts(){
    print('상품 목록을 표시합니다.\n');
    for(var product in productMap.keys){
      print(product.toString()+' / '+productMap[product].toString()+'원\n');
    }
  }

  void addToCart(){
    String? productName;
    int? productAmount;

    bool keepAdd=true;
    while(keepAdd){
      // 상품명 입력받기
      // productName : 사용자가 장바구니에 넣을 물건 이름
      print('상품명을 입력해주세요. 취소를 원하시면 [exit]를 입력해주세요.\n');
      productName=stdin.readLineSync(/*encoding: Encoding.getByName('utf-8')!*/)!;

      // print('productName: ${productName.codeUnits} ${"가".codeUnits}');
      // 장바구니에 담는 기능을 종료하는 코드
      if(productName=='exit'){
        break;
      }
      // productMap에 물건 이름과 일치하는 key가 없을 경우
      else if(!productMap.containsKey(productName)){
        print('존재하지 않는 상품입니다.\n');
        continue;
      }
      try{
        print('수량을 입력해주세요.\n');
        productAmount=int.parse(stdin.readLineSync().toString());
        // 수량을 0 이하로 입력한 경우
        if(productAmount<=0){throw InputException(null);}
      }on InputException {
        print('0개보다 많은 개수의 상품만 담을 수 있어요!\n');
        continue;
      }catch(e){
        print('입력값이 올바르지 않습니다!\n');
        continue;
      }
      keepAdd=false;
    }

    // 상품명과 가격이 모두 옳게 입력되었을 경우에 총 금액 업데이트
    if(productName!=null&&productAmount!=null){
      totalCost+=productMap[productName]!*productAmount; //productMap[productName] : 물건 가격
      if(!cartMap.containsKey(productName)){
        cartMap[productName]=productAmount;
      } else {
        cartMap[productName]=productAmount+cartMap[productName]!;
      }
      print('장바구니에 상품이 담겼어요 !\n');
    }
    else{
      print('장바구니를 종료합니다.\n');
    }
  }

  void showTotal(){
    if(cartMap.isEmpty){
      print('장바구니에 담긴 상품이 없습니다.\n');
    }
    else{
      print('장바구니에 담긴 상품은\n');
      for(var entry in cartMap.entries){
        print('${entry.key}: ${entry.value}\n');
      }
      print('입니다. 총 $totalCost원 입니다.\n');
    }
  }

  void resetCart(){
    print('[1] 장바구니 초기화 / [2] 선택 상품만 삭제\n');

    int resetCmd=int.parse(stdin.readLineSync().toString());

    switch(resetCmd){
      case 1:
        totalCost=0;
        cartMap={};
        print('장바구니를 초기화했습니다.\n');
      case 2:
        print('장바구니를 편집합니다.\n');
        for(var entry in cartMap.entries){
          print('${entry.key}: ${entry.value}\n');
        }
        String? productToDelete;
        int? amountToDelete;
        while(true){
          try{
          print('삭제할 상품의 이름을 입력해주세요.\n');
          productToDelete=stdin.readLineSync();
          }catch(e){
            print('입력값이 잘못되었습니다!\n');
            continue;
          }
          try{
          print('삭제할 상품의 수량을 입력해주세요.\n');
          amountToDelete=int.parse(stdin.readLineSync()!);
          if(cartMap[productToDelete]!<amountToDelete){throw InputException(null);}
          }on InputException{
            print('0개 이하로 삭제할 수 없습니다.\n');
            continue;
          }catch(e){
            print('입력값이 잘못되었습니다!\n');
            continue;
          }
          break;
        }

        cartMap[productToDelete]=cartMap[productToDelete]!-amountToDelete;
        totalCost-=productMap[productToDelete]!*amountToDelete;
        if(cartMap[productToDelete]==0){cartMap.remove(productToDelete);}

        print('삭제를 완료했습니다.\n');
    }
  }

}