<template>
  <b-container fluid>
      <b-row>
          <b-col cols="3">
                      <b-button variant="info" @click="showAll">A</b-button>
                      <b-button variant="success" @click="showBuyOder">B</b-button>
                      <b-button variant="danger" @click="showSellOder">S</b-button>
                <table width="60%">
                  <tr>
                    <th  style="color: silver;font-size: 10px ">Price</th>
                    <th  style="color: silver;font-size: 10px ">Amount</th>
                    <th  style="color: silver;font-size: 10px ">Total</th>
                  </tr>
                  <tr v-for="item in listBuyToken" v-if="item.isActive == true && showBuy==true">
                      <td class="up">{{item.price}}</td>
                      <td class="up">{{item.tokens}}</td>
                      <td >{{item.total}}</td>
                  </tr>

                 <b-progress :value="value" :max="max" show-progress animated></b-progress>

                  <tr v-for="item in listSellToken" v-if="item.isActive == true && showSell==true">
                      <td class="down">{{item.price}}</td>
                      <td class="down">{{item.tokens}}</td>
                      <td>{{item.total}}</td>
                  </tr>
                </table>
          </b-col>
          <b-col>
               <b-row>
                    <b-col>
                        <b-form >

                          <span style="font-weight: bold;"> Buy {{listGame[idActive].nameToken}}</span>

                          <b-form-group>
                            <label>Price : </label>
                            <b-form-input  v-on:keyup="keyUpPrice(priceBuy)"  v-model="priceBuy"   type="number" ></b-form-input>
                          </b-form-group>

                          <b-form-group>
                            <label>Amount : </label>
                            <b-form-input v-on:keyup="keyUpAmount(amountBuy)"  v-model="amountBuy"  type="number"></b-form-input>
                          </b-form-group>    
                          
                          <b-form-group>
                            <label>Total : </label>
                            <b-form-input disabled v-model="totalBuy"></b-form-input>
                          </b-form-group> 

                          <b-button type="button" block variant="outline-success" @click="buy">Buy</b-button>

                        </b-form>

                    </b-col>
                     <b-col>
                        <b-form >

                          <span style="font-weight: bold;"> Sell {{listGame[idActive].nameToken}}</span>

                          <b-form-group>
                            <label>Price : </label>
                            <b-form-input v-on:keyup="keyUpPriceSell(priceSell)" type="number" v-model="priceSell" ></b-form-input>
                          </b-form-group>

                          <b-form-group>
                            <label>Amount : </label>
                            <b-form-input  v-on:keyup="keyUpAmountSell(amountSell)"  type="number" v-model="amountSell" ></b-form-input>
                          </b-form-group>    
                          
                           <b-form-group>
                            <label>Total : </label>
                            <b-form-input disabled v-model="totalSell"></b-form-input>
                          </b-form-group> 

                          <b-button type="button" block variant="outline-danger" @click="sell"> Sell</b-button>

                        </b-form>
                    </b-col>
               </b-row>
          </b-col>
          <b-col cols="3">
                <table width="60%">
                  <tr>
                    <th style="color: silver;">Pair</th>
                    <th style="color: silver;">Price</th>
                    <th style="color: silver;">Change</th>
                  </tr>
                  <tr v-for="item in listGame" @click="redirect(item.id)" style="    cursor: pointer;">
                    <td style="font-weight: 400;">{{item.nameToken}}/TRX</td>
                    <td>{{item.change}}</td>
                    <td>{{item.exchange}}</td>
                  </tr>
                </table>

                <br><br><br><br>
                <br><br><br><br>
                
                  <p>Oder History</p>
                 <table width="60%">
                  <tr>
                    <th  style="color: silver;font-size: 10px ">Price</th>
                    <th  style="color: silver;font-size: 10px ">Token</th>
                    <th  style="color: silver;font-size: 10px ">Time</th>
                  </tr>
                  <tr v-for="item in orderHistory" >
                      <td v-bind:class="{ up : (item.orderType == 1) , down : (item.orderType == 0)}">{{item.price}}</td>
                      <td v-bind:class="{ up : (item.orderType == 1) , down : (item.orderType == 0)}">{{item.token}}</td>
                      <td v-bind:class="{ up : (item.orderType == 1) , down : (item.orderType == 0)}">{{forMatDate(item.time)}}</td>
                  </tr>
                </table>


          </b-col>
  

      </b-row>
  </b-container>
</template>

