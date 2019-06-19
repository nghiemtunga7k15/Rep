import TRONWEB from './tron-web.js'
const Main = {
	CONTRACT_ADDRESS:'TTvfPu4KPmsrzZt8arAikpeKKxw5WkKQ55',
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
	getCountZom(callback){
		this.CONTRACT
		.getCountZom(TRONWEB.getAccount())
		.call()
		.then(response)
		.catch(error)
		function response(succes) {
			return callback(null , succes);
		}
		function error(e) {
			return callback(e, null);
		}
	},
	getZoomPlay(id,callback){
		this.CONTRACT
		.RoomPlay(TRONWEB.getAccount(),id)
		.call()
		.then(response)
		.catch(error)
		function response(succes) {
			return callback(null , succes);
		}
		function error(e) {
			return callback(e, null);
		}
	}
}
export default Main;