// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require bootstrap
//= require turbolinks
//= require_tree .

function myLocation() {
                /* 객체가 존재하면 */
                if ( navigator.geolocation )
                {
                /* getCurrentPostion 메서드를 호출 ( 위치를 가져오는 핸들러함수를 파라미터로 ) */  
                    navigator.geolocation.getCurrentPosition( successHandler );
                }
                else          
                {
                    alert("not support geolocation");
                }
            }
       
/* 위치정보를 가져오는 사용자정의 핸들러함수 */
function successHandler( position ) {
    latitude = position.coords.latitude; 
    longitude = position.coords.longitude;  
}

window.onload = myLocation;

