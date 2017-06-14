<template xmlns:v-on="http://www.w3.org/1999/xhtml">
  <div class="container-fluid">
    <!-- Modal -->
    <div v-if="updatedArtwork" class="modal fade" id="myModal" role="dialog">
      <div class="modal-dialog">

        <!-- Modal content-->
        <div class="modal-content">
          <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal">&times;</button>
            <h4 class="modal-title">Edit Artwork</h4>
          </div>
          <div class="modal-body">
            <form class="form-horizontal">
              <div class="form-group">
                <label for="add-title" class="col-sm-2 col-form-label">Title</label>
                <div class="col-sm-10">
                  <input class="form-control" id="add-title" placeholder="Title" v-model="updatedArtwork.title" required/>
                </div>
                <div class="form-group has-error" v-if="errors.title" v-for="error in errors.title">
                  <label class="control-label" for="add-title">
                    {{ error }}
                  </label>
                </div>
              </div>
              <div class="form-group">
                <label for="add-description" class="col-sm-2 col-form-label">Description</label>
                <div class="col-sm-10">
                  <textarea class="form-control" id="add-description" rows="5"
                    placeholder="Description" v-model="updatedArtwork.description" required/>
                </div>
                <div class="form-group has-error" v-if="errors.description" v-for="error in errors.description">
                  <label class="control-label" for="add-description">
                    {{ error }}
                  </label>
                </div>
              </div>
              <div class="form-group">
                <label for="add-price" class="col-sm-2 col-form-label">Price</label>
                <div class="col-sm-10">
                  <input type="number" step=0.01 class="form-control" id="add-price"
                         placeholder="Price" v-model="updatedArtwork.price" required/>
                </div>
                <div class="form-group has-error" v-if="errors.price" v-for="error in errors.price">
                  <label class="control-label" for="add-price">
                    {{ error }}
                  </label>
                </div>
              </div>
              <div class="form-group">
                <label class="col-sm-2 col-form-label">Width</label>
                <div class="col-sm-10">
                  <input type="number" class="form-control" id="add-width"
                         placeholder="Width" v-model="updatedArtwork.dimensions.width" required/>
                </div>
                <div class="form-group has-error" v-if="errors.width" v-for="error in errors.width">
                  <label class="control-label">
                    {{ error }}
                  </label>
                </div>
              </div>
              <div class="form-group">
                <label class="col-sm-2 col-form-label">Height</label>
                <div class="col-sm-10">
                  <input type="number" class="form-control" id="add-height"
                         placeholder="Height" v-model="updatedArtwork.dimensions.height" required/>
                </div>
                <div class="form-group has-error" v-if="errors.height" v-for="error in errors.height">
                  <label class="control-label">
                    {{ error }}
                  </label>
                </div>
              </div>
              <div class="form-group">
                <label class="col-sm-2 col-form-label">Depth</label>
                <div class="col-sm-10">
                  <input type="number" class="form-control" id="add-depth"
                         placeholder="Depth" v-model="updatedArtwork.dimensions.depth" required/>
                </div>
                <div class="form-group has-error" v-if="errors.depth" v-for="error in errors.depth">
                  <label class="control-label">
                    {{ error }}
                  </label>
                </div>
              </div>
            </form>
          </div>
          <div class="modal-footer">
            <button @click.prevent="updateArtwork($event)" class="btn">Update</button>
            <button type="button" class="btn" data-dismiss="modal">Close</button>
          </div>
        </div>

      </div>
    </div>

    <div class="container-fluid">
      <div class="jumbotron">
        <p>{{ artwork.description }}</p>
      </div>
      <div class="row">
        <!--left content with dropzone-->
        <div class="col-xs-6 artwork-info">
          <div class="panel panel-default">
            <div class="panel-heading artwork-info-head">
              <div class="col-xs-11 pull-left">
                <h3 class="panel-title"> Artist: {{ artist.name }}</h3>
                <h3 class="panel-title"> Title: {{ artwork.title }} </h3>
                <h3 class="panel-title"> Price: {{ artwork.price }} $ </h3>
              </div>
              <div class="col-xs-1 artwork-publisher">
                <button type="button" class="btn btn-default btn-sm pull-right"
                        v-if="artwork.state === 'published'"
                        v-on:click='unpublishArtwork(artwork.id)'>
                  <span class="glyphicon glyphicon-star"
                        aria-hidden="true">
                  </span>
                </button>
                <button type="button" class="btn btn-default btn-sm pull-right"
                        v-else v-on:click='publishArtwork(artwork.id)'>
                  <span class="glyphicon glyphicon-star-empty" aria-hidden="true">
                  </span>
                </button>
              </div>
            </div>
            <div class="panel-body">
              <div class="dropzone" id="artworkDropzone" multiple></div>
              <div class="clearfix"></div>
            </div>
          </div>
        </div>

        <!--right content with carousel-->
        <div class="col-xs-6 artwork-info">
          <div id="carousel-example-generic" class="carousel slide" data-ride="carousel">
            <!-- Wrapper for slides -->
            <div class="carousel-inner" role="listbox">

              <div v-if="imagesAny" class="item"
                   v-for="(image, index) in artwork.images"
                   :class="{ 'active': !index }">
                <img :src="image.file.show.url"/>
              </div>
              <!--<div v-else>-->
              <div v-else class="item active">
                <img src="../../assets/fallback.jpeg"/>
              </div>
              <!--</div>-->
            </div>

            <div v-if="imagesAny && artwork.images.length > 1">
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
        </div>
      </div>
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
        artwork: {
          images: [],
        },
        updatedArtwork: null,
        artist: '',
        errors: [],
      };
    },
    computed: {
      imagesAny() {
        return !!this.artwork.images.length;
      },
    },
    methods: {
      payloadArtwork() {
        const artw = this.updatedArtwork;
        return {
          artwork: {
            title: artw.title,
            description: artw.description,
            price: artw.price,
            width: artw.dimensions.width,
            height: artw.dimensions.height,
            depth: artw.dimensions.depth
          }
        };
      },
      updateArtwork() {
        this.errors = [];
        httpClient.updateArtwork(this.$route.params.id, this.payloadArtwork()).then((response) => {
          $('#myModal').modal('toggle');
          this.artwork = response;
          this.updatedArtwork = JSON.parse(JSON.stringify(response));
        }).catch((error) => {
          console.log(error);
          this.errors = error.response.data.errors;
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
          paramName: "image", // The name that will be used to transfer the file
          maxFilesize: 10, // MB
          acceptedFiles: 'image/*',
          addRemoveLinks: true,
          init: function() {
            this.on("success", function(file, response) {
              this.removeFile(file);
              vm.artwork.images = response.images;
            });

            this.on("error", function(file, response) {
              for (let error of response.image_errors) {
                console.log(error);
                console.log(file.name);
                if(file.name === error.filename) {
                  this.defaultOptions.error(file, error.messages);
                };
              };
            });
          },
        });
      },
    },
    beforeMount() {
      httpClient.getArtworks(this.$route.params.id).then((artwork) => {
        this.artwork = artwork;
        this.updatedArtwork = JSON.parse(JSON.stringify(artwork));
        this.artist = artwork.artist;
      }).then(() => {
        this.initDropzone();
      });
    },
  };
