pragma solidity ^0.4.25;

contract ECircle{

   //member
   address[] private members;
   mapping(address => string) private member_mail;
   mapping(address => uint8) private mapMember;

   // dex amount for every user
   mapping(address=>Wallet) public userWallets;
    
   // order related
   uint8 private ORDER_TYPE_LOAN=1;
   uint8 private ORDER_TYPE_LEND=2;
   
   uint256[] private ordersSeqArr;
   mapping(uint256 => Order) private orders;
   
   // deal order related
   DealOrder[] private dealOrders; // all deal orders
   mapping(address => DealOrder[]) private userDealOrder;
   
   uint256 private current_interest;
   uint256 private orderNoSeq = 0;

   struct Order {
      uint256 orderNo;
      uint8 orderType;
      
      address postUser;
      uint256 amount;
      //uint256 interest;
      uint256 round;
      uint256 borrowingTime;
   }

   struct DealOrder {
      Order order;
      string interest;
      address loanUser;
      address lendUser;
   }
   
   struct Wallet{
       uint256 dexAmount;
       uint256 tokenAmount;
   }
    
    constructor() public{
        
    }
    /*
    Register
    */
    function register(string memory email) public returns (bool){
        if(mapMember[msg.sender] == 0){
            mapMember[msg.sender] = 1;
            member_mail[msg.sender] = email;
            members.push(msg.sender);
            
            Wallet memory w;
            w.dexAmount = 0;
            w.tokenAmount = 0;
            
            userWallets[msg.sender] = w;
            return true;
        }else{
            // already registered
            return false;
        }
        
    }
    
    /*
    deposit DEX
    */
    function deposit() public payable returns(bool){
        userWallets[msg.sender].dexAmount = userWallets[msg.sender].dexAmount + msg.value;
        return true;
    }
    
    
    /*
    withdraw DEX
    */
    function withdraw() public validateDexAmount payable{
       msg.sender.transfer(userWallets[msg.sender].dexAmount);
       userWallets[msg.sender].dexAmount = 0;
    }
    
    function postLoan(uint256 amount, uint256 borrowingTime, uint256 round) isValidateUser
        public returns (uint256){
        return genOrder(amount, borrowingTime, round, ORDER_TYPE_LOAN);
    }
    
    function postLend(uint256 amount, uint256 borrowingTime, uint256 round) isValidateUser
        public returns (uint256){
        return genOrder(amount, borrowingTime, round, ORDER_TYPE_LEND);
    }
    
    function genOrder(uint256 amount, uint256 round, uint256 borrowingTime, uint8 orderType) 
        private returns (uint256){
        
        Order memory one;

        one.orderNo=genOrderNo();
        one.orderType=orderType;
        one.postUser = msg.sender;
        one.amount = amount;
        one.round = round;
        one.borrowingTime = borrowingTime;
        
        ordersSeqArr.push(one.orderNo);
        orders[one.orderNo]=one;

        return orders[one.orderNo].orderNo;
    }
    
    function makeDeal(uint256 orderNo, uint256 interest)
        public returns (bool){
            DealOrder memory dealOrder;
            dealOrder.order = orders[orderNo];
            
    }
    
    function getOrder(uint256 orderNo) 
        public view returns(uint256,uint8,uint256,uint256,uint256){
        
        Order memory one = orders[orderNo];
        
        return (one.orderNo, one.orderType, one.amount, one.round, one.borrowingTime);
    }
    
    // function getCurrentInterest() view private returns (uint256){
    //     return 1;
    // }
    
    function genOrderNo()  private returns(uint256){
        return ++orderNoSeq;
    }
        
    modifier isValidateUser {
        uint8 userAddr = mapMember[msg.sender];
        require(userAddr>0, "You haven't registered yet, please register first.");
        _;
    }
   
     modifier validateDexAmount {
         uint256 amount = userWallets[msg.sender].dexAmount;
         require(amount>0, "Your DEX amount is 0, please deposit.");
         _;
     }
    
  /* function validateDexAmount() private view returns(bool){
        uint256 amount = userWallets[msg.sender].dexAmount;
        require(amount>0, "Your DEX amount is 0, please deposit.");
    }*/
    
    
}

