class Session < ActiveRecord::Base
  has_many :feedbacks
  belongs_to :user1, class_name: "User"
  belongs_to :user2, class_name: "User"


  # def add_feedback(feedback)
  #   pair_id = [self.student1.id, self.student2.id]

  #   if pair_id[0] == feedback.student.id
  #     self.feedback1 = feedback
  #     pair_id.delete(feedback.student.id)
  #   end
  #   if pair_id[1] == feedback.student.id
  #     self.feedback2 = feedback
  #     pair_id.delete(feedback.student.id)
  #   end
  # end
end
