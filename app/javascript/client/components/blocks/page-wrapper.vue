<template>
    <div id="page_wrapper" class="v-application--wrap">

<!--            side menu: -->
<!--        <v-navigation-drawer app>-->
<!--            &lt;!&ndash; &ndash;&gt;-->
<!--        </v-navigation-drawer>-->

        <v-app-bar app color="white">
<!--            burger: -->
<!--            <v-app-bar-nav-icon></v-app-bar-nav-icon>-->

            <v-toolbar-title style="display:contents;">
                <router-link to="/" style="text-decoration: none; display:contents;">
                    <v-avatar color="primary" size="40">
                        <img src="~images/xo_monster_logo.png" alt="XO Monster"/>
                    </v-avatar>
                    <v-toolbar-title class="pl-3" style="">
                        XO Monster
                    </v-toolbar-title>
                </router-link>
            </v-toolbar-title>

            <v-spacer></v-spacer>

            <navigation></navigation>
        </v-app-bar>

        <v-main>
            <component :is="wraps" v-bind="$attrs" v-on="$listeners"></component>
        </v-main>
    </div>
</template>

<script>
    export default {
        inheritAttrs: false, // optional
        props: ['wraps']
    }
</script>