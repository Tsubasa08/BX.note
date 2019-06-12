const { environment } = require("@rails/webpacker");
const webpack = require("webpack");

environment.loaders.get("sass").use.push("import-glob-loader");

environment.plugins.prepend(
  "Provide",
  new webpack.ProvidePlugin({
    $: "jquery",
    jQuery: "jquery",
    jquery: "jquery"
  })
);

module.exports = environment;
