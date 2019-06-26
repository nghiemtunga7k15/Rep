<template>
  <b-container fluid>
    <div>
          <b-tabs >
            <b-tab title="This is Market" active>
                <div>
                  <table style="width:100%">
                    <tr>
                      <th style="color: #999;font-weight: normal;line-height: 1;">Cặp</th>
                      <th style="color: #999;font-weight: normal;line-height: 1;">Coin Name</th>
                      <th style="color: #999;font-weight: normal;line-height: 1;">Thay đổi gần nhất 24h </th> 
                      <th style="color: #999;font-weight: normal;line-height: 1;">Giá cao nhất 24h</th>
                      <th style="color: #999;font-weight: normal;line-height: 1;">Khối lượng giao dịch</th>
                    </tr>
                    <tr  v-for="item in listGame" style="cursor: pointer;" @click="setValue(item.id)">
                      <td>{{item.nameToken}}/<span style="color: rgb(112, 168, 0);">ETH</span></td>
                      <td>{{item.nameToken}}</td>
                      <td :class="{ actives: (item.change  < 0.009), text: (item.change > 0.009 ) }">{{(item.exchange)}}/{{item.nameToken}} </td>
                      <td :class="{ actives: (item.change  < 0), text: (item.change  > 0 ) }">{{convert(item.change)}} %</td> 
                      <td>10000 Transactions</td>
                    </tr>
                  </table>
                </div>
            </b-tab>
            <b-tab title="This is Page 1"><p>I'm the second tab</p></b-tab>
            <b-tab title="This is Page 2"><p>I'm a disabled tab!</p></b-tab>
          </b-tabs>
    </div>
  
<br>
      <b-row>
          <b-col cols="3">
              <b-list-group v-for="item in listZoom">
                <b-list-group-item>{{item.name}}</b-list-group-item>
              </b-list-group>
          </b-col>
          <b-col>
            <div>
              <b-row>
                  <b-col> 
                      <span style="font-weight: bold">Token</span> : {{listGame[idActive].nameToken}}
                  </b-col>
                  <b-col> 
                      <span style="font-weight: bold">Zoom</span> : {{listGame[idActive].nameToken}}
                  </b-col>
                  <b-col> 
                      <span style="font-weight: bold">Amount Player</span> : {{listGame[idActive].nameToken}}
                  </b-col>
                  <b-col> 
                      <span style="font-weight: bold">Amoutn Token</span> : {{tokenUser}}
                  </b-col>
              </b-row>
              <b-form-group label="Entern Token">
                <b-form-select  v-model="token" :options="listToken" size="sm" class="mt-3"></b-form-select>
              </b-form-group>
               <b-button v-if="tokenUser == 10000 " @click="modalShow = !modalShow">Exchange Tokens</b-button>
    
                <b-modal v-model="modalShow" hide-footer>
                  <b-form-group
                    label="Tokens">
                      <div>
                        <b-form-input v-model="token" placeholder="Enter Token Want Buy" type="number"></b-form-input>
                      </div>
                      <br>
                      <div>
                        <b-button class="btn-lock " style="width: 100% !important" @click="buy" >Buy</b-button>
                      </div>
                  </b-form-group>
                </b-modal>
            </div>
          </b-col>
      </b-row>
  </b-container>
</template>

<script>
  import { mapGetters, mapActions } from 'vuex';
  import Main from './../../js/Main.js'
  import Token from './../../js/Token.js'
  import MYTronWeb from './../../js/tron-web.js'
  export default {
    computed: {
        ...mapGetters([
            'listGame',
            'idActive',
            'listZoom',
            'tokenUser'
        ])
    },
    data() {
      return {
        coin:0,
        token:'',
        listToken:[0,1,2,3,4,5],
        modalShow: false
      }
    },
    mounted(){
      this.loadData();
      this.onExchangeIdActiveChange();
    },
    methods:{
      ...mapActions([
          'SET_ID_ACTIVE',
          'SET_GAME_LIST_SHOW',
          'SET_ZOOM_LIST_SHOW',
          'SET_TOKEN'
      ]),
      loadData(){
        let self = this;
        if(!Main.CONTRACT && !Token.CONTRACT){
          return setTimeout(function(){
              self.loadData();
          },1000)
        }
        self.onExchangeIdActiveChange();
        self.loadZoom();
        self.loadToken();
      },
      onExchangeIdActiveChange() {
        this.$store.watch(
          (state)=>{
            return this.$store.getters.idActive
          },
          (val)=>{
           //something changed do something
            this.showInfo();
            this.loadZoom();
          },
          {
            deep:true
          }
        ); 
      },
      setValue(val){
        this.SET_ID_ACTIVE(val);
      },
      showInfo(){
          // console.log(this.listGame[this.idActive])
      },
      convert(val){
        var num = val;
        var n = num.toFixed(2);
        return n;
      },
      loadZoom(){
        let self = this;
        let add = self.listGame[self.idActive].addressStoreToken;
         Main.getCountZom(add,function(err , success){
            if(err){
              console.log(err)
            }else{
              if(success == 0){
                self.SET_ZOOM_LIST_SHOW([]);
              }else{
                let promise = [];
                for (let idx = 1; idx <= success ; idx++) {
                    promise.push(self.getZoom(add,idx));
                }
                Promise
                .all(promise)
                .then(listZoom=>{
                    self.SET_ZOOM_LIST_SHOW(listZoom);
                })
              }
            }
         })
      },
      getZoom(add,id){
        return new Promise((resolve,reject)=>{
              Main.getZoomPlay(add,id,function(err,success){
                if(err){
                  return  reject(err);
                }else{
                  return resolve(success);
                }
              })
        })
      },
      buy(){
        let self = this;
        let addrToken = self.listGame[self.idActive].addressStoreToken;
        Main.changeToken(addrToken , MYTronWeb.getAccount(), self.token)
      },
      loadToken(){
        let self = this;
        Token.getTokens(function(err,success){
          if(err){
            console.log(err);
          }
            self.SET_TOKEN(success.balances)
        })
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
</style>
