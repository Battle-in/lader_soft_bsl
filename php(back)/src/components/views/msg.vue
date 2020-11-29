<template>
    <div class="wrapper-row">
        <div class="menu__slide" v-bind:class="{ active: isActive}">
            <img v-bind:src="mail" class="logo home" v-on:click="go">
            <img v-bind:src="home" class="logo msg" v-on:click="go">
            <img v-bind:src="set" class="logo set" v-on:click="go">
        </div>
        <div class="menu">
            <img v-bind:src="menu" class="static" v-on:click="mn" v-bind:class="{ active__menu: !isActive}">
            <img v-bind:src="logo" class="logo">
        </div>
        <div class="left">
            <div class="left__catr">
                <div class="left__catr-ca">
                     <img src="" alt="">
                </div>
                 <div class="left__catr-ca">
                     <img src="" alt="">
                </div>
                 <div class="left__catr-ca">
                     <img src="" alt="">
                </div>
            </div>
            <div class="left__contacts">
                <div class="left__column">
                    <div class="left__row" v-for="(people , cm) in resp" :key="cm" v-on:click="giveMSg">
                        <div class="left__row-left">
                            <img v-bind:src="people.avatar" >
                        </div>
                        <div class="left__row-right">
                            <p>{{ people.frms }}</p>
                            <p> {{people.text}} </p>
                        </div>
                    </div>
                </div>
            
            </div>
        </div>
        <div class="right">
            <div class="right__msg">
                <div class="right__column">
                    <div class="right__row left-msg">
                        <div class="right__row-avatar">
                            <img src="https://bsl-show.ru/resourse/img/avatar/images222.jpg" alt="">
                            <p>admin</p>
                        </div>
                        <div class="right__row-text">
                            <p>hello</p>
                            <p>7.32</p>
                        </div>
                    </div>
                    <div class="right__row right-msg">
                        <div class="right__row-text">
                            <p>hello</p>
                            <p>7.32</p>
                        </div>
                        <div class="right__row-avatar">
                            <img src="https://bsl-show.ru/resourse/img/avatar/images222.jpg" alt="">
                            <p>admin</p>
                        </div>
                    </div>
                </div>
            </div>
            <div class="right__send">
                    <div class="right__send-fr">
                    <input type="text" placeholder="text">
                    <button>send</button>
                    </div>
                </div>
                <transition name="fade">
         <router-view />
      </transition>
        </div>
    </div>
</template>

<script>
import logo from '@/assets/icon/logo.svg';
import menu from '@/assets/icon/menu.svg';
import home from '@/assets/icon/home.svg';
import mail from '@/assets/icon/mail.svg';
import set from '@/assets/icon/set.svg';
import axios from 'axios';
import router from '../../router';
export default {
    name: 'app',
    data() {
        return {
            axios,
            router,
            menu,
            logo ,
            set,
            home,
            mail,
            isActive: true ,
            cokie: document.cookie.split('; ')[0].split('=')[1] ,
            cat:'spam' ,
            resp: null,
        }
    } ,
    methods: {
        mn: function() {
            this.isActive ? this.isActive = false : this.isActive = true;
        } ,
        go :function(e) {
            
            if(e.toElement.classList[1] == 'home') {
                this.isActive = false;
                this.mn();
                router.push('/msg');
            } 
            if(e.toElement.classList[1] == 'msg') {
                this.isActive = false;
                this.mn();
                this.isActive = false;
                router.push('/acces');
            }
            if(e.toElement.classList[1] == 'set') {
                this.isActive = false;
                this.mn();
                this.isActive = false;
                router.push('/');
            }
        },
        giveMSg:  function() {
                 axios.post('https://bsl-show.ru/api/userAgent.php' , this.data ,  {
                        headers : { 'Content-Type' : 'multipart/form-data axios'} 
                    })
                    .then(response => {
                        console.log(response.data);
                    })
        }
    } ,
    watch: {
       
    } , 
    mounted() {
        console.log(this.data = {'type': this.cat, 'ts': this.cokie })
       // console.log(this.data = {'type':'spam', 'ts':'andrei'})
        //console.log(this.data);
            axios.post('https://bsl-show.ru/api/userMsg.php' , this.data ,  {
                        headers : { 'Content-Type' : 'multipart/form-data axios'} 
                    })
                    .then(response => {
                        this.resp = response.data;
                        console.log(response.data);  
                    })
    }
}
</script>

