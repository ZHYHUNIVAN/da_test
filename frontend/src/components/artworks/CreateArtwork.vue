<template xmlns:v-bind="http://www.w3.org/1999/xhtml">
  <div class="container">
    <form @submit.prevent="createArtwork()">
      <div class="form-group row">
        <label for="add-title" class="col-sm-2 col-form-label">Title</label>
        <div class="col-sm-10">
          <input class="form-control" id="add-title" placeholder="Title" v-model="artwork.title" required/>
        </div>
        <div class="form-group has-error" v-if="errors.title" v-for="error in errors.title">
          <label class="control-label" for="add-title">
            {{ error }}
          </label>
        </div>
      </div>
      <div class="form-group row">
        <label for="add-description" class="col-sm-2 col-form-label">Description</label>
        <div class="col-sm-10">
          <textarea class="form-control" id="add-description" rows="5"
                    placeholder="Description" v-model="artwork.description" required/>
        </div>
        <div class="form-group has-error" v-if="errors.description" v-for="error in errors.description">
          <label class="control-label" for="add-description">
            {{ error }}
          </label>
        </div>
      </div>
      <div class="form-group row">
        <label for="add-price" class="col-sm-2 col-form-label">Price</label>
        <div class="col-sm-10">
          <input type="number" step=0.01 class="form-control" id="add-price"
                 placeholder="Price" v-model="artwork.price" required/>
        </div>
        <div class="form-group has-error" v-if="errors.price" v-for="error in errors.price">
          <label class="control-label" for="add-price">
            {{ error }}
          </label>
        </div>
      </div>
      <div class="form-group row">
        <label class="col-sm-2 col-form-label">Artist</label>
        <div class="col-sm-10">
          <select v-model="artwork.artist_id" class="form-control">
            <option disabled value="">Please select an artist</option>
            <option v-for="artist in artists" v-bind:value="artist.id">
              {{ artist.name }}
            </option>
          </select>
        </div>
        <div class="form-group has-error" v-if="errors.artist" v-for="error in errors.artist">
          <label class="control-label">
            {{ error }}
          </label>
        </div>
      </div>
      <div class="form-group row">
        <label class="col-sm-2 col-form-label">Width</label>
        <div class="col-sm-10">
          <input type="number" class="form-control" id="add-width"
                 placeholder="Width" v-model="artwork.width" required/>
        </div>
        <div class="form-group has-error" v-if="errors.width" v-for="error in errors.width">
          <label class="control-label">
            {{ error }}
          </label>
        </div>
      </div>
      <div class="form-group row">
        <label class="col-sm-2 col-form-label">Height</label>
        <div class="col-sm-10">
          <input type="number" class="form-control" id="add-height"
                 placeholder="Height" v-model="artwork.height" required/>
        </div>
        <div class="form-group has-error" v-if="errors.height" v-for="error in errors.height">
          <label class="control-label">
            {{ error }}
          </label>
        </div>
      </div>
      <div class="form-group row">
        <label class="col-sm-2 col-form-label">Depth</label>
        <div class="col-sm-10">
          <input type="number" class="form-control" id="add-depth"
                 placeholder="Depth" v-model="artwork.depth" required/>
        </div>
        <div class="form-group has-error" v-if="errors.depth" v-for="error in errors.depth">
          <label class="control-label">
            {{ error }}
          </label>
        </div>
      </div>

      <button type=”submit” class="btn btn-primary">Create</button>
      <router-link to="/" class="btn btn-default">Cancel</router-link>
    </form>
  </div>
</template>

<script>
  /* eslint-disable */
  import httpClient from '../../utils/backend-api';

  export default {
    name: 'CreateArtwork',
    data() {
      return {
        artwork: {
          title: '',
          description: '',
          price: '',
          artist_id: '',
          width: '',
          height: '',
          depth: ''
        },
        artists: [],
        errors: {},
      };
    },
    methods: {
      getArtists() {
        httpClient.getArtists('').then((response) => {
          this.artists = response;
        });
      },
      createArtwork() {
        const formData = new FormData();
        for (let key in this.artwork) {
          formData.append('artwork[' + key + ']', this.artwork[key]);
        };

        httpClient.createArtwork(formData).then((response) => {
          this.artwork = response;
          this.$router.push(`/artworks/${response.id}`);
        }).catch((error) => {
          this.errors = error.response.data.errors;
        });
      },
    },
    mounted() {
      this.getArtists();
    },
  };
</script>

<style scoped>

</style>
