<<<<<<< HEAD
pragma solidity ^0.4.25;

contract ECircle{
    
    //member
    address[] private members;
    mapping(address => string) private member_mail;
    mapping(address => uint8) private mapMember;
	
	
	uint8 private ORDER_TYPE_LOAN=1;
    uint8 private ORDER_TYPE_LEND=2;
   
    order[ ] private orders;
    uint256 private current_interest;
    uint256 private orderNoSeq = 0;

    struct order {
      uint256 orderNo;
      uint8 orderType;
      
      uint256 amount;
      //uint256 interest;
      uint256 round;
      uint256 borrowingTime;
    }
	
    
    constructor() public{
        
    }
    
    /*
    Register
    */
    function register(string email) public returns (string){
        if(mapMember[msg.sender] == 0){
            mapMember[msg.sender] = 1;
            member_mail[msg.sender] = email;
            members.push(msg.sender);
        }else{
            // already registered
            return "You have registered";
        }
        
    }
	
	
	    function postLoan(uint256 amount, uint256 borrowingTime, uint256 round) public returns (bool){
        order memory one;
        one.orderNo=genOrderNo();
        one.orderType=ORDER_TYPE_LOAN;
        one.amount = amount;
        one.round = round;
        one.borrowingTime = borrowingTime;
        orders.push(one);
    }
    
    // function getCurrentInterest() view private returns (uint256){
    //     return 1;
    // }
    
    function genOrderNo()  private returns(uint256){
        return orderNoSeq++;
    }
	