hero_count = Dir[Rails.root.join('db', 'data', 'heroes', '*')].count {|f| File.file?(f) }
$stderr.puts "seeding #{hero_count} heroes"
# first pass: create all heroes in database
Hero.destroy_all
(1..hero_count).each do |id|
  h = Hero.build_from_json(id)
  h.save!
end
$stderr.puts "pass 1 done: Material.count=#{Material.count}"
# second pass: fill in missing materials (sometimes an earlier Hero.id
# has a material with a later Hero.id that wasn't in the DB yet)
(1..hero_count).each do |id|
  h = Hero.find(id)
  hj = Hero.build_from_json(id)
  h.update_materials!(hj.materials)
end
$stderr.puts "pass 2 done: Material.count=#{Material.count}"
# finally, set Hero.max_stars [see bin/audit_
(1..hero_count).each do |id|
  h = Hero.find(id)
  case h.stars
  when 1, 2, 3, 10
    h.max_stars = h.stars
  when 6, 7, 8, 9
    h.max_stars = h.natural? ? 10 : 9
  when 4, 5
    if h.natural?
      h.max_stars = 10
    elsif Hero.find_by(name: h.name, stars: 6)
      h.max_stars = 9
    else
      h.max_stars = 5
    end
  end
  h.save!
end
$stderr.puts "pass 3 done (max_stars)"
$stderr.puts ""
$stderr.puts "don't forget to update the sitemap if new heroes were added!"
