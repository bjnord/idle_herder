hero_count = Dir[Rails.root.join('db', 'data', 'heroes', '*')].count {|f| File.file?(f) }
$stderr.puts "seeding #{hero_count} heroes"
# first pass: create all heroes in database
Hero.destroy_all
(1..hero_count).each do |id|
  h = Hero.build_from_json(id)
  h.save!
end
$stderr.puts "pass 1: Material.count=#{Material.count}"
# second pass: fill in missing materials (sometimes an earlier Hero.id
# has a material with a later Hero.id that wasn't in the DB yet)
(1..hero_count).each do |id|
  h = Hero.find(id)
  hj = Hero.build_from_json(id)
  h.update_materials!(hj.materials)
end
$stderr.puts "pass 2: Material.count=#{Material.count}"
$stderr.puts ""
$stderr.puts "don't forget to update the sitemap if new heroes were added!"
