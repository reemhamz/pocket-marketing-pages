const path = require("path");
const MiniCssExtractPlugin = require("mini-css-extract-plugin");
const CssMinimizerPlugin = require("css-minimizer-webpack-plugin");
const RemoveEmptyScriptsPlugin = require("webpack-remove-empty-scripts");

const isDevelopment = process.env.NODE_ENV === "development";

const cssConfig = {
  entry: {
    styles: "./static/scss/styles.scss",
  },
  output: {
    // clean: true,
    filename: "temp/[name].js",
    path: path.resolve(__dirname, "static/"),
  },
  optimization: {
    minimizer: [new CssMinimizerPlugin({})],
  },
  module: {
    rules: [
      {
        test: /\.scss$/,
        use: [
          isDevelopment ? "style-loader" : MiniCssExtractPlugin.loader,
          {
            loader: "css-loader",
            options: {
              url: false,
            },
          },
          "sass-loader",
        ],
      },
    ],
  },
  watchOptions: {
    aggregateTimeout: 600,
    ignored: "./node_modules/",
  },
  performance: {
    hints: "warning",
  },
  plugins: [new RemoveEmptyScriptsPlugin()].concat(
    isDevelopment
      ? []
      : [new MiniCssExtractPlugin({ filename: "css/[name].css" })]
  ),
};

const jsConfig = {
  entry: {
    index: "./static/js/index.js",
  },
  output: {
    filename: "js/[name].bundle.js",
    path: path.resolve(__dirname, "static/"),
  },
  module: {
    rules: [
      {
        test: /\.m?js$/,
        exclude: /(node_modules)/,
        use: {
          loader: "babel-loader",
          options: {
            presets: ["@babel/preset-env"],
          },
        },
      },
    ],
  },
};

module.exports = [cssConfig, jsConfig];
