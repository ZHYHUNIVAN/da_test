<template xmlns:v-on="http://www.w3.org/1999/xhtml">
  <div class="container-fluid">
    <button type="button" class="btn btn-info btn-lg" data-toggle="modal" data-target="#myModal">Open Modal</button>

    <!-- Modal -->
    <div class="modal fade" id="myModal" role="dialog">
      <div class="modal-dialog">

        <!-- Modal content-->
        <div class="modal-content">
          <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal">&times;</button>
            <h4 class="modal-title">Modal Header</h4>
          </div>
          <div class="modal-body">
            <p>Some text in the modal.</p>
          </div>
          <div class="modal-footer">
            <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
          </div>
        </div>

      </div>
    </div>

    <div class="bg-info">
      <div class="container-fluid">
        <div class="col-xs-2">
          <h3 class="panel-title"> {{ artwork.title }} </h3>
          <h3 class="panel-title"> {{ artwork.description }} </h3>
          <h3 class="panel-title"> {{ artwork.price }} $ </h3>
          <h3 class="panel-title"> Artist name: {{ artist.name }}</h3>
        </div>
        <div class="col-xs-8"></div>
        <div class="col-xs-2">
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
        </div>
      </div>
      <div class="dropzone" id="artworkDropzone" multiple>
      </div>

      <div class="clearfix"></div>
    </div>

    <div id="carousel-example-generic" class="carousel slide" data-ride="carousel" style="width: 60%; margin: 0 auto;">
      <!-- Wrapper for slides -->
      <div class="carousel-inner" role="listbox">
        <div class="item" v-for="(image, index) in artwork.images" :class="{ 'active': !index }">
          <img :src="image.file.show.url" style="width: 100%"/>
          <div class="carousel-caption">

          </div>
        </div>
      </div>

      <!-- Controls -->
      <a class="left carousel-control" href="#carousel-example-generic" role="button" data-slide="prev">
        <span class="glyphicon glyphicon-chevron-left" aria-hidden="true"></span>
        <span class="sr-only">Previous</span>
      </a>
      <a class="right carousel-control" href="#carousel-example-generic" role="button" data-slide="next">
        <span class="glyphicon glyphicon-chevron-right" aria-hidden="true"></span>
        <span class="sr-only">Next</span>
      </a>
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
          renameFilename: function(filename) {
            console.log(this.images);
            return 'string' + filename;
          },
          init: function() {
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
          },
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
    /*flex-basis: 180px;*/
    margin: 10px;
    /*flex-direction: row;*/
    /*flex-wrap: wrap;*/
    /*justify-content: center;*/
    flex-basis: 300px;
  }

  .flex-item img {
    width: 100%;
    display: block;
  }
</style>
