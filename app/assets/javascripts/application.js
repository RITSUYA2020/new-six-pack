// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require rails-ujs
//= require turbolinks
//= require bootstrap-sprockets
//= require popper
//= require js/lightbox
//= require_tree .

// 機能の内容を順々に表示する
$(function(){
   $(window).on('load scroll', function() {
      var winScroll = $(window).scrollTop();
      var winHeight = $(window).height();
      var scrollPos = winScroll + (winHeight * 0.8);

      $(".show").each(function() {
         if($(this).offset().top < scrollPos) {
            $(this).css({opacity: 1, transform: 'translate(0, 0)'});
         }
      });
   });
});

// トップページへ遷移する
$(function() {
   setTimeout(function(){
      $('.start p').fadeIn(1600);
   },500); //0.5秒後にロゴをフェードイン!
   setTimeout(function(){
      $('.start').fadeOut(500);
   },2500); //2.5秒後にロゴ含め真っ白背景をフェードアウト！
});

// ファイル選択した画像を即時プレビュー表示する
$(function(){
   // inputのidから情報の取得
   $('#work_out_before_image').on('change', function (e) {
      // ここから既存の画像のurlの取得
      var reader = new FileReader();
      reader.onload = function (e) {
         $(".before_image").attr('src', e.target.result);
         }
      // ここまで
      reader.readAsDataURL(e.target.files[0]); //取得したurlにアップロード画像のurlを挿入
   });
});

$(function(){
   // inputのidから情報の取得
   $('#work_out_after_image').on('change', function (e) {
      // ここから既存の画像のurlの取得
      var reader = new FileReader();
      reader.onload = function (e) {
         $(".after_image").attr('src', e.target.result);
         }
      // ここまで
      reader.readAsDataURL(e.target.files[0]); //取得したurlにアップロード画像のurlを挿入
   });
});
