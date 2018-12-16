pragma solidity ^0.4.25;

contract ECircle{
    
    uint256 constant _18_0 = 1000000000000000000;
   //member
   address[] private members;
   mapping(address => string) private member_mail;
   mapping(address => uint8) private mapMember;

   // dex amount for every user
   mapping(address=>Wallet) public userWallets;
   
   // exchange rate for each token to DEX
   mapping(string=>uint256) private exchangeRate;
    
   uint256 private ECircleDEX;
   uint256 private ECircleToken;
    
   // token type
   string private TOKEN_TYPE="COB";
   
   // order related
   uint8 private ORDER_TYPE_BORROW=1;
   uint8 private ORDER_TYPE_SUPPLY=2;
   uint256 private orderNoSeq = 0;
   uint256[] private ordersSeqArr;
   mapping(uint256 => Order) private orders;

   //
   mapping(address => Order[]) private userBorrowOrder;
   mapping(address => Order[]) private userSupplyOrder;

   
   //
   uint256 private interestU=2;
   uint256 private BORROW_InterestRate;
   uint256 private SUPPLY_InterestRate;


   //GUI event
   event depositEvent(uint256 amountDEX);
   event supplyEvent(uint256 amountDEX, int256 amountToken);
   event balanceEvent(uint256 amountDEX, int256 amountToken);
   event borrowEvent(uint256 amountDEX, int256 amountToken);
 //  event balEvent(uint256 amountDEX);

   struct Order {
      uint256 orderNo;
      uint8 orderType; //ORDER_TYPE_LOAN, ORDER_TYPE_LEND
      string token;
      uint256 amount;
      uint256 interest;
      address reqUser;
   }
   
   struct Wallet{
       uint256 dexAmount;
       int256 tokenAmount;
   }

    modifier validateDexAmount(uint256 amount){
        require(userWallets[msg.sender].dexAmount > amount, "Your DEX amount not enough, please deposit.");
        _;
    }
    
    modifier isValidateUser {
        uint8 userAddr = mapMember[msg.sender];
        require(userAddr>0, "You haven't registered yet, please register first.");
        _;
    }
   
    
    constructor() public{
        exchangeRate[TOKEN_TYPE]=30;
        interestU=2;
        BORROW_InterestRate=3;
        SUPPLY_InterestRate=2;
     //   ECircleDEX = 500 * _18_0;
      //  ECircleToken = ECircleDEX * exchangeRate[TOKEN_TYPE] * _18_0;
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
    function deposit() public payable{
        userWallets[msg.sender].dexAmount = userWallets[msg.sender].dexAmount + msg.value;
        emit depositEvent(userWallets[msg.sender].dexAmount);
    }
    
    /*
    initial cash to contract
    */
    function deposit2Contract() public payable{
        //userWallets[msg.sender].dexAmount = userWallets[msg.sender].dexAmount + msg.value;
        //emit depositEvent(userWallets[msg.sender].dexAmount);
    }
    
    /*
    withdraw DEX
    */
    function withdraw() public validateDexAmount(0) payable{
       msg.sender.transfer(userWallets[msg.sender].dexAmount);
       userWallets[msg.sender].dexAmount = 0;
    }
    
    /*
    token amount 
    */
    function dexToToken(uint256 dexAmount) public view returns (uint256){
        uint256 tokenAmount = dexAmount * exchangeRate[TOKEN_TYPE];
        return tokenAmount;
    }
    
    function tokenToDex() public view returns(int256){
        int256 convDEX = userWallets[msg.sender].tokenAmount / int256(exchangeRate[TOKEN_TYPE]);
        return convDEX;
    }
  /*  function tokenToDex_exec(string memory tokenType) public view returns(uint256){
        uint256 dexAmount = userWallets[msg.sender].tokenAmount / exchangeRate[tokenType];
        return dexAmount;
    }*/
    
   function calInterest(int256 convDEX) private pure returns (int256){
        //cal borrow
        if(convDEX < 0){
            convDEX = convDEX + (convDEX * -1) / 20;
        }else{
            convDEX = convDEX + (convDEX) / 33;
        }
        return convDEX;
       /* for(uint256 i=0;i<userSupplyOrder[msg.sender].length;i++){
            
        }*/
    }
    
    /* request */
    function borrow(uint256 amount) 
        public
       // isValidateUser
        validateDexAmount(amount)
        returns (bool){
        //genOrder(amount, tokenType, interest, ORDER_TYPE_LOAN);
        
        
        //gen order
        Order memory one;

        one.orderNo=genOrderNo();
        one.orderType=ORDER_TYPE_BORROW;
        one.token = TOKEN_TYPE;
        one.amount = userWallets[msg.sender].dexAmount;
        one.interest = BORROW_InterestRate;
        one.reqUser = msg.sender;

        ordersSeqArr.push(one.orderNo);
        orders[one.orderNo]=one;
        
        userBorrowOrder[msg.sender].push(one);
        
        
        userWallets[msg.sender].tokenAmount = userWallets[msg.sender].tokenAmount 
        - int256(dexToToken(amount) * 2);
        userWallets[msg.sender].dexAmount =  userWallets[msg.sender].dexAmount - amount;
       
       
        //ECircleDEX = ECircleDEX + amount;
       // ECircleToken = ECircleToken - dexToToken(userWallets[msg.sender].dexAmount)*2;
       
        
        emit borrowEvent(userWallets[msg.sender].dexAmount, userWallets[msg.sender].tokenAmount);
    }
    function supply(uint256 amount) 
        public
        //isValidateUser
        validateDexAmount(amount)
        returns (bool){
        
        require(userWallets[msg.sender].dexAmount > amount, "Not enough DEX!");
        
        //gen order
        Order memory one;

        one.orderNo=genOrderNo();
        one.orderType=ORDER_TYPE_SUPPLY;
        one.token = TOKEN_TYPE;
        one.amount = amount;
        one.interest = SUPPLY_InterestRate;
        one.reqUser = msg.sender;

        ordersSeqArr.push(one.orderNo);
        orders[one.orderNo]=one;
        
        userSupplyOrder[msg.sender].push(one);
        
        //genOrder(amount, tokenType, interest, ORDER_TYPE_LEND)
        
        userWallets[msg.sender].dexAmount =  userWallets[msg.sender].dexAmount - amount;
        userWallets[msg.sender].tokenAmount = userWallets[msg.sender].tokenAmount 
        + int256(dexToToken(amount));
        
       // ECircleDEX = ECircleDEX + amount;
        
        //ECircleToken = ECircleToken + dexToToken(amount);
        
        emit supplyEvent(userWallets[msg.sender].dexAmount, userWallets[msg.sender].tokenAmount);
    }
    
    function balance() public {
        // token to DEX
        int256 convDEX = tokenToDex();
        convDEX = calInterest(convDEX);
        if(convDEX < 0){
            userWallets[msg.sender].dexAmount = userWallets[msg.sender].dexAmount + uint256((convDEX/2) * -1);
        }else{
            userWallets[msg.sender].dexAmount = userWallets[msg.sender].dexAmount + uint256(convDEX);
        }
        
        userWallets[msg.sender].tokenAmount = 0;
        emit balanceEvent(userWallets[msg.sender].dexAmount, userWallets[msg.sender].tokenAmount);
    }
    
    function genOrder(uint256 amount, string memory tokenType, uint256 interest, uint8 orderType) 
        private returns (uint256){
        
        Order memory one;

        one.orderNo=genOrderNo();
        one.orderType=orderType;
        one.token = tokenType;
        one.amount = amount;
        one.interest = interest;
        one.reqUser = msg.sender;

        ordersSeqArr.push(one.orderNo);
        orders[one.orderNo]=one;

        return orders[one.orderNo].orderNo;
    }
    
    function getOrder(uint256 orderNo) 
        public view returns(uint256,uint8, string memory, uint256,uint256,address){
        
        Order memory one = orders[orderNo];
      
        return (one.orderNo, one.orderType, one.token, one.amount, one.interest, one.reqUser);
    }
    
    // function getCurrentInterest() view private returns (uint256){
    //     return 1;
    // }
    
    function genOrderNo()  private returns(uint256){
        return ++orderNoSeq;
    }
     

    
        
}
