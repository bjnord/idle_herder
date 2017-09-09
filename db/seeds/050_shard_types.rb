shard_type_count = Dir[Rails.root.join('db', 'data', 'shard_types', '*')].count {|f| File.file?(f) }
$stderr.puts "seeding #{shard_type_count} shard_types"
ShardType.destroy_all
(1..shard_type_count).each do |id|
  h = ShardType.build_from_json(id)
  h.save!
end
$stderr.puts "ShardType.count=#{ShardType.count}"
