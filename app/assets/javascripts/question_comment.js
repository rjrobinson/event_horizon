$(function() {
  var $addCommentButton = $('#add-question-comment a');
  var $addCommentForm = $('#question-comment');

  $addCommentButton.on('click', function(e) {
    e.preventDefault();
    if ($addCommentForm.hasClass('hidden')) {
      $addCommentForm.removeClass('hidden');
    } else {
      $addCommentForm.addClass('hidden');
    }
  });
});
