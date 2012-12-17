// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
//= require jquery
//= require jquery_ujs
//= require fancybox
//= require_tree .

$(document).ready(function(){
  $('#slides_five').slides({
    preload: true,
    preloadImage: '/assets/img/loading.gif',
    play: 3000,
    pause: 2500,
    hoverPause: true,
    generatePagination: false
  });

  $('#slides_four').slides({
    preload: true,
    preloadImage: '/assets/img/loading.gif',
    play: 30000,
    pause: 25000,
    hoverPause: true,
    generatePagination: false
  });

  $("a.fancybox").fancybox({
      'href'   : '#inline',
      'titleShow'  : false,
      'transitionIn'  : 'elastic',
      'transitionOut' : 'elastic'
  });

  $('.carousel').carousel();

  $(".youtube_link").click(function() {
    $.fancybox({
      'padding'   : 0,
      'autoScale'   : false,
      'transitionIn'  : 'none',
      'transitionOut' : 'none',
      'title'     : this.title,
      'width'     : 800,
      'height'    : 450,
      'href'      : this.href.replace(new RegExp("watch\\?v=", "i"), 'v/'),
      'type'      : 'swf',
      'swf'       : {
          'wmode'    : 'transparent',
          'allowfullscreen' : 'true'
      }
    });

    return false;
  });
});