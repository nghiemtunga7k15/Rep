pragma solidity ^0.4.25;
contract StoreTokenInterface {
	function isStoreTokenContract() external pure returns(bool);
}
contract Main {
	address public owner;
	bool public isActive = false;

	StoreTokenInterface public StoreTokenContract;

	mapping(address => uint256) public count;
	mapping(address => StoreToken) public MainToken;
	mapping(address => mapping(uint256 => Room)) public RoomPlay;
	mapping(address => uint256[]) public listZoom;

	struct StoreToken {
		bool isActive;
		string tokenName;
		address addressToken;
		StoreTokenInterface addressStoreToken;
	}

	struct Room {
		string name;
		uint256 coin;
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

	function setStoreToken(address _addrStoreToken , address _addrToken , string _name ) public isOwner returns(bool succes){
		StoreTokenContract = StoreTokenInterface(_addrStoreToken);
		if(StoreTokenContract.isStoreTokenContract() == false) { revert(); }
		MainToken[_addrToken].isActive           = true;
		MainToken[_addrToken].tokenName          = _name;
		MainToken[_addrToken].addressToken       = _addrToken;
		MainToken[_addrToken].addressStoreToken  = StoreTokenContract;
		succes = true;
	}

	function createZoom(address _addrOwner , string _name ,  uint256 _coin) public returns(bool succes){
		count[_addrOwner] = count[_addrOwner]  + 1;
		listZoom[_addrOwner].push(count[_addrOwner]);
		RoomPlay[_addrOwner][count[_addrOwner]].name = _name;
		RoomPlay[_addrOwner][count[_addrOwner]].coin = _coin;
	}


	function getZoom(address _addrOwner , uint256 _id) public view returns(string name , uint256 coin){
		Room storage list  =  RoomPlay[_addrOwner][_id];
		name  = list.name;
		coin  = list.coin;
	}

	function getCountZom(address _addrOwner) public view returns(uint256){
		return listZoom[_addrOwner].length;
	}

}	