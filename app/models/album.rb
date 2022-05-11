class Album < ApplicationRecord
	validates :title, presence: true
	validates :description, presence: true
  validates :tagged, presence: { message: "Input must contain at least one tag" }
	validates :cover_image, presence: true
	has_many_attached :images, dependent: :destroy
	has_one_attached :cover_image

	belongs_to :user
	has_and_belongs_to_many :tags

  def tagged=(names)
    self.tags = names.split(',').map do |name|
      Tag.where(name: name.strip).first_or_create!
    end
  end

  def tagged
    tags.map(&:name).join(", ")
  end
end
