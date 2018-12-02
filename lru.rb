

$cache = Hash.new
$max_size = 5

$recent_read_keys = {}

def get_value(key)
  value = $cache[key]
  return unless value

  mark_as_recent(key)

  value
end

def set_value(key, value)
  if !$cache.key?(key) && $cache.size == $max_size
    key_to_evict = $recent_read_keys.keys.first
    $cache.delete(key_to_evict) # evict
    $recent_read_keys.delete(key_to_evict)
  end

  mark_as_recent(key)

  $cache[key] = value
end

def mark_as_recent(key)
  $recent_read_keys.delete(key)
  $recent_read_keys[key] = true
end

def assert(result)
  raise "something smells fishy!" unless result
end

assert(get_value("omg") == nil)

5.times do |i|
  set_value("key#{i}", i)
end

puts "after setting 5 keys:"
puts $cache.inspect
puts $recent_read_keys.inspect

10.times { set_value("key5", 5) }

puts "after setting key5:"

# key1 should be gone
puts $cache.inspect
puts $recent_read_keys.inspect
