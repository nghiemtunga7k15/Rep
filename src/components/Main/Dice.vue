<template>
  <b-container fluid>
    <!-- <b-row>
      <b-col cols="3">
        <b-list-group v-b-scrollspy:listgroup-ex >
        <b-list-group>
          <div v-for="item in listGame" @click="setValue(item.id)">
          <b-list-group-item v-bind:href="'#list-item-'+item.id"><span >Item {{item.id}}</span></b-list-group-item>
            
          </div>
        </b-list-group>
      </b-col>

      <b-col cols="9">
        <div id="listgroup-ex" style="position:relative; overflow-y:auto; height: 170px" >
          <div v-for="item in listGame">
              <h4 v-bind:id="'list-item-'+item.id">Item {{item.id}}</h4>
              <p>{{ text }}</p>
          </div>
        </div>
        <b-jumbotron>
          <p>{{listGame[idActive].name}}</p>
          <b-button variant="primary" href="#">More Info</b-button>
        </b-jumbotron>
      </b-col>
    </b-row>  -->
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
          <div>
             <b-form-select  v-model="demo" :options="listCoin" size="sm" class="mt-3"></b-form-select>
          </div>
        <br>
    <div>
      <b-input-group
        v-for="size in ['sm']"
        :key="size"
        :size="size"
        class="mb-3"
        prepend="Coin"
      >

        <input type="" v-model="demo + ' ' +listGame[idActive].nameToken" name="">
        <b-input-group-append>
          <b-button size="sm" text="Button" variant="success" @click="demos">Betting</b-button>
        </b-input-group-append>
      </b-input-group>

      <div v-for="item in listZoom">
        <p>ok</p>
      </div>
</div>
  </b-container>
</template>

<script>
  import { mapGetters, mapActions } from 'vuex';
  import Main from './../../js/main.js'
  export default {
    computed: {
        ...mapGetters([
            'listGame',
            'idActive',
            'listZoom'
        ])
    },
    data() {
      return {
        // text: `
        //   Quis magna Lorem anim amet ipsum do mollit sit cillum voluptate ex nulla
        //   tempor. Laborum consequat non elit enim exercitation cillum aliqua
        //   consequat id aliqua. Esse ex consectetur mollit voluptate est in duis
        //   laboris ad sit ipsum anim Lorem. Incididunt veniam velit elit elit veniam
        //   Lorem aliqua quis ullamco deserunt sit enim elit aliqua esse irure. Laborum
        //   nisi sit est tempor laborum mollit labore officia laborum excepteur
        //   commodo non commodo dolor excepteur commodo. Ipsum fugiat ex est consectetur
        //   ipsum commodo tempor sunt in proident.
        // `,
        demo:0,
        listCoin:[0,10,20,30]
      }
    },
    mounted(){
      this.showInfo();
      this.onExchangeIdActiveChange();
    },
    methods:{
      ...mapActions([
          'SET_ID_ACTIVE',
          'SET_GAME_LIST_SHOW',
          'SET_ZOOM_LIST_SHOW'
      ]),
      loadData(){
        let self = this;
        // if(!Main.CONTRACT)
      }
      onExchangeIdActiveChange() {
        this.$store.watch(
          (state)=>{
            return this.$store.getters.idActive
          },
          (val)=>{
           //something changed do something
            this.showInfo();
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
      demos(){
        let self = this;
         Main.getCountZom(function(err , success){
            if(err){
              console.log(err)
            }else{
              if(success == 0){
                self.SET_ZOOM_LIST_SHOW([]);
              }else{
                let promise = [];
                for (let idx = 0; idx < success ; idx++) {
                    promise.push(self.getZoom(idx));
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
      getZoom(id){
        return new Promise((resolve,reject)=>{
              Main.getZoomPlay(id,function(err,success){
                if(err){
                  return  reject(err);
                }else{
                  return resolve(success);
                }
              })
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
