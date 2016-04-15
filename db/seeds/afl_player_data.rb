def afl_player_data
  data_files = Dir.glob('data/team_player_data/**/*').select{ |e| File.file? e }
  data_files.map do |file|
    JSON.parse(File.read(file))
  end
end
