$(function(){
	//	Initialize Superfish
		$('.sf-menu').superfish({
			autoArrows: false
		});
	//	Initialize Pretty Photo
		$("a[data-gal^='prettyPhoto']").prettyPhoto({theme:'facebook'});
		
	$('.sf-menu > li > a').hover(
		function(){
			$(this).stop().animate({color:'#f7ef0f'},200)
		},
		function(){
			$(this).stop().animate({color:'#fff'},200)
		}
	);
	$('h4 a, .button, .list-2 a, .list-3 a, .link-3 a').hover(
		function(){
			$(this).stop().animate({color:'#f7ef0f'},200)
		},
		function(){
			$(this).stop().animate({color:'#fff'},200)
		}
	);
	
	$('h4.f-2 a').hover(
		function(){
			$(this).stop().animate({color:'#fff'},200)
		},
		function(){
			$(this).stop().animate({color:'#f7ef0f'},200)
		}
	);
	
	$('.list-1 li a').hover(
		function(){
			$(this).stop().animate({color:'#fff'},200)
		},
		function(){
			$(this).stop().animate({color:'#626262'},200)
		}
	);
	
})