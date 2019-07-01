<template>
  <b-container fluid>
      <div>
          <b-tabs >
                <div>
                  <table style="width:100%">
                    <tr>
                      <th style="color: #999;font-weight: normal;line-height: 1;">Cặp</th>
                      <th style="color: #999;font-weight: normal;line-height: 1;">Coin Name</th>
                      <th style="color: #999;font-weight: normal;line-height: 1;">Thay đổi gần nhất 24h </th> 
                      <th style="color: #999;font-weight: normal;line-height: 1;">Giá cao nhất 24h</th>
                      <th style="color: #999;font-weight: normal;line-height: 1;">Khối lượng giao dịch</th>
                    </tr>
                    <tr  v-for="item in listGame" style="cursor: pointer;" @click="redirectToGame(item.id)">
                      <td>{{item.nameToken}}/<span style="color: rgb(112, 168, 0);">ETH</span></td>
                      <td>{{item.nameToken}}</a></td>
                      <td :class="{ actives: (item.change  < 0.009), text: (item.change > 0.009 ) }">{{(item.exchange)}}/{{item.nameToken}} </td>
                      <td :class="{ actives: (item.change  < 0), text: (item.change  > 0 ) }">{{convert(item.change)}} %</td> 
                      <td>10000 Transactions</td>
                    </tr>
                  </table>
                </div>
          </b-tabs>
    </div>
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
    },
    methods:{
      ...mapActions([
          'SET_ID_ACTIVE',
          'SET_GAME_LIST_SHOW',
          'SET_ZOOM_LIST_SHOW',
          'SET_TOKEN'
      ]),
      redirectToGame(tradeId){
          this.$router.push({name:'dice', query: { id: tradeId }});
      },
      loadData(){
        let self = this;
        if(!Main.CONTRACT && !Token.CONTRACT){
          return setTimeout(function(){
              self.loadData();
          },1000)
        }
      },
      convert(val){
        var num = val;
        var n = num.toFixed(2);
        return n;
      },
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
