import Vue from 'vue';
import Router from 'vue-router';
import Artworks from '@/components/artworks/Artworks';
import Artwork from '@/components/artworks/Artwork';
import CreateArtwork from '@/components/artworks/CreateArtwork';

Vue.use(Router);

export default new Router({
  mode: 'history',
  routes: [
    {
      path: '/',
      name: 'Artworks',
      component: Artworks,
    },
    {
      path: '/artworks/:id',
      name: 'Artwork',
      component: Artwork,
    },
    {
      path: '/artworks/',
      name: 'CreateArtwork',
      component: CreateArtwork,
    },

  ],
});
