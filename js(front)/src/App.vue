<template>
  <div id="app">
      <transition name="fade">
         <router-view />
      </transition>
  </div>
</template>

<script>

export default {
  name: 'App',
  components: {

  }
}
</script>

<style>
#app {
    display: flex;
    flex: 1 1 auto;
    min-width: 100vw;
    min-height: 100%;
    overflow: hidden;
}

.fade-enter-active, .fade-leave-active {
  transition: 0.5s;
}
.fade-enter, .fade-leave-to /* .fade-leave-active до версии 2.1.8 */ {
  transition: 0.5s;
  opacity: 0;
}

</style>
