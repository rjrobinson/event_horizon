$(function() {
  $(".hidden-attributes").hide();

  $(".line").on("click", function(e) {
    var line = $(this);
    var sourceFileId = line.parents(".source-file").data("sourceFileId");
    var lineNo = line.data("line-no");
    var action = $("form.new_comment").attr("action");
    var id = "source-" + sourceFileId + "-line-" + lineNo + "-form"

    if (!line.hasClass("generated-form")) {
      var form = $(generateForm(id, action, sourceFileId, lineNo)).insertAfter(line);
      form.on("submit", function(e) {
        e.preventDefault();
        $.post(
          $(this).attr("action") + ".json",
          $(this).serialize(),
          function(data) {
            var comment = formatComment(data.comment);
            form.replaceWith(comment);
          }
        );
      });
      line.addClass("generated-form show-form");
    } else {
      $("#" + id).toggle();
      line.toggleClass("show-form");
    }
  });
});

function formatComment(comment) {
  return '<div class="inline-comment comment">' +
    '<div class="inline-comment-body"><div class="user">' +
    comment.user + ' commented' +
    '</div><div class="body">' + comment.body + '</div></div></div>';
}

function generateForm(id, action, sourceFileId, lineNo) {
  var token = $("meta[name=\"csrf-token\"]").attr("content");


  return '<form accept-charset="UTF-8" action="' + action + '" ' +
    'class="inline-comment-form" id="' + id + '" method="post">' +
    '  <input name="utf8" type="hidden" value="&#x2713;" />' +
    '  <input name="authenticity_token" type="hidden" value="' + token + '" />' +
    '  <input name="comment[source_file_id]" type="hidden" value="' + sourceFileId + '" />' +
    '  <input name="comment[line_number]" type="hidden" value="' + lineNo + '" />' +
    '  <textarea id="comment_body" name="comment[body]" placeholder="Leave a comment..." rows="5"></textarea>' +
    '  <input class="button tiny" name="commit" type="submit" value="Submit" />' +
    '</form>';
}
