class Course < ApplicationRecord
  validates :title, :description, :short_description, :language, :level, :price, presence: true
  validates :description, presence: true, length: { :minimum => 5 }
  
  belongs_to :user
  has_many :lessons, dependent: :destroy

  def to_s
    title
  end

  has_rich_text :description

  extend FriendlyId
  # friendly_id :title, use: :slugged

  friendly_id :generated_slug, use: :slugged

  def generated_slug
    require 'securerandom'
    random_string = SecureRandom.hex(5)
    @random_slug ||= persisted? friendly_id: :random_string
  end

  LANGUAGES = [:"English", :"Russian", :"Polish", :"Spanish"]
  def self.languages
    LANGUAGES.map { |language| [language, language] }
  end

  LEVELS = [:"Beginner", :"Intermediate", :"Advanced"]
  def self.levels
    LEVELS.map { |level| [level, level] }
  end

  include PublicActivity::Model
  tracked owner: Proc.new{ |controller, model| controller.current_user }
end
