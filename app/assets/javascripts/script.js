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
			//　湿度
			$('#humidity').text(data.main.humidity);
			//　風速
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