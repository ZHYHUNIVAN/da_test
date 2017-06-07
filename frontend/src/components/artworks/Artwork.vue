<template>
  <div>
    <div class="col-sm-12">
      <div class="jumbotron text-center">
        <router-link class="btn btn-sm btn-success" to="/">Artworks</router-link>
      </div>
    </div>

    <div class="panel panel-default">
      <div class="panel-heading">
        <h3 class="panel-title"> {{ artwork.title }} </h3>
        <h3 class="panel-title"> {{ artwork.description }} </h3>
        <h3 class="panel-title"> {{ artwork.price }} $ </h3>

        <div v-if="artwork.state === 'published'">
          <button type="button" class="btn btn-default btn-xs" v-on:click='unpublishArtwork(artwork.id)'>
            <span class="glyphicon glyphicon-star"
                  aria-hidden="true">
            </span>
          </button>
        </div>
        <div v-else>
          <button type="button" class="btn btn-default btn-xs" v-on:click='publishArtwork(artwork.id)'>
            <span class="glyphicon glyphicon-star-empty" aria-hidden="true">
            </span>
          </button>
        </div>
      </div>
      <div class="panel-body">
        <div class="row">
          <div v-for="image in artwork.images">
            <div class="col-md-4">
              <div class="thumbnail">
                <img :src="image.file.show.url" style="max-width:100%;">
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>


<script>
  import httpClient from '../../utils/backend-api';

  export default {
    name: 'Artwork',
    data() {
      return {
        artwork: '',
      };
    },
    methods: {
      getArtwork() {
        httpClient.getArtworks(this.$route.params.id).then((artwork) => {
          this.artwork = artwork;
        });
      },
      publishArtwork(id) {
        httpClient.publishArtwork(id).then(() => {
          this.artwork.state = 'published';
        });
      },
      unpublishArtwork(id) {
        httpClient.unpublishArtwork(id).then(() => {
          this.artwork.state = 'unpublished';
        });
      },
    },
    mounted() {
      this.getArtwork(this.$route.params.id);
    },
  };
</script>

<!-- Add "scoped" attribute to limit CSS to this component only -->
<style scoped>
</style>
