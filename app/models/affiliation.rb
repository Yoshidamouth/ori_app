class Affiliation < ActiveHash::Base
  self.data = [
    { id: 1, name: '---' },
    { id: 2, name: '本社' },
    { id: 3, name: '東支店' },
    { id: 4, name: '西支店' },
    { id: 5, name: '南支店' },
    { id: 6, name: '北支店' },
  ]
  include ActiveHash::Associations
  has_many :users
end