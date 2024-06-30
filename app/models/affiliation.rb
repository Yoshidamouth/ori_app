class Affiliation < ActiveHash::Base
  self.data = [
    { id: 1, name: '---' },
    { id: 2, name: '本社' },
    { id: 3, name: '東営業所' },
    { id: 4, name: '西営業所' },
    { id: 5, name: '南営業所' },
    { id: 6, name: '北営業所' },
  ]
  include ActiveHash::Associations
  has_many :users
end