pragma solidity >=0.4.23 <0.6.0;
contract ERC20Interface {
    function totalSupply() public view returns (uint);
    function balanceOf(address tokenOwner) public view returns (uint balance);
    function allowance(address tokenOwner, address spender) public view returns (uint remaining);
    function transfer(address to, uint tokens) public returns (bool success);
    function approve(address spender, uint tokens) public returns (bool success);
    function transferFrom(address from, address to, uint tokens) public returns (bool success);

    event Transfer(address indexed from, address indexed to, uint tokens);
    event Approval(address indexed tokenOwner, address indexed spender, uint tokens);
}
contract Token is ERC20Interface{
	string  public constant name = "TTC";
    string  public constant symbol = "0xTTC";
    uint8   public constant decimals = 18;
    uint    public _totalSupply = 10**3;
    uint    public _totalSupplyMax = 10**10;

  	address public addressMain;
    address public owner;
    bool    public isActive = false;

    mapping(address => uint256) public  balances;
    mapping(address => mapping(address => uint256)) public  allowed;

    constructor () public {
    	owner = msg.sender;
    	balances[owner] = 10000;
    }

    modifier onlyOwner(){
    	require(msg.sender == owner);
    	_;
    }

    modifier contractActive(){
    	require(msg.sender == owner);
    	_;
    }

    function isTokenContract() public pure returns(bool){
    	return true;
    }

    function setup() public onlyOwner returns(bool success){
    	require(isActive == false);
    	isActive = true;
    	success = true;
    }

    function totalSupply() public view returns(uint){

    }

    function balanceOf(address tokenOwner) public view returns(uint balance){
    		balance = balances[tokenOwner];
    }

    function allowance(address tokenOwner, address spender) public view returns (uint remaining){
            remaining = allowed[tokenOwner][spender];
    }

    function transfer(address to, uint tokens) public returns (bool success){
            if(balances[msg.sender]< 0 ){ revert();}
            balances[msg.sender] = balances[msg.sender] - tokens;
            balances[to] = balances[to] + tokens;
    }

    function approve(address spender, uint tokens) public returns (bool success){
            allowed[msg.sender][spender] = tokens;
            success = true;
    }

    function transferFrom(address from, address to, uint tokens) public returns (bool success){
            if(allowed[from][to] < tokens) { revert(); }
            if (to == address(0)) revert();  
            if (tokens <= 0) revert();
            balances[from] = balances[from] - tokens;
            balances[to] = balances[to] + tokens;
            allowed[from][to] = allowed[from][to] - tokens;
    }
}