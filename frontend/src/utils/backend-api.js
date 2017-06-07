import axios from 'axios';

const BASE_URL = 'http://localhost:3000';
const ARTWORKS_URL = `${BASE_URL}/api/artworks`;
const ARTISTS_URL = `${BASE_URL}/api/artists`;

export default {
  getArtists(id = '', config = {}) {
    const url = `${ARTISTS_URL}/${id}`;
    return axios.get(url, config).then(response => response.data);
  },

  getArtworks(id = '') {
    const url = `${ARTWORKS_URL}/${id}`;
    return axios.get(url).then(response => response.data);
  },

  /* eslint-disable */
  createArtwork(data, config = {}) {
    const url = `${ARTWORKS_URL}/`;
    return axios.post(url, data, config).then(response => response.data);
  },

  publishArtwork(id) {
    const url = `${ARTWORKS_URL}/${id}/publish`;
    return axios.post(url).then(response => response.data);
  },

  unpublishArtwork(id) {
    const url = `${ARTWORKS_URL}/${id}/unpublish`;
    return axios.post(url).then(response => response.data);
  },

  removeArtwork(id) {
    const url = `${ARTWORKS_URL}/${id}`;
    return axios.delete(url).then(response => response.data);
  },
};
