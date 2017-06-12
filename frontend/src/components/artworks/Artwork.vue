<template xmlns:v-on="http://www.w3.org/1999/xhtml">
  <div>
    <div class="panel panel-default">
      <div class="panel-heading">
        <h3 class="panel-title"> {{ artwork.title }} </h3>
        <h3 class="panel-title"> {{ artwork.description }} </h3>
        <h3 class="panel-title"> {{ artwork.price }} $ </h3>
        <h3 class="panel-title"> Artist name: {{ artist.name }}</h3>

        <div class="dropzone" id="artworkDropzone" multiple>
        </div>

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
      <!--<div class="panel-body">-->
        <div class="flex-container">
          <div class="flex-item" v-for="image in artwork.images">
            <img :src="image.file.show.url" />
          </div>
        </div>
      <!--</div>-->
    </div>
  </div>
</template>


<script>
  /* eslint-disable */
  import Dropzone from 'dropzone';
  import httpClient from './../../utils/backend-api';

  Dropzone.options.artworkDropzone = false;

  export default {
    name: 'Artwork',
    data() {
      return {
        showModal: false,
        artwork: '',
        artist: '',
      };
    },
    methods: {
      getArtwork() {
        httpClient.getArtworks(this.$route.params.id).then((artwork) => {
          this.artwork = artwork;
          this.artist = artwork.artist;
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
      initDropzone() {
        let vm = this;
        const artworkDropzone = new Dropzone('#artworkDropzone', {
          url: `http://localhost:3000/api/artworks/${this.$route.params.id}`,
          method: 'put',
          paramName: "images", // The name that will be used to transfer the file
          maxFilesize: 8, // MB
          uploadMultiple: true,
          parallelUploads: 10,
          acceptedFiles: 'image/*',
          addRemoveLinks: true,
          init: function() {
            this.on("sendingmultiple", function(file) {
              console.log(this.files);
            });
            this.on("successmultiple", function(file, response) {
              this.removeAllFiles();
              vm.artwork.images = response.images;
            });

            this.on("error", function(file, response) {
              for (let error of response.image_errors) {
                if(file.name === error.filename) {
                  this.defaultOptions.error(file, error.messages[0]);
                };
              };
            });
          }
        });
      },
    },
    mounted() {
      this.getArtwork();
      this.initDropzone()
    },
  };
</script>

<style>
  .dropzone .dz-preview .dz-error-message {
    top: 150px;
  }

  .flex-container {
    padding: 20px;
    overflow: hidden;
    box-sizing: border-box;
    display: flex;
    flex-direction: row;
    flex-wrap: wrap;
    justify-content: center;

  }

  .flex-item {
    /*display: flex;*/
    /*flex-direction: row;*/
    /*flex-wrap: wrap;*/
    /*justify-content: center;*/
    /*flex-basis: 180px;*/
    margin: 10px;
    flex-basis: 300px;
  }

  .flex-item img {
    width: 100%;
    display: block;
  }
</style>
