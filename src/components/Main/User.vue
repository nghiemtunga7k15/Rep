<template>
  <div class="main">
			  <b-row>
          <b-col cols="3">
                <table style="width:100%">
                    <tr>
                      <th style="color: #999;font-weight: normal;line-height: 1;">Cặp</th>
                      <th style="color: #999;font-weight: normal;line-height: 1;">Coin Name</th>
                    </tr>
                    <tr  v-for="item in listGame" style="cursor: pointer;" @click="setValue(item.id)">
                      <td>{{item.nameToken}}/<span style="color: rgb(112, 168, 0);">ETH</span></td>
                      <td>{{item.nameToken}}</td>
                     
                    </tr>
                  </table>
            </b-col>
						<b-col cols="9">
                <table style="width:100%">
                  <tr>
                    <th>STT</th>
                    <th>Address</th> 
                    <th>Token</th>
                    <th>Action</th>
                  </tr>
                  <tr v-for="item in listBuy">
                    <td>#</td>
                    <td>{{item.traderAddr}}</td> 
                    <td>{{item.tokens}}</td>
                    <td><b-button variant="outline-primary" @click="buy(item.traderAddr, item.tokens)">Buy</b-button></td>
                  </tr>
                </table>    
            </b-col> 
			  </b-row>
  </div>
</template>

<script>
  import { mapGetters, mapActions } from 'vuex';
  import Main from './../../js/Main.js'
export default {
  computed: {
        ...mapGetters([
            'listBuy',
            'listGame',
            'idActive'
        ])
  },
  data () {
    return {
        
    }
  },
   mounted(){
      this.onExchangeIdActiveChange();
    },
  methods:{
    ...mapActions([
          'SET_ID_ACTIVE',
          'SET_BUY_LIST_SHOW'
    ]),
    loadData(){
        let self = this;
        if(!Main.CONTRACT){
          return setTimeout(function(){
              self.loadData();
          },1000)
        }
        this.loadRequest();
    },
    setValue(val){
        this.SET_ID_ACTIVE(val);
      },
    buy(address, tokens){
        let self = this;
        let tokenAddr = self.listGame[self.idActive].addToken;
        // let addressStoreToken = self.listGame[self.idActive].addressStoreToken;
        initTokenContract();
        function initTokenContract() {
          tronWeb
            .contract()
            .at(tokenAddr)
            .then(approveTokens)
            .catch(err);
        }
        function approveTokens(contract){
            // contract.approve(address , tronWeb.toHex(tokens * (10 ** 18))).send().then(()=>{
            contract.approve(address , tokens ).send().then(()=>{
              Main.sell(tokenAddr , 'TPL66VK2gCXNCD7EJg9pgJRfqcRazjhUZY' ,address ,tokens);            
            })
            .catch(e => console.log(e));
        }
        function err(e) { 
          return console.log(e); 
        } 
    },
    convert(val){
        var num = val;
        var n = num.toFixed(2);
        return n;
    },
    onExchangeIdActiveChange() {
        this.$store.watch(
          (state)=>{
            return this.$store.getters.idActive
          },
          (val)=>{
              this.loadRequest();
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
