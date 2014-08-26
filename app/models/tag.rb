class Tag
  include Mongoid::Document
  include Mongoid::Timestamps
  
  field :name, type: String

  embedded_in :user, inverse_of: :tags
end
