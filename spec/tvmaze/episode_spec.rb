describe 'Episode' do
  it 'intiialize fields properly' do
    params = attributes_for('TVMaze::Episode')

    episode = TVMaze::Episode.new(params)

    mapping_hash = TVMaze::Episode::EPISODE_MAPPING
    mapping_hash.keys.each do |key|
      expect(episode.send(mapping_hash[key].to_s)).to eq(params[key])
    end
  end
end
