<template>
 	<UserView />
</template>

<script>
import UserView from './../../view/User' 
import  Main from './../../js/Main.js' 
import { mapGetters, mapActions } from 'vuex';
export default {

  components:{
    UserView
  },
  mounted(){
      this.loadData();
  },
  computed: {
        ...mapGetters([
            'listGame',
            'idActive',
            'listBuy'
        ])
  },

  data () {
    return {
        
    }
  },
  methods:{
      ...mapActions([
          'SET_BUY_LIST_SHOW',
      ]),
      loadData(){
      	let self = this;
      	if(!Main.CONTRACT){
	         return setTimeout(() => {
	           self.loadData();
	         }, 1000); 
      	}
      	self.loadRequest();
      },
      onExchangeIdActiveChange() {
        this.$store.watch(
          (state)=>{
            return this.$store.getters.idActive
          },
          (val)=>{
           //something changed do something
            
          },
          {
            deep:true
          }
        ); 
      },
      getRequest(add , id){
      		return new Promise((resolve,reject)=>{
      			Main.getListRequest(add,id,function(err,sucess){
      				if(err){
      					reject(err);
      				}
      					resolve(sucess);
      			})
      		})
      },
      loadRequest(){
      	let self = this;
        let add = self.listGame[self.idActive].addressStoreToken;
      	Main.getcountRequest(add,function(err,sucess){
      		if(err){
      			console.log(err);
      		}else{      	
		      		let promise = [];
		      		for (let idx = 1; idx <= sucess; idx++) {
		      			promise.push(self.getRequest(add,idx));
		      		}
			      		Promise
			      			.all(promise)
			      			.then(listBuy=>{
			      				self.SET_BUY_LIST_SHOW(listBuy);
			      			})	    	  	
      		}
      	})
      }




  }
}
</script>

<style>

</style>
