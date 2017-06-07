<template>
  <div>
    <app-nav></app-nav>
    <h3 class="text-center">Artworks List</h3>
    <hr/>

    <div class="col-sm-4" v-for="artwork in artworks">
      <div class="panel panel-default">
        <div class="panel-heading">
          <h3 class="panel-title"> {{ artwork.title }} </h3>
        </div>
        <div class="panel-body">
          <router-link :to="{ name: 'Artwork', params: { id: artwork.id }}">
            <div class="row">
              <div v-for="image in artwork.images">
                <div class="col-md-4">
                  <div class="thumbnail">
                    <img :src="image.file.preview.url" style="max-width:100%;">
                  </div>
                </div>
              </div>
            </div>
          </router-link>
        </div>
        <button v-on:click='removeArtwork(artwork.id)' class="btn btn-danger">Remove</button>
      </div>
    </div>
  </div>
</template>

<script>
  import AppNav from './../AppNav';
  import httpClient from '../../utils/backend-api';

  export default {
    name: 'Artworks',
    components: {
      AppNav,
    },
    data() {
      return {
        artworks: [],
      };
    },
    methods: {
      getArtworks() {
        httpClient.getArtworks().then((artworks) => {
          this.artworks = artworks;
        });
      },
      removeArtwork(id) {
        httpClient.removeArtwork(id).then(() => {
          this.artworks = this.artworks.filter(e => e.id !== id);
        });
      },
    },
    mounted() {
      this.getArtworks();
    },
  };
</script>

<!-- Add "scoped" attribute to limit CSS to this component only -->
<style scoped>
</style>
