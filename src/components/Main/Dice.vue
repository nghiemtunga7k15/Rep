<template>
  <b-container fluid>
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
               <b-button v-if="tokenUser == 0 " @click="modalShow = !modalShow">Exchange Tokens</b-button>
    
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
      this.SET_ID_ACTIVE(this.$route.query.id)
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
            this.loadZoom();
          },
          {
            deep:true
          }
        ); 
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