<script>
  import { mapGetters, mapActions } from 'vuex';
  import Main from './../../js/Main.js'
  import Trade from './../../js/Trade.js'
  import MYTronWeb from './../../js/tron-web.js'
  import ForMat from './../../js/format.js'
  export default {
    computed: {
        ...mapGetters([
          'listGame',
          'idActive',
          'listBuyToken',
          'listSellToken',
          'orderHistory'
        ])
    },
    data() {
      return {
        demo:'sasddsa',
        priceBuy : '',
        amountBuy : '',
        totalBuy:0,
        priceSell : '',
        amountSell : '',
        totalSell:0,
        value: 100,
        max: 100,
        showSell:true,
        showBuy:true,
      }
    },
    mounted(){
      this.onExchangeIdActiveChange();
      this.init();
    },
    methods:{
      ...mapActions([
          'SET_ID_ACTIVE',
          'SET_GAME_LIST_SHOW',
          'SET_ZOOM_LIST_SHOW',
          'SET_TOKEN',
          'Set_List_Buy_Token',
          'Set_List_Sell_Token',
          'Set_List_History'
      ]),
      forMatDate(timestamp){
        return ForMat.forMatDate(timestamp);
      },
      redirect(tradeId){
        this.SET_ID_ACTIVE(tradeId);
        this.$router.push({name:'trade', query: { id: tradeId }});

      },
      init(){
          let self = this;
          if (!Trade.CONTRACT) {
            return setTimeout(() => {
              self.init();
            }, 1000);
          } 
            self.getCountIdTransaction();
          setInterval(function(){ 
            self.getOrderBuy();
            self.getOrderSell();
          }, 1000);
      },
      onExchangeIdActiveChange() {
        this.$store.watch(
          (state)=>{
            return this.$store.getters.idActive
          },
          (val)=>{
              this.getCountIdTransaction();            
              this.getOrderBuy();            
              this.getOrderSell();            
          },
          {
            deep:true
          }
        ); 
      },
      buy(){
         let addToken= this.listGame[this.idActive].addToken;
          Trade.buy(addToken ,this.amountBuy , this.priceBuy);
      },
      sell(){
         let addToken= this.listGame[this.idActive].addToken;
          Trade.sell(addToken ,this.amountSell , this.priceSell);
      },
      showBuyOder(){
        this.showSell = false;
        this.showBuy = true;
      },
      showSellOder(){
        this.showSell = true;
        this.showBuy = false;
      },
      showAll(){
        this.showBuy = true;
        this.showSell = true;
      },
      getCountIdTransaction(){
        let self = this;
         let addToken= this.listGame[this.idActive].addToken;
         Trade.getCountIdTransaction(addToken ,function (err , id) {
            if(err){
              return console.log(err);
            }else{
                if(id  <= 0  ){
                    self.Set_List_History([]);
                }
                let promises = [];
                  for(let idx =  1 ; idx <=  id; idx++) {
                      promises.push(self.transactionDetail(addToken, idx));
                  }
                  Promise
                    .all(promises)
                    .then(historyOrder=>{
                        self.Set_List_History(historyOrder);
                    })
                    .catch(e=>{
                        return console.log(e);
                    })
            }
         })
      },
      transactionDetail(addToken ,id){
          return new Promise((resolve,reject)=>{
              Trade.getTransactionDetail(addToken  , id ,function (err , success) {
                  if(err){
                    reject(err);
                  }else{
                    resolve(success);
                  }
              })
          })
      },
      getOrderBuy(){
        let self = this;
        let addToken= this.listGame[this.idActive].addToken;
          Trade.getCountBuy(addToken ,function (err , success) {
                if(err){
                      return console.log(err);
        
                }else{
                    let promises = [];
                      for (let idx = 0; idx  < success; idx++) {
                            promises.push(self.getOrderIdBuy(addToken , idx));
                      }
                    Promise
                      .all(promises)
                      .then(listBuy=>{
                          self.Set_List_Buy_Token(listBuy);
                      })
                      .catch(e=>{
                        return console.log(e)
                      })
                }
          })
      },
      getOrderIdBuy(addToken , id ){
        return new Promise((resolve,reject)=>{

          Trade.getOrderIdBuy(addToken ,id,function (err , oderID) {
                if(err){
                       reject(err);
                }else{
                      Trade.getOderDetail(addToken  , oderID , function (err,success) {
                          if(err){
                            reject(err);
                          }else{
                            resolve(success);
                          }
                      }) 
                }
          })
        })
      },
      getOrderSell(){
         let self = this;
        let addToken= this.listGame[this.idActive].addToken;
          Trade.getCountSell(addToken ,function (err , success) {
                if(err){
                  return console.log(err);
                }else{
                     let promises = [];
                      for (let idx = 0; idx  < success; idx++) {
                            promises.push(self.getOrderIdSell(addToken , idx));       
                      }
                    Promise
                      .all(promises)
                      .then(listSell=>{
                          self.Set_List_Sell_Token(listSell);
                      })
                      .catch(e=>{
                        return console.log(e)
                      })
                }
          })
      },
      getOrderIdSell(addToken , id ){
        return new Promise((resolve,reject)=>{

          Trade.getOrderIdSell(addToken ,id,function (err , oderID) {
                if(err){
                       reject(err);
                }else{
                      Trade.getOderDetail(addToken  , oderID , function (err,success) {
                          if(err){
                            reject(err);
                          }else{
                            resolve(success);
                          }
                      }) 
                }
          })
        })
      },
      keyUpPrice (val) {
        this.totalBuy = parseInt(this.priceBuy) * parseInt(this.amountBuy);

      },
      keyUpAmount(val){
        this.totalBuy = parseInt(this.priceBuy) * parseInt(this.amountBuy);
      },
      keyUpPriceSell(val) {
        this.totalSell = parseInt(this.priceSell) * parseInt(this.amountSell);

      },
      keyUpAmountSell(val){
        this.totalSell = parseInt(this.priceSell) * parseInt(this.amountSell);
      }
     }
  }
</script>
<style >
    .text{
      color:green;
    }
    .actives{
      color : rgb(234, 0, 112);;
    }
    .up{
      color: green;
    }
    .down{
      color : red;
    }
</style>
