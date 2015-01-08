$(function() {
  $(".hidden-attributes").hide();

  $(".code-line").on("click", function(e) {
    var line = $(this);
    var sourceFileId = line.parents(".source-file").data("sourceFileId");
    var lineNo = line.data("line-no");
    var action = $("form.new_comment").attr("action");
    var id = "source-" + sourceFileId + "-line-" + lineNo + "-form"

    console.log('action' + action);

    if (!line.hasClass("generated-form")) {
      var row = $(generateRowWithForm(id, action, sourceFileId, lineNo)).insertAfter(line);
      var form = row.find("form");

      form.on("submit", function(e) {
        e.preventDefault();
        $.post(
          form.attr("action") + ".json",
          form.serialize(),
          function(data) {
            var comment = formatComment(data.comment);
            row.replaceWith(comment);
            line.removeClass("generated-form");
          }
        );
      });
      line.addClass("generated-form");
    } else {
      var formLine = $("#" + id).parents(".code-comment-form");
      formLine.toggle();
    }
  });
});

function formatComment(comment) {
  return "<tr class=\"code-comment-inline\"><td colspan=\"2\"><div class=\"code-comment-header\"><span class=\"code-username\">" + comment.user + "</span> commented on <span class=\"code-timestamp\">" + comment.created_at + "</span></div><div class=\"code-comment-body\">" + comment.html_body + "</div></td></tr>";
}

function generateRowWithForm(id, action, sourceFileId, lineNo) {
  var token = $("meta[name=\"csrf-token\"]").attr("content");

  return "<tr class=\"code-comment-form\"><td colspan=\"2\"><form accept-charset=\"UTF-8\" action=\"" + action + "\" id=\"" + id + "\" method=\"post\"><input name=\"utf8\" type=\"hidden\" value=\"&#x2713;\" /><input name=\"authenticity_token\" type=\"hidden\" value=\"" + token + "\" /><input name=\"comment[source_file_id]\" type=\"hidden\" value=\"" + sourceFileId + "\" /><input name=\"comment[line_number]\" type=\"hidden\" value=\"" + lineNo + "\" /><textarea id=\"comment_body\" name=\"comment[body]\" placeholder=\"Leave a comment...\" rows=\"5\"></textarea><input class=\"button tiny\" name=\"commit\" type=\"submit\" value=\"Submit\" /></form></td></tr>";
}
