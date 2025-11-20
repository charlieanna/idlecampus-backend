// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

require("@rails/ujs").start()
require("turbolinks").start()
require("@rails/activestorage").start()
require("channels")
require("jquery")
require("../resizable_panels")

console.log('Hello from application.js')

// Support component names relative to this directory:
// TEMPORARILY DISABLED TO FIX WEBPACK BUILD ISSUES WITH RECHARTS/ES-TOOLKIT
// Uncomment when resolved:
// var componentRequireContext = require.context("components", true);
// var ReactRailsUJS = require("react_ujs");
// console.log('ReactRailsUJS loaded:', ReactRailsUJS);
// console.log('Component context:', componentRequireContext.keys());
// ReactRailsUJS.useContext(componentRequireContext);



// Uncomment to copy all static images under ../images to the output folder and reference
// them with the image_pack_tag helper in views (e.g <%= image_pack_tag 'rails.png' %>)
// or the `imagePath` JavaScript helper below.
//
// const images = require.context('../images', true)
// const imagePath = (name) => images(name, true)
