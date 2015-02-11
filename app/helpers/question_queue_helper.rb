module QuestionQueueHelper
  def question_queue_update_button(question_queue)
    if question_queue.status == "open"
      link_to "I'm on it!", question_queue_path(id: question_queue, question_queue: { status: "in-progress"}), method: :patch, class: "ee-button on-it"
    elsif question_queue.status == "in-progress"
      link_to "We Solved It!", question_queue_path(id: question_queue, question_queue: { status: "done"}), method: :patch, class: "ee-button solved-it"
    end
  end

  def queue_status(question)
    if question.question_queue.any?
      content_tag(
        :small,
        question.question_queue.first.status_text,
        class: "queue-status #{question.question_queue.first.status}"
      )
    end
  end
end
