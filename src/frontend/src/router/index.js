import Vue from 'vue'
import Router from 'vue-router'
import Trade from '@/components/trade.vue'

Vue.use(Router)

export default new Router({
  routes: [
    {
      path: '/',
      name: 'trade',
      component: Trade
    }
  ]
})