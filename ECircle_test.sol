pragma solidity ^0.5.1;

import "./ECircle.sol";

contract ECircle_test{
    
    ECircle o;
    
    constructor() public {
        o = new ECircle();
    }
    
    function register_test() public  {
        bool result = o.register("aaa@gmail.com");
        require(result==true, "register fail");
        
        result = o.register("aaa@gmail.com");
        require(result==false, "duplicate register fail");
    }
    
    function postLoan_test() public returns (uint){
        uint orderNo = o.postLoan(100, 20, 3);
        require(orderNo==1, "first postLoan fail");
        
        orderNo = o.postLoan(1000, 200, 5);
        require(orderNo==2, "second postLoan fail");
        
        return orderNo;
    }
    
    function getOrder_test() public view returns(uint256,uint8,uint256,uint256,uint256){
      (uint256 orderNo,uint8 orderType,uint256 amount,uint256 round ,uint256 borrowingTime)
       = o.getOrder(2);
       
       require(orderNo==2, "orderNo fail");
       require(orderType==1, "orderType fail");
       require(amount==1000, "amount fail");
       require(round==200, "round fail");
       require(borrowingTime==5, "borrowingTime fail");
       
       return (orderNo, orderType, amount, round , borrowingTime);
    }
    

}