<style lang="scss">

    body {
       overflow: hidden;
    }
    .wrapper-row {
        display: flex;
        flex: 1 1 auto;
        min-width: 100vw;
        min-height: 100%;
        overflow-x: hidden;
        max-width: 100vw;
        max-height: 100vh;
    }
    .menu {
        display: flex;
        flex-direction: column;
        justify-content: space-between;
        width: 135px;
        min-height: 100vh;
        background: #31C967;
        border-radius: 0px;
            &__slide {
                transition: 0.5s;
                background: #31C967;
                position: absolute;
                display: flex;
                flex-direction: column;
                    img {
                        margin-left: 20px;
                    }
            }
    }

    .active {
        opacity: 0;
        transition: 0.5;
        transform: translateX(-100%);
    }

    .active__menu {
        transition: 0.4s;
        opacity: 0;
    }

    .static {
        width: 50px;
        height: 50px;
        margin: 50px auto;
        cursor: pointer;
        transition: 0.6s;
    }
    .logo {
        margin: 40px auto;
    }

    .left {
        ::-webkit-scrollbar { width: 5px; height: 8px;}
        ::-webkit-scrollbar-track {  background-color: #999;}
        ::-webkit-scrollbar-track-piece { background-color: #ffffff;}
        ::-webkit-scrollbar-thumb { height: 50px; background-color: #666; border-radius: 3px;}
        ::-webkit-scrollbar-corner { background-color: #999;}
        ::-webkit-resizer { background-color: #666;}
        overflow: hidden;
        background: #3C3F48;
        display: flex;
        flex: 1 1 auto;
        flex-direction: column;
        min-height: 100vh;
        max-width: 339px;
            &__catr {
                display: flex;
                flex-direction: row;
                width: 339px;
                background: #3C3F48;
                height: 90px;
                    &-ca {
                        width: 113px;
                    }
                border-bottom: 2px solid black;

            }
        &__column {
           // overflow-y: scroll;
            overflow-x: hidden;
            min-height: 100vh;
            max-height: 100vh;
        }
        &__contacts {
            //overflow-y: scroll;
            max-height: 100vh;
        }
        &__row {
            margin: 5px auto;
            //border-bottom: 1px solid #000000;
            box-sizing: border-box;
            border-radius: 5px;
            display: flex;
            width: 330px;
            height: 90px;
            background: #4B4F5A;
               &-right {
                   p:nth-child(1) {
                       margin-bottom: 10px;
                       font-weight: normal;
                        font-size: 24px;
                        line-height: 28px;
                        color: #FFFFFF;
                   }
                   p:nth-child(2) {
                       font-weight: 300;
                        font-size: 18px;
                        line-height: 21px;
                        color: #FFFFFF;
                        margin-bottom: 20px;
                   }
                   margin: 15px 20px;
               }
               &-left {
                   img {
                        background: #C4C4C4;
                        width: 70px;
                        height: 70px;
                        margin: 10px;
                        border-radius: 50px;
                   }
               }
        }
    }
    .right {
        ::-webkit-scrollbar { width: 5px; height: 8px;}
        ::-webkit-scrollbar-track {  background-color: #999;}
        ::-webkit-scrollbar-track-piece { background-color: #ffffff;}
        ::-webkit-scrollbar-thumb { height: 50px; background-color: #666; border-radius: 3px;}
        ::-webkit-scrollbar-corner { background-color: #999;}
        ::-webkit-resizer { background-color: #666;}
        background: #EEEFF3;
        display: flex;
        flex-direction: column;
        flex: 1 1 auto;
            &__send {
                background: white;
                display: flex;
                flex: 1 1 auto;
                max-height: 130px ;
                &-fr {
                    margin: auto;
                    max-height: 55px;
                    display: flex;
                    justify-content: space-between;
                }
                    input {
                        padding-left: 50px;
                        width: 572px;
                        height: 55px;
                        box-sizing: border-box;
                        border-radius: 20px;
                        border: 1px solid #000000;
                        font-weight: 300;
                        font-size: 36px;
                        line-height: 42px;
                        transition: 0.4s;
                        color: #000000;
                    }
                    input:hover {
                        transition: 0.6s;
                        box-shadow: 0px 4px 5px 4px rgba(0, 0, 0, 0.25);
                    }
                    input:focus {
                        transition: 0.5s;
                         box-shadow: 0px 4px 5px 4px rgba(0, 0, 0, 0.35);
                    }
                    button {
                        transition: 0.4s;
                        margin-left: 20px;
                        border: 1px solid #000000;
                        width: 161px;
                        height: 55px;
                        background: #FFFFFF;
                        box-sizing: border-box;
                        border-radius: 20px;
                        font-weight: 300;
                    font-size: 24px;
                    line-height: 28px;

                    color: #000000;
                    }
                    button:hover {
                        transition: 0.6s;
                        box-shadow: 0px 4px 5px 4px rgba(0, 0, 0, 0.25);
                    }
            }
            &__msg {
                margin: 60px 0px 60px 0px ;
                display: flex;
                flex-direction: column;
                flex: 1 1 auto;
                overflow-y: scroll;
            }
            &__column {
                margin: 20px auto;
                 justify-content: center;
            }
            &__row {
                margin-top: 50px;
                justify-content: left;
                display: flex;
                &-avatar {
                    margin-right: 15px;
                    margin-left: 15px ;
                    img {
                        width: 102px;
                        height: 102px;
                        border-radius: 50px;
                    }
                    p {
                        margin-top: 5px;
                    }
                    text-align: center;
                }
                &-text {
                    padding: 20px;
                    display: flex;
                    justify-content: space-between;
                    background: #FFFFFF;
                    border-radius: 20px;
                    width: 572px;
                    min-height: 110px;
                    height: 100%;
                        p:nth-child(1) {
                            font-weight: 300;
                            font-size: 18px;
                            line-height: 21px;
                            /* identical to box height */
                            color: #000000;
                        }
                }
            }
    }

</style>