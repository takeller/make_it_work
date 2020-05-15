class Project <ApplicationRecord
  validates_presence_of :name, :material
  belongs_to :challenge
  has_many :contestant_projects
  has_many :contestants, through: :contestant_projects

  def total_contestants
    contestants.count
  end

  def average_experience
    avg_exp = contestants.average(:years_of_experience)
    if avg_exp == nil
      "0"
    else
      avg_exp.to_s
    end
  end

  def add_contestant(id)
    
  end
end
