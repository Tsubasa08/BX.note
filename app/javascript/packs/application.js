import "@fortawesome/fontawesome-free/js/all";
import "src/javascripts/application";
import "src/stylesheets/application";
import "slick-carousel/slick/slick";
import "slick-carousel/slick/slick-theme.scss";
import "slick-carousel/slick/slick.scss";
import Rails from "rails-ujs";
Rails.start();

// require.context("src/images/", true, /\.(gif|jpg|png|svg|ico)$/);
const images = require.context("src/images", true);
