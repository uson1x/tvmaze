describe 'Show' do
  it 'intiialize fields properly' do
    params = attributes_for('TVMaze::Show')

    show = TVMaze::Show.new(params)

    mapping_hash = TVMaze::Show::SHOW_MAPPING
    mapping_hash.keys.each do |key|
      expect(show.send(mapping_hash[key].to_s)).to eq(params[key])
    end
  end

  it 'populates episodes if they present' do
    episodes = [attributes_for('TVMaze::Episode'), attributes_for('TVMaze::Episode')]

    params = { '_embedded' => { 'episodes' => episodes } }

    show = TVMaze::Show.new(params)

    expect(show.episodes.count).to eq(episodes.count)
  end

  it 'does not populate episodes if episode list was not embedded' do
    show = TVMaze::Show.new
    expect(show.episodes).to eq([])
  end

  it 'populates next_episode if present' do
    next_episode = attributes_for('TVMaze::Episode')

    params = { '_embedded' => { 'nextepisode' => next_episode } }

    show = TVMaze::Show.new(params)

    expect(show.next_episode).not_to eq(nil)
    expect(show.next_episode.id).to eq(next_episode[:id])
    expect(show.next_episode.name).to eq(next_episode[:name])
  end

  it 'does not build next_episode if next episode was not embedded' do
    show = TVMaze::Show.new
    expect(show.next_episode).to eq(nil)
  end

  it 'populates seasons properly' do
    episodes = [attributes_for('TVMaze::Episode', season: 1),
                attributes_for('TVMaze::Episode', season: 2),
                attributes_for('TVMaze::Episode', season: 3)]

    params = { '_embedded' => { 'episodes' => episodes } }

    show = TVMaze::Show.new(params)

    expect(show.seasons).not_to eq(nil)
    expect(show.seasons.count).to eq(episodes.count)
    show.seasons.each do |season|
      expect(season.episodes.count).to eq(1)
      expect(season.episodes[0].season).to eq(season.number)
    end
  end

  it 'does not populate seasons if episode list was not embedded' do
    show = TVMaze::Show.new
    expect(show.seasons).to eq([])
  end
end
