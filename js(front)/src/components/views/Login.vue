<template>
    <div class="wrapper lgn">
        <div class="box">
            <p class="box__logo">Вход</p>
            <input type="text" placeholder="login" v-model="login">
            <input type="password" placeholder="passwod" v-model="password">
            <p v-if="errors.is == false" class="box__error">Есть пустые поля</p>
            <p v-if="errors.er == false" class="box__error">Неправеотный логин или пароль</p>
            <button v-on:click="checkform">Войти</button>
         
        </div>
    </div>
</template>


<script>
// eslint-disable-next-line no-unused-vars
import axios from 'axios';
import router from '../../router'
export default {
    name: 'app',
    data() {
        return {
            errors: {
                'is': null,
                'er': null,
            },
            router,
            login:null ,
            password:null ,
            data: {},
            resp: null,
            cokie: null
        }
    },
    methods: {
        checkform: async function() {
                if(this.login && this.password) {
                    if(this.cokie == null || this.cokie == undefined || this.cokie == '' ) {
                    console.log('asfsf');
                    this.errors.is = true;
                    this.data = {'login':this.login , 'pass':this.password}
                        await axios.post('https://bsl-show.ru/api/userAgent.php' , this.data ,  {
                            headers : { 'Content-Type' : 'multipart/form-data axios'} 
                            })
                        .then(response => {
                            this.resp = response.data; 
                            
                        })
                            if(this.resp.status) {
                                console.log(this.resp.login);
                                document.cookie = 'user='+this.resp.login;
                        
                            } else {
                                this.errors.er = false;
                            }
                } else {
                    router.push('/msg');
                }
            }  else {
                this.errors.is = false;
            }
        }
    }, 
    mounted() {
            this.cokie = document.cookie.split('; ')[0].split('=')[0]
            if(this.cokie != null && this.cokie != undefined && this.cokie != '') {
                router.push('/msg');
            }
    }
}
</script>


<style lang="scss">

    .lgn {
        background: #EEEFF3;
    }
    .box {
        display: flex;
        flex-direction: column;
        margin: auto;
        width: 470px;
        height: 376px;
        text-align: center;
        background: #FFFFFF;
        border-radius: 22px;
            &__logo {
                font-size: 38px;
                line-height: 56px;

                color: #000000;
                margin-top: 30px;
                margin-bottom: 40px;
            }
            input {
                font-size: 20px;
                line-height: 35px;
                padding-left: 10px;
                color: #000000;

                margin-left: auto;
                margin-right: auto;
                width: 300px;
                min-height: 40px;
                margin-bottom: 40px;
                background: rgba(196, 196, 196, 0);
                border: 1px solid #000000;
                box-sizing: border-box;
                border-radius: 5px;
            }
            input[type='password']  {
                margin-bottom: 20px;
            }
            input:hover {
            transition: 0.5s;
            box-shadow: 0px 4px 26px 2px rgba(67, 59, 59, 0.68)
            }
            input:focus {
                transition: 0.6s;
                box-shadow: 0px 4px 22px 4px rgba(49, 201, 103, 0.37);
            }
            button {
                width: 283px;
                height: 58px;
                margin-left: auto;
                margin-right: auto;
                background: #31C967;
                border-radius: 26px;
                margin-bottom: 30px;
                font-size: 38px;
                line-height: 56px;

                color: #FFFFFF;
            }
            button:hover {
                transition: 0.8s;
                background: #FDCF52;
            }
            &__error {
                margin-bottom: 15px;
                font-size: 18px;
                color: red;
            }
    }
       
</style>