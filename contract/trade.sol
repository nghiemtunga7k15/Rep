pragma solidity >=0.4.23 <0.6.0;
contract Trade {
    address owner;
    mapping(address => uint256) public countIdOder;
    mapping(address =>  uint[]) public listBuy;
    mapping(address =>  uint[]) public listSell;
    mapping(address =>  mapping(uint256 => Order)) public BuyOder;
    mapping(address => uint256) public countTransaction;
    mapping(address =>  uint[]) public listTransaction;
    mapping(address =>  mapping(uint256 => Transaction)) public Transactions;
    constructor () public {
		owner = msg.sender;
	}

	struct Order {
		uint256 tokens;
		uint256 orderType; // 0 Buy - 1 Sell
		address trade;
	 	uint256 price;
	 	bool	isActive;
	}
	struct Transaction {
		address trader;
		uint256 tokens;
		uint256 price;
		uint256 time;
		uint256 orderType;
	}

	function buy(address addr ,address trader , uint256 token , uint256 price) public  payable  returns(bool sucess){
		for(uint256 idx = 0 ; idx < listSell[addr].length ; idx++){
			uint256 id = listSell[addr][idx];
			Order memory oder = BuyOder[addr][id];
			if(oder.isActive == true && oder.orderType == 1 && oder.price <= price){
				token = matchingSell(addr , trader, id ,token);
				if(token <=0){
					break;
				}
			}
		}
		if(token >0){
			createOder(addr,trader ,token , price ,0);
		}
		sucess = true;
	}

	function sell(address addr ,address trader ,  uint256 token , uint256 price) public  returns(bool sucess){
		for(uint256 idx = 0 ; idx < listBuy[addr].length ; idx++){
			uint256 id = listBuy[addr][idx];
			Order memory oder = BuyOder[addr][id];
			if(oder.isActive == true && oder.orderType == 0 && oder.price >= price){
					token  = matchingBuy(addr , trader, id ,token);
					if(token <=0){
						break;
					}
			}
		}
		if(token > 0){
			createOder(addr, trader , token , price ,1);
		}
		sucess = true;
	}

	function createOder(address addr, address trader  , uint256 token , uint256 price , uint256 orderType) private {
		countIdOder[addr] = countIdOder[addr]  + 1;

		BuyOder[addr][countIdOder[addr]].tokens = token;
		BuyOder[addr][countIdOder[addr]].orderType = orderType;
		BuyOder[addr][countIdOder[addr]].trade = addr;
		BuyOder[addr][countIdOder[addr]].price = price;
		BuyOder[addr][countIdOder[addr]].isActive = true;

		if(orderType ==0){
			listBuy[addr].push(countIdOder[addr]);
		}else{
			listSell[addr].push(countIdOder[addr]);
		}
	}

	function matchingBuy(address addr,address trader  ,uint256 idOder,  uint256 token) public  returns(uint256 tokenSuplly){
		Order storage oder = BuyOder[addr][idOder];
		uint256 tokenSell;
		if(oder.tokens < token){
			tokenSell = oder.tokens;
		}else{
			tokenSell = token;
		}

		oder.tokens = oder.tokens - tokenSell;
		
		if(oder.tokens == 0){
			oder.isActive = false;
		}
		createTransaction(addr , trader , tokenSell , oder.price ,oder.orderType, now);
		tokenSuplly = token - tokenSell;

	}

	function matchingSell(address addr ,address trader ,uint256 idOder,  uint256 token) public  returns(uint256 tokenSuplly){
		Order storage oder = BuyOder[addr][idOder];
		uint256 tokenSell;
		if(oder.tokens < token){
			tokenSell = oder.tokens;
		}else{
			tokenSell = token;
		}

		oder.tokens = oder.tokens - tokenSell;
		if(oder.tokens == 0){
			oder.isActive = false;
		}
		createTransaction(addr , trader , tokenSell , oder.price ,oder.orderType, now);
		tokenSuplly = token - tokenSell;
	}

	function getCountBuy(address addr) public view returns(uint256){
			return listBuy[addr].length;
	}

	function getCountSell(address addr) public view returns(uint256){
			return listSell[addr].length;
	}

	function getOderDetail(address addr , uint256 id) public view returns(address tradeAddr , uint256 tokens , uint256 price , uint256 orderType , bool isActive) {
		Order memory oderDetail = BuyOder[addr][id];


		tradeAddr = oderDetail.trade;
		tokens = oderDetail.tokens;
		price = oderDetail.price;
		orderType = oderDetail.orderType;
		isActive = oderDetail.isActive;
	}

	function getBalance() public view returns(uint256){
		return address(this).balance;
	}

	function createTransaction(address addr , address tradeAddr ,uint256 token , uint256 price  ,uint256 orderType, uint256 time) private {
			countTransaction[addr] = countTransaction[addr] + 1;

			Transaction storage transaction = Transactions[addr][countTransaction[addr]];
			transaction.trader = tradeAddr;
			transaction.tokens = token;
			transaction.price = price;
			transaction.time = time;
			transaction.orderType = orderType;
	}

	function transactionDetail(address addr , uint256 id) public view returns(uint256 token , uint256 price , uint256 time , uint256 orderType){
			token = Transactions[addr][id].tokens;
			price = Transactions[addr][id].price;
			time = Transactions[addr][id].time;
			orderType = Transactions[addr][id].orderType;
	}


	function getCountIdTransaction(address addr) public view returns(uint256){
		return countTransaction[addr] ; 
	}


}