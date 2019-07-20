import Rails from "rails-ujs";
global.$ = jQuery;
Rails.start();

import "@fortawesome/fontawesome-free/js/all";
import "src/javascripts/application";
import "src/stylesheets/application";
import "slick-carousel/slick/slick";
import "slick-carousel/slick/slick-theme.scss";
import "slick-carousel/slick/slick.scss";

// require.context("src/images/", true, /\.(gif|jpg|png|svg|ico)$/);
const images = require.context("src/images", true);
