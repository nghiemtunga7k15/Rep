import Vue from 'vue'
import Router from 'vue-router'
import DiceContainer from './../container/Dice'
import UserContainer from './../container/User'
import HomeContainer from './../container/Home'
import TradeContainer from './../container/Trade'
Vue.use(Router)
const HomeRouter = { path: '/',name: 'Home',component: HomeContainer };
const DiceRouter = { path: '/dice',name: 'dice',component: DiceContainer };
const TradeRouter = { path: '/trade',name: 'trade',component: TradeContainer };
const UserRouter = { path: '/user',name: 'User',component: UserContainer };
const routes = [
	DiceRouter,
	TradeRouter,
	UserRouter,
	HomeRouter
]

const router =  new Router({
  routes: routes,
  mode: 'history',
})
 export default router;