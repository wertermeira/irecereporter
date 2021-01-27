import $ from 'jquery';
import 'owl.carousel2/dist/assets/owl.carousel.css';
import 'owl.carousel2/dist/assets/owl.theme.default.css';
$(function(){
  $('.icon-bar a').on('click',function(){
    $('.categories').removeClass('d-none');
  })
  $('.owl-carousel').owlCarousel({
    loop: false,
    margin: 0,
    nav: false,
    responsive:{
      0:{
          items:2
      },
      600:{
          items:2
      },
      1000:{
          items:4
      }
  }
  })
  $('.times-button').on('click',function(){
    $('.categories').addClass('d-none');
  })
  $.ajax({
    url: '/services/weather',
    type: 'GET',
    contentType: 'application/json; charset=utf-8',
    success: function(resultData) {
      GetIconWeather(resultData.results)
    },
    error : function(jqXHR, textStatus, errorThrown) {
    },
    timeout: 120000,
  });
})

function GetIconWeather(results) {
  var output = ''
  switch (results.condition_slug) {
    case 'storm':
      output = 'poo-storm';
      break;
    case 'hail':
      output = 'snowflake';
      break;
    case 'fog':
      output = 'smog';
      break;
    case 'rain':
      output = 'cloud-showers-heavy';
      break;
    case 'clear_day':
      output = 'sun';
      break;
    case 'clear_night':
      output = 'moon';
      break;
    case 'cloud':
      output = 'cloud';
      break;
    case 'cloudly_day':
      output = 'cloud-sun';
      break;
    case 'cloudly_night':
      output = 'cloud-moon';
      break;
    case 'none_day':
      output = 'sun';
      break;
    case 'none_night':
      output = 'moon';
      break;
    default:
      output = 'sun';
      break;
  }
  $('.header-weather').html("<i class='fa fa-" + output + "'></i><span> " + results.temp + "º" +", Irecê</span>")
}
