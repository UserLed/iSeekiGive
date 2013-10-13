(function($)
{
	$(document).ready(function() {
		$('.styleswitch').click(function()
		{
			switchStylestyle(this.getAttribute("rel"));
			return false;
		});
		// var c = readCookie('style');
		// if (c) switchStylestyle(c);
	});

	function switchStylestyle(styleName)
	{
		$('link[rel*=style][title]').each(function(i) 
		{
			this.disabled = true;
			if (this.getAttribute('title') == styleName) this.disabled = false;
		});
		// createCookie('style', styleName, 365);
	}
})(jQuery);


(function($)
{
	$(document).ready(function() {
		$('#switch_960').click(function(){
			event.preventDefault();
			$('body').removeClass('width1200');	
			$(this).addClass('btn-primary');
			$('#switch_1200').removeClass('btn-primary');
			$(window).resize(); 
		});

		$('#switch_1200').click(function(){
			event.preventDefault();
			$('body').addClass('width1200');
			$(this).addClass('btn-primary');
			$('#switch_960').removeClass('btn-primary');
			$(window).resize();
		});


		$('#switch_wide').click(function(){
			event.preventDefault();
			$('body').removeClass('boxed');
			$(this).addClass('btn-primary');
			$('#switch_boxed').removeClass('btn-primary');
			$(window).resize();
		});


		$('#switch_boxed').click(function(){
			event.preventDefault();
			$('body').addClass('boxed');
			$(this).addClass('btn-primary');
			$('#switch_wide').removeClass('btn-primary');
			$(window).resize();
		});


		$('.pattern_switch').click(function(){
			event.preventDefault();
			// console.log($(this).css('background-image'));
			// console.log('baz');
			$('body').removeClass('bg-img');
			$('body').addClass('bg-pattern');
			$('body').css('background-image', $(this).css('background-image'));
			$('body').addClass('boxed');
			$('#switch_wide').removeClass('btn-primary');
			$('#switch_boxed').addClass('btn-primary');
			// $('body').addClass('bg-pattern');
			// $('body').css
			$(window).resize();
		});

		$('.bg_image_switch').click(function(){
			event.preventDefault();
			$('body').removeClass('bg-pattern');
			$('body').addClass('bg-img');
			$('body').css('background-image', 'url("' + $(this).attr('rel') + '")');
			$('body').addClass('boxed');
			$('#switch_wide').removeClass('btn-primary');
			$('#switch_boxed').addClass('btn-primary');
			$(window).resize();
		});

	});
})(jQuery);




// Cookie functions
function createCookie(name,value,days)
{
	if (days)
	{
		var date = new Date();
		date.setTime(date.getTime()+(days*24*60*60*1000));
		var expires = "; expires="+date.toGMTString();
	}
	else var expires = "";
	document.cookie = name+"="+value+expires+"; path=/";
}
function readCookie(name)
{
	var nameEQ = name + "=";
	var ca = document.cookie.split(';');
	for(var i=0;i < ca.length;i++)
	{
		var c = ca[i];
		while (c.charAt(0)==' ') c = c.substring(1,c.length);
		if (c.indexOf(nameEQ) == 0) return c.substring(nameEQ.length,c.length);
	}
	return null;
}
function eraseCookie(name)
{
	createCookie(name,"",-1);
}

// Switcher
jQuery('.demo_changer .demo-icon').click(function(){

	if(jQuery('.demo_changer').hasClass("active")){
		jQuery('.demo_changer').animate({"left":"-218px"},function(){
			jQuery('.demo_changer').toggleClass("active");
		});						
	}else{
		jQuery('.demo_changer').animate({"left":"0px"},function(){
			jQuery('.demo_changer').toggleClass("active");
		});			
	} 
});