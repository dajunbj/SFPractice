public class DogCls extends AnimalCls {
    //■継承：AnimalClsを敬称しているDogCls
    public DogCls(string animalNm, integer age){
        super(animalNm,age);
    }
    //犬のメソッド
    public void bite(){
        system.debug(super.name+' can bite.');
    }
     //override(オーバーライド) 例
     public override void eat(){
        //親クラスのメソッド【eat】を呼び出す
        system.debug(super.name+' can eat bone too.');
    }
     //override(オーバーライド) 例(Key Ward :superの使い方)
     public override void sleep(){
        //親クラスのメソッド【sleep】を呼び出す
        super.sleep();
    }
    //OverLoad例1
    public void sports(){
        system.debug(super.name+' can sport.');
    }
    public void sports(integer dogAge){
        if (dogAge > 2) {
            system.debug(super.name+' can help you.');            
        } else {
            system.debug(super.name+' can not help you.');
        }
    }
    public void sports(integer dogAge,string sportType){
        string retVal  = '';
        if (dogAge > 2) {
            retVal = super.name+' can '+ sportType+'';
        } else {
            retVal = super.name+' can not '+ sportType+'';
        }
        system.debug(retVal);
    }
    //OverLoadの例２
    public void insertStoreInfo(A01_Store__c rec){
        insert rec;
    }
    public void insertStoreInfo(list<A01_Store__c> recList){
        insert recList;
    }
}