class Calendar < ActiveRecord::Base
  belongs_to :company
  has_one :api_key, dependent: :destroy

  after_create :generate_api_key

  private

  def generate_api_key
    create_api_key
  end
end
