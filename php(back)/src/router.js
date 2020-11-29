import Vue from 'vue'
import Router from 'vue-router'
import Login from '@/components/views/Login'

Vue.use(Router)

export default new Router({
    mode: 'history',
    routes: [
        {
            path: '/',
            component: Login 
        }, 
        {
            path: '/msg',
            component: () => import('./components/views/Msg.vue')
        },
        {
            path: '/acces',
            component: () => import('./components/views/Acces.vue')
        }
    ]
})