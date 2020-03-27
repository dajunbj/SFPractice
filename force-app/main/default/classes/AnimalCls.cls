public virtual class AnimalCls {
    //動物名前
    public string name{get;set;}
    //動物年齢
    public integer age{get;set;}
    
    public AnimalCls(string paramName,integer paramAge){
        system.debug('名前：' + paramName);
        system.debug('年齢：' + paramAge);
        name = paramName;
        age = paramAge;
    }
    
    public virtual void eat(){
        system.debug(name+' can eat food.');
    }
    
    public virtual void sleep(){
        system.debug(name+' can sleep.');     
    }
}