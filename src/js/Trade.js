import TRONWEB from './tron-web.js'
const Trade = {
	CONTRACT_ADDRESS:'TNXEhW2Ah3KJHtG3w9qjtbXsWkrG4AZ8x4',
	CONTRACT :null,
	init(callback){
		let self = this;
	    if (typeof(window.tronWeb) === 'undefined') {
	        setTimeout(self.init, 1000);
	    } else {
	      tronWeb
	        .contract()
	        .at(self.CONTRACT_ADDRESS)
	        .then(response)
	        .catch(error);
	      function response(tronContract) {
	        self.CONTRACT = tronContract;
	        return callback(true);
	      } 
	      function error(e) { 
	        return callback(false); 
	      }
	    }
	},
	buy(addressToken,token,price){
		let	amount = token * price ;
		token= token * (10 ** 18);
		price = TRONWEB.toSun(price);
		token = TRONWEB.toHex(token);
		this.CONTRACT.buy(addressToken,TRONWEB.getAccount(),token , price).send({ callValue: parseInt(TRONWEB.toSun(amount)) });	
	},
	sell(addressToken,token,price){
		token= token * (10 ** 18);
		token = TRONWEB.toHex(token);
		price = TRONWEB.toSun(price);
		this.CONTRACT.sell(addressToken,TRONWEB.getAccount(),token , price).send();	
	},
	getCountBuy(addressToken ,callback){
		this.CONTRACT
			.getCountBuy(addressToken)
			.call()
			.then(response)
			.catch(error)
		function response(res) {
			return callback(null, parseInt(res));
		}
		function error(e){
			return callback(e,null);
		}
	},
	getCountSell(addressToken ,callback){
		this.CONTRACT
			.getCountSell(addressToken)
			.call()
			.then(response)
			.catch(error)
		function response(res) {
			return callback(null, parseInt(res));
		}
		function error(e){
			return callback(e,null);
		}
	},
	getOderDetail(addressToken ,id,callback){
		this.CONTRACT
			.getOderDetail(addressToken,id)
			.call()
			.then(response)
			.catch(error)
		function response(result) {
			let data = {
	    		"tradeAddr": TRONWEB.toAddress(result.tradeAddr), 
	    		"price":  TRONWEB.toTrx(parseInt(result.price)), 
	    		"tokens": parseInt(result.tokens) / ( 10 ** 18 ), 
	    		"total": TRONWEB.toTrx(parseInt(result.price)) * parseInt(result.tokens)  / (10 ** 18),
	    		"orderType": parseInt(result.orderType), 
	    		"isActive": result.isActive
	    	};
			return callback(null, data);
		}
		function error(e){
			return callback(e,null);
		}
	},
	getOrderIdBuy(addressToken ,id,callback){
		this.CONTRACT
			.listBuy(addressToken,id)
			.call()
			.then(response)
			.catch(error)
		function response(result) {
			return callback(null, result);
		}
		function error(e){
			return callback(e,null);
		}
	},
	getOrderIdSell(addressToken ,id,callback){
		this.CONTRACT
			.listSell(addressToken,id)
			.call()
			.then(response)
			.catch(error)
		function response(result) {
			return callback(null, result);
		}
		function error(e){
			return callback(e,null);
		}
	},
	getCountIdTransaction(addressToken , callback) {
		this.CONTRACT
			.getCountIdTransaction(addressToken)
			.call()
			.then(response)
			.catch(error)
		function response(result) {
			return callback(null, parseInt(result));
		}
		function error(e){
			return callback(e,null);
		}
	},
	getTransactionDetail(addressToken , id , callback){
		this.CONTRACT
			.transactionDetail(addressToken , id)
			.call()
			.then(response)
			.catch(error)
		function response(result) {
			let data = {
				'token' :  parseInt(result.token) / (10 ** 18),
				'price' :  TRONWEB.toTrx(parseInt(result.price)), 
				'time' :  parseInt(result.time),
				'orderType' :  parseInt(result.orderType),
			}
			return callback(null, data);
		}
		function error(e){
			return callback(e,null);
		}
	}



	
}
export default Trade;