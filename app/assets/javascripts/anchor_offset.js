//I just found this online somewhere

$(function() {
  $('.smooth_scroll').click(function() {
	if (location.pathname.replace(/^\//,'') == this.pathname.replace(/^\//,'') && location.hostname == this.hostname) {
    	smooth_scroll(this.hash);
	}
  });
});

function smooth_scroll(destination){
      var target = $(destination);
      target = target.length ? target : $('[name=' + destination.slice(1) +']');
      if (target.length) {
		var scrollpoint = 0;
		if(target.offset().top < 90){
			scrollpoint = target.offset().top;
		} else {
			scrollpoint = target.offset().top - 90;
		}
        $('html,body').animate({
			scrollTop: scrollpoint
		}, 500, 'easeInOutBack');
        return false;
    }
}
