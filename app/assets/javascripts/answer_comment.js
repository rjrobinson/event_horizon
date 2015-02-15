$(function() {
  var $addCommentButton = $('#add-answer-comment');
  var $addCommentForm = $('#answer-comment');

  $addCommentButton.on('click', function(e) {
    e.preventDefault();
    if ($addCommentForm.hasClass('hidden')) {
      $addCommentForm.removeClass('hidden');
    } else {
      $addCommentForm.addClass('hidden');
    }
  });
});
