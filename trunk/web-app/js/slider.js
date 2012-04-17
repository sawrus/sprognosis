$(window).load(function(){
	$('.slider')._TMS({
		show:0,
		pauseOnHover:false,
		prevBu:'.prev',
		nextBu:'.next',
		playBu:'.play',
		duration:600,
		preset:'verticalLines',
		pagination:true,//'.pagination',true,'<ul></ul>'
		pagNums:false,
		slideshow:6000,
		numStatus:false,
		banners:'fromRight',// fromLeft, fromRight, fromTop, fromBottom
		bannerDuration:300,
		waitBannerAnimation:false,
		progressBar:'<div class="progbar"></div>'
	});
 })