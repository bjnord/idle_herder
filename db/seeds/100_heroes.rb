Hero.destroy_all
(1..260).each do |id|
  h = Hero.build_from_json(id)
  h.save!
end
