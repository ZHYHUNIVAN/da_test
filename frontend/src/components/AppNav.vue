<template>
  <nav class="navbar navbar-default">
    <div class="container-fluid">
      <div class="navbar-header">
        <router-link to="/" class="navbar-brand"> ArtWorks Gallery </router-link>
      </div>

      <div v-if="$route.name === 'Artworks'" class="navbar-header navbar-right">
        <router-link :to="{ name: 'CreateArtwork'}">
          <span  class="btn navbar-brand">
            Create Artwork
          </span>
        </router-link>
      </div>

      <div v-if="$route.name === 'Artwork'" class="navbar-header navbar-right">
        <span  class="btn navbar-brand" data-toggle="modal" data-target="#myModal">
            Edit Artwork
        </span>
      </div>
    </div>
  </nav>
</template>

<script>
  export default {
    name: 'app-nav',
  };
</script>

<!-- Add "scoped" attribute to limit CSS to this component only -->
<style scoped>
  .navbar-right { margin-right: 0px !important}

  .btn {
    -webkit-transition-duration: 0.4s; /* Safari */
    transition-duration: 0.4s;
    border-radius: 3px;
    background-color: #555555;
    color: white;
  }

  .btn:hover {
    background-color: #aeaf19; /* Green */
    color: white;
  }
</style>
