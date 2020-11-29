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
                    <div class="left__row">
                        <div class="left__row-left">
                            <img src="https://bsl-show.ru/resourse/img/avatar/images222.jpg" alt="">
                        </div>
                        <div class="left__row-right">
                            <p>Имя</p>
                            <p>Привет</p>
                        </div>
                    </div>
                     <div class="left__row">
                        <div class="left__row-left">
                            <img src="https://bsl-show.ru/resourse/img/avatar/images222.jpg" alt="">
                        </div>
                        <div class="left__row-right">
                            <p>Имя</p>
                            <p>Привет</p>
                        </div>
                    </div>
                    
                </div>
            
            </div>
        </div>
        <div class="right">
           <div class="right__box">
               <p>Authorize access to categories</p>
                <div class="right__box-box">
                    <span>select category</span>
                    <div class="right__box-box-ch">
                          <input type="checkbox"> <span>Spam</span>  
                    </div>
                    <div class="right__box-box-ch">
                          <input type="checkbox"> <span>Busness</span> 
                    </div>
                </div>
                <input type="text" placeholder="nick">
                <button>Add user</button>
           </div>
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
                router.push('/');
            }
            if(e.toElement.classList[1] == 'set') {
                this.isActive = false;
                this.mn();
                this.isActive = false;
                router.push('/');
            }
        }
    } ,
    watch: {
       
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
        transition: 0.5;
        transform: translateX(-150%);
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
           &__box {
               display: flex;
               flex-direction: column;
               text-align: center;
               margin: auto;
               input[type='text'] {
                   padding-left: 10px;
                   margin: 15px auto;
                   border: 1px solid #000000;
                    box-sizing: border-box;
                    border-radius: 5px;
                    width: 250.26px;
                    height: 40px;
               }
               button {
                   margin: 15px auto;
                   background: #31C967;
                    border-radius: 26px;
                    font-weight: 300;
                    font-size: 30px;
                    line-height: 35px;
                    width: 244px;
                    height: 50px;
                    color: #FFFFFF;

               }
               p {
                   margin-bottom:45px;
                   font-size: 30px;
                    line-height: 35px;

                    color: #000000;

               }
                &-box {
                    text-align: left;
                    background: #FFFFFF;
                    border-radius: 31px;
                    width: 656px;
                    height: 423px;
                    display: flex;
                    flex-direction: column;
                        span {
                            margin-top: 30px;
                            margin-left: 30px;
                            font-weight: 300;
                            font-size: 30px;
                            line-height: 35px;

                            color: #000000;
                        }
                        input {
                            width: 20px;
                            height: 20px;
                            margin-top: 30px;
                            margin-left: 30px;
                            font-weight: 300;
                            font-size: 30px;
                            line-height: 35px;

                            color: #000000;
                            
                        }
                }
           }
    }

</style>