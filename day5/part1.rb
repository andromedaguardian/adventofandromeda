def get_map_data(input)
  data = []
  loop do
    break unless !input.eof?
    line = input.readline.chomp
    next unless !line.include?(':')
    break unless !line.empty?
    data << line.split.map(&:to_i)  
  end
  return data
end

def get_value(data, key)
  value = nil
  data.each do |values|
    dest, src, range = values
    if (src..(src+range)).cover?(key)
      offset = key - src
      value = dest + offset
      break
    end
  end
  return value || key
end

input = File.open("input1.txt", "r")

seeds = input.readline.chomp.split(':').last.split.map(&:to_i)
input.readline # skip a blank line

seed_to_soil = get_map_data(input)
soil_to_fertilizer = get_map_data(input)
fertilizer_to_water = get_map_data(input)
warter_to_light = get_map_data(input)
light_to_temperature = get_map_data(input)
temperature_to_humidity = get_map_data(input)
humidity_to_location = get_map_data(input)

locations = []
seeds.each do |seed|
  locations << [
    seed_to_soil,
    soil_to_fertilizer,
    fertilizer_to_water,
    warter_to_light,
    light_to_temperature,
    temperature_to_humidity,
    humidity_to_location
  ].reduce(seed){ |key, map| get_value(map, key) }
end

puts locations.min

