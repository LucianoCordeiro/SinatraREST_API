class Cat
  include DataMapper::Resource

  property :id, Serial
  property :name, String
  property :age, Integer

  validates_presence_of :name
  validates_presence_of :age

end
