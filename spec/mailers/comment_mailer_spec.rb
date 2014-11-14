describe CommentMailer do
  describe "new_comments" do
    let(:submission) { FactoryGirl.create(:submission) }

    context "when single comment" do
      let(:comment) { FactoryGirl.create(:comment, submission: submission) }
      let(:mail) { CommentMailer.new_comments(submission, [comment]) }

      it "specifies the lesson name in the subject" do
        expected = "There is 1 new comment on your #{submission.lesson.title} submission."
        expect(mail.subject).to eq(expected)
      end

      it "includes the username of the commenter" do
        expect(mail.body.encoded).to include(comment.user.username)
      end

      it "includes the body of the comment" do
        expect(mail.body.encoded).to include(comment.body)
      end

      it "includes a link to the submission" do
        expect(mail.body.encoded).to include(submission_url(submission))
      end
    end

    context "when multiple comments" do
      let(:comments) { FactoryGirl.create_list(:comment, 3, submission: submission) }
      let(:mail) { CommentMailer.new_comments(submission, comments) }

      it "specifies the number of comments in the subject" do
        expected = "There are 3 new comments on your #{submission.lesson.title} submission."
        expect(mail.subject).to eq(expected)
      end

      it "includes the username and body for each comment" do
        comments.each do |comment|
          expect(mail.body.encoded).to include(comment.user.username)
          expect(mail.body.encoded).to include(comment.body)
        end
      end
    end
  end
end
