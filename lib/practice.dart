import 'dart:io';

void main(){
  print("Welcome to Dart");
  // stdout.write('Enter your name:');
  // var name = stdin.readLineSync();
  // print(("Welcome,$name"));
  // // int a = stdin
  var myC =my_class();
  myC.printName("Soumayjit");
  myC.printName("Arindam");
  addition().addTwoNumber(5,7);
  Mul().multiplication(3,4);
  int result=pow().power(2,4);
  print(result);

}

class my_class {
  void printName(String name) {
    print("My Name is $name");
  }
}

class addition{
  void addTwoNumber(int a,int b){
    print(a+b);
  }
}

class Mul{
  void multiplication(int a,int b){
    print(a*b);
  }
}
class pow{
  int power(int a,int b){
    int c=1;
    for(int i=0;i<b;i++){
      c=c*a;
    }
    return c;
  }
}