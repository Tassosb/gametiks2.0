// dynamically generate monitor fill pattern for associated views
$(document).ready(function() {
  var associatedViews = $('.spawn-monitor-fill');
  for (var i = 0; i < associatedViews.length; i++) {
    // grab the child element with id = monitor-fill-container
    var child = '<div class="monitor-fill-container"></div>';
    var childNode = $.parseHTML(child);
    $(associatedViews[i]).prepend(childNode);
    var height = $(childNode).css('height');
    var multiplier = Math.round(parseInt(height.substring(0, height.length - 2)) / 2);
    for (var j = 0; j < multiplier; j++) {
      varb fill = $.parseHTML(`<div id="fill-${j}" class="monitor-fill"></div>`);
      $(childNode).append(fill);
    };
  };
});
