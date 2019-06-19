import Vue from 'vue'
import Router from 'vue-router'
import DiceContainer from './../container/Dice'
import UserContainer from './../container/User'
Vue.use(Router)
const DiceRouter = { path: '/',name: 'Home',component: DiceContainer };
const UserRouter = { path: '/user',name: 'User',component: UserContainer };
const routes = [
	DiceRouter,
	UserRouter
]

const router =  new Router({
  routes: routes,
  mode: 'history',
})
 export default router;