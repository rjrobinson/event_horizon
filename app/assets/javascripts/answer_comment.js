$(function() {
  var $addCommentButton = $('.add-answer-comment a');

  $addCommentButton.on('click', function(e) {
    e.preventDefault();
    var $target = $(e.target);
    var $commentDiv = $target.parent().parent().find('div.answer-comment');

    if ($commentDiv.hasClass('hidden')) {
      $commentDiv.removeClass('hidden');
    } else {
      $commentDiv.addClass('hidden');
    }
  });
});
