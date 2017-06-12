<template xmlns:v-on="http://www.w3.org/1999/xhtml">
  <div>
    <h3 class="text-center">Artworks List</h3>
    <hr/>

    <div class="col-sm-4" v-for="artwork in artworks">
      <div class="panel panel-default">
        <div class="panel-heading">
          <h3 class="panel-title pull-left"> {{ artwork.title }} </h3>
          <button type="button" class="btn btn-default btn-xs pull-right"
                  v-if="artwork.state === 'published'"
                  v-on:click='unpublishArtwork(artwork.id)'>
            <span class="glyphicon glyphicon-star"
                  aria-hidden="true">
            </span>
          </button>
          <button type="button" class="btn btn-default btn-xs pull-right"
                  v-else v-on:click='publishArtwork(artwork.id)'>
            <span class="glyphicon glyphicon-star-empty" aria-hidden="true">
            </span>
          </button>
          <div class="clearfix"></div>
        </div>
        <div class="panel-body thumbnail">
          <router-link :to="{ name: 'Artwork', params: { id: artwork.id }}">
            <img v-if="artwork.images && artwork.images.length !== 0" :src="artwork.images[0].file.preview.url">
            <img v-else src="../../assets/fallback.jpeg">
          </router-link>
        </div>
        <div class = "panel-footer"> Artist name: {{ artwork.artist.name }} </div>
        <!--<button v-on:click='removeArtwork(artwork.id)' class="btn btn-danger">Remove</button>-->
      </div>
    </div>
  </div>
</template>

<script>
  /* eslint-disable */
  import httpClient from '../../utils/backend-api';

  export default {
    name: 'Artworks',
    data() {
      return {
        artworks: [],
      };
    },
    methods: {
      publishArtwork(id) {
        httpClient.publishArtwork(id).then(() => {
          this.artworks.forEach((artwork) => {
            if(artwork.id === id)
            {
              artwork.state = 'published';
            }
          });
        });
      },
      unpublishArtwork(id) {
        httpClient.unpublishArtwork(id).then(() => {
          this.artworks.forEach((artwork) => {
            if(artwork.id === id)
            {
              artwork.state = 'unpublished';
            }
          });
        });
      },
      getArtworks() {
        httpClient.getArtworks().then((response) => {
          this.artworks = response;
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
  .thumbnail img {
    height: 300px;
    /*max-width:100%;*/
  }
</style>
