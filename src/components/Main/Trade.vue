<template>
  <b-container fluid>
      <b-row>
          <b-col cols="3">
                <table width="60%">
                  <tr>
                    <th>Price</th>
                    <th>Amount</th>
                    <th>Total</th>
                  </tr>
                  <tr>
                    <td>1</td>
                    <td>5</td>
                    <td>5</td>
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
                            <b-form-input  placeholder=""></b-form-input>
                          </b-form-group>

                          <b-form-group>
                            <label>Amount : </label>
                            <b-form-input  placeholder=""></b-form-input>
                          </b-form-group>    

                          <b-button type="submit" block variant="outline-success">Buy</b-button>

                        </b-form>

                    </b-col>
                     <b-col>
                        <b-form >

                          <span style="font-weight: bold;"> Sell {{listGame[idActive].nameToken}}</span>

                          <b-form-group>
                            <label>Price : </label>
                            <b-form-input  placeholder=""></b-form-input>
                          </b-form-group>

                          <b-form-group>
                            <label>Amount : </label>
                            <b-form-input  placeholder=""></b-form-input>
                          </b-form-group>    

                          <b-button type="submit" block variant="outline-danger">Sell</b-button>

                        </b-form>
                    </b-col>
               </b-row>
          </b-col>
          <b-col cols="3">
                <table width="60%">
                  <tr>
                    <th>Pair</th>
                    <th>Price</th>
                    <th>Change</th>
                  </tr>
                  <tr v-for="item in listGame" @click="redirect(item.id)">
                    <td>{{item.nameToken}}</td>
                    <td>{{item.change}}</td>
                    <td>{{item.exchange}}</td>
                  </tr>
                </table>
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
          'idActive'
        ])
    },
    data() {
      return {
        demo:'sasddsa'
      }
    },
    mounted(){
      // this.SET_ID_ACTIVE(this.$route.query.id)
      // this.loadData();
      this.onExchangeIdActiveChange();
    },
    methods:{
      ...mapActions([
          'SET_ID_ACTIVE',
          'SET_GAME_LIST_SHOW',
          'SET_ZOOM_LIST_SHOW',
          'SET_TOKEN'
      ]),
      redirect(tradeId){
        this.SET_ID_ACTIVE(tradeId);
        this.$router.push({name:'trade', query: { id: tradeId }});

      },
      onExchangeIdActiveChange() {
        this.$store.watch(
          (state)=>{
            return this.$store.getters.idActive
          },
          (val)=>{
            // alert(this.listGame[this.idActive].addToken)              
          },
          {
            deep:true
          }
        ); 
      },
      buy(){
         let addToken= this.listGame[this.idActive].addToken;
         alert(addToken)

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
