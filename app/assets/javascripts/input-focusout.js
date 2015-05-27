// First, checks if it isn't implemented yet.
if (!String.prototype.format) {
  String.prototype.format = function() {
    var args = arguments;
    return this.replace(/{(\d+)}/g, function(match, number) { 
      return typeof args[number] != 'undefined'
        ? args[number]
        : match
      ;
    });
  };
}

// First, checks if it isn't implemented yet.
if (!String.prototype.formatArray) {
  String.prototype.formatArray = function(args) {
    return this.replace(/{(\d+)}/g, function(match, number) { 
      return typeof args[number] != 'undefined'
        ? args[number]
        : match
      ;
    });
  };
}

function updateFilmJumbotron(update_id,str_format,str_args) {
	for (i = 0; i < str_args.length; i++) { 
	    str_args[i] = document.getElementById(str_args[i]).value;
	}
	var newTitle = str_format.formatArray(str_args);
	$('.' + update_id).html(newTitle);
}