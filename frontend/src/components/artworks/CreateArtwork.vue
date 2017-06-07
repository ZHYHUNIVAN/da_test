<template>
  <div class="container">
    <form @submit.prevent="createArtwork()" enctype="multipart/form-data">
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
        <label class="col-sm-2 col-form-label">ArtistID</label>
        <div class="col-sm-10">
          <v-select id="add-artist-id"
                    :value.sync="artwork.artist_id" :options="artistIds">
          </v-select>
        </div>
        <div class="form-group has-error" v-if="errors.artist" v-for="error in errors.artist">
          <label class="control-label">
            {{ error }}
          </label>
        </div>
      </div>
      <div v-if="isFailed">
        <h2>Uploaded failed.</h2>
        <p>
          <a href="javascript:void(0)" @click="reset()">Try again</a>
        </p>
        <span v-for="error in uploaderErrors">
          <pre>
            File {{ error.filename }}
            <span v-for="message in error.messages">
              {{ message }}
            </span>
          </pre>
        </span>
      </div>
      <div class="dropbox">
        <input ref='filesUpload' type="file" multiple :disabled="isSaving || isFailed"
               @change="filesChange($event.target.files); fileCount = $event.target.files.length"
               accept="image/*" class="input-file">
        <p v-if="isInitial">
          Drag your file(s) here to begin<br> or click to browse
        </p>
        <p v-if="isSaving">
          Uploading {{ fileCount }} files...
        </p>
      </div>

      <button type=”submit” class="btn btn-primary">Create</button>
      <router-link to="/" class="btn btn-default">Cancel</router-link>
    </form>
  </div>
</template>

<script>
  /* eslint-disable */
  import vSelect from "vue-select"
  import httpClient from '../../utils/backend-api';

  const STATUS_INITIAL = 0, STATUS_SAVING = 1, STATUS_SUCCESS = 2, STATUS_FAILED = 3;

  export default {
    name: 'CreateArtwork',
    components: { vSelect },
    data() {
      return {
        artwork: {
          title: '',
          description: '',
          price: '',
          artist_id: '',
        },
        artistIds: [],
        currentStatus: null,
        uploadedFiles: [],
        errors: {},
        uploaderErrors: [],
      };
    },
    computed: {
      isInitial() {
        return this.currentStatus === STATUS_INITIAL;
      },
      isSaving() {
        return this.currentStatus === STATUS_SAVING;
      },
      isSuccess() {
        return this.currentStatus === STATUS_SUCCESS;
      },
      isFailed() {
        return this.currentStatus === STATUS_FAILED;
      },
    },
    methods: {
      getArtistIds() {
        const config = {
          params: { 'ids': 'true' }
        };
        httpClient.getArtists('', config).then((response) => {
          for (const id of response.ids) {
            this.artistIds.push(id.toString());
          };
        });
      },
      reset() {
        // reset form files to initial state
        this.$refs.filesUpload.value = null;
        this.currentStatus = STATUS_INITIAL;
        this.uploadedFiles = [];
        this.uploaderErrors = [];
      },
      createArtwork() {
        const formData = new FormData();
        for (let key in this.artwork) {
          formData.append('artwork[' + key + ']', this.artwork[key]);
        };

        for (var i = 0; i < this.uploadedFiles.length; i++) {
          let file = this.uploadedFiles[i];

          formData.append('images[]', file, file.name);
        };

        const config = {
          headers: { 'content-type': 'multipart/form-data' }
        };
        httpClient.createArtwork(formData, config).then((response) => {
          this.currentStatus = STATUS_SUCCESS;
          this.artwork = response;
          this.$router.push(`/artworks/${response.id}`);
        }).catch((error) => {
          this.currentStatus = STATUS_FAILED;
          this.uploaderErrors = error.response.data.image_errors;
          this.errors = error.response.data.errors;
        });
      },
      filesChange(fileList) {
        this.currentStatus = STATUS_SAVING;
        // handle file changes
        if (!fileList.length) return;
        this.uploadedFiles = fileList;
      },
    },
    mounted() {
      this.getArtistIds();
      this.reset();
    },
  };
</script>

<style scoped>
  .dropbox {
    outline: 2px dashed grey;
    /* the dash box */
    outline-offset: -10px;
    background: lightcyan;
    color: dimgray;
    padding: 10px 10px;
    min-height: 200px;
    /* minimum height */
    position: relative;
    cursor: pointer;
  }

  .input-file {
    opacity: 0;
    /* invisible but it's there! */
    width: 100%;
    height: 200px;
    position: absolute;
    cursor: pointer;
  }

  .dropbox:hover {
    background: lightblue;
    /* when mouse over to the drop zone, change color */
  }

  .dropbox p {
    font-size: 1.2em;
    text-align: center;
    padding: 50px 0;
  }
</style>
