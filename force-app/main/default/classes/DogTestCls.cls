@isTest
public class DogTestCls {
    //継承のサンプルをテストする
    static testMethod void testExtendsCls001(){
        
        DogCls dog = new DogCls('蘭ちゃん',10);    
        //Dogのメソッド
        dog.bite();  
        //Animalのメソッド
        dog.eat();
        //Animalのメソッド
        dog.sleep();
        
        AnimalCls animalCls = new AnimalCls('ワンちゃん',5);    
        animalCls.eat();
        animalCls.sleep();
        //親のクラスに子クラスのメソッドを呼び出せない
        //animalCls.bite();
    }
    //Override & Overload
    static testMethod void testExtendsCls002(){
        
        DogCls dog = new DogCls('蘭ちゃん',10); 
        //Overrideのメソッド
        dog.eat();
        dog.sleep();
        
        //Overloadのメソッド
        dog.sports();
        dog.sports(10);
        dog.sports(10,'swim');
        
        dog.sports();
        dog.sports(1);
        dog.sports(1,'swim');
    }    
}