</script>

<style scoped>
  .modal-footer .btn {
    -webkit-transition-duration: 0.4s; /* Safari */
    transition-duration: 0.4s;
    border-radius: 3px;
    background-color: #555555;
    color: white;
  }
  .modal-footer .btn:hover {
    background-color: #aeaf19; /* Green */
    color: white;
  }
  .jumbotron {
    /*padding-top: 0px;*/
    margin: 0px;
  }
  .artwork-info {
    height: 370px;
  }
  .artwork-info-head {
    height: 90px;
  }
  .artwork-publisher {
    height: 100%;
    display: flex;
    justify-content: flex-end;
  }
  .artwork-publisher button {
    align-self: center;
  }
  .carousel-inner .item img{
    width: 100%;
  }
  .artwork-info .panel, .artwork-info .carousel, .artwork-info .carousel .carousel-inner {
    height: 100%;
  }
  button {
    outline: none;
  }
  .dropzone {
    border: 4px dashed rgba(150, 150, 150, .4);
    height: 250px;
  }
  .dropzone span {
    font-size: 18px;
    font-weight: bold;
    color: rgba(150, 150, 150, .6);
  }
  .dropzone .dz-preview .dz-error-message {
    top: 150px;
  }
  .container-fluid .row {
    height: 450px;
    display: flex;
    align-items: center;
  }
  .flex-item img {
    width: 100%;
    display: block;
  }
</style>
