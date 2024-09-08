# == Schema Information
#
# Table name: users
#
#  id         :bigint           not null, primary key
#  email      :string
#  first_name :string
#  full_name  :string
#  last_name  :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_users_on_email  (email)
#
class User < ApplicationRecord
  after_initialize :generate_default_name
  before_save :downcase_email
  before_save :generate_full_name

  def generate_default_name
    self.first_name = "NONE" if self.first_name.blank?
    self.last_name = "NONE" if self.last_name.blank?
  end

  def downcase_email
    self.email = self.email.downcase if self.email.present?
  end

  def generate_full_name
    self.full_name = [ self.first_name, self.last_name ].select { |x| x.present? }.join(" ")
  end
end
