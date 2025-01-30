// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"
import "@popperjs/core"
import "bootstrap"

import $ from 'jquery';
import 'select2';

$(document).on('turbo:load', function() {
  $('.select2').select2({
    width: '100%',
    placeholder: "Search for a book...",
    allowClear: true
  });
});
