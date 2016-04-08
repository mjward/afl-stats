def afl_match_data
  data_files = Dir.glob('data/match_data/**/*').select{ |e| File.file? e }
  data_files.map do |file|
    JSON.parse(File.read(file))
  end
end
