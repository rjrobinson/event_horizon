module QuestionQueueHelper
  def question_queue_update_button(question_queue)
    if question_queue.status == "open"
      link_to "I'm on it!", question_queue_path(id: question_queue, question_queue: { status: "in progress"}), method: :patch, class: "button alert"
    elsif question_queue.status == "in progress"
      link_to "We Solved It!", question_queue_path(id: question_queue, question_queue: { status: "done"}), method: :patch, class: "button alert"
    end
  end
end
