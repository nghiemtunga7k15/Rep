pragma solidity >=0.4.23 <0.6.0;
contract StoreTokenInterface {
	function isStoreTokenContract() external pure returns(bool);
	function transferFrom(address from, address to, uint256 tokens) external pure returns(bool);
	function transfer(address to, uint256 tokens) external pure returns(bool);
	function demo(uint256 num) external pure returns(uint256);
}
contract Main {
	address public owner;
	bool public isActive = false;

	StoreTokenInterface public StoreTokenContract;

	mapping(address => StoreToken) public MainToken;
	mapping(address => uint256) public count;
	mapping(address => uint256[]) public listZoom;
	mapping(address => mapping(uint256 => Room)) public RoomPlay;

	mapping(address => uint256) public countRequest;
	mapping(address => uint256[]) public arrRequest;
	mapping(address => mapping(uint256 => Buy)) public listRequest;
	struct StoreToken {
		bool isActive;
		string tokenName;
		address addressToken;
		StoreTokenInterface addressStoreToken;
	}

	struct Room {
		string  name;
		uint256 coin;
	}

	struct Buy {
		address buyer;
		uint256 tokens;
		bool isActive;
	}

	constructor () public {
		owner = msg.sender;
	}


	modifier isOwner() {
		require(msg.sender == owner);
		_;
	}

	function setup() public isOwner returns(bool succes) {
		require(isActive == false);
		isActive = true;
		succes = true;
	}

	function setStoreToken( address _addrToken ,address _addrStoreToken, string memory _name ) public isOwner returns(bool succes){
		StoreTokenContract = StoreTokenInterface(_addrStoreToken);
		if(StoreTokenContract.isStoreTokenContract() == false) { revert(); }
		MainToken[_addrToken].isActive           = true;
		MainToken[_addrToken].tokenName          = _name;
		MainToken[_addrToken].addressToken       = _addrToken;
		MainToken[_addrToken].addressStoreToken  = StoreTokenContract;
		succes = true;
	}

	function createZoom(address _addrOwner , string memory _name ,  uint256 _coin) public returns(bool succes){
		count[_addrOwner] = count[_addrOwner]  + 1;
		listZoom[_addrOwner].push(count[_addrOwner]);
		RoomPlay[_addrOwner][count[_addrOwner]].name = _name;
		RoomPlay[_addrOwner][count[_addrOwner]].coin = _coin;
		succes = true;
	}


	function getZoom(address _addrOwner , uint256 _id) public view returns(string memory name , uint256 coin){
		Room storage list  =  RoomPlay[_addrOwner][_id];
		name  = list.name;
		coin  = list.coin;
	}

	function getCountZom(address _addrOwner) public view returns(uint256){
		return listZoom[_addrOwner].length;
	}

	function changeToken(address _addrtoken,address _addrBuyer , uint256 _token) public  returns(bool succes){
		countRequest[_addrtoken] = countRequest[_addrtoken] + 1;
		arrRequest[_addrtoken].push(countRequest[_addrtoken]);
		listRequest[_addrtoken][countRequest[_addrtoken]].buyer = _addrBuyer;
		listRequest[_addrtoken][countRequest[_addrtoken]].tokens = _token;
		listRequest[_addrtoken][countRequest[_addrtoken]].isActive = true;
		succes = true;
	}

	function getCountBuy(address _addrToken) public view returns(uint256){
		return arrRequest[_addrToken].length;
	}	

	// function sell(address _addrtoken ,address from, address to, uint256 tokens) public returns(bool succes){
	// 	StoreToken storage token = MainToken[_addrtoken];
	// 	token.addressStoreToken.transferFrom(from , to , tokens);
	// 	succes  = true;
	// }
	function sell(address _addrtoken ,uint256 num) public returns(uint256 succes){
		StoreToken storage token = MainToken[_addrtoken];
	succes = 	token.addressStoreToken.demo(num);
		// succes  = true;
	}

}	
