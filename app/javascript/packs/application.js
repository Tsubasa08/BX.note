import "src/javascripts/application";
import "src/stylesheets/application";
import "@fortawesome/fontawesome-free/js/all";

// require.context("src/images/", true, /\.(gif|jpg|png|svg|ico)$/);
const images = require.context("src/images", true);
