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
//= require bootstrap-sprockets
//= require popper
//= require_tree .

// 基本機能の内容を順々に表示する
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

$(function(){
   // inputのidから情報の取得
   $('#user_profile_image').on('change', function (e) {
      // ここから既存の画像のurlの取得
      var reader = new FileReader();
      reader.onload = function (e) {
         $(".profile_image").attr('src', e.target.result);
         }
      // ここまで
      reader.readAsDataURL(e.target.files[0]); //取得したurlにアップロード画像のurlを挿入
   });
});

// Google Maps API
$(function(){
   var map;
   function initMap() {

      // マップの表示
      var myLatLng = {lat: 35.658449, lng: 139.702172}; // 緯度・経度の指定
      map = new google.maps.Map(document.getElementById('map'), {
         center: {lat: 35.658449, lng: 139.702172},
         zoom: 14
      });

      // マーカーの表示
      var marker = new google.maps.Marker({
         position: myLatLng,
         map: map,
         animation: google.maps.Animation.DROP
      });
   }
   initMap();
});

// （API_KEY には、"取得したAPIキー" を記述）
API_KEY = "a8938ff23701e0f370434bc5009bb076";

$(function(){
   $('#btn').on('click',function() {
      // 入力された都市名でWebAPIに天気情報をリクエスト
      $.ajax({
         url: "http://api.openweathermap.org/data/2.5/weather?q=" + $('#cityname').val() + "&units=metric&appid=" + "a8938ff23701e0f370434bc5009bb076",
         dataType : 'jsonp',
      }).done(function (data){
         //通信成功
         // 位置
         $('#place').text(data.name);
         // 最高気温
         $('#temp_max').text(data.main.temp_max);
         // 最低気温
         $('#temp_min').text(data.main.temp_min);
         // 湿度
         $('#humidity').text(data.main.humidity);
         // 風速
         $('#speed').text(data.wind.speed);
         // 天気
         $('#weather').text(data.weather[0].main);
         // 天気アイコン
         $('#img').attr("src","http://openweathermap.org/img/w/" + data.weather[0].icon + ".png");
         $('#img').attr("width","25");
         $('#img').attr("height","25");
         $('#img').attr("alt",data.weather[0].main);
      }).fail(function (data){
         //通信失敗
         alert('通信に失敗しました。');
      });
   });
});

$(function() {
   // #back内の<a>タグがクリックされたときの処理
   $('#back a').on('click',function(event){
      $('body, html').animate({
        scrollTop:0
      }, 800);
      event.preventDefault();
   });
});

// タブメニュー
// DOMContentLoaded == DOMツリーの構築が完了
document.addEventListener('DOMContentLoaded' , function(){
	// タブに対してクリックイベントを適用
	const tabs = document.getElementsByClassName('tab'); // 指定したclass名の要素の集合（HTMLCollection）を取得
	for(let i = 0; i < tabs.length; i++) { // 全てのタブ（classにtabの値をもつ要素）に対して、addEventListenerメソッドでクリックイベントを適用
		tabs[i].addEventListener('click', tabSwitch);
	}

	// タブをクリックすると実行する関数
	function tabSwitch(){
		// タブのclassの値を変更
		document.getElementsByClassName('is-active')[0].classList.remove('is-active'); // classの値is-activeをもつタブに対し、is-activeの値を削除
		this.classList.add('is-active'); // クリックしたタブに対してclassの値is-activeを追加
      // コンテンツのclassの値を変更
      // コンテンツ（classにpanelの値をもつ要素）の中で、classの値is-show（display:block;を適用）をもつ要素に対し、is-showの値を削除し非表示
		document.getElementsByClassName('is-show')[0].classList.remove('is-show'); 
		const arrayTabs = Array.prototype.slice.call(tabs); // 要素の集合を配列に変換
		const index = arrayTabs.indexOf(this); // 配列から指定した要素の順序(インデックス番号)を取得
		document.getElementsByClassName('panel')[index].classList.add('is-show'); // その番号を利用して指定したコンテンツに対し、classの値is-showを追加
	};
